-- 19.3 执行存储过程
# EXECUTE AddNewProduct('JTS01',
#     'Stuffed Eiffel Tower',
#     6.49,
#     'Plush stuffed toy with the text La Tour Eiffel in red white and blue');

-- 19.4 创建存储过程
-- 书上代码为 Oracle 和 SQL Server 版本，下略，下面代码为 MySQL 版本
-- 对邮件发送清单中具有邮件地址的顾客进行计数
DELIMITER //
CREATE PROCEDURE MailingListCount(
    OUT ListCount INT
)
BEGIN
    DECLARE v_rows INT DEFAULT 0;
    SELECT COUNT(*)
    INTO v_rows
    FROM Customers
    WHERE cust_email IS NOT NULL;
    SET ListCount = v_rows;
END//
DELIMITER ;
-- 调用 MySQL 例子
CALL MailingListCount(@ReturnValue);
SELECT @ReturnValue;

-- 在 Orders 表中插入一个新订单
DELIMITER //
CREATE PROCEDURE NewOrder(IN cust_id CHAR(10))
BEGIN
    -- 为订单号声明一个变量
    DECLARE order_num INT;
    -- 获取当前最大订单号
    SELECT MAX(order_num)
    INTO order_num
    FROM Orders;
    -- 决定下一个订单号
    SET order_num = order_num + 1;
    -- 插入新订单
    INSERT INTO Orders(order_num, order_date, cust_id)
    VALUES (order_num, NOW(), cust_id);
    -- 将新订单号作为输出参数返回
    SELECT order_num;
END//
DELIMITER ;