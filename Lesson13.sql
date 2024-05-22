-- 13.1 使用表别名
SELECT cust_name, cust_contact
FROM Customers AS C,
     Orders AS O,
     OrderItems AS OI
WHERE C.cust_id = O.cust_id
  AND OI.order_num = O.order_num
  AND prod_id = 'RGAN01';

-- Oracle 中没有 AS

-- 13.2 使用不同类型的联结
-- 13.2.1 自联结
SELECT cust_id, cust_name, cust_contact
FROM Customers
WHERE cust_name = (SELECT cust_name
                   FROM Customers
                   WHERE cust_contact = 'Jim Jones');
-- 等价于
SELECT c1.cust_id, c1.cust_name, c1.cust_contact
FROM Customers AS c1,
     Customers AS c2
WHERE c1.cust_name = c2.cust_name
  AND c2.cust_contact = 'Jim Jones';

-- 13.2.2 自然联结
-- 自然联结要求你只能选择那些唯一的列，一般通过对一个表使用通配符（SELECT *），而对其他表的列使用明确的子集来完成。
SELECT C.*,
       O.order_num,
       O.order_date,
       OI.prod_id,
       OI.quantity,
       OI.item_price
FROM Customers AS C,
     Orders AS O,
     OrderItems AS OI
WHERE C.cust_id = O.cust_id
  AND OI.order_num = O.order_num
  AND prod_id = 'RGAN01';

-- 13.2.3 外联结
-- 内联结，检索所有顾客及其订单
SELECT Customers.cust_id, Orders.order_num
FROM Customers
         INNER JOIN Orders ON Customers.cust_id = Orders.cust_id;
-- 外联结语法类似。检索包括没有订单顾客在内的所有顾客
SELECT Customers.cust_id, Orders.order_num
FROM Customers
         LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;

-- LEFT OUTER JOIN 从 FROM 子句左边的表（Customers表）中选择所有行。为了从右边的表中选择所有行，需要使用 RIGHT OUTER JOIN
SELECT Customers.cust_id, Orders.order_num
FROM Customers
         RIGHT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;

-- MariaDB、MySQL和SQLite不支持FULL OUTER JOIN语法。
# SELECT Customers.cust_id, Orders.order_num
# FROM Customers
#          FULL OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id;

-- 13.3 使用带聚集函数的联结
SELECT Customers.cust_id,
       COUNT(Orders.order_num) AS num_ord
FROM Customers
         INNER JOIN Orders ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;

SELECT Customers.cust_id,
       COUNT(Orders.order_num) AS num_ord
FROM Customers
         LEFT OUTER JOIN Orders ON Customers.cust_id = Orders.cust_id
GROUP BY Customers.cust_id;

-- 13.6
-- 1. 使用INNER JOIN编写SQL语句，以检索每个顾客的名称（Customers表中的cust_name）和所有的订单号（Orders表中的order_num）。
SELECT customers.cust_name, orders.order_num
FROM customers
         INNER JOIN orders ON customers.cust_id = orders.cust_id
ORDER BY cust_name;

-- 2. 修改刚刚创建的SQL语句，仅列出所有顾客，即使他们没有下过订单。
SELECT DISTINCT customers.cust_name
FROM customers
         LEFT OUTER JOIN orders ON customers.cust_id = orders.cust_id
ORDER BY cust_name;

-- 3. 使用 OUTER JOIN 联结 Products 表和 OrderItems 表，返回产品名称（prod_name）和与之相关的订单号（order_num）的列表，并按商品名称排序。
SELECT products.prod_name, orderitems.order_num
FROM products
         LEFT OUTER JOIN orderitems ON products.prod_id = orderitems.prod_id
ORDER BY prod_name;

-- 4. 修改上一题中创建的SQL语句，使其返回每一项产品的总订单数（不是订单号）。
SELECT products.prod_name, COUNT(orderitems.order_num) AS orders
FROM products
         LEFT OUTER JOIN orderitems ON products.prod_id = orderitems.prod_id
GROUP BY products.prod_name
ORDER BY prod_name;

-- 5. 编写 SQL 语句，列出供应商（Vendors 表中的 vend_id）及其可供产品的数量，包括没有产品的供应商。
-- 你需要使用 OUTER JOIN 和 COUNT () 聚合函数来计算 Products 表中每种产品的数量。
-- 注意：vend_id 列会显示在多个表中，因此在每次引用它时都需要完全限定它
SELECT Vendors.vend_id, COUNT(prod_id)
FROM Vendors
         LEFT OUTER JOIN Products ON Vendors.vend_id = Products.vend_id
GROUP BY Vendors.vend_id;