-- 16.1 更新数据
UPDATE Customers
SET cust_email = 'kim@thetoystore.com'
WHERE cust_id = 1000000005;

-- 更新多个列
UPDATE Customers
SET cust_contact = 'Sam Roberts',
    cust_email   = 'sam@toyland.com'
WHERE cust_id = 1000000006;

-- 要删除某个列的值，可设置它为NULL（假如表定义允许NULL值）
UPDATE Customers
SET cust_email = NULL
WHERE cust_id = 1000000005;

-- 16.2 删除数据
DELETE
FROM Customers
WHERE cust_id = 1000000006;

-- 16.5 挑战题
-- 1. 美国各州的缩写应始终用大写。编写 SQL 语句来更新所有美国地址，包括供应商状态（Vendors 表中的 vend_state）和顾客状态（Customers 表中的 cust_state），使它们均为大写。
UPDATE Vendors
SET vend_state = UPPER(vend_state)
WHERE vend_country = 'USA';
UPDATE Customers
SET cust_state = UPPER(cust_state)
WHERE cust_country = 'USA';


-- 2. 第 15 课的挑战题 1 要求你将自己添加到 Customers 表中。现在请删除自己。确保使用 WHERE 子句（在 DELETE 中使用它之前，先用 SELECT 对其进行测试），否则你会删除所有顾客！
DELETE Customers
WHERE cust_id = 1000000042;