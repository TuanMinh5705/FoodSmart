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
insert into Stores(merchant_id, store_name, store_address, contact_number)
values (5, 'Cơm rang và phở bò Minh Khánh', '102 Tu Hoàng , Minh Khai , Bắc Từ Liêm , Hà Nội', '0123456789');
insert into Categorys(category_name,`description`) values
("Đồ ăn nhanh","Đồ ăn nhánh"),
('Bánh mì','Bánh mì'),
('Cơm,Cơm rang','Cơm,Cơm rang'),
('Mì , bún , phở',"Mì , bún , phở"),
('Đồ tráng miệng , đồ ngọt','Đồ tráng miệng , đồ ngọt'),
("Đồ uống",'Đồ uống');
insert into Products(store_id,product_name,price,stock_quantity) values
(1,'Cơm rang dưa bò',35000,20),
(1,'Phở bò',40000,20);
insert into Products_Categorys(product_id,category_id) values
(1,3),
(2,4);
insert into Product_Images(product_id,image_path) values 
(1,'https://drive.google.com/drive/folders/1ow5kehB1lhNkHlIYffRvy9cec-wVgNdw'),
(2,'https://drive.google.com/drive/folders/16qRMJhofBX3An0Gr3UbYSO9cR06lTnda');
insert into Carriers(carrier_name, contact_phone, shipping_cost)
values ("Be", '0867536601', 25000),
       ("Grap", "0342707049", 25000);
insert into Shippers(carrier_id,shipper_name,phonenumber) values
(1,'Lê Văn Dân',"0778899221"),
(2,'Đỗ Quốc Huy','0112233445');
-- Thêm dữ liệu vào bảng Vouchers (Mã giảm giá của sàn)
INSERT INTO Vouchers (voucher_code, discount_value, start_date, end_date, start_time, end_time, quantity, description) VALUES
('A0001', 10, '2026-02-01 00:00:00', '2026-02-10 00:00:00', '07:00:00', '12:00:00', 100, "Mã giảm giá 10% từ 7:00 đến 12:00"),
('A0002', 15, '2026-02-01 00:00:00', '2026-02-10 00:00:00', '07:00:00', '12:00:00', 100, "Mã giảm giá 15% từ 7:00 đến 12:00"),
('A0003', 15, '2026-02-01 00:00:00', '2026-02-10 00:00:00', '12:00:00', '15:00:00', 100, "Mã giảm giá 15% từ 12:00 đến 15:00"),
('A0004', 20, '2026-03-01 00:00:00', '2026-03-15 00:00:00', '18:00:00', '22:00:00', 50, "Mã giảm giá 20% từ 18:00 đến 22:00"),
('A0005', 25, '2026-03-05 00:00:00', '2026-03-20 00:00:00', '00:00:00', '23:59:59', 200, "Mã giảm giá 25% áp dụng cả ngày");

INSERT INTO Stores (merchant_id, store_name, store_address, contact_number) VALUES
(5, 'Pizza Hut', '202 Đường Phan Xích Long, Quận Phú Nhuận, TP.HCM', '0945123456'),
(6, 'Lẩu Bò Ba Toa', '303 Đường Hai Bà Trưng, Đà Lạt', '0956123456');

-- Thêm dữ liệu vào bảng Store_Coupons (Mã giảm giá của cửa hàng)
INSERT INTO Store_Coupons (store_id, coupon_code, discount_value, start_date, end_date, start_time, end_time, quantity, description) VALUES
(1, 'M0001', 5, '2025-03-01 00:00:00', '2025-03-10 00:00:00', '08:00:00', '22:00:00', 20, "Mã giảm giá 5% áp dụng cho cửa hàng 1"),
(1, 'M0002', 10, '2025-04-01 00:00:00', '2025-04-15 00:00:00', '10:00:00', '20:00:00', 30, "Mã giảm giá 10% áp dụng cho cửa hàng 2"),
(2, 'M0003', 15, '2025-05-01 00:00:00', '2025-05-20 00:00:00', '12:00:00', '23:00:00', 15, "Mã giảm giá 15% áp dụng cho cửa hàng 1 từ 12h đến 23h"),
(1, 'M0004', 20, '2025-06-01 00:00:00', '2025-06-30 00:00:00', '06:00:00', '18:00:00', 50, "Mã giảm giá 20% áp dụng từ 6h đến 18h cho cửa hàng 3"),
(2, 'M0005', 25, '2025-07-01 00:00:00', '2025-07-15 00:00:00', '00:00:00', '23:59:59', 100, "Mã giảm giá 25% áp dụng cả ngày cho cửa hàng 2");

