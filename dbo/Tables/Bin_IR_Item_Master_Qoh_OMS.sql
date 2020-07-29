CREATE TABLE [dbo].[Bin_IR_Item_Master_Qoh_OMS] (
    [SKU]                  NVARCHAR (30)   NOT NULL,
    [BIN_SIZE]             NVARCHAR (10)   NOT NULL,
    [SENSOR_PERCENTAGE]    DECIMAL (7, 4)  NOT NULL,
    [ESTIMATED_QOH]        NUMERIC (18)    NULL,
    [IS_PRODUCT_TOO_LARGE] BIT             NULL,
    [NOTES]                NVARCHAR (2000) NULL,
    [TST_CENTER_BU]        NVARCHAR (5)    NULL,
    [TEST_DATE]            DATE            NULL,
    [TESTER_EMPLOYEE_ID]   NVARCHAR (30)   NULL,
    CONSTRAINT [Bin_IR_Item_Master_Qoh_PK] PRIMARY KEY CLUSTERED ([SKU] ASC, [BIN_SIZE] ASC, [SENSOR_PERCENTAGE] ASC)
);

