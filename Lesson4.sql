-- 4.1 使用 WHERE 子句
-- 在 SELECT 语句中，数据根据 WHERE 子句中指定的搜索条件进行过滤
SELECT prod_name, prod_price
FROM Products
WHERE prod_price = 3.49;

-- 在同时使用 ORDER BY 和 WHERE 子句时，应该让 ORDER BY 位于 WHERE 之后，否则将会产生错误

-- 4.2 WHERE 子句操作符
-- 4.2.1 检查单个值
SELECT prod_name, prod_price
FROM Products
WHERE prod_price < 10;

-- 4.2.2 不匹配检查
SELECT vend_id, prod_name
FROM Products
WHERE vend_id <> 'DLL01';
-- or
SELECT vend_id, prod_name
FROM Products
WHERE vend_id != 'DLL01';

-- 4.2.3 范围值检查
-- 要检查某个范围的值，可以使用 BETWEEN 操作符，必须指定两个值——所需范围的低端值和高端值，用 AND 关键字分隔
SELECT prod_name, prod_price
FROM Products
WHERE prod_price BETWEEN 5 AND 10;

-- 4.2.4 空值检查
SELECT prod_name
FROM Products
WHERE prod_price IS NULL;

SELECT cust_name
FROM Customers
WHERE cust_email IS NULL;

-- 4.4
-- 1 编写 SQL 语句，从 Products 表中检索产品 ID（prod_id）和产品名称（prod_name），只返回价格为 9.49 美元的产品。
SELECT prod_id, prod_name
FROM products
WHERE prod_price = 9.49;

-- 2 编写 SQL 语句，从 Products 表中检索产品 ID（prod_id）和产品名称（prod_name），只返回价格为 9 美元或更高的产品。
SELECT prod_id, prod_name
FROM products
WHERE prod_price >= 9;

-- 结合第 3 课和第 4 课编写 SQL 语句，从 OrderItems 表中检索出所有不同订单号（order_num），其中包含 100 个或更多的产品。
SELECT DISTINCT order_num
FROM orderitems
WHERE quantity >= 100;

-- 4 编写 SQL 语句，返回 Products 表中所有价格在 3 美元到 6 美元之间的产品的名称（prod_name）和价格（prod_price），然后按价格对结果进行排序。
-- （本题有多种解决方案，我们在下一课再讨论，不过你可以使用目前已学的知识来解决它。）
SELECT prod_name, prod_price
FROM products
WHERE prod_price BETWEEN 3 AND 6
ORDER BY prod_price;
