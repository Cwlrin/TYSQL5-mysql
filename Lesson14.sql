-- 14.2 创建组合查询
-- 可用UNION操作符来组合数条SQL查询。利用UNION，可给出多条SELECT语句，将它们的结果组合成一个结果集。

-- 14.2.1 使用UNION
-- 使用UNION很简单，所要做的只是给出每条SELECT语句，在各条语句之间放上关键字UNION
-- 语句 1
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL', 'IN', 'MI');
-- 语句 2
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All';
-- 组合这两条语句
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL', 'IN', 'MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All';

-- 14.2.3 包含或取消重复的行
-- 如果想返回所有的匹配行，可使用UNION ALL而不是UNION
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL', 'IN', 'MI')
UNION ALL
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All';

-- 14.2.4 对组合查询结果排序
-- 在用UNION组合查询时，只能使用一条ORDER BY子句，它必须位于最后一条SELECT语句之后
-- 不允许使用多条ORDER BY子句
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_state IN ('IL', 'IN', 'MI')
UNION
SELECT cust_name, cust_contact, cust_email
FROM Customers
WHERE cust_name = 'Fun4All'
ORDER BY cust_name, cust_contact;

-- 14.4 挑战题
-- 1. 编写 SQL 语句，将两个 SELECT 语句结合起来，以便从 OrderItems 表中检索产品 ID（prod_id）和 quantity。
-- 其中，一个 SELECT 语句过滤数量为 100 的行，另一个 SELECT 语句过滤 ID 以 BNBG 开头的产品。按产品 ID 对结果进行排序。
SELECT orderitems.prod_id, orderitems.quantity
FROM orderitems
WHERE quantity = 100
UNION
SELECT prod_id, orderitems.quantity
FROM orderitems
WHERE prod_id LIKE 'BNBG%'
ORDER BY prod_id;

-- 2. 重写刚刚创建的SQL语句，仅使用单个SELECT语句。
SELECT orderitems.prod_id, orderitems.quantity
FROM orderitems
WHERE quantity = 100
   OR prod_id LIKE 'BNBG%'
ORDER BY prod_id;

-- 3. 我知道这有点荒谬，但这节课中的一个注释提到过。编写 SQL 语句，组合 Products 表中的产品名称（prod_name）和 Customers 表中的顾客名称（cust_name）并返回，然后按产品名称对结果进行排序。
SELECT prod_name
FROM Products
UNION
SELECT cust_name
FROM Customers
ORDER BY prod_name;

-- 4．下面的SQL语句有问题吗？（尝试在不运行的情况下指出。）
# SELECT cust_name, cust_contact, cust_email
# FROM Customers
# WHERE cust_state = 'MI'
# ORDER BY cust_name;
# UNION
# SELECT cust_name, cust_contact, cust_email
# FROM Customers
# WHERE cust_state = 'IL'ORDER BY cust_name;
-- 第一个 SELECT 语句后的;不应该出现，它将终止该语句。同样，如果将结合 UNION 的 SELECT 语句进行排序，则只能使用一个 ORDER BY，并且它必须跟在最后一个 SELECT 之后。