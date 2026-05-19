-- =======================================================
-- Ká»ŠCH Báº¢N Táº O CÆ  Sá»ž Dá»® LIá»†U SHOPEE CLONE WEB
-- =======================================================

-- 1. Táº O DATABASE
CREATE DATABASE Froken3pShopDB;
GO

USE Froken3pShopDB;
GO

-- 2. Táº O CÃC Báº¢NG (TABLES)

-- Báº£ng NgÆ°á»i dÃ¹ng (KhÃ¡ch hÃ ng & Admin)
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Username NVARCHAR(50) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(100) NOT NULL,
    Email NVARCHAR(100) NOT NULL,
    Phone NVARCHAR(20),
    Address NVARCHAR(255),
    Role NVARCHAR(20) DEFAULT 'User', -- GiÃ¡ trá»‹: 'Admin' hoáº·c 'User'
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Báº£ng Danh má»¥c Sáº£n pháº©m
CREATE TABLE Categories (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Description NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Báº£ng Sáº£n pháº©m
CREATE TABLE Products (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    CategoryId INT NOT NULL,
    Name NVARCHAR(200) NOT NULL,
    Description NVARCHAR(MAX),
    BasePrice DECIMAL(18,2) NOT NULL,
    StockQuantity INT NOT NULL DEFAULT 0,
    ImageUrl NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (CategoryId) REFERENCES Categories(Id) ON DELETE CASCADE
);
GO

-- Báº£ng Thuá»™c tÃ­nh Sáº£n pháº©m (Xá»­ lÃ½ logic Size Ä‘á»™ng, MÃ u sáº¯c,...)
CREATE TABLE ProductAttributes (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    ProductId INT NOT NULL,
    AttributeName NVARCHAR(50) NOT NULL,  -- VD: 'Size', 'Color'
    AttributeValue NVARCHAR(50) NOT NULL, -- VD: 'XL', 'Äá»'
    PriceAdjustment DECIMAL(18,2) DEFAULT 0, -- GiÃ¡ cá»™ng thÃªm náº¿u chá»n thuá»™c tÃ­nh nÃ y (VD: size XXL Ä‘áº¯t hÆ¡n 10k)
    Stock INT NOT NULL DEFAULT 0, -- Sá»‘ lÆ°á»£ng tá»“n kho riÃªng cho size/mÃ u nÃ y
    FOREIGN KEY (ProductId) REFERENCES Products(Id) ON DELETE CASCADE
);
GO

-- Báº£ng ÄÆ¡n hÃ ng
CREATE TABLE Orders (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    OrderDate DATETIME DEFAULT GETDATE(),
    TotalAmount DECIMAL(18,2) NOT NULL,
    Status NVARCHAR(50) DEFAULT 'Pending', -- Tráº¡ng thÃ¡i: Pending, Processing, Shipped, Delivered, Cancelled
    ShippingAddress NVARCHAR(255) NOT NULL,
    PaymentMethod NVARCHAR(50) DEFAULT 'COD',
    FOREIGN KEY (UserId) REFERENCES Users(Id)
);
GO

-- Báº£ng Chi tiáº¿t ÄÆ¡n hÃ ng
CREATE TABLE OrderDetails (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    OrderId INT NOT NULL,
    ProductId INT NOT NULL,
    ProductAttributeId INT NULL, -- CÃ³ thá»ƒ NULL náº¿u sáº£n pháº©m khÃ´ng phÃ¢n loáº¡i size/mÃ u
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    FOREIGN KEY (OrderId) REFERENCES Orders(Id) ON DELETE CASCADE,
    FOREIGN KEY (ProductId) REFERENCES Products(Id),
    FOREIGN KEY (ProductAttributeId) REFERENCES ProductAttributes(Id)
);
GO

-- =======================================================
-- 3. CHÃˆN Dá»® LIá»†U MáºªU (SAMPLE DATA)
-- =======================================================

-- ThÃªm User vÃ  Admin
INSERT INTO Users (Username, PasswordHash, FullName, Email, Role)
VALUES 
('admin', 'hashed_pwd_123', 'Quáº£n trá»‹ viÃªn', 'admin@shopee.com', 'Admin'),
('khachhang1', 'hashed_pwd_456', 'Nguyá»…n VÄƒn A', 'nva@gmail.com', 'User');

-- ThÃªm Danh má»¥c
INSERT INTO Categories (Name, Description)
VALUES 
(N'Quáº§n Ão', N'Thá»i trang nam ná»¯ Ä‘a dáº¡ng'),
(N'GiÃ y DÃ©p', N'GiÃ y thá»ƒ thao, giÃ y da cao cáº¥p'),
(N'MÅ© NÃ³n', N'Phá»¥ kiá»‡n nÃ³n lÆ°á»¡i trai, nÃ³n len');

-- ThÃªm Sáº£n pháº©m
INSERT INTO Products (CategoryId, Name, Description, BasePrice, StockQuantity)
VALUES 
(1, N'Ão thun nam Cá»• trÃ²n', N'Ão thun 100% cotton thoÃ¡ng mÃ¡t.', 150000, 100),
(2, N'GiÃ y thá»ƒ thao Sneaker', N'GiÃ y Ä‘i bá»™ siÃªu Ãªm Ã¡i, thÃ­ch há»£p cháº¡y bá»™.', 500000, 50);

-- ThÃªm Size (Logic Size Ä‘á»™ng)
INSERT INTO ProductAttributes (ProductId, AttributeName, AttributeValue, PriceAdjustment, Stock)
VALUES 
-- Ão thun (Size M, L, XL - XL Ä‘áº¯t hÆ¡n 10.000)
(1, 'Size', 'M', 0, 30),
(1, 'Size', 'L', 0, 40),
(1, 'Size', 'XL', 10000, 30),
-- GiÃ y thá»ƒ thao (Size 42, 43)
(2, 'Size', '42', 0, 25),
(2, 'Size', '43', 0, 25);
GO

PRINT N'CÆ¡ sá»Ÿ dá»¯ liá»‡u Froken3pShopDB vÃ  cÃ¡c báº£ng Ä‘Ã£ Ä‘Æ°á»£c táº¡o thÃ nh cÃ´ng cÃ¹ng vá»›i dá»¯ liá»‡u máº«u!';

