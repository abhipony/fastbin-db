CREATE TABLE [dbo].[Fastbin_Order_Packing_Slip_OMS] (
    [PLANOGRAM_ID]                 INT           NOT NULL,
    [BIN_ROW]                      INT           NOT NULL,
    [BIN_COLUMN]                   INT           NOT NULL,
    [SKU]                          NVARCHAR (30) NOT NULL,
    [LAST_ORDER_QTY]               INT           NULL,
    [LAST_ORDER_CREATION_DT]       DATETIME2 (7) NULL,
    [LAST_ORDER_CREATION_USER]     NVARCHAR (50) NULL,
    [OLDEST_ORDER_ID]              NVARCHAR (30) NULL,
    [OLDEST_ORDER_QTY]             INT           NULL,
    [LAST_PACK_SLIP_DELIVERY_USER] NVARCHAR (50) NULL,
    [LAST_PACK_SLIP_SIGNATURE_DT]  DATETIME2 (7) NULL,
    [LAST_PACKSLIP_DELIVERED_QTY]  INT           NULL,
    CONSTRAINT [Fastbin_Order_Packing_Slip_PK] PRIMARY KEY CLUSTERED ([PLANOGRAM_ID] ASC, [BIN_ROW] ASC, [BIN_COLUMN] ASC, [SKU] ASC)
);

