-- 8.2 使用函数
-- 8.2.1 文本处理函数
-- UPPER() 将文本转换为大写
SELECT vend_name, UPPER(vend_name) AS vend_name_upcase
FROM Vendors
ORDER BY vend_name;

-- SOUNDEX() 用于返回字符串的 SOUNDEX 值，能对字符串进行发音比较而不是字母比较
SELECT cust_name, cust_contact
FROM Customers
WHERE cust_contact = 'Michael Green';

SELECT cust_name, cust_contact
FROM Customers
WHERE SOUNDEX(cust_contact) = SOUNDEX('Michael Green');

-- 8.2.2 日期和时间处理函数
SELECT order_num
FROM Orders
WHERE YEAR(order_date) = 2020;

-- 8.2.3 数值处理函数

-- 8.4
-- 1. 我们的商店已经上线了，正在创建顾客账户。所有用户都需要登录名，默认登录名是其名称和所在城市的组合。
-- 编写 SQL 语句，返回顾客 ID（cust_id）、顾客名称（customer_name）和登录名（user_login），其中登录名全部为大写字母，并由顾客联系人的前两个字符（cust_contact）和其所在城市的前三个字符（cust_city）组成。
-- 例如，我的登录名是 BEOAK（Ben Forta，居住在 Oak Park）。
-- 提示：需要使用函数、拼接和别名。
SELECT cust_id,
       cust_name,
       UPPER(
               CONCAT(LEFT(cust_contact, 2), LEFT(cust_city, 3))
       ) AS user_login
FROM customers;

-- 2. 编写 SQL 语句，返回 2020 年 1 月的所有订单的订单号（order_num）和订单日期（order_date），并按订单日期排序。
-- 你应该能够根据目前已学的知识来解决此问题，但也可以开卷查阅 DBMS 文档。
SELECT order_num, order_date
FROM orders
WHERE YEAR(order_date) = 2020
  AND MONTH(order_date) = 1
ORDER BY order_date