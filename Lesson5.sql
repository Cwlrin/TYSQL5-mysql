-- 5.1 组合 WHERE 子句
-- 5.1.1 AND操作符
-- AND : 用在 WHERE 子句中的关键字，用来指示检索满足所有给定条件的行
SELECT prod_id, prod_price, prod_name
FROM Products
WHERE vend_id = 'DLL01'
  AND prod_price <= 4;

-- 可以增加多个过滤条件，每个条件间都要使用 AND 关键字

-- 5.1.2 OR操作符
-- OR : WHERE 子句中使用的关键字，用来表示检索匹配任一给定条件的行。
SELECT prod_id, prod_price, prod_name
FROM Products
WHERE vend_id = 'DLL01'
   OR vend_id = 'BRS01';

-- 5.1.3 求值顺序
# SELECT prod_name, prod_price
# FROM Products
# WHERE vend_id = 'DLL01' OR vend_id = 'BRS01'
#     AND prod_price >= 10;
-- SQL 在处理 OR 操作符前，优先处理 AND 操作符
-- 在 WHERE 子句中使用圆括号，圆括号具有比 AND 或 OR 操作符更高的优先级
SELECT prod_name, prod_price
FROM Products
WHERE (vend_id = 'DLL01' OR vend_id = 'BRS01')
  AND prod_price >= 10;

-- 5.2 IN 操作符
-- IN : WHERE 子句中用来指定要匹配值的清单的关键字，功能与 OR 相当
SELECT prod_name, prod_price
FROM Products
WHERE vend_id IN ('DLL01', 'BRS01')
ORDER BY prod_name;
-- 等价以下 SQL
# SELECT prod_name, prod_price
# FROM Products
# WHERE vend_id = 'DLL01' OR vend_id = 'BRS01'
# ORDER BY prod_name;

-- 5.3 NOT 操作符
-- NOT : WHERE 子句中用来否定其后条件的关键字。
SELECT prod_name
FROM Products
WHERE NOT vend_id = 'DLL01'
ORDER BY prod_name;
-- 等价以下 SQL
# SELECT prod_name
# FROM Products
# WHERE vend_id <> 'DLL01'
# ORDER BY prod_name;

-- 5.5
-- 1 编写 SQL 语句，从 Vendors 表中检索供应商名称（vend_name），仅返回加利福尼亚州的供应商
-- （这需要按国家[USA]和州[CA]进行过滤，没准其他国家也存在一个加利福尼亚州）。
-- 提示：过滤器需要匹配字符串。
SELECT vend_name
FROM vendors
WHERE vend_country = 'USA'
  AND vend_state = 'CA';

-- 2 编写 SQL 语句，查找所有至少订购了总量 100 个的 BR01、BR02 或BR03 的订单。
-- 你需要返回 OrderItems 表的订单号（order_num）、产品 ID（prod_id）和数量，并按产品 ID 和数量进行过滤。
-- 提示：根据编写过滤器的方式，可能需要特别注意求值顺序。
SELECT order_num, prod_id, quantity
FROM orderitems
WHERE prod_id IN ('BR01', 'BR02', 'BR03')
  AND quantity >= 100;

-- 现在，我们回顾上一课的挑战题。编写 SQL 语句，
-- 返回所有价格在 3 美元到 6 美元之间的产品的名称（prod_name）和价格（prod_price）。
-- 使用 AND，然后按价格对结果进行排序。
SELECT prod_name, prod_price
FROM products
WHERE prod_price >= 3
  AND prod_price <= 6
ORDER BY prod_price;

-- 4. 下面的 SQL 语句有问题吗？（尝试在不运行的情况下指出。）
# SELECT vend_name
# FROM Vendors
# ORDER BY vend_name
# WHERE vend_country = 'USA' AND vend_state = 'CA';
-- ORDER BY 必须跟在 WHERE 子句之后
