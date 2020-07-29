CREATE TABLE [dbo].[FastBinRF] (
    [LastTimestamp]    DATETIME2 (7) NOT NULL,
    [TagReader]        NVARCHAR (40) NOT NULL,
    [BinId]            NVARCHAR (40) NOT NULL,
    [UpdatesPerPeriod] INT           NULL,
    [BinEmptyDate]     DATETIME2 (7) NULL,
    [ControllerSN]     VARCHAR (20)  NULL,
    CONSTRAINT [PK_FastBinRF] PRIMARY KEY CLUSTERED ([BinId] ASC)
);


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Timestamp of when the bin was first put into the empty enclosure', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinRF', @level2type = N'COLUMN', @level2name = N'BinEmptyDate';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'ID number of each bin', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinRF', @level2type = N'COLUMN', @level2name = N'BinId';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Time stamp of when a bin last communicated', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinRF', @level2type = N'COLUMN', @level2name = N'LastTimestamp';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Tags from each reader', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinRF', @level2type = N'COLUMN', @level2name = N'TagReader';


GO
EXECUTE sp_addextendedproperty @name = N'MS_Description', @value = N'Updates per period', @level0type = N'SCHEMA', @level0name = N'dbo', @level1type = N'TABLE', @level1name = N'FastBinRF', @level2type = N'COLUMN', @level2name = N'UpdatesPerPeriod';

