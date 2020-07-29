CREATE TABLE [dbo].[FastBinDeviceDtl] (
    [tstmp]        DATETIME2 (7)  NOT NULL,
    [bdAddr]       NVARCHAR (40)  NOT NULL,
    [rssi]         SMALLINT       NULL,
    [aLB]          SMALLINT       NULL,
    [aLM]          SMALLINT       NULL,
    [aLT]          SMALLINT       NULL,
    [binSize]      SMALLINT       NULL,
    [rptrFlags]    NVARCHAR (50)  NULL,
    [transType]    NVARCHAR (20)  NULL,
    [battVoltage]  DECIMAL (5, 4) NULL,
    [sensorPerc]   DECIMAL (7, 4) NULL,
    [uPP]          INT            NULL,
    [ControllerSN] VARCHAR (20)   NULL,
    [RepeaterSN]   VARCHAR (20)   NULL
);


GO
CREATE CLUSTERED INDEX [idx_FastBinDeviceDtl_tstmp_bdAddr]
    ON [dbo].[FastBinDeviceDtl]([tstmp] DESC, [bdAddr] DESC);


GO
CREATE NONCLUSTERED INDEX [IX_dbo_FastBinDeviceDtl_bdAddr]
    ON [dbo].[FastBinDeviceDtl]([bdAddr] ASC);


GO
CREATE TRIGGER [dbo].[FastBinDeviceDtl_Insert_trigger] ON [dbo].[FastBinDeviceDtl] FOR INSERT 
AS
BEGIN 
   SET NOCOUNT ON;
		MERGE FastBinIR AS t
		USING (
				SELECT * FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY bdAddr ORDER BY bdAddr,tstmp DESC) AS RN FROM INSERTED) cte WHERE rn=1
		)AS s
		ON (t.BinId = s.bdAddr  ) 
		WHEN MATCHED THEN 
		UPDATE SET 
			  t.LastTimeStamp = s.tstmp  ,
			  t.SignalStrength = s.rssi,
			  t.AmbientLightBottom =s.aLB,
			  t.AmbientLightMiddle = s.aLM,
			  t.AmbientLightTop =  s.aLT,
			  t.BinSize = s.binSize ,
			  t.HeartBeat = s.rptrFlags,
			  t.TransType = s.transType ,
			  t.BatteryVoltage = s.battVoltage ,
			  t.SensorPerc = s.sensorPerc ,
			  t.UpdatesPerPeriod = 1,
			  t.ControllerSN = s.ControllerSN,
			  t.RepeaterSN = s.RepeaterSN
		WHEN  NOT MATCHED  THEN 
			INSERT (	LastTimeStamp,	BinId ,SignalStrength,AmbientLightBottom , AmbientLightMiddle,AmbientLightTop,BinSize,HeartBeat,TransType,BatteryVoltage,SensorPerc,UpdatesPerPeriod,RepeaterSN,ControllerSN) 
			VALUES (s.tstmp,s.bdAddr,s.rssi,s.aLB,s.aLM,s.aLT,s.binSize,s.rptrFlags,s.transType,s.battVoltage,s.sensorPerc,1,s.RepeaterSN,s.ControllerSN);
END