-- 22.1 约束

-- 22.1.1 主键
CREATE TABLE Vendors
(
    vend_id      CHAR(10) NOT NULL PRIMARY KEY,
    vend_name    CHAR(50) NOT NULL,
    vend_address CHAR(50) NULL,
    vend_city    CHAR(50) NULL,
    vend_state   CHAR(5)  NULL,
    vend_zip     CHAR(10) NULL,
    vend_country CHAR(50) NULL
);

ALTER TABLE Vendors
    ADD CONSTRAINT PRIMARY KEY (vend_id);

-- 22.1.2 外键
CREATE TABLE Orders
(
    order_num  INTEGER  NOT NULL PRIMARY KEY,
    order_date DATETIME NOT NULL,
    cust_id    CHAR(10) NOT NULL REFERENCES Customers (cust_id)
);

ALTER TABLE Orders
    ADD CONSTRAINT
        FOREIGN KEY (cust_id) REFERENCES Customers (cust_id);

-- 22.1.4 检查约束
CREATE TABLE OrderItems
(
    order_num  INTEGER  NOT NULL,
    order_item INTEGER  NOT NULL,
    prod_id    CHAR(10) NOT NULL,
    quantity   INTEGER  NOT NULL CHECK (quantity > 0),
    item_price MONEY NOT NULL
);

ADD CONSTRAINT
CHECK (gender LIKE '[MF]');
-- 22.2 索引
CREATE INDEX prod_name_ind
    ON Products (prod_name);

-- 22.3 触发器
DELIMITER $$
CREATE TRIGGER customer_state
    BEFORE INSERT
    ON Customers
    FOR EACH ROW
BEGIN
    SET NEW.cust_state = UPPER(NEW.cust_state);
END$$
DELIMITER ;