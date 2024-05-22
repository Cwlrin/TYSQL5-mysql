-- 12.2 创建联结
SELECT vend_name, prod_name, prod_price
FROM Vendors,
     Products
WHERE Vendors.vend_id = Products.vend_id;

-- 12.2.1 WHERE 子句的重要性
-- 笛卡儿积（cartesian product）由没有联结条件的表关系返回的结果为笛卡儿积。检索出的行的数目将是第一个表中的行数乘以第二个表中的行数。
SELECT vend_name, prod_name, prod_price
FROM Vendors,
     Products;
-- 有时，返回笛卡儿积的联结，也称叉联结（cross join）。

-- 12.2.2 内联结
SELECT vend_name, prod_name, prod_price
FROM Vendors
         INNER JOIN Products ON Vendors.vend_id = Products.vend_id;

-- 12.2.3 联结多个表
SELECT prod_name, vend_name, prod_price, quantity
FROM OrderItems,
     Products,
     Vendors
WHERE Products.vend_id = Vendors.vend_id
  AND OrderItems.prod_id = Products.prod_id
  AND order_num = 20007;
-- 11 课例子
SELECT cust_name, cust_contact
FROM Customers
WHERE cust_id IN (SELECT cust_id
                  FROM Orders
                  WHERE order_num IN (SELECT order_num
                                      FROM OrderItems
                                      WHERE prod_id = 'RGAN01'));
-- 等价于
SELECT cust_name, cust_contact
FROM Customers,
     Orders,
     OrderItems
WHERE Customers.cust_id = Orders.cust_id
  AND OrderItems.order_num = Orders.order_num
  AND prod_id = 'RGAN01';

-- 12.4
-- 1. 编写 SQL 语句，返回 Customers 表中的顾客名称（cust_name）和 Orders 表中的相关订单号（order_num），并按顾客名称再按订单号对结果进行排序。
-- 实际上是尝试两次，一次使用简单的等联结语法，一次使用 INNER JOIN。
-- 等联结
SELECT cust_name, order_num
FROM customers,
     orders
WHERE Customers.cust_id = Orders.cust_id
ORDER BY cust_name, order_num;
-- INNER JOIN
SELECT cust_name, order_num
FROM customers
         INNER JOIN orders ON Customers.cust_id = Orders.cust_id
ORDER BY cust_name, order_num;
-- 2. 我们来让上一题变得更有用些。除了返回顾客名称和订单号，添加第三列 OrderTotal，其中包含每个订单的总价。
-- 有两种方法可以执行此操作：使用 OrderItems 表的子查询来创建 OrderTotal 列，或者将 OrderItems 表与现有表联结并使用聚合函数。
-- 提示：请注意需要使用完全限定列名的地方。
-- 使用子查询的解法
SELECT cust_name,
       order_num,
       (SELECT Sum(item_price * quantity)
        FROM OrderItems
        WHERE Orders.order_num = OrderItems.order_num) AS OrderTotal
FROM Customers,
     Orders
WHERE Customers.cust_id = Orders.cust_id
ORDER BY cust_name, order_num;
-- 使用联结的解法
SELECT cust_name, orders.order_num, SUM(item_price * order_item) AS OrderTotal
FROM customers,
     orders,
     orderitems
WHERE orders.order_num = orderitems.order_num
  AND Customers.cust_id = Orders.cust_id
GROUP BY cust_name, Orders.order_num
ORDER BY cust_name, order_num;

-- 3. 我们重新看一下第 11 课的挑战题 2。编写 SQL 语句，检索订购产品 BR01 的日期，这一次使用联结和简单的等联结语法。输出应该与第 11 课的输出相同。
# SELECT cust_id, order_date
# FROM orders
# WHERE order_num IN (SELECT order_num
#                     FROM orderitems
#                     WHERE prod_id = 'BR01')
# ORDER BY order_date;
SELECT orders.cust_id, orders.order_date
FROM orders,
     orderitems
WHERE orders.order_num = orderitems.order_num
  AND prod_id = 'BR01'
ORDER BY order_date;

-- 4. 很有趣，我们再试一次。重新创建为第 11 课挑战题 3 编写的 SQL 语句，这次使用 ANSI 的 INNER JOIN 语法。
-- 在之前编写的代码中使用了两个嵌套的子查询。要重新创建它，需要两个 INNER JOIN 语句，每个语句的格式类似于本课讲到的 INNER JOIN 示例，而且不要忘记 WHERE 子句可以通过 prod_id 进行过滤。
# SELECT cust_email
# FROM customers
# WHERE cust_id IN (SELECT cust_id
#                   FROM orders
#                   WHERE order_num IN (SELECT order_num
#                                       FROM orderitems
#                                       WHERE prod_id = 'BR01'));
SELECT cust_email
FROM customers
         INNER JOIN orders ON customers.cust_id = orders.cust_id
         INNER JOIN orderitems ON orders.order_num = orderitems.order_num
WHERE prod_id = 'BR01';

-- 5. 再让事情变得更加有趣些，我们将混合使用联结、聚合函数和分组。准备好了吗？回到第 10 课，当时的挑战是要求查找值等于或大于 1000 的所有订单号。
-- 这些结果很有用，但更有用的是订单数量至少达到这个数的顾客名称。因此，编写 SQL 语句，使用联结从 Customers 表返回顾客名称（cust_name），并从 OrderItems 表返回所有订单的总价。
-- 提示：要联结这些表，还需要包括 Orders 表（因为 Customers 表与 OrderItems 表不直接相关，Customers 表与 Orders 表相关，而 Orders 表与 OrderItems 表相关）。
-- 不要忘记 GROUP BY 和 HAVING，并按顾客名称对结果进行排序。你可以使用简单的等联结或 ANSI 的 INNER JOIN 语法。或者，如果你很勇敢，请尝试使用两种方式编写。
-- 等值连接语法
SELECT cust_name, SUM(item_price * quantity) AS total_price
FROM Customers,
     Orders,
     OrderItems
WHERE Customers.cust_id = Orders.cust_id
  AND Orders.order_num = OrderItems.order_num
GROUP BY cust_name
HAVING SUM(item_price * quantity) >= 1000
ORDER BY cust_name;

-- ANSI INNER JOIN 语法
SELECT cust_name, SUM(item_price * quantity) AS total_price
FROM customers
         INNER JOIN orders ON customers.cust_id = orders.cust_id
         INNER JOIN orderitems ON orderitems.order_num = orders.order_num
GROUP BY cust_name
HAVING SUM(item_price * quantity) >= 1000
ORDER BY cust_name;


