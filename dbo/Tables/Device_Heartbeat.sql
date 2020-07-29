CREATE TABLE [dbo].[Device_Heartbeat] (
    [DeviceSN]      VARCHAR (20)  NOT NULL,
    [ControllerSN]  VARCHAR (20)  NOT NULL,
    [DeviceType]    VARCHAR (20)  NOT NULL,
    [LastTimestamp] DATETIME2 (7) NOT NULL,
    CONSTRAINT [pk_device_heartbeat_devicesn] PRIMARY KEY CLUSTERED ([DeviceSN] ASC)
);

