-- 10.1 数据分组
SELECT COUNT(*) AS num_prods
FROM Products
WHERE vend_id = 'DLL01';

-- 10.2 创建分组
-- 下列语句中，GROUP BY 子句指示 DBMS 按 vend_id 排序并分组数据
SELECT vend_id, COUNT(*) AS num_prods
FROM Products
GROUP BY vend_id;

-- 10.3 过滤分组
-- HAVING 支持所有 WHERE 操作符
-- WHERE 在数据分组前进行过滤，HAVING 在数据分组后进行过滤
SELECT cust_id, COUNT(*) AS orders
FROM Orders
GROUP BY cust_id
HAVING COUNT(*) >= 2;

SELECT vend_id, COUNT(*) AS num_prods
FROM Products
WHERE prod_price >= 4
GROUP BY vend_id
HAVING COUNT(*) >= 2;

-- 10.4 分组和排序
SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY order_num
HAVING COUNT(*) >= 3;

SELECT order_num, COUNT(*) AS items
FROM OrderItems
GROUP BY order_num
HAVING COUNT(*) >= 3
ORDER BY items, order_num;

-- 10.7
-- 1. OrderItems 表包含每个订单的每个产品。编写 SQL 语句，返回每个订单号（order_num）各有多少行数（order_lines），并按 order_lines 对结果进行排序。
SELECT order_num, COUNT(*) AS order_lines
FROM orderitems
GROUP BY order_num
ORDER BY order_lines;

-- 2. 编写 SQL 语句，返回名为 cheapest_item 的字段，该字段包含每个供应商成本最低的产品（使用 Products 表中的 prod_price），然后从最低成本到最高成本对结果进行排序
SELECT vend_id, MIN(prod_price) AS cheapest_item
FROM products
GROUP BY vend_id
ORDER BY cheapest_item;

-- 3. 确定最佳顾客非常重要，请编写 SQL 语句，返回至少含 100 项的所有订单的订单号（OrderItems表中的order_num）
SELECT order_num
FROM orderitems
GROUP BY order_num
HAVING SUM(quantity) >= 100
ORDER BY order_num;

-- 4. 确定最佳顾客的另一种方式是看他们花了多少钱。编写SQL语句，返回总价至少为1000的所有订单的订单号（OrderItems表中的order_num）。
-- 提示：需要计算总和（item_price乘以quantity）。按订单号对结果进行排序。
SELECT order_num, SUM(item_price * quantity) AS total_price
FROM OrderItems
GROUP BY order_num
HAVING SUM(item_price * quantity) >= 1000
ORDER BY order_num;

-- 5. 下面的 SQL 语句有问题吗？（尝试在不运行的情况下指出。）
# SELECT order_num, COUNT(*) AS items
# FROM OrderItems
# GROUP BY items
# HAVING COUNT(*) >= 3
# ORDER BY items, order_num;
-- GROUP BY 项是错误的。GROUP BY 必须是实际列，而不是用于执行汇总计算的列。允许使用 GROUP BY order_num。