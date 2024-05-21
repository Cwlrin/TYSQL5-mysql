-- 2.2 检索单个列
SELECT prod_name
FROM Products;

-- 2.3 检索多个列
SELECT prod_id, prod_name, prod_price
FROM Products;

-- 2.4 检索所有列
SELECT *
FROM Products;

-- 2.5 检索不同的值
-- DISTINCT 关键字指示数据库只返回不同的值
SELECT DISTINCT vend_id
FROM Products;

-- 2.6 限制结果
-- MySQL 方言使用 LIMIT 子句
SELECT prod_name
FROM Products
LIMIT 5;

SELECT prod_name
FROM Products
LIMIT 5 OFFSET 5;

-- 2.7 注释1
# 注释2
/* 注释3 */

-- 2.9
-- 1  编写 SQL 语句，从 Customers 表中检索所有的 ID（cust_id）。
SELECT cust_id
FROM customers;

-- 2 OrderItems 表包含了所有已订购的产品（有些已被订购多次）。编写SQL 语句，检索并列出已订购产品（prod_id）的清单（不用列每个订单，只列出不同产品的清单）。提示：最终应该显示 7 行。
SELECT DISTINCT prod_id
FROM orderitems;

-- 3 编写 SQL语句，检索 Customers 表中所有的列，再编写另外的 SELECT语句，仅检索顾客的 ID。使用注释，注释掉一条 SELECT 语句，以便运行另一条 SELECT 语句。（当然，要测试这两个语句。）
# SELECT *
SELECT cust_id
FROM customers;