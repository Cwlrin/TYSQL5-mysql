-- 21.2 使用游标
DECLARE CustCursor CURSOR
    FOR
SELECT *
FROM Customers
WHERE cust_email IS NULL;
-- 21.2.2 使用游标
DELIMITER $$
CREATE PROCEDURE UseCursor()
BEGIN
    DECLARE done INT DEFAULT FALSE;
    DECLARE CustCursor CURSOR FOR SELECT * FROM Customers;
    DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;
    DECLARE Cust_id INT;
    DECLARE Cust_name VARCHAR(255);
    -- 假设顾客名称字段是 VARCHAR 类型

    -- 打开游标
    OPEN CustCursor;

    -- 循环遍历游标
    read_loop:
    LOOP
        FETCH CustCursor INTO Cust_id, Cust_name; -- 假设 Customers 表有 id 和 name 列
        IF done THEN
            LEAVE read_loop;
        END IF;

        -- 处理获取的数据
        -- ...
    END LOOP;

    -- 关闭游标
    CLOSE CustCursor;
END$$
DELIMITER ;

-- 21.2.3 关闭游标
CLOSE CustCursor
