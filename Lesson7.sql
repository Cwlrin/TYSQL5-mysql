-- 7.1 计算字段
-- 字段（field）基本上与列（column）的意思相同，经常互换使用

-- 7.2 拼接字段
-- 拼接（concatenate） 将值联结到一起（将一个值附加到另一个值）构成单个值，此操作符可用加号（+）或两个竖杠（||）表示
-- SQL Server 使用 +号。DB2、Oracle、PostgreSQL 和 SQLite 使用 ||，在 MySQL 和 MariaDB 中，必须使用特殊的函数。
-- 使用加号
# SELECT vend_name + '(' + vend_country + ')'
# FROM Vendors
# ORDER BY vend_name;
-- 使用 ||
# SELECT vend_name || '(' || vend_country || ')'
# FROM Vendors
# ORDER BY vend_name;
-- 使用 MySQL 或 MariaDB
SELECT Concat(vend_name, ' (', vend_country, ')')
FROM Vendors
ORDER BY vend_name;

-- RTRIM() 函数可以去掉字符串右边的空格，LTRIM() 去掉字符串左边的空格以及 TRIM() 去掉字符串左右两边的空格。
# SELECT RTRIM(vend_name) + ' (' + RTRIM(vend_country) + ')'
# FROM Vendors
# ORDER BY vend_name;

-- 别名（alias）是一个字段或值的替换名。别名用 AS 关键字赋予。
SELECT Concat(RTrim(vend_name), ' (', RTrim(vend_country), ')') AS vend_title
FROM Vendors
ORDER BY vend_name;
-- 别名的名字既可以是一个单词，也可以是一个字符串。如果是后者，字符串应该括在引号中

-- 7.3 执行算术计算
SELECT prod_id, quantity, item_price
FROM OrderItems
WHERE order_num = 20008;

SELECT prod_id,
       quantity,
       item_price,
       quantity * item_price AS expanded_price
FROM OrderItems
WHERE order_num = 20008;

-- 7.5 挑战题
-- 1. 别名的常见用法是在检索出的结果中重命名表的列字段（为了符合特定的报表要求或客户需求）。
-- 编写 SQL 语句，从 Vendors 表中检索 vend_id、vend_name、vend_address 和 vend_city，将 vend_name 重命名为 vname，将 vend_city 重命名为 vcity，将 vend_address 重命名为 vaddress。
-- 按供应商名称对结果进行排序（可以使用原始名称或新的名称）。
SELECT vend_id,
       vend_name    AS vname,
       vend_address AS vaddress,
       vend_city    AS vcity
FROM vendors
ORDER BY vend_name;

-- 2 我们的示例商店正在进行打折促销，所有产品均降价 10%。
-- 编写 SQL语句，从 Products 表中返回 prod_id、prod_price 和 sale_price。sale_price 是一个包含促销价格的计算字段。
-- 提示：可以乘以 0.9，得到原价的 90%（即 10%的折扣）
SELECT prod_id,
       prod_price,
       prod_price * 0.9 AS sale_price
FROM products