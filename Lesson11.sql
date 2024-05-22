-- 11.2 利用子查询进行过滤
SELECT order_num
FROM OrderItems
WHERE prod_id = 'RGAN01';
-- 输出结果为 20007, 20008
SELECT cust_id
FROM Orders
WHERE order_num IN (20007, 20008);
-- 结合这两个查询，把第一个查询（返回订单号的那一个）变为子查询
SELECT cust_id
FROM Orders
WHERE order_num IN (SELECT order_num
                    FROM OrderItems
                    WHERE prod_id = 'RGAN01');
-- 输出结果为 1000000004，1000000005
SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (1000000004, 1000000005);
-- 将这句转换为子查询
SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (SELECT cust_id
                  FROM Orders
                  WHERE order_num IN (SELECT order_num
                                      FROM OrderItems
                                      WHERE prod_id = 'RGAN01'));

-- 11.3 作为计算字段使用子查询
SELECT COUNT(*) AS orders
FROM Orders
WHERE cust_id = 1000000001;

SELECT cust_name,
       cust_state,
       (SELECT COUNT(*)
        FROM Orders
        WHERE Orders.cust_id = Customers.cust_id) AS orders
FROM Customers
ORDER BY cust_name;

-- 11.5
-- 1. 使用子查询，返回购买价格为 10 美元或以上产品的顾客列表。你需要使用 OrderItems 表查找匹配的订单号（order_num），然后使用Order 表检索这些匹配订单的顾客ID（cust_id）。
SELECT cust_id
FROM orders
WHERE order_num IN (SELECT order_num
                    FROM orderitems
                    WHERE item_price >= 10);

-- 2. 你想知道订购 BR01 产品的日期。编写 SQL 语句，使用子查询来确定哪些订单（在 OrderItems 中）购买了 prod_id 为 BR01 的产品，然后从 Orders 表中返回每个产品对应的顾客 IDcust_id）和订单日期（order_date）。按订购日期对结果进行排序。
SELECT cust_id, order_date
FROM orders
WHERE order_num IN (SELECT order_num
                    FROM orderitems
                    WHERE prod_id = 'BR01')
ORDER BY order_date;

-- 3．现在我们让它更具挑战性。在上一个挑战题，返回购买 prod_id 为 BR01 的产品的所有顾客的电子邮件（Customers 表中的 cust_email）。提示：这涉及 SELECT 语句，最内层的从 OrderItems 表返回 order_num，中间的从 Customers 表返回 cust_id。
SELECT cust_email
FROM customers
WHERE cust_id IN (SELECT cust_id
                  FROM orders
                  WHERE order_num IN (SELECT order_num
                                      FROM orderitems
                                      WHERE prod_id = 'BR01'));

-- 4．我们需要一个顾客 ID 列表，其中包含他们已订购的总金额。编写 SQL 语句，返回顾客 ID（Orders 表中的 cust_id），并使用子查询返回 total_ordered 以便返回每个顾客的订单总数。将结果按金额从大到小排序。提示：你之前已经使用 SUM() 计算订单总数。
SELECT cust_id,
       (SELECT SUM(item_price * quantity)
        FROM OrderItems
        WHERE Orders.order_num = OrderItems.order_num) AS total_ordered
FROM Orders
ORDER BY total_ordered DESC;

-- 5．再来。编写 SQL 语句，从 Products 表中检索所有的产品名称（prod_name），以及名为 quant_sold 的计算列，其中包含所售产品的总数（在 OrderItems 表上使用子查询和 SUM(quantity) 检索）。
SELECT prod_name,
       (SELECT Sum(quantity)
        FROM OrderItems
        WHERE Products.prod_id = OrderItems.prod_id) AS quant_sold
FROM Products;