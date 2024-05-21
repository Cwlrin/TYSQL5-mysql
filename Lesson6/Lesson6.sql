-- 6.1 LIKE 操作符
-- 通配符：用来匹配值的一部分的特殊字符。
-- 搜索模式：由字面值、通配符或两者组合构成的搜索条件。

-- 6.1.1 百分号（%）通配符
-- % 表示任何字符出现任意次数，代表搜索模式中给定位置的 0 个、1 个或多个字符
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE 'Fish%';
-- 通配符可在搜索模式中的任意位置使用，并且可以使用多个通配符
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '%bean bag%';
-- 通配符也可以出现在搜索模式的中间
SELECT prod_name
FROM Products
WHERE prod_name LIKE 'F%y';
-- '%'不会匹配产品名称为 NULL 的行

-- 6.1.2 下划线（_）通配符
-- 下划线的用途与 % 一样，但它只匹配单个字符，而不是多个字符
SELECT prod_id, prod_name
FROM Products
WHERE prod_name LIKE '__ inch teddy bear';

-- 6.1.3 方括号（[ ]）通配
-- 方括号（[]）通配符用来指定一个字符集，它必须匹配指定位置（通配符的位置）的一个字符。
-- SQL Server 支持集合，，但是 MySQL，Oracle，DB2，SQLite都不支持。
# SELECT cust_contact
# FROM Customers
# WHERE cust_contact LIKE '[JM]%'
# ORDER BY cust_contact;
-- 此通配符可以用前缀字符 ^（脱字号）来否定
# SELECT cust_contact
# FROM Customers
# WHERE cust_contact LIKE '[^JM]%'
# ORDER BY cust_contact;
-- 也可以使用 NOT 操作符得出类似的结果
# SELECT cust_contact
# FROM Customers
# WHERE NOT cust_contact LIKE '[JM]%'
# ORDER BY cust_contact;

-- 6.4
-- 1 编写 SQL 语句，从 Products 表中检索产品名称（prod_name）和描述（prod_desc），仅返回描述中包含 toy 一词的产品。
SELECT prod_name, prod_desc
FROM products
WHERE prod_desc LIKE '%toy%';

-- 2 反过来再来一次。编写 SQL 语句，从 Products 表中检索产品名称（prod_name）和描述（prod_desc），仅返回描述中未出现 toy 一词的产品。这次，按产品名称对结果进行排序。
SELECT prod_name, prod_desc
FROM products
WHERE NOT prod_desc LIKE '%toy%'
ORDER BY prod_name;

-- 3 编写 SQL 语句，从 Products 表中检索产品名称（prod_name）和描述（prod_desc），仅返回描述中同时出现 toy 和 carrots 的产品。
-- 有好几种方法可以执行此操作，但对于这个挑战题，请使用 AND 和两个 LIKE 比较。
SELECT prod_name, prod_desc
FROM products
WHERE prod_desc LIKE '%toy%'
  AND prod_desc LIKE '%carrots%';

-- 4 来个比较棘手的。我没有特别向你展示这个语法，而是想看看你根据目前已学的知识是否可以找到答案。
-- 编写 SQL 语句，从 Products 表中检索产品名称（prod_name）和描述（prod_desc），仅返回在描述中以先后顺序同时出现 toy 和 carrots 的产品。
-- 提示：只需要用带有三个 % 符号的 LIKE 即可。
SELECT prod_name, prod_desc
FROM products
WHERE prod_desc LIKE '%toy%carrots%';