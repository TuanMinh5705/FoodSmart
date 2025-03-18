use foodsmart;


DELIMITER //
CREATE PROCEDURE Get_Merchant_Stats(IN merchantID INT)
BEGIN
    -- Tổng đơn hàng & tổng doanh thu
    SELECT 
        COUNT(o.order_id) AS total_orders,
        COALESCE(SUM(i.total_amount), 0) AS total_revenue
    FROM Orders o
    LEFT JOIN Invoices i ON o.order_id = i.order_id
    WHERE o.store_id IN (SELECT store_id FROM Stores WHERE merchant_id = merchantID);

    -- Top 5 sản phẩm bán chạy
    SELECT 
        p.product_name,
        SUM(po.quantity) AS total_sold
    FROM Products p
    JOIN Products_Orders po ON p.product_id = po.product_id
    WHERE p.store_id IN (SELECT store_id FROM Stores WHERE merchant_id = merchantID)
    GROUP BY p.product_id, p.product_name
    ORDER BY total_sold DESC
    LIMIT 5;

    -- Doanh thu chi tiết theo tuần (từng ngày trong tuần)
    SELECT 
        d.day,
        COALESCE(SUM(i.total_amount), 0) AS revenue
    FROM (
        SELECT CURDATE() - INTERVAL (n - 1) DAY AS day
        FROM (SELECT 0 AS n UNION SELECT 1 UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6) numbers
    ) d
    LEFT JOIN Orders o ON DATE(o.order_date) = d.day 
        AND o.store_id IN (SELECT store_id FROM Stores WHERE merchant_id = merchantID)
    LEFT JOIN Invoices i ON o.order_id = i.order_id
    WHERE WEEK(d.day) = WEEK(CURRENT_DATE)
    GROUP BY d.day
    ORDER BY d.day ASC;

    -- Doanh thu chi tiết theo tháng (từng ngày trong tháng, linh hoạt theo số ngày thực tế của tháng)
    SELECT 
        d.day,
        COALESCE(SUM(i.total_amount), 0) AS revenue
    FROM (
        SELECT DATE_ADD(DATE_SUB(LAST_DAY(CURRENT_DATE), INTERVAL DAY(LAST_DAY(CURRENT_DATE)) - 1 DAY), INTERVAL (n - 1) DAY) AS day
        FROM (
            SELECT 1 AS n UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 UNION SELECT 7 
            UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12 UNION SELECT 13 
            UNION SELECT 14 UNION SELECT 15 UNION SELECT 16 UNION SELECT 17 UNION SELECT 18 UNION SELECT 19 
            UNION SELECT 20 UNION SELECT 21 UNION SELECT 22 UNION SELECT 23 UNION SELECT 24 UNION SELECT 25 
            UNION SELECT 26 UNION SELECT 27 UNION SELECT 28 UNION SELECT 29 UNION SELECT 30 UNION SELECT 31
        ) days
        WHERE n <= DAY(LAST_DAY(CURRENT_DATE))  -- Chỉ lấy đúng số ngày của tháng hiện tại
    ) d
    LEFT JOIN Orders o ON DATE(o.order_date) = d.day 
        AND o.store_id IN (SELECT store_id FROM Stores WHERE merchant_id = merchantID)
    LEFT JOIN Invoices i ON o.order_id = i.order_id
    WHERE MONTH(d.day) = MONTH(CURRENT_DATE)
    GROUP BY d.day
    ORDER BY d.day ASC;

   -- Doanh thu chi tiết theo năm (từng tháng trong năm, luôn có đủ 12 tháng)
SELECT 
    d.month,
    COALESCE(SUM(i.total_amount), 0) AS revenue
FROM (
    SELECT 1 AS month UNION SELECT 2 UNION SELECT 3 UNION SELECT 4 UNION SELECT 5 UNION SELECT 6 
    UNION SELECT 7 UNION SELECT 8 UNION SELECT 9 UNION SELECT 10 UNION SELECT 11 UNION SELECT 12
) d
LEFT JOIN Orders o ON MONTH(o.order_date) = d.month 
    AND o.store_id IN (SELECT store_id FROM Stores WHERE merchant_id = merchantID)
    AND YEAR(o.order_date) = YEAR(CURRENT_DATE)
