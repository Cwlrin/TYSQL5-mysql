-- 15.1 数据插入
-- 15.1.1 插入完整的行
INSERT INTO Customers
VALUES (1000000006,
        'Toy Land',
        '123 Any Street',
        'New York',
        'NY',
        '11111',
        'USA',
        NULL,
        NULL);

-- 在某些SQL实现中，跟在INSERT之后的INTO关键字是可选的。但是，即使不一定需要，最好还是提供这个关键字，这样做将保证SQL代码在DBMS之间可移植。
-- 编写INSERT语句的更安全（不过更烦琐）的方法如下
INSERT INTO Customers(cust_id,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country,
                      cust_contact,
                      cust_email)
VALUES (1000000006,
        'Toy Land',
        '123 Any Street',
        'New York',
        'NY',
        '11111',
        'USA',
        NULL,
        NULL);

-- 下面的INSERT语句填充所有列（与前面的一样），但以一种不同的次序填充。因为给出了列名，所以插入结果仍然正确
INSERT INTO Customers(cust_id,
                      cust_contact,
                      cust_email,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip)
VALUES (1000000006,
        NULL,
        NULL,
        'Toy Land',
        '123 Any Street',
        'New York',
        'NY',
        '11111');

-- 15.1.2 插入部分行
INSERT INTO Customers(cust_id,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country)
VALUES (1000000006,
        'Toy Land',
        '123 Any Street',
        'New York',
        'NY',
        '11111',
        'USA');

-- 15.1.3 插入检索出的数据
INSERT INTO Customers(cust_id,
                      cust_contact,
                      cust_email,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country)
SELECT cust_id,
       cust_contact,
       cust_email,
       cust_name,
       cust_address,
       cust_city,
       cust_state,
       cust_zip,
       cust_country
FROM CustNew;

-- 15.2 从一个表复制到另一个表
CREATE TABLE CustCopy AS
SELECT *
FROM Customers;
-- SQL Server 写法
# SELECT *
# INTO CustCopy
# FROM Customers;

-- 15。4
-- 1. 使用 INSERT 和指定的列，将你自己添加到 Customers 表中。明确列出要添加哪几列，且仅需列出你需要的列。
INSERT INTO Customers(cust_id,
                      cust_name,
                      cust_address,
                      cust_city,
                      cust_state,
                      cust_zip,
                      cust_country,
                      cust_email)
VALUES (1000000042,
        'Ben''s Toys',
        '123 Main Street',
        'Oak Park',
        'MI',
        '48237',
        'USA',
        'ben@forta.com');
-- 2. 备份 Orders 表和 OrderItems 表
CREATE TABLE OrdersBackup AS
SELECT *
FROM Orders;
CREATE TABLE OrderItemsBackup AS
SELECT *
FROM OrderItems;