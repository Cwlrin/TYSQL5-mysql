-- 18.1 视图
-- 视图是虚拟的表。与包含数据的表不一样，视图只包含使用时动态检索数据的查询
SELECT cust_name, cust_contact
FROM Customers,
     Orders,
     OrderItems
WHERE Customers.cust_id = Orders.cust_id
  AND OrderItems.order_num = Orders.order_num
  AND prod_id = 'RGAN01';
-- 假如可以把整个查询包装成一个名为ProductCustomers的虚拟表
SELECT cust_name, cust_contact
FROM ProductCustomers
WHERE prod_id = 'RGAN01';

-- 18.2 创建视图
CREATE VIEW ProductCustomers AS
SELECT cust_name, cust_contact, prod_id
FROM Customers,
     Orders,
     OrderItems
WHERE Customers.cust_id = Orders.cust_id
  AND OrderItems.order_num = Orders.order_num;
-- 此时可运行
SELECT cust_name, cust_contact
FROM ProductCustomers
WHERE prod_id = 'RGAN01';

-- 18.2.2 用视图重新格式化检索出的数据
SELECT Concat(RTrim(vend_name), ' (', RTrim(vend_country), ')') AS vend_title
FROM Vendors
ORDER BY vend_name;
-- 把此语句转换为视图
CREATE VIEW VendorLocations AS
SELECT Concat(RTrim(vend_name), ' (', RTrim(vend_country), ')') AS vend_title
FROM Vendors;

SELECT *
FROM VendorLocations;

-- 18.2.3 用视图过滤不想要的数据
-- 定义Customer-EMailList视图，过滤没有电子邮件地址的顾客
CREATE VIEW CustomerEMailList AS
SELECT cust_id, cust_name, cust_email
FROM Customers
WHERE cust_email IS NOT NULL;

SELECT *
FROM CustomerEMailList;

-- 18.2.4 使用视图与计算字段
SELECT prod_id,
       quantity,
       item_price,
       quantity * item_price AS expanded_price
FROM OrderItems
WHERE order_num = 20008;
-- 把此语句转换为视图
CREATE VIEW OrderItemsExpanded AS
SELECT order_num,
       prod_id,
       quantity,
       item_price,
       quantity * item_price AS expanded_price
FROM OrderItems;
-- 检索订单20008的详细内容（上面的输出），如下进行
SELECT *
FROM OrderItemsExpanded
WHERE order_num = 20008;

-- 18.4
-- 1. 创建一个名为CustomersWithOrders的视图，其中包含Customers表中的所有列，但仅仅是那些已下订单的列。提示：可以在Orders表上使用JOIN来仅仅过滤所需的顾客，然后使用SELECT来确保拥有正确的数据。
CREATE VIEW CustomersWithOrders AS
SELECT Customers.cust_id,
       Customers.cust_name,
       Customers.cust_address,
       Customers.cust_city,
       Customers.cust_state,
       Customers.cust_zip,
       Customers.cust_country,
       Customers.cust_contact,
       Customers.cust_email
FROM Customers
         JOIN Orders ON Customers.cust_id = Orders.cust_id;

-- 2. 下面的 SQL 语句有问题吗？（尝试在不运行的情况下指出。）
# CREATE VIEW OrderItemsExpanded AS
# SELECT order_num,
#        prod_id,
#        quantity,
#        item_price,
#        quantity * item_price AS expanded_price
# FROM OrderItems
# ORDER BY order_num;
-- 视图中不允许使用 ORDER BY。如果你想在从视图检索数据的 SELECT中使用 ORDER BY 对数据进行排序，则视图的使用方式与表相同