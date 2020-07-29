CREATE TABLE [dbo].[Bin_Orders_OMS] (
    [OWNER_BU]               NVARCHAR (5)   NOT NULL,
    [CUST_NO]                NVARCHAR (10)  NOT NULL,
    [CUST_NAME]              NVARCHAR (100) NULL,
    [PLANOGRAM_ID]           INT            NOT NULL,
    [PLANOGRAM_NAME]         NVARCHAR (100) NULL,
    [LOCATION_NAME]          NVARCHAR (50)  NULL,
    [BIN_ROW]                INT            NOT NULL,
    [BIN_COLUMN]             INT            NOT NULL,
    [SKU]                    NVARCHAR (25)  NOT NULL,
    [CUST_SKU]               NVARCHAR (25)  NULL,
    [SKU_DESCRIPTION]        NVARCHAR (100) NULL,
    [MIN_QTY]                INT            NOT NULL,
    [MAX_QTY]                INT            NOT NULL,
    [MINIMUM_ORDER_QTY]      INT            NOT NULL,
    [DISPLAY_ORDER_SEQUENCE] INT            NULL,
    [QTY_ON_ORDER]           INT            NULL,
    [BIN_ID]                 NVARCHAR (40)  NOT NULL,
    [HARDWARE_TYPE]          NVARCHAR (4)   NULL,
    [LAST_ORDER_CREATION_DT] DATETIME2 (7)  NULL,
    [LAST_MODIFIED_USER]     INT            NULL,
    CONSTRAINT [Bin_Orders_PK] PRIMARY KEY CLUSTERED ([BIN_ROW] ASC, [BIN_COLUMN] ASC, [SKU] ASC, [BIN_ID] ASC, [PLANOGRAM_ID] ASC)
);

