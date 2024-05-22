-- 17.1 创建表
-- 17.1.1 表创建基础
-- 下面的 SQL 语句创建本书中所用的 Products 表
CREATE TABLE Products
(
    prod_id    CHAR(10)      NOT NULL,
    vend_id    CHAR(10)      NOT NULL,
    prod_name  CHAR(254)     NOT NULL,
    prod_price DECIMAL(8, 2) NOT NULL,
    prod_desc  VARCHAR(1000) NULL
);

-- 17.1.2 使用NULL值
-- 每个表列要么是NULL列，要么是NOT NULL列，这种状态在创建时由表的定义规定
CREATE TABLE Orders
(
    order_num  INTEGER  NOT NULL,
    order_date DATETIME NOT NULL,
    cust_id    CHAR(10) NOT NULL
);

-- 下一个例子将创建混合了NULL和NOT NULL列的表
CREATE TABLE Vendors
(
    vend_id      CHAR(10) NOT NULL,
    vend_name    CHAR(50) NOT NULL,
    vend_address CHAR(50),
    vend_city    CHAR(50),
    vend_state   CHAR(5),
    vend_zip     CHAR(10),
    vend_country CHAR(50)
);

-- 17.1.3 指定默认值
-- SQL允许指定默认值，在插入行时如果不给出值，DBMS将自动采用默认值。默认值在CREATE TABLE语句的列定义中用关键字DEFAULT指定
CREATE TABLE OrderItems
(
    order_num  INTEGER       NOT NULL,
    order_item INTEGER       NOT NULL,
    prod_id    CHAR(10)      NOT NULL,
    quantity   INTEGER       NOT NULL DEFAULT 1,
    item_price DECIMAL(8, 2) NOT NULL
);

-- 17.2 更新表
ALTER TABLE Vendors
    ADD vend_phone CHAR(20);

ALTER TABLE Vendors
    DROP COLUMN vend_phone;

-- 17.3 删除表
DROP TABLE CustCopy;

-- 17.6
-- 1. 在Vendors表中添加一个网站列（vend_web）。你需要一个足以容纳URL的大文本字段
ALTER TABLE Vendors
    ADD vend_web CHAR(100);

-- 2. 使用UPDATE语句更新Vendor记录，以便加入网站（你可以编造任何地址）
UPDATE Vendors
SET vend_web = 'https://google.com/'
WHERE vend_id = 'DLL01';