========================================================================
-- checking 'gold.dim_customers'
========================================================================
-- check for uniqueness of customer key in gold.dim_customers
-- Expectations : No results

SELECT 
 customer_key,
  COUNT(*) AS duplicates_count
FROM gold.dim_customers
GROUP BY customer_key
HAVING COUNT(*) > 1;

===================================================================================
-- checking 'gold.dim_products
====================================================================================
-- check for uniqueness of customer key in gold.dim_products
-- Expectations : No results
SELECT 
 product_key,
  COUNT(*) AS duplicates_count
FROM gold.dim_poducts
GROUP BY product_keys
HAVING COUNT(*) > 1;


-- ====================================================================
-- Checking 'gold.fact_sales'
-- ====================================================================
-- Check the data model connectivity between fact and dimensions
SELECT * 
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL OR c.customer_key IS NULL  
