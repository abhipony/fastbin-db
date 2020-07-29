CREATE TABLE [dbo].[ftpLastMod] (
    [deviceID]     NVARCHAR (50) NOT NULL,
    [lastModified] DATETIME2 (7) NOT NULL,
    [bin]          BIT           NULL,
    [rptr]         BIT           NULL,
    [tag]          BIT           NULL,
    CONSTRAINT [PK_ftpLastMod_deviceID] PRIMARY KEY CLUSTERED ([deviceID] ASC)
);

