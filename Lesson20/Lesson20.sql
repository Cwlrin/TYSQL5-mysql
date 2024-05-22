-- 20.1 事务处理
-- 事务处理用来管理 INSERT、UPDATE 和 DELETE 语句。不能回退 SELECT 语句（回退 SELECT 语句也没有必要），也不能回退 CREATE 或 DROP 操作。事务处理中可以使用这些语句，但进行回退时，这些操作也不撤销。

-- 20.2 控制事务处理
START TRANSACTION;

-- 20.2.1 使用 ROLLBACK
DELETE
FROM Orders;
ROLLBACK;

-- 20.2.2 使用COMMIT
START TRANSACTION;
DELETE
FROM OrderItems
WHERE order_num = 12345;
DELETE
FROM Orders
WHERE order_num = 12345;
COMMIT;

-- 20.2.3 使用保留点
ROLLBACK TO delete1;