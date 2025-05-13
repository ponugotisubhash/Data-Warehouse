/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files. 
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv Files to bronze tables.

Parameters:
    None. 
	  This stored procedure does not accept any parameters or return any values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

Execute bronze.load_bronze;
Create Or Alter Procedure bronze.load_bronze As
Begin
	Declare @Start_time DateTime, @End_time DateTime, @Start_Batch_layer DateTime, @End_Batch_Layer DateTime
	Begin Try
			Set @Start_Batch_layer=GetDate();
			Print '==============================';
			Print 'Loading Bronze Layer';
			Print '==============================';

			Print '------------------------------';
			Print 'Loading CRM Tables';
			Print '------------------------------';
			
			Set @Start_time = GetDate();
			PRINT '>> Truncating Table: bronze.crm_cust_info';
			Truncate Table bronze.crm_cust_info;
			PRINT '>> Inserting Data Into: bronze.crm_cust_info';
			Bulk insert bronze.crm_cust_info
			From 'C:\Users\chinn\OneDrive\Desktop\mydatabase\source_crm\cust_info.csv'
			With ( 
				Firstrow = 2,
				Fieldterminator = ',',
				Tablock
				)
			Set @End_time = GetDate();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
			PRINT '>> -------------';

			Set @Start_time = GetDate();
			PRINT '>> Truncating Table: bronze.crm_prd_info';
			Truncate Table bronze.crm_prd_info;
			PRINT '>> Inserting Data Into: bronze.crm_prd_info';
			Bulk insert bronze.crm_prd_info
			From 'C:\Users\chinn\OneDrive\Desktop\mydatabase\source_crm\prd_info.csv'
			With ( 
				Firstrow = 2,
				Fieldterminator = ',',
				Tablock
				)
				Set @End_time = GetDate();
				PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
				PRINT '>> -------------';

			Set @Start_time = GetDate();
			PRINT '>> Truncating Table: bronze.crm_sales_details';
			Truncate Table bronze.crm_sales_details;
			PRINT '>> Inserting Data Into: bronze.crm_sales_details';
			Bulk insert bronze.crm_sales_details
			From 'C:\Users\chinn\OneDrive\Desktop\mydatabase\source_crm\sales_details.csv'
			With ( 
				Firstrow = 2,
				Fieldterminator = ',',
				Tablock
				)
				SET @end_time = GETDATE();
				PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
				PRINT '>> -------------';

			Print '------------------------------';
			Print 'Loading ERP Tables';
			Print '------------------------------';

			Set @Start_time = GetDate();
			Print '>> Truncating Table: bronze.erp_cust_AZ12';
			Truncate Table bronze.erp_cust_AZ12;
			Print '>> Inserting Data Into: bronze.erp_cust_AZ12';
			Bulk insert bronze.erp_cust_AZ12
			From 'C:\Users\chinn\OneDrive\Desktop\mydatabase\source_erp\CUST_AZ12.csv'
			With ( 
				Firstrow = 2,
				Fieldterminator = ',',
				Tablock
				)
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
			PRINT '>> -------------';

			Set @Start_time = GetDate();
			Print '>> Truncating Table: bronze.erp_loc_a101';
			Truncate Table bronze.erp_loc_a101;
			Print '>> Inserting Data Into: bronze.erp_loc_a101';
			Bulk insert bronze.erp_loc_a101
			From 'C:\Users\chinn\OneDrive\Desktop\mydatabase\source_erp\LOC_A101.csv'
			With ( 
				Firstrow = 2,
				Fieldterminator = ',',
				Tablock
				)
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
			PRINT '>> -------------';

			Set @Start_time = GetDate();
			Print '>> Truncating Table: bronze.erp_px_cat_g1v2';
			Truncate Table bronze.erp_px_cat_g1v2;
			Print '>> Inserting Data Into: bronze.erp_px_cat_g1v2';
			Bulk insert bronze.erp_px_cat_g1v2
			From 'C:\Users\chinn\OneDrive\Desktop\mydatabase\source_erp\PX_CAT_G1V2.csv'
			With ( 
				Firstrow = 2,
				Fieldterminator = ',',
				Tablock
				)
			SET @end_time = GETDATE();
			PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds';
			PRINT '>> -------------';

			Set @End_Batch_Layer=GetDate();
			PRINT '=========================================='
			PRINT 'Loading Bronze Layer is Completed';
			Print '>> Total Load Duration:' + cast(DateDiff(second, @Start_Batch_Layer, @End_Batch_Layer) As NVARCHAR)+'seconds';
			PRINT '=========================================='
	End Try
	Begin Catch
	PRINT '=========================================='
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER'
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================='
	End Catch	
End
