-- 9.1 聚集函数
-- 9.1.1 AVG() 函数
-- AVG() 通过对表中行数计数并计算其列值之和，求得该列的平均值
SELECT AVG(prod_price) AS avg_price
FROM Products;

-- AVG() 也可以用来确定特定列或行的平均值
SELECT AVG(prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01';

-- 9.1.2 COUNT() 函数
-- COUNT()函数进行计数。可利用COUNT()确定表中行的数目或符合特定条件的行的数目
-- 使用COUNT(＊)对表中行的数目进行计数，不管表列中包含的是空值（NULL）还是非空值
SELECT COUNT(*) AS num_cust
FROM Customers;

-- 使用 COUNT(column) 对特定列中具有值的行进行计数，忽略 NULL 值
SELECT COUNT(cust_email) AS num_cust
FROM Customers;

-- 9.1.3 MAX() 函数
-- MAX() 返回指定列中的最大值
SELECT MAX(prod_price) AS max_price
FROM Products;

-- 9.1.4 MIN() 函数
-- MIN() 返回指定列的最小值
SELECT MIN(prod_price) AS min_price
FROM Products;

-- 9.1.5 SUM() 函数
-- SUM() 用来返回指定列值的和（总计）
SELECT SUM(quantity) AS items_ordered
FROM OrderItems
WHERE order_num = 20005;

-- SUM()也可以用来合计计算值
SELECT SUM(item_price * quantity) AS total_price
FROM OrderItems
WHERE order_num = 20005;

-- 9.2 聚集不同值
-- 以上5个聚集函数都可以如下使用。
-- - 对所有行执行计算，指定 ALL 参数或不指定参数（因为 ALL 是默认行为）
-- - 只包含不同的值，指定 DISTINCT 参数。
SELECT AVG(DISTINCT prod_price) AS avg_price
FROM Products
WHERE vend_id = 'DLL01';

-- DISTINCT不能用于COUNT(*)

-- 9.3 组合聚集函数
SELECT COUNT(*)        AS num_items,
       MIN(prod_price) AS price_min,
       MAX(prod_price) AS price_max,
       AVG(prod_price) AS price_avg
FROM Products;

-- 9.5
-- 1. 编写SQL语句，确定已售出产品的总数（使用OrderItems中的quantity列）
SELECT SUM(quantity)
FROM orderitems;

-- 2. 修改刚刚创建的语句，确定已售出产品项（prod_item）BR01的总数。
SELECT SUM(quantity)
FROM orderitems
WHERE prod_id = 'BR01';

-- 3. 编写SQL语句，确定 Products 表中价格不超过 10 美元的最贵产品的价格（prod_price）。将计算所得的字段命名为 max_price。
SELECT MAX(prod_price) AS max_price
FROM products
WHERE prod_price <= 10;
