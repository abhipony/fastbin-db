CREATE TABLE [dbo].[FastBinIR] (
    [LastTimestamp]      DATETIME2 (7)  NOT NULL,
    [BinId]              NVARCHAR (40)  NOT NULL,
    [SignalStrength]     SMALLINT       NULL,
    [AmbientLightBottom] SMALLINT       NULL,
    [AmbientLightMiddle] SMALLINT       NULL,
    [AmbientLightTop]    SMALLINT       NULL,
    [BinSize]            SMALLINT       NULL,
    [HeartBeat]          NVARCHAR (50)  NULL,
    [TransType]          NVARCHAR (20)  NULL,
    [BatteryVoltage]     DECIMAL (5, 4) NULL,
    [SensorPerc]         DECIMAL (7, 4) NULL,
    [UpdatesPerPeriod]   INT            NULL,
    [QohBelowMinDate]    DATETIME2 (7)  NULL,
    [ControllerSN]       VARCHAR (20)   NULL,
    [RepeaterSN]         VARCHAR (20)   NULL,
    CONSTRAINT [PK_FastBinIR] PRIMARY KEY CLUSTERED ([BinId] ASC)
);


GO
 
CREATE TRIGGER [dbo].[FastBinIR_Update_trigger] 
ON [dbo].[FastBinIR] 
FOR UPDATE  , INSERT 
AS 
  BEGIN 
      SET NOCOUNT ON; 
	  DECLARE @isInsert bit
	  SET @isInsert = 0  
	 
	  IF NOT EXISTS(SELECT * FROM DELETED)
	  BEGIN
		SET  @isInsert = 1
	  END
      
	  IF UPDATE (SensorPerc) OR @isInsert = 1
        BEGIN
            MERGE FastBinIR AS t 
            USING ( SELECT  n.binid , p.min_qty AS MinQty , 
                                  n.QohBelowMinDate, Round(( q.estimated_qoh / q.sensor_percentage) * n.sensorperc, 0) AS Qoh ,p.qty_on_order
                           FROM  INSERTED N  
                                  LEFT JOIN  DELETED o ON o.BinId = n.BinId 
                                             AND o.SensorPerc <> n.SensorPerc 
                                  JOIN bin_planogram_product_oms p 
                                    ON n.BinId = p.bin_id 
                                  LEFT JOIN bin_ir_item_master_qoh_oms q 
                                         ON p.SKU = q.SKU 
                                            AND bin_size = CASE n.binsize 
                                                             WHEN 240 THEN 'Large' 
                                                             WHEN 230 THEN 'Medium' 
                                                             WHEN 220 THEN 'Small' 
                                                           END 
                                            AND q.sensor_percentage = 50.000) s
            ON ( t.BinId = s.BinId ) 
            WHEN MATCHED THEN 
              UPDATE SET t.QohBelowMinDate = CASE 
                                               WHEN s.MinQty > s.qoh AND t.QohBelowMinDate IS NULL 
                                             THEN 
                                               Getdate() 
                                               WHEN  (Isnull(s.qoh, 0) + isnull(qty_on_order,0) ) >= s.MinQty THEN NULL 
                                               ELSE t.QohBelowMinDate 
                                             END; 

        END 
  END
GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ambient light bottom sensors', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinIR', @level2type = N'COLUMN', @level2name = N'AmbientLightBottom';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ambient light middle sensors', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinIR', @level2type = N'COLUMN', @level2name = N'AmbientLightMiddle';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Ambient light top sensors', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinIR', @level2type = N'COLUMN', @level2name = N'AmbientLightTop';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Current voltage of each IR bin battery', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinIR', @level2type = N'COLUMN', @level2name = N'BatteryVoltage';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID number of each bin', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinIR', @level2type = N'COLUMN', @level2name = N'BinId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Size of IR bin', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinIR', @level2type = N'COLUMN', @level2name = N'BinSize';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Repeater flags', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinIR', @level2type = N'COLUMN', @level2name = N'HeartBeat';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Time stamp of when a bin last communicated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinIR', @level2type = N'COLUMN', @level2name = N'LastTimestamp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Sensor percentage', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinIR', @level2type = N'COLUMN', @level2name = N'SensorPerc';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Signal strength', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinIR', @level2type = N'COLUMN', @level2name = N'SignalStrength';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'transaction Type', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinIR', @level2type = N'COLUMN', @level2name = N'TransType';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Updates per period', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinIR', @level2type = N'COLUMN', @level2name = N'UpdatesPerPeriod';

