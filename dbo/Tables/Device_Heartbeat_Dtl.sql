CREATE TABLE [dbo].[Device_Heartbeat_Dtl] (
    [DeviceSN]      VARCHAR (20)  NOT NULL,
    [ControllerSN]  VARCHAR (20)  NOT NULL,
    [DeviceType]    VARCHAR (20)  NOT NULL,
    [LastTimestamp] DATETIME2 (7) NOT NULL
);


GO
CREATE NONCLUSTERED INDEX [ix_devicesn]
    ON [dbo].[Device_Heartbeat_Dtl]([DeviceSN] ASC);


GO
CREATE CLUSTERED INDEX [ix_lasttimestamp]
    ON [dbo].[Device_Heartbeat_Dtl]([LastTimestamp] ASC);


GO




CREATE TRIGGER [dbo].[DeviceHeartbeatDtl_Insert_trigger] ON [dbo].[Device_Heartbeat_Dtl] FOR INSERT 
AS
BEGIN 
   SET NOCOUNT ON;
		MERGE Device_Heartbeat AS t
		USING (
				SELECT * FROM (SELECT *,ROW_NUMBER() OVER (PARTITION BY DeviceSN ORDER BY DeviceSN,LastTimestamp DESC) AS RN FROM INSERTED) cte WHERE rn=1
		)AS s
		ON (t.DeviceSN = s.DeviceSN  ) 
		WHEN MATCHED THEN 
		UPDATE SET 
			  t.LastTimeStamp = s.LastTimestamp,
			  t.ControllerSN = s.ControllerSN,
			  t.DeviceType = s.DeviceType
		WHEN  NOT MATCHED  THEN 
			INSERT (DeviceSN,ControllerSN,DeviceType,LastTimeStamp) 
			VALUES (s.DeviceSN,s.ControllerSN,s.DeviceType,s.LastTimestamp);
END