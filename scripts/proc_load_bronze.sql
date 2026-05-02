/*
==============================================================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
================================================================================================================
Script Purpose:
    This stored procedure loads data into the 'bronze' schema from external CSV files.
    It performs the following actions:
    - Truncates the bronze tables before loading data.
    - Uses the `BULK INSERT` command to load data from csv files to bronze tables.
Parameters:
    None.
  This stored procedure does not accept any parameters or return any values.

Usage Example:
  EXEC bronze.load_bronze;
=============================================================================================================
*/
CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME,   @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY
		SET @batch_start_time = GETDATE();
		PRINT'==============================================================';
		PRINT'loading Bronze Layer';
		PRINT'==============================================================';

		PRINT'===============================================================';
		PRINT'Loading CRM Tables';
		PRINT'===============================================================';
		
		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info

		PRINT'Loading Table bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'E:\Downloads\Dataware House Project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '----------------';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_prd_info';
		 TRUNCATE TABLE bronze.crm_prd_info

		 PRINT'Loading Table bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'E:\Downloads\Dataware House Project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '----------------';


		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.crm_sales_details';
		TRUNCATE TABLE bronze.crm_sales_details

		PRINT'Loading Table bronze.crm_sales_details';
		BULK INSERT bronze.crm_sales_details
		FROM 'E:\Downloads\Dataware House Project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '----------------';

			PRINT'===============================================================';
			PRINT'Loading ERP Tables';
			PRINT'===============================================================';

		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.erp_cat';
		TRUNCATE TABLE bronze.erp_cat
		PRINT'>> Loading table erp.cat';

		BULK INSERT bronze.erp_cat
		FROM 'E:\Downloads\Dataware House Project\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '----------------';


			SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.erp_loc';
		TRUNCATE TABLE bronze.erp_loc;

		PRINT'>> Loading table bronze.erp.loc';
		BULK INSERT bronze.erp_loc
		FROM 'E:\Downloads\Dataware House Project\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '----------------';



		SET @start_time = GETDATE();
		PRINT'>> Truncating Table: bronze.erp_cust';
		TRUNCATE TABLE bronze.erp_cust

		PRINT'>> Loading table erp.cust';
		BULK INSERT bronze.erp_cust
		FROM 'E:\Downloads\Dataware House Project\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT'>> Load duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + 'seconds'
		PRINT '----------------';

		SET @batch_end_time = GETDATE();
		PRINT '=========================================================';
		PRINT 'Loading Bronze Layer is completed';
		PRINT '  - Total duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
	END TRY
	BEGIN CATCH
		PRINT '=======================================================';
		PRINT 'ERROR OCCURED DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '========================================================';
	END CATCH
END
