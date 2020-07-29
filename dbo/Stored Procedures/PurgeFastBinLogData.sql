create PROCEDURE PurgeFastBinLogData
AS
BEGIN
  DECLARE @v_maxRecord int = 20000
  DECLARE @v_days_IR int
  DECLARE @v_days_RFID int
  DECLARE @v_days_Heartbeat int

  SET @v_days_IR = (SELECT CONVERT(int,setting_value)  FROM program_setting WHERE System_Id='DataRetention' AND Setting_Name='Days_IR')
  SET @v_days_RFID = (SELECT CONVERT(int,setting_value)  FROM program_setting WHERE System_Id='DataRetention' AND Setting_Name='Days_RFID')
  SET @v_days_Heartbeat = (SELECT CONVERT(int,setting_value)  FROM program_setting WHERE System_Id='DataRetention' AND Setting_Name='Days_Heartbeat')

  WHILE EXISTS (SELECT   *
    FROM FastBinTagDtl
    WHERE tstmp < GETDATE() - @v_days_RFID)
  BEGIN
    DELETE TOP (@v_maxRecord) FROM FastBinTagDtl
    WHERE tstmp < GETDATE() - @v_days_RFID
  END
  WHILE EXISTS (SELECT   *
    FROM FastBinDeviceDtl
    WHERE tstmp < GETDATE() - @v_days_IR)
  BEGIN
    DELETE TOP (@v_maxRecord) FROM FastBinDeviceDtl
    WHERE tstmp < GETDATE() - @v_days_IR
  END
  WHILE EXISTS (SELECT   *
    FROM  Device_Heartbeat_Dtl
    WHERE LastTimestamp < GETDATE() - @v_days_Heartbeat)
  BEGIN
    DELETE TOP (@v_maxRecord) FROM Device_Heartbeat_Dtl
    WHERE LastTimestamp < GETDATE() - @v_days_Heartbeat
  END
END