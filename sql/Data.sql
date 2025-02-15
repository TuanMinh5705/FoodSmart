insert into Roles(role_name) values
('Admin'),
('User'),
('Merchant');
insert into `Account`(username, `password`, phonenumber, role_id)
values ('NgocThom', 'Vy12092001', '0123456789', 1),
       ('TuanMinh', 'Minh123', '0123456789', 1),
       ('DucKhanh', 'Khanh123', '0123456789', 1),
       ('VanDam', 'Dam123', '0123456789', 1),
       ('a', 'a', '0123456789', 2),
       ('b', 'b', '0123456789', 3);
insert into Stores(merchant_id, store_name, store_address, contact_number)
values (5, 'Cơm rang và phở bò Minh Khánh', '102 Tu Hoàng , Minh Khai , Bắc Từ Liêm , Hà Nội', '0123456789');
insert into Categorys(category_name,description_path) values
("Đồ ăn nhanh","https://drive.google.com/drive/folders/11mfrLNCJ2rhFq6S6inqisIM9VBEVHNQV"),
('Bánh mì','https://drive.google.com/drive/folders/11mfrLNCJ2rhFq6S6inqisIM9VBEVHNQV'),
('Cơm,Cơm rang','https://drive.google.com/drive/folders/11mfrLNCJ2rhFq6S6inqisIM9VBEVHNQV'),
('Mì , bún , phở',"https://drive.google.com/drive/folders/11mfrLNCJ2rhFq6S6inqisIM9VBEVHNQV"),
('Đồ tráng miệng , đồ ngọt','https://drive.google.com/drive/folders/11mfrLNCJ2rhFq6S6inqisIM9VBEVHNQV'),
("Đồ uống",'https://drive.google.com/drive/folders/11mfrLNCJ2rhFq6S6inqisIM9VBEVHNQV');
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
insert into Vouchers(voucher_code, discount_value, expiry_date, quantity, `description`) values
('A0001', 10, '2026-02-10 00:00:00', 100, "Mã giảm giá 10% từ 7:00 đến 12:00"),
('A0002', 15, '2026-02-10 00:00:00', 100, "Mã giảm giá 15% từ 7:00 đến 12:00"),
('A0003', 15, '2026-02-10 00:00:00', 100, "Mã giảm giá 15% từ 12:00 đến 15:00");
insert into Store_Coupons(store_id,coupon_code,discount_value,expiry_date,quantity,`description`) values
(1,'M0001',5,'2025-03-10 00:00:00',20,"Mã giảm giá 5% áp dụng cho cửa hàng 1");
