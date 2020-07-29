CREATE TABLE [dbo].[Bin_Planogram_Product_OMS] (
    [OWNER_BU]                 NVARCHAR (25) NULL,
    [CUST_NO]                  NVARCHAR (10) NOT NULL,
    [PLANOGRAM_ID]             INT           NOT NULL,
    [BIN_COLUMN]               INT           NOT NULL,
    [BIN_ROW]                  INT           NOT NULL,
    [SKU]                      NVARCHAR (25) NOT NULL,
    [BIN_ID]                   NVARCHAR (40) NOT NULL,
    [CUST_SKU]                 NVARCHAR (25) NULL,
    [MIN_QTY]                  INT           NULL,
    [MAX_QTY]                  INT           NULL,
    [MINIMUM_ORDER_QTY]        INT           NULL,
    [DISPLAY_ORDER_SEQUENCE]   INT           NULL,
    [SHOPPING_CART_QTY]        INT           NULL,
    [LAST_MODIFIED_DT]         DATETIME2 (7) NULL,
    [LAST_MODIFIED_USER]       INT           NULL,
    [LAST_MODIFIED_PROGRAM_ID] INT           NULL,
    [IS_VALID]                 BIT           NOT NULL,
    [QTY_ON_ORDER]             INT           NULL,
    [SELECTED_FILL_FREQUENCY]  INT           NULL,
    [FILL_FREQUENCY_1_ROQ]     INT           NULL,
    [FILL_FREQUENCY_2_ROQ]     INT           NULL,
    [FILL_FREQUENCY_3_ROQ]     INT           NULL,
    [HARDWARE_TYPE]            NVARCHAR (4)  NULL,
    [ESTIMATED_QOH]            INT           NULL,
    [RFID_MIN_BINS]            INT           NULL,
    [RFID_MAX_BINS]            INT           NULL,
    CONSTRAINT [Bin_Planogram_Product_PK] PRIMARY KEY CLUSTERED ([PLANOGRAM_ID] ASC, [BIN_ROW] ASC, [BIN_COLUMN] ASC, [SKU] ASC, [BIN_ID] ASC)
);


GO
CREATE NONCLUSTERED INDEX [IX_dbo_Bin_Planogram_Product_OMS_BIN_ID]
    ON [dbo].[Bin_Planogram_Product_OMS]([BIN_ID] ASC);

