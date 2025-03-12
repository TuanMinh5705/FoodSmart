insert into Roles(role_name) values
('Admin'),
('User'),
('Merchant');

insert into `Account`(username, `password`, role_id) values ('NgocThom', 'Vy12092001', 1),
       ('TuanMinh', 'Minh123', 1),
       ('DucKhanh', 'Khanh123', 1),
       ('VanDam', 'Dam123', 1),
       ('abc', 'abc123', 3),
       ('bac', 'abc123', 3),
       ('ade','abc123',2),
       ('abc1','abc123',2),
       ('abc2','abc123',2);
insert into account_details(user_id,address,phonenumber,is_default) value
(7,"nhổn","0123456789",1),
(7,"nhổn2","0123498765",0);

INSERT INTO Categories(category_name, `description`, avt_path) VALUES
    ("Đồ ăn nhanh", "Đồ ăn nhanh", 'fast_food.png'),
    ('Bánh mì', 'Bánh mì', 'bread.png'),
    ('Cơm,Cơm rang', 'Cơm,Cơm rang', 'chicken_rice.png'),
    ('Mì , bún , phở', 'Mì , bún , phở', 'noodles.png'),
    ('Đồ tráng miệng ', 'Đồ tráng miệng ', 'chocolate_cake.png'),
    ("Đồ uống", "Đồ uống", 'fruit.png'),
    ('Salat', 'Các salat thơm ngon', 'salat.png'),
    ('Kem', 'Các loại kem hấp dẫn', 'ice2.png'),
    ('Nước đống chai', 'Nước đống chai', 'coca.png'),
    ('Pizza', 'Các loại pizza phong cách Ý', 'pizza.png');

insert into Stores(merchant_id, store_name, store_address, contact_number) values 
(7, 'Cơm rang và phở bò Minh Khánh', '102 Tu Hoàng , Minh Khai , Bắc Từ Liêm , Hà Nội', '0123456789'),
(8, 'Pizza Hut', '202 Đường Phan Xích Long, Quận Phú Nhuận, TP.HCM', '0945123456'),
(6, 'Lẩu Bò Ba Toa', '303 Đường Hai Bà Trưng, Đà Lạt', '0956123456');
INSERT INTO Products (store_id, product_name, price, stock_quantity) VALUES
    (3, 'Cơm rang dưa bò', 35000, 20),
    (3, 'Phở bò', 40000, 20),
    (3, 'Bún chả Hà Nội', 45000, 30),
    (3, 'Bánh cuốn nóng', 30000, 25),
    (3, 'Pizza Margherita', 180000, 15),
    (3, 'Pizza Xúc Xích', 190000, 10),
    (3, 'Pizza Hải Sản', 200000, 12),
    (3, 'Mì Ý Carbonara', 120000, 18),
    (2, 'Lẩu bò đặc biệt', 250000, 8),
    (2, 'Bánh mì bò né', 40000, 25),
    (2, 'Bún bò Huế', 50000, 30),
    (2, 'Gỏi cuốn tôm thịt', 30000, 40),
    (2, 'Bánh Flan', 20000, 50),
    (2, 'Trà Sữa Matcha', 50000, 60),
    (2, 'Cà phê sữa đá', 25000, 50),
    (1, 'Sinh tố bơ', 45000, 40),
    (1, 'Trà đào cam sả', 55000, 45),
    (1, 'Nước ép cam', 35000, 50),
    (1, 'Gà rán sốt cay', 75000, 30),
    (1, 'Khoai tây chiên', 30000, 60),
    (1, 'Lẩu hải sản chua cay', 280000, 10);
   


INSERT INTO Product_Images (product_id, is_primary, image_path) VALUES  
    (1, TRUE, 'fried_rice.png'), 
    (1, false, 'fried_rice2.png'), 
    (1, false, 'vegetable.png'), 
    (2, TRUE, 'beef_pho.png'),  
    (2, false, 'noodle soup.png'),  
    (2, false, 'noodle soup.png'),  
    (3, TRUE, 'bunCha.png'),  
    (3, false, 'bunCha.png'),  
    (3, false, 'bunCha.png'),  
    (4, TRUE, 'taco.png'),  
    (4, FALSE, 'spring rolls.png'),  
    (4, FALSE, 'spring rolls1.png'),  
    (5, TRUE, 'sausage pizza.png'),
    (5, FALSE, 'sausage pizza1.png'),
    (5, FALSE, 'sausage pizza2.png'),
    (6, TRUE, 'sausage pizza.png'),
    (6, false, 'sausage pizza1.png'),
    (6, false, 'sausage pizza2.png'),
    (7, true, 'seafood pizza2.png'),
    (7, false, 'seafood pizza.png'),
    (7, false, 'seafood pizza2.png'),
    (8, true, 'spaghetti.png'),
    (8, false, 'spaghetti1.png'),
    (8, false, 'spaghetti3.png'),
    (9, true, 'hotpot.png'),
    (9, false, 'beef hotpot1.png'),
    (9, false, 'beef hotpot2.png'),
    (10, TRUE, 'doner.png'),
    (10, false, 'chesse.png'),
    (10, false, 'pate.png'),
    (11, TRUE, 'bunBo.png'),
    (11, FALSE, 'noodle soup.png'),
    (11, FALSE, 'buncha.png'),
    (12, true, 'spring rolls.png'),
    (12, false, 'spring rolls1.png'),
    (12, false, 'taco.png'),
    (13, TRUE, 'flan.png'),
    (13, TRUE, 'flan1.png'),
    (13, TRUE, 'flan2.png'),
    (14, TRUE, 'matcha.png'),
    (14, false, 'matcha.png'),
    (14, false, 'matcha.png'),
    (15, true, 'coffee3.png'),
    (15, false, 'coffee.png'),
    (15, false, 'coffee1.png'),
    (16, true, 'avocado_smoothie.png'),
    (16, false, 'avocado_smoothie1.png'),
    (16, false, 'avocado_smoothie2.png'),
    (17, true, 'peach_tea1.png'),
    (17, false, 'peach_tea2.png'),
    (17, false, 'peach_tea3.png'),
    (18, true, 'orange_juice1.png'),
    (18, false, 'orange_juice.png'),
    (18, false, 'orange_juice2.png'),
    (19, true, 'fried chicken1.png'),
    (19, false, 'fried chicken2.png'),
    (19, false, 'fried chicken.png'),
    (20, true, 'fried_potatoes.png'),
    (20, true, 'fried_potatoes2.png'),
    (20, true, 'fried_potatoes1.png'),
    (21, false, 'hotpot.png'),
    (21, false, 'beef hotpot.png'),
    (21, false, 'beef hotpot1.png');


insert into Carriers(carrier_name, contact_phone, shipping_cost)
values ("Be", '0867536601', 25000),
       ("Grap", "0342707049", 25000);
       
insert into Shippers(carrier_id,shipper_name,phonenumber) values
(1,'Lê Văn Dân','0778899221'),
(2,'Đỗ Quốc Huy','0112233445');

-- Thêm dữ liệu vào bảng Vouchers (Mã giảm giá của sàn)
INSERT INTO Vouchers (voucher_code, discount_value, start_date, end_date, start_time, end_time, quantity, description) VALUES
('A0001', 10, '2026-02-01 00:00:00', '2026-02-10 00:00:00', '07:00:00', '12:00:00', 100, "Mã giảm giá 10% từ 7:00 đến 12:00"),
('A0002', 15, '2026-02-01 00:00:00', '2026-02-10 00:00:00', '07:00:00', '12:00:00', 100, "Mã giảm giá 15% từ 7:00 đến 12:00"),
('A0003', 15, '2026-02-01 00:00:00', '2026-02-10 00:00:00', '12:00:00', '15:00:00', 100, "Mã giảm giá 15% từ 12:00 đến 15:00"),
('A0004', 20, '2026-03-01 00:00:00', '2026-03-15 00:00:00', '18:00:00', '22:00:00', 50, "Mã giảm giá 20% từ 18:00 đến 22:00"),
('A0005', 25, '2026-03-05 00:00:00', '2026-03-20 00:00:00', '00:00:00', '23:59:59', 200, "Mã giảm giá 25% áp dụng cả ngày");
INSERT INTO Store_Coupons (store_id, coupon_code, discount_value, start_date, end_date, start_time, end_time, quantity, description) VALUES
(3, 'S0001', 10, '2025-05-01 00:00:00', '2025-05-10 00:00:00', '09:00:00', '21:00:00', 50, "Mã giảm giá 10% cho cửa hàng 3"),
(3, 'S0002', 15, '2025-06-01 00:00:00', '2025-06-15 00:00:00', '10:00:00', '22:00:00', 40, "Mã giảm giá 15% áp dụng cho cửa hàng 3"),
(3, 'S0003', 20, '2025-07-01 00:00:00', '2025-07-20 00:00:00', '11:00:00', '23:00:00', 30, "Mã giảm giá 20% từ 11:00 đến 23:00");

use foodsmart;
INSERT INTO Orders (user_id, shipper_id, store_id, voucher_id, coupon_id, order_status, shipping_date, delivery_date, order_date, payment_method, payment_status, shipping_address) 
VALUES 
(7, 1, 1, NULL, NULL, 'Completed', '2024-02-15 10:00:00', '2024-02-16 15:00:00', '2024-02-14 08:00:00', 'Credit Card', 'Paid', '123 Đường ABC, Hà Nội'),
(7, 2, 2, NULL, NULL, 'Completed', '2024-02-18 14:00:00', '2024-02-19 18:00:00', '2024-02-17 09:30:00', 'COD', 'Paid', '456 Đường XYZ, TP.HCM'),
(7, 1, 1, NULL, NULL, 'Completed', '2024-02-20 09:00:00', '2024-02-21 12:00:00', '2024-02-19 07:45:00', 'Credit Card', 'Paid', '789 Đường DEF, Đà Nẵng'),
(7, 2, 3, NULL, NULL, 'Completed', '2024-02-22 11:00:00', '2024-02-23 14:30:00', '2024-02-21 10:00:00', 'COD', 'Paid', '101 Đường MNO, Cần Thơ'),
(7, 1, 2, NULL, NULL, 'Completed', '2024-02-25 16:00:00', '2024-02-26 20:00:00', '2024-02-24 13:15:00', 'Credit Card', 'Paid', '112 Đường PQR, Hải Phòng');

INSERT INTO Products_Orders (product_id, order_id, price_at_time, quantity) 
VALUES 
(1, 1, 50000, 5), -- Sản phẩm 1 bán được 5 lần trong đơn hàng 1
(2, 1, 45000, 3), -- Sản phẩm 2 bán được 3 lần trong đơn hàng 1
(1, 2, 50000, 10), -- Sản phẩm 1 bán được 10 lần trong đơn hàng 2 (bán chạy)
(3, 2, 70000, 2), -- Sản phẩm 3 bán được 2 lần trong đơn hàng 2
(4, 2, 60000, 1), -- Sản phẩm 4 bán được 1 lần trong đơn hàng 3
(2, 2, 45000, 7), -- Sản phẩm 2 bán được 7 lần trong đơn hàng 4
(5, 2, 80000, 4), -- Sản phẩm 5 bán được 4 lần trong đơn hàng 5
(1, 3, 50000, 6); -- Sản phẩm 1 tiếp tục bán được 6 lần trong đơn hàng 5 (bán chạy)
