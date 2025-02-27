use foodsmart;
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




