CREATE TABLE [dbo].[Program_Setting] (
    [System_Id]          VARCHAR (50)  NOT NULL,
    [Setting_Name]       VARCHAR (50)  NOT NULL,
    [Setting_Value]      VARCHAR (200) NOT NULL,
    [Last_Modified_Date] DATETIME      NULL,
    [Last_Modified_User] VARCHAR (50)  NULL,
    CONSTRAINT [PK_Program_Setting] PRIMARY KEY CLUSTERED ([System_Id] ASC, [Setting_Name] ASC, [Setting_Value] ASC)
);

