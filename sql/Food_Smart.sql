create database FoodSmart;
use FoodSmart;
-- Bảng vai trò
create table Roles
(
    role_id   int primary key auto_increment,
    role_name varchar(255)
);
-- Bảng tài khoản 
create table `Account`
(
    account_id  int primary key auto_increment,
    username    varchar(255) unique not null,
    `password`  varchar(255)        not null,
    `status`    boolean default true,
    phonenumber varchar(255),
    avt_path    text    default ('https://drive.google.com/drive/folders/17CK_H9K-S16UIc3EbkjNHCcurMEDI2fO'),
    role_id     int,
    foreign key (role_id) references Roles (role_id)
);
-- Bảng địa chỉ người dùng
create table User_Address
(
    address_id  int primary key auto_increment,
    user_id     int,
    address     text,
    phonenumber varchar(255),
    is_deafault boolean default false,
    foreign key (user_id) references `Account` (account_id)
);
-- Bảng ví điện tử người dùng
create table E_Wallet
(
    wallet_id  int primary key auto_increment,
    balance    bigint,
    created_at timestamp,
    updated_at timestamp,
    `status`   boolean,
    account_id int,
    foreign key (account_id) references `Account` (account_id)
);
-- Bảng báo cáo doanh thu 
create table Revenue_Report
(
    report_id   int primary key auto_increment,
    account_id  int,
    report_date timestamp,
    foreign key (account_id) references `Account` (account_id)
);
-- Bảng thông báo 
create table Notifications
(
    notification_id   int primary key auto_increment,
    message           text,
    notification_type varchar(255),
    `status`          boolean default false,
    created_at        timestamp,
    account_id        int,
    foreign key (account_id) references `Account` (account_id)
);
-- Bảng trung gian thông báo và tài khoản
create table Notification_Account
(
    notification_id int,
    account_id      int,
    foreign key (account_id) references `Account` (account_id),
    foreign key (notification_id) references Notifications (notification_id)
);
-- Bảng khiếu nại , báo cáo
create table User_Complaint
(
    complaint_id int primary key auto_increment,
    content      text,
    feedback     text,
    `status`     boolean default false,
    created_at   timestamp,
    user_id      int,
    foreign key (user_id) references `Account` (account_id)
);
-- Bảng trò chuyện 
create table Conversation
(
    conversation_id int primary key auto_increment,
    message_chat    text,
    message_time    timestamp,
    message_status  boolean default false
);
-- Bảng trung gian trò chuyện và tài khoản
create table Conversation_Account
(
    conversation_id int,
    sender_id       int,
    receiver_id     int,
    chat_type       boolean default true,
    foreign key (sender_id) references `Account` (account_id),
    foreign key (receiver_id) references `Account` (account_id),
    foreign key (conversation_id) references Conversation (conversation_id)
);
-- Bảng cửa hàng 
create table Stores
(
    store_id       int primary key auto_increment,
    merchant_id    int,
    store_name     varchar(255),
    store_address  text,
    contact_number varchar(255),
    banner_path    text    default ('https://drive.google.com/drive/folders/17CK_H9K-S16UIc3EbkjNHCcurMEDI2fO'),
    avt_path       text    default ('https://drive.google.com/drive/folders/17CK_H9K-S16UIc3EbkjNHCcurMEDI2fO'),
    store_type     boolean default false,
    foreign key (merchant_id) references `Account` (account_id)
);
-- Bảng mã giảm giá của cửa hàng 
create table Store_Coupons
(
    coupon_id      int primary key auto_increment,
    store_id       int,
    coupon_code    varchar(255) unique,
    discount_value int,
    expiry_date    timestamp,
    quantity       int,
    `description`  text,
    foreign key (store_id) references Stores (store_id)
);
-- Bảng mã giảm giá của sàn 
create table Vouchers
(
    voucher_id     int primary key auto_increment,
    voucher_code   varchar(255) unique,
    discount_value int,
    expiry_date    timestamp,
    quantity       int,
    `description`  text
);
-- Bảng trung gian Mã giảm giá của sàn và cửa hàng đối tác
create table Vouchers_Stores
(
    voucher_id int,
    store_id   int,
    foreign key (store_id) references Stores (store_id),
    foreign key (voucher_id) references Vouchers (voucher_id)
);


