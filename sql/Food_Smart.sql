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
    account_id int primary key auto_increment,
    username   varchar(255) unique not null,
    `password` varchar(255)        not null,
    `active`   boolean default true,
    avt_path   text    default ('avt_default.jpg'),
    role_id    int,
    foreign key (role_id) references Roles (role_id) on delete cascade
);
-- Bảng địa chỉ, số điện thoại người dùng
create table Account_Details
(
    account_details_id  int primary key auto_increment,
    user_id     int,
    address     text,
    phonenumber varchar(255),
    is_default boolean default false,
    foreign key (user_id) references `Account` (account_id) on delete cascade
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
    foreign key (account_id) references `Account` (account_id) on delete cascade
);
-- Bảng báo cáo doanh thu 
create table Revenue_Report
(
    report_id   int primary key auto_increment,
    account_id  int,
    report_date timestamp,
    foreign key (account_id) references `Account` (account_id) on delete cascade
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
    foreign key (account_id) references `Account` (account_id) on delete cascade
);
-- Bảng trung gian thông báo và tài khoản
create table Notification_Account
(
    notification_id int,
    account_id      int,
    foreign key (account_id) references `Account` (account_id),
    foreign key (notification_id) references Notifications (notification_id) on delete cascade
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
    foreign key (user_id) references `Account` (account_id) on delete cascade
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
    foreign key (sender_id) references `Account` (account_id) on delete cascade,
    foreign key (receiver_id) references `Account` (account_id) on delete cascade,
    foreign key (conversation_id) references Conversation (conversation_id) on delete cascade
);
-- Bảng cửa hàng 
create table Stores
(
    store_id       int primary key auto_increment,
    merchant_id    int,
    store_name     varchar(255),
    store_address  text,
    contact_number varchar(255),
    banner_path    text    default ('banner-default.jpg'),
    avt_path       text    default ('avt_store_default.jpg'),
    store_type     boolean default true,
    foreign key (merchant_id) references `Account` (account_id) on delete cascade
);
-- Bảng mã giảm giá của cửa hàng 
CREATE TABLE Store_Coupons
(
    coupon_id      INT PRIMARY KEY AUTO_INCREMENT,
    store_id       INT,
    coupon_code    VARCHAR(255) UNIQUE NOT NULL,
    discount_value INT                 NOT NULL,
    start_date     TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    end_date       TIMESTAMP           NOT NULL,
    start_time     TIME      DEFAULT NULL,
    end_time       TIME      DEFAULT NULL,
    quantity       INT       DEFAULT 0,
    description    TEXT,
    FOREIGN KEY (store_id) REFERENCES Stores (store_id) ON DELETE CASCADE
);

-- Bảng mã giảm giá của sàn 
CREATE TABLE Vouchers
(
    voucher_id     INT PRIMARY KEY AUTO_INCREMENT,
    voucher_code   VARCHAR(255) UNIQUE,
    discount_value INT,
    start_date     TIMESTAMP default CURRENT_TIMESTAMP,
    end_date       TIMESTAMP NOT NULL,
    start_time     TIME      DEFAULT NULL,
    end_time       TIME      DEFAULT NULL,
    quantity       INT,
    `description`  TEXT
);

-- Bảng danh mục sản phẩm 
create table Categories
(
    category_id      int primary key auto_increment,
    category_name    varchar(255),
    `description` text,
    avt_path text default ('product_default.png')
);
-- Bảng danh mục sản phẩm của cửa hàng 
CREATE TABLE Categories_Stores (
    store_id INT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES Categories (category_id) on delete cascade,
    FOREIGN KEY (store_id) REFERENCES Stores (store_id) on delete cascade
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
    foreign key (store_id) references Stores (store_id) on delete cascade
);
-- Bảng trung gian giữa sản phẩm và danh mục 
create table Products_Categories
(
    product_id  int,
    category_id int,
    foreign key (category_id) references Categories (category_id) on delete cascade,
    foreign key (product_id) references Products (product_id) on delete cascade
);
-- Bảng ảnh sản phẩm
create table Product_Images
(
    image_id   int primary key auto_increment,
    product_id int,
    image_path text    default ('product_default.png'),
    is_primary boolean default true,
    foreign key (product_id) references Products (product_id) on delete cascade
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
    foreign key (carrier_id) references Carriers (carrier_id) on delete cascade
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
    foreign key (coupon_id) references Store_Coupons (coupon_id) on delete cascade,
    foreign key (voucher_id) references Vouchers (voucher_id) on delete cascade,
    foreign key (store_id) references Stores (store_id) on delete cascade,
    foreign key (shipper_id) references Shippers (shipper_id) on delete cascade,
    foreign key (user_id) references `Account` (account_id) on delete cascade
);
-- Bảng trung gian giữa đơn hàng và sản phẩm
create table Products_Orders
(
    product_id    int,
    order_id      int,
    price_at_time int,
    quantity      int,
    foreign key (product_id) references Products (product_id) on delete cascade,
    foreign key (order_id) references Orders (order_id) on delete cascade
);
-- Bảng hóa đơn
create table Invoices
(
    invoice_id   int primary key auto_increment,
    order_id     int,
    payment_date timestamp,
    total_amount bigint,
    foreign key (order_id) references Orders (order_id) on delete cascade
);
