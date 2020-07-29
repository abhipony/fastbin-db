create PROCEDURE dbo.UpdateQohBelowMinDate_Job AS 
BEGIN
	WITH cteQOH (planogram_id,BinId,MinQty,Qoh)
	AS ( 
	SELECT  planogram_id,BinId,MIN_QTY AS MinQty , ROUND(( q.estimated_qoh / q.sensor_percentage)*n.sensorperc, 0) AS Qoh  FROM FastBinIR n 
		LEFT JOIN bin_planogram_product_oms p 
			ON n.BinId = p.bin_id 
			LEFT JOIN bin_ir_item_master_qoh_oms q 
			ON p.SKU = q.SKU 
				AND bin_size = CASE n.binsize 
				WHEN 240 THEN 'Large' 
				WHEN 230 THEN 'Medium' 
				WHEN 220 THEN 'Small' 
				END 
				AND q.sensor_percentage = 25.000   )
	 
	UPDATE  ir set ir.QohBelowMinDate = CASE  
											WHEN s.MinQty > s.qoh AND ir.QohBelowMinDate IS NULL THEN Getdate() 
											WHEN s.qoh IS NULL OR Isnull(s.qoh, 0) >= s.MinQty THEN NULL 
											ELSE ir.QohBelowMinDate END
		FROM FastBinIR ir LEFT JOIN cteQOH s on ir.BinId = s.BinId 
END