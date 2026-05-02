/*
=========================================================================
DDL Script: Create Bronze Tables
=========================================================================
Script Purpose:
  This script creates tables in the 'bronze' schema, dropping existing tables
  if they already exist.
  Run this script to re-define the DDL structure of 'bronze' Tables
==============================================================================
*/

IF OBJECT_ID ('bronze.crm_cust_info' , 'U') IS NOT NULL
	DROP TABLE bronze.crm_cust_info
CREATE TABLE bronze.crm_cust_info(
  cst_id INT,
  cst_key NVARCHAR(50),
  cst_firstname NVARCHAR(50),
  cst_lastname NVARCHAR(50),
  cst_marital_status NVARCHAR(50),
  cst_gndr NVARCHAR(50),
  cst_create_date DATE
);

IF OBJECT_ID ('bronze.crm_prd_info', 'U') IS NOT NULL
	DROP TABLE bronze.crm_prd_info
CREATE TABLE bronze.crm_prd_info(
  prd_id INT,
  prd_key NVARCHAR(50),
  prd_nm NVARCHAR(50),
  prd_cost INT,
  prd_line NVARCHAR(50),
  prd_start_dt DATETIME,
  prd_end_dt DATETIME
);

IF OBJECT_ID ('bronze.crm_sales_details', 'U') IS NOT NULL
	DROP TABLE bronze.crm_sales_details
CREATE TABLE bronze.crm_sales_details(
  sls_ord_num NVARCHAR(50),
  sls_prd_key NVARCHAR(50),
  sls_cust_id INT,
  sls_order_dt NVARCHAR(20),
  sls_shp_dt NVARCHAR(20),
  sls_due_dt DATE,
  sls_sales INT,
  sls_quality INT,
  sls_price INT
);

IF OBJECT_ID ('bronze.erp_cust', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cust
CREATE TABLE bronze.erp_cust(
  cid NVARCHAR(50),
  BDATE DATE,
  GEN NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_loc', 'U') IS NOT NULL
	DROP TABLE bronze.erp_loc
CREATE TABLE bronze.erp_loc(
  CID NVARCHAR(50),
  CNTRY NVARCHAR(50)
);

IF OBJECT_ID ('bronze.erp_cat', 'U') IS NOT NULL
	DROP TABLE bronze.erp_cat
CREATE TABLE bronze.erp_cat(
  ID NVARCHAR(50),
  CAT NVARCHAR(50),
  SUBCAT NVARCHAR(50),
  MAINTENANCE NVARCHAR(50)
);