-- Bảng danh mục sản phẩm 
create table Categorys
(
    category_id      int primary key auto_increment,
    category_name    varchar(255),
    description_path text default ('https://drive.google.com/drive/folders/11mfrLNCJ2rhFq6S6inqisIM9VBEVHNQV')
);
-- Bảng sản phẩm
create table Products
(
    product_id     int primary key auto_increment,
    store_id       int,
    product_name   varchar(255),
    price          int,
    stock_quantity int,
    discount       int default 0,
    foreign key (store_id) references Stores (store_id)
);
-- Bảng trung gian giữa sản phẩm và danh mục 
create table Products_Categorys
(
    product_id  int,
    category_id int,
    foreign key (category_id) references Categorys (category_id),
    foreign key (product_id) references Products (product_id)
);
-- Bảng ảnh sản phẩm
create table Product_Images
(
    image_id   int primary key auto_increment,
    product_id int,
    image_path text    default ('https://drive.google.com/drive/folders/11mfrLNCJ2rhFq6S6inqisIM9VBEVHNQV'),
    is_primary boolean default true,
    foreign key (product_id) references Products (product_id)
);


-- Bảng nhà vận chuyển 
create table Carriers
(
    carrier_id    int primary key auto_increment,
    carrier_name  varchar(255),
    contact_phone varchar(255),
    shipping_cost int
);
-- Bảng nhân viên vận chuyển 
create table Shippers
(
    shipper_id   int primary key auto_increment,
    carrier_id   int,
    shipper_name varchar(255),
    phonenumber  varchar(255),
    foreign key (carrier_id) references Carriers (carrier_id)
);


-- Bảng đơn hàng 
create table Orders
(
    order_id         int primary key auto_increment,
    user_id          int,
    shipper_id       int,
    store_id         int,
    voucher_id       int,
    coupon_id        int,
    order_status     varchar(255),
    shipping_date    timestamp,
    delivery_date    timestamp,
    order_date       timestamp,
    payment_method   varchar(255),
    payment_status   varchar(255),
    shipping_address text,
    foreign key (coupon_id) references Store_Coupons (coupon_id),
    foreign key (voucher_id) references Vouchers (voucher_id),
    foreign key (store_id) references Stores (store_id),
    foreign key (shipper_id) references Shippers (shipper_id),
    foreign key (user_id) references `Account` (account_id)
);
-- Bảng trung gian giữa đơn hàng và sản phẩm
create table Products_Orders
(
    product_id    int,
    order_id      int,
    price_at_time int,
    quantity      int,
    foreign key (product_id) references Products (product_id),
    foreign key (order_id) references Orders (order_id)
);
-- Bảng hóa đơn
create table Invoices
(
    invoice_id   int primary key auto_increment,
    order_id     int,
    payment_date timestamp,
    total_amount bigint,
    foreign key (order_id) references Orders (order_id)
);

-- Trigger khi cập nhật trạng thái cửa hàng
DELIMITER
//

CREATE TRIGGER trg_after_update_store
    AFTER UPDATE
    ON Stores
    FOR EACH ROW
BEGIN
    -- Nếu chuyển từ đối tác sang không đối tác
    IF OLD.store_type = TRUE AND NEW.store_type = FALSE THEN
    DELETE FROM Vouchers_Stores WHERE store_id = NEW.store_id;
    -- Nếu chuyển từ không đối tác sang đối tác
    ELSEIF OLD.store_type = FALSE AND NEW.store_type = TRUE THEN
        INSERT INTO Vouchers_Stores (voucher_id, store_id)
    SELECT voucher_id, NEW.store_id FROM Vouchers;
END IF;
END;
//

DELIMITER ;

