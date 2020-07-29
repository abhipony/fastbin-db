CREATE TABLE [dbo].[Error_Log] (
    [Log_Id]        INT           IDENTITY (1, 1) NOT NULL,
    [Line]          VARCHAR (200) NULL,
    [LastTimestamp] DATETIME2 (7) NULL,
    [FileType]      VARCHAR (5)   NULL,
    [TagReader]     VARCHAR (20)  NULL,
    [Controller]    VARCHAR (20)  NULL,
    [Message]       VARCHAR (500) NULL,
    CONSTRAINT [pk_Log_Id] PRIMARY KEY CLUSTERED ([Log_Id] ASC)
);

