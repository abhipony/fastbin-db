

CREATE FUNCTION [dbo].[FastBin_Report_Fn](@P_Date DATETIME)
RETURNS TABLE 
AS
       RETURN 
(
with fastbin_dat as(select DISTINCT a.*, case when a.binsize=220 then 'Small'
when a.binsize=230 then 'Medium'
when a.binsize=240 then 'Large' end bin_size  from [dbo].[FastBinDeviceDtl]a),
min_sensorPCT
     AS (  SELECT DISTINCT sku,
                  bin_size,
                  CASE WHEN MIN (sensor_percentage) = 25 THEN 25 ELSE 50 END
                  sensor_percentage
             FROM  [dbo].[Bin_IR_Item_Master_Qoh_OMS] a
         GROUP BY SKU, bin_size),
sensor_data
     AS (SELECT DISTINCT a.SKU,a.sensor_percentage as 'Actual_Sensor_Pct',
                b.sensor_percentage as 'Min_Sensor_Pct',
                a.bin_size,
                a.estimated_QOH
           FROM [dbo].[Bin_IR_Item_Master_Qoh_OMS] a,min_sensorPCT b
where a.sensor_percentage= b.sensor_percentage and a.sku=b.sku and a.bin_size=b.bin_size)
SELECT Distinct a.BIN_ID,
       b.owner_bu AS 'Owner_BU',
       max(b.CUST_NAME) AS 'Cust_Name',
       a.CUST_NO AS 'Cust_No',
       max(b.Location_name) AS 'Location',
       a.PLANOGRAM_ID AS'Planogram_ID',
       b.PLANOGRAM_NAME AS 'Device_Name',
       c.BIN_SIZE AS 'Bin_Size' ,
       d.BIN_SIZE AS 'FBBin_Size' ,
       max(b.BIN_ROW) AS 'Bin_Row',
       cast(max(b.BIN_ROW) as varchar) + '-' + cast(max(b.BIN_COLUMN) as varchar) AS 'Bin_position',
       max(CONVERT(VARCHAR(12),d.tstmp, 101)) AS 'Last_heartbeat',
       count(distinct a.bin_ID) AS 'No_of_Reports',
       max(d.upp) AS 'No_of_Updates_per_period',
       b.sku AS 'Fastenal SKU',
       max(b.cust_sku) AS 'Customer Part',
       b.SKU_DESCRIPTION AS 'Item Description',
      -- 'est start QOH' AS 'Estimated Starting QOH',
       --'est end QOH' AS 'Estimated Ending QOH'
       max(a.MIN_QTY) AS 'Min_Qty',
       max(a.MAX_QTY) AS 'Max_Qty',
       max(a.MINIMUM_ORDER_QTY) AS 'Minimum_Order_Qty',
       --pkg qty
       --Price each
      max(c.SENSOR_PERCENTAGE) AS 'Test_Center_Pct',
      max(c.ESTIMATED_QOH) AS 'Test_Center_Qty',
       round((( max(c.ESTIMATED_QOH)/ max(sd.Actual_sensor_pct))*max(d.sensorperc)),2)  AS 'Test_Center_Approx_Qty',
       max(b.last_order_creation_dt) as 'Oldest Back Order',
       --Days below min
       --Days since last order
       max(b.last_order_creation_dt) as 'Date of Last_order',
       max(b.last_order_creation_dt) as 'Ordered Time',
       max(b.last_modified_user) AS 'Orderer',
       max(a.QTY_ON_ORDER) AS 'QOO',
       max(a.estimated_QOH) AS 'Estimated_QOH',
       max(b.last_modified_user) AS 'Deliverer',
       sum(b.delivered_qty) AS 'Delivered_QTY',
       a.LAST_MODIFIED_DT AS 'Last_Modified_Dt',
       max(d.sensorperc) AS 'FastBin_sensor_pct',max(TransType) AS 'Bin_Type'
  FROM (([dbo].[Bin_Planogram_Product_OMS] a INNER JOIN
       [dbo].[Bin_Orders_PackingSlip_Dtl_OMS] b on a.PLANOGRAM_ID = b.PLANOGRAM_ID
	    AND a.sku = b.sku
		--AND CONVERT(VARCHAR(12),a.LAST_MODIFIED_DT, 101) = CONVERT(VARCHAR(12),@P_Date, 101)
		)
		INNER JOIN 
       [dbo].[Bin_IR_Item_Master_Qoh_OMS] c on (a.sku = c.sku)
	   INNER JOIN
       fastbin_dat d on (a. BIN_ID=d.BDADDR and CONVERT(VARCHAR(12),a.LAST_MODIFIED_DT,101)= CONVERT(VARCHAR(12),d.tstmp, 101) AND
	   c.bin_size = d.bin_size)
	   INNER JOIN
	   sensor_data sd on (c.bin_size = sd.bin_size
       AND c.sensor_percentage=sd.Actual_sensor_pct
       --AND sd.Actual_sensor_pct=d.sensorpct
      ))
GROUP BY   a.BIN_ID,b.owner_bu,
           a.PLANOGRAM_ID,
            b.PLANOGRAM_NAME,
            a.CUST_NO,a.LAST_MODIFIED_DT,
             b.sku,b.SKU_DESCRIPTION,c.SKU,c.BIN_SIZE, d.BIN_SIZE,
              cast((b.BIN_ROW) as varchar) + '-' + cast((b.BIN_COLUMN) as varchar)
                                            )