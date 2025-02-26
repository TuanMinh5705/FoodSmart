insert into Roles(role_name) values
('Admin'),
('User'),
('Merchant');

insert into `Account`(username, `password`, role_id)
values ('NgocThom', 'Vy12092001', 1),
       ('TuanMinh', 'Minh123', 1),
       ('DucKhanh', 'Khanh123', 1),
       ('VanDam', 'Dam123', 1),
       ('abc', 'abc123', 3),
       ('bac', 'abc123', 3);

insert into Stores(merchant_id, store_name, store_address, contact_number) values 
(5, 'Cơm rang và phở bò Minh Khánh', '102 Tu Hoàng , Minh Khai , Bắc Từ Liêm , Hà Nội', '0123456789'),
(5, 'Pizza Hut', '202 Đường Phan Xích Long, Quận Phú Nhuận, TP.HCM', '0945123456'),
(6, 'Lẩu Bò Ba Toa', '303 Đường Hai Bà Trưng, Đà Lạt', '0956123456');

insert into Categories(category_name,`description`) values
("Đồ ăn nhanh","Đồ ăn nhanh"),
('Bánh mì','Bánh mì'),
('Cơm,Cơm rang','Cơm,Cơm rang'),
('Mì , bún , phở','Mì , bún , phở'),
('Đồ tráng miệng , đồ ngọt','Đồ tráng miệng , đồ ngọt'),
("Đồ uống","Đồ uống");

insert into Products(store_id,product_name,price,stock_quantity) values
(3,'Cơm rang dưa bò',35000,20),
(3,'Phở bò',40000,20),
(3,'Bún chả Hà Nội',45000,30),
(3,'Bánh cuốn nóng',30000,25),
(3,'Pizza Margherita',180000,15),
(3,'Pizza Xúc Xích',190000,10),
(3,'Pizza Hải Sản',200000,12),
(3,'Mì Ý Carbonara',120000,18),
(3,'Lẩu bò đặc biệt',250000,8),
(3,'Bánh mì bò né',40000,25),
(3,'Bún bò Huế',50000,30),
(3,'Gỏi cuốn tôm thịt',30000,40),
(3,'Bánh Flan',20000,50),
(3,'Trà Sữa Matcha',50000,60);

 
insert into categories_stores(store_id,category_id) values
(1,3),
(1,4),
(1,1),
(2,1),
(2,2),
(3,1),(3,2),(3,3);

INSERT INTO Product_Images (product_id, is_primary)  
VALUES  
(1, TRUE), 
(2,  TRUE),  
(3, TRUE),  
(4, TRUE),  
(5, TRUE),
(6, FALSE),
(7, FALSE),
(8, TRUE),
(9, FALSE),
(10, TRUE),
(11, TRUE),
(12, FALSE),
(13, TRUE),
(14, TRUE);

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