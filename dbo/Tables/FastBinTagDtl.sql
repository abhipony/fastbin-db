CREATE TABLE [dbo].[FastBinTagDtl] (
    [tstmp]        DATETIME2 (7) NOT NULL,
    [tagRdr]       NVARCHAR (40) NOT NULL,
    [tagEpc]       NVARCHAR (40) NOT NULL,
    [uPP]          INT           NULL,
    [ControllerSN] VARCHAR (20)  NULL
);


GO
CREATE CLUSTERED INDEX [idx_FastBinTagDtl_tstmp_tagRdr_tagEpc]
    ON [dbo].[FastBinTagDtl]([tstmp] ASC, [tagRdr] ASC, [tagEpc] ASC);


GO
CREATE TRIGGER [dbo].[FastBinTagDtl_Insert_trigger] ON [dbo].[FastBinTagDtl] FOR INSERT   
AS  
BEGIN   
   SET NOCOUNT OFF;  
   DECLARE @DateInt VARCHAR(50) ;  
    BEGIN TRY   
  SET  @DateInt  = (SELECT Setting_Value from Program_Setting where System_Id='FastBinRF' and Setting_Name='EmptyBin');  
  MERGE FastBinRF AS t  
  USING (  
    SELECT * FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY tagEpc ORDER BY tagEpc,tstmp DESC) AS RN FROM INSERTED) cte WHERE rn=1  
  )AS s  
  ON (t.BinId = s.tagEpc  )   
  WHEN MATCHED THEN   
  UPDATE SET   
     t.LastTimeStamp = s.tstmp  ,  
     t.TagReader = s.tagRdr,  
     t.UpdatesPerPeriod = s.uPP, 
	 t.ControllerSN = s.ControllerSN, 
     t.BinEmptyDate = case when DATEDIFF(mi, t.LastTimeStamp,s.tstmp)> CAST(@DateInt  AS INT)  then s.tstmp else t.BinEmptyDate end   
  WHEN  NOT MATCHED  THEN   
   INSERT (BinId ,LastTimeStamp,TagReader,UpdatesPerPeriod,BinEmptyDate,ControllerSN)   
   VALUES (s.tagEpc,s.tstmp,tagRdr,uPP,s.tstmp,s.ControllerSN);  
 END TRY  
      BEGIN CATCH   
          SELECT Error_message();   
      END CATCH;   
END