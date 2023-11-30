-- 製品マスタテーブル
CREATE TABLE product_master (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(255),
    description TEXT,
    price DECIMAL(10, 2),
    delete_flg BOOLEAN,
    last_update_date TIMESTAMP
);

-- 顧客マスタテーブル
CREATE TABLE customer_master (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(255),
    contact_info VARCHAR(255),
    address VARCHAR(255),
    last_update_date TIMESTAMP
);

-- 部署マスタテーブル
CREATE TABLE dept_master (
    dept_id INT PRIMARY KEY,
    dept_name VARCHAR(255),
    last_update_date TIMESTAMP
);

-- 従業員マスタテーブル
CREATE TABLE employee_master (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(255),
    dept_id INT,
    last_update_date TIMESTAMP,
    FOREIGN KEY (dept_id) REFERENCES dept_master(dept_id)
);

-- 受注管理テーブル
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    order_date DATETIME,
    customer_id INT,
    employee_id INT,
    total_amount DECIMAL(12, 2),
    delivery_date DATETIME,
    order_status VARCHAR(255),
    last_update_date TIMESTAMP,
    FOREIGN KEY (customer_id) REFERENCES customer_master(customer_id),
    FOREIGN KEY (employee_id) REFERENCES employee_master(employee_id)
);

-- 受注明細テーブル
CREATE TABLE order_details (
    order_detail_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    unit_price DECIMAL(10, 2),
    discount_rate DECIMAL(5, 2),
    last_update_date TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id),
    FOREIGN KEY (product_id) REFERENCES product_master(product_id)
);

-- 売上管理テーブル
CREATE TABLE sales (
    order_id INT PRIMARY KEY,
    total_amount DECIMAL(12, 2),
    expense_amount DECIMAL(12, 2),
    gross_profit_amount DECIMAL(12, 2),
    dept_id INT,
    record_date DATETIME,
    last_update_date TIMESTAMP,
    FOREIGN KEY (order_id) REFERENCES orders(order_id)
    FOREIGN KEY (dept_id) REFERENCES dept_master(dept_id)
);

-- 在庫管理テーブル
CREATE TABLE inventory (
    product_id INT PRIMARY KEY,
    update_date TIMESTAMP PRIMARY KEY,
    quantity_on_hand INT,
    FOREIGN KEY (product_id) REFERENCES product_master(product_id)
);
