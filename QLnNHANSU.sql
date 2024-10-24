CREATE DATABASE QLNhanSu;
GO

USE QLNhanSu;
GO


-- Create PHONGBAN table (Department)
CREATE TABLE PHONGBAN
(
    IDPB INT PRIMARY KEY,               -- Department ID (Primary Key)
    TENPB NVARCHAR(50)                  -- Department name
);

-- Create BOPHAN table (Division)
CREATE TABLE BOPHAN
(
    IDBP INT PRIMARY KEY,               -- Division ID (Primary Key)
    TENBP NVARCHAR(50)                  -- Division name
);

-- Create CHUCVU table (Position)
CREATE TABLE CHUCVU
(
    IDCV INT PRIMARY KEY,               -- Position ID (Primary Key)
    TENCV NVARCHAR(50)                  -- Position name
);

-- Create TRINHDO table (Education Level)
CREATE TABLE TRINHDO
(
    IDTD INT PRIMARY KEY,               -- Education level ID (Primary Key)
    TENTD NVARCHAR(50)                  -- Education level name
);

-- Create NHANVIEN table (Employee)
CREATE TABLE NHANVIEN
(
    MANV INT PRIMARY KEY,               -- Employee ID (Primary Key)
    HOTEN NVARCHAR(50),                 -- Full name
    GIOITINH BIT,                       -- Gender (0: Female, 1: Male)
    NGAYSINH DATE,                      -- Date of birth
    DIENTHOAI NVARCHAR(50),             -- Phone number
    CCCD NVARCHAR(50),                  -- Citizen ID
    DIACHI NVARCHAR(300),               -- Address
    HINHANH VARBINARY(MAX),             -- Image
    IDPB INT,                           -- Department ID (Foreign Key)
    IDBP INT,                           -- Division ID (Foreign Key)
    IDCV INT,                           -- Position ID (Foreign Key)
    IDTD INT,                           -- Education level ID (Foreign Key)
    FOREIGN KEY (IDPB) REFERENCES PHONGBAN(IDPB),   -- Department reference
    FOREIGN KEY (IDBP) REFERENCES BOPHAN(IDBP),     -- Division reference
    FOREIGN KEY (IDCV) REFERENCES CHUCVU(IDCV),     -- Position reference
    FOREIGN KEY (IDTD) REFERENCES TRINHDO(IDTD)     -- Education level reference
);

-- Create BAOHIEM table (Insurance)
CREATE TABLE BAOHIEM
(
    IDBH INT PRIMARY KEY,               -- Insurance ID (Primary Key)
    SOBH NVARCHAR(50),                  -- Insurance number
    NGAYCAP DATE,                       -- Issuance date
    NOICAP NVARCHAR(50),                -- Place of issuance
    NOIKHAMBENH NVARCHAR(50),           -- Place of medical treatment
    MANV INT,                           -- Employee ID (Foreign Key)
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)    -- Employee reference
);

-- Create HOPDONG table (Contract)
CREATE TABLE HOPDONG
(
    SOHD INT PRIMARY KEY,               -- Contract number (Primary Key)
    NGAYBATDAU DATE,                    -- Start date
    NGAYKETTHUC DATE,                   -- End date
    NGAYKY DATE,                        -- Date of signing
    NOIDUNG NVARCHAR(MAX),              -- Content
    LANKY INT,                          -- Number of renewals
    THOIHAN NVARCHAR(50),               -- Duration
    HESOLUONG FLOAT,                    -- Salary coefficient
    MANV INT,                           -- Employee ID (Foreign Key)
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)    -- Employee reference
);


-- Create LOAICONG table (Work Type)
CREATE TABLE LOAICONG
(
    IDLOAICONG INT PRIMARY KEY,          -- Work type ID (Primary Key)
    TENLC NVARCHAR(50),                  -- Work type name
    HESO FLOAT                           -- Coefficient
);

-- Create BANGCONG table (Timesheet)
CREATE TABLE BANGCONG
(
    MABC INT PRIMARY KEY,               -- Timesheet ID (Primary Key)
    NAM INT,                            -- Year
    THANG INT,                          -- Month
    NGAY INT,                           -- Day
    GIOVAO INT,                         -- Hour in
    PHUTVAO INT,                        -- Minute in
    GIORA INT,                          -- Hour out
    PHUTRA INT,                         -- Minute out
    MANV INT,                           -- Employee ID (Foreign Key)
    IDLOAICONG INT,                     -- Work type ID (Foreign Key)
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),        -- Employee reference
    FOREIGN KEY (IDLOAICONG) REFERENCES LOAICONG(IDLOAICONG) -- Work type reference
);


-- Create KHENTHUONG_KYLUAT table (Rewards and Disciplinary Actions)
CREATE TABLE KHENTHUONG_KYLUAT
(
    IDKT INT PRIMARY KEY,                -- Reward/Penalty ID (Primary Key)
    SOKTKL NVARCHAR(10),                 -- Reward/Penalty number
    NOIDUNG NVARCHAR(500),               -- Content
    NGAY DATE,                           -- Date
    MANV INT,                            -- Employee ID (Foreign Key)
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)    -- Employee reference
);


-- Create LOAICA table (Overtime Type)
CREATE TABLE LOAICA
(
    IDLOAICA INT PRIMARY KEY,            -- Overtime type ID (Primary Key)
    TENLOAICA NVARCHAR(50),              -- Overtime type name
    HESO FLOAT                           -- Coefficient
);

-- Create TANGCA table (Overtime)
CREATE TABLE TANGCA
(
    ID INT PRIMARY KEY,                  -- Overtime ID (Primary Key)
    NAM INT,                             -- Year
    THANG INT,                           -- Month
    NGAY INT,                            -- Day
    SOGIO FLOAT,                         -- Hours worked
    MANV INT,                            -- Employee ID (Foreign Key)
    IDLOAICA INT,                        -- Overtime type ID (Foreign Key)
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),        -- Employee reference
    FOREIGN KEY (IDLOAICA) REFERENCES LOAICA(IDLOAICA)   -- Overtime type reference
);

-- Create PHUCAP table (Allowances)
CREATE TABLE PHUCAP
(
    IDPC INT PRIMARY KEY,                -- Allowance ID (Primary Key)
    TENPC NVARCHAR(50),                  -- Allowance name
    SOTIEN FLOAT                         -- Amount
);

-- Create NV_PHUCAP table (Employee Allowances)
CREATE TABLE NV_PHUCAP
(
    ID INT PRIMARY KEY,                  -- Employee Allowance ID (Primary Key)
    MANV INT,                            -- Employee ID (Foreign Key)
    IDPC INT,                            -- Allowance ID (Foreign Key)
    NGAY DATE,                           -- Date
    NOIDUNG NVARCHAR(500),               -- Content
    SOTIEN FLOAT,                        -- Amount
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV),        -- Employee reference
    FOREIGN KEY (IDPC) REFERENCES PHUCAP(IDPC)           -- Allowance reference
);

-- Create LUONG table (Salary)
CREATE TABLE LUONG
(
    ID INT PRIMARY KEY,                  -- Salary ID (Primary Key)
    NAM INT,                             -- Year
    THANG INT,                           -- Month
    NGAY INT,                            -- Day
    SOTIEN FLOAT,                        -- Amount
    TRANGTHAI BIT,                       -- Status (0: Unpaid, 1: Paid)
    MANV INT,                            -- Employee ID (Foreign Key)
    FOREIGN KEY (MANV) REFERENCES NHANVIEN(MANV)        -- Employee reference
);