LEFT JOIN Invoices i ON o.order_id = i.order_id
GROUP BY d.month
ORDER BY d.month ASC;
END //
DELIMITER ;


CREATE TABLE IF NOT EXISTS Categories_Stores (
    store_id INT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories (category_id) ON DELETE CASCADE,
    FOREIGN KEY (store_id) REFERENCES Stores (store_id) ON DELETE CASCADE
);

DELIMITER //
CREATE TRIGGER after_store_insert
AFTER INSERT ON Stores
FOR EACH ROW
BEGIN
    INSERT INTO Categories_Stores (store_id, category_id)
    SELECT NEW.store_id, category_id FROM Categories;
END;
//
DELIMITER ;
DELIMITER //

CREATE PROCEDURE register_account(
    IN p_username    VARCHAR(255),
    IN p_password    VARCHAR(255),
    IN p_address     TEXT,
    IN p_phonenumber VARCHAR(255),
    IN p_avtPath TEXT,
    IN p_rolename VARCHAR(255)
)
BEGIN
    DECLARE v_role_id    INT;
    DECLARE v_account_id INT;

    -- Bắt đầu transaction để đảm bảo tính toàn vẹn dữ liệu
    START TRANSACTION;

    -- Lấy role_id của role 'user'
    SELECT role_id 
      INTO v_role_id
      FROM Roles 
     WHERE role_name = p_rolename
     LIMIT 1;

    IF v_role_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Role "user" không tồn tại!';
    END IF;

    -- Chèn thông tin tài khoản vào bảng Account
    INSERT INTO Account (username, `password`,avt_path, role_id)
    VALUES (p_username, p_password,p_avtPath, v_role_id);

    -- Lấy account_id vừa được tạo
    SET v_account_id = LAST_INSERT_ID();

    -- Chèn thông tin chi tiết tài khoản vào bảng Account_Details
    INSERT INTO Account_Details (user_id, address, phonenumber, is_default)
    VALUES (v_account_id, p_address, p_phonenumber, true);

    COMMIT;
END //

DELIMITER ;

DELIMITER //
CREATE PROCEDURE updateAccountInfo(
    IN p_account_id INT,
    IN p_username VARCHAR(255),
    IN p_password VARCHAR(255),
    IN p_active BOOLEAN,
    IN p_avt_path TEXT,
    IN p_role_name VARCHAR(255)
)
BEGIN
    DECLARE v_role_id INT;

    -- Lấy role_id từ role_name
    SELECT role_id INTO v_role_id
    FROM Roles
    WHERE role_name = p_role_name
    LIMIT 1;

    -- Nếu không tìm thấy role_name, thoát không cập nhật gì
    IF v_role_id IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Role name không hợp lệ!';
    END IF;

    -- Cập nhật thông tin tài khoản trong bảng `Account`
    UPDATE `Account`
    SET username = p_username,
        `password` = p_password,
        `active` = p_active,
        avt_path = p_avt_path,
        role_id = v_role_id
    WHERE account_id = p_account_id;
END //
DELIMITER ;

CREATE VIEW ProductSummary AS
SELECT p.*, 
       c.category_id, 
       c.category_name,
       s.store_name,
       COALESCE(SUM(po.quantity), 0) AS total_sold
FROM Products p
LEFT JOIN Products_Orders po ON p.product_id = po.product_id
LEFT JOIN Products_Categories pc ON p.product_id = pc.product_id
LEFT JOIN Categories c ON pc.category_id = c.category_id
LEFT JOIN Stores s ON p.store_id = s.store_id
GROUP BY p.product_id, p.product_name, p.price, p.stock_quantity, p.discount, p.store_id,
         c.category_id, c.category_name, s.store_name;




