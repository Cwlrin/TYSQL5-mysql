-- 3.1 排序数据
-- ORDER BY 子句取一个或多个列的名字，据此对输出进行排序
SELECT prod_name
FROM Products
ORDER BY prod_name;

-- 3.2 按多个列排序
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price, prod_name;

-- 3.3 按列位置排序
-- ORDER BY 支持按相对列位置进行排序
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY 2, 3;

-- 3.4 指定排序方向
-- DESC 关键字可以进行降序排序
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC;

-- 多个列排序中，DESC 关键字只应用到直接位于其前面的列名
-- 如果想在多个列上进行降序排序，必须对每一列指定 DESC 关键字
SELECT prod_id, prod_price, prod_name
FROM Products
ORDER BY prod_price DESC, prod_name;

-- 3.6
-- 1 编写 SQL 语句，从 Customers 中检索所有的顾客名称（cust_names），
-- 并按从 Z 到 A 的顺序显示结果。
SELECT cust_name
FROM customers
ORDER BY cust_name DESC;

-- 2 编写 SQL 语句，从 Orders 表中检索顾客 ID（cust_id）和订单号（order_num），
-- 并先按顾客 ID 对结果进行排序，再按订单日期倒序排列。
SELECT cust_id, order_num
FROM orders
ORDER BY cust_id, order_date DESC;

-- 3 显然，我们的虚拟商店更喜欢出售比较贵的物品，而且这类物品有很多。
-- 编写 SQL 语句，显示 OrderItems 表中的数量和价格（item_price），
-- 并按数量由多到少、价格由高到低排序。
SELECT order_item, item_price
FROM orderitems
ORDER BY order_item DESC, item_price DESC;

-- 4 下面的 SQL 语句有问题吗？（尝试在不运行的情况下指出。
# SELECT vend_name,
# FROM Vendors
# ORDER vend_name DESC;
-- 应删去逗号，ORDER 后缺少 BY
