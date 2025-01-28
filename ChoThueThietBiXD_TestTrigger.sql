CREATE DATABASE ChoThueThietBiXD_testTrigger;
GO

USE ChoThueThietBiXD_testTrigger;
GO

drop database ChoThueThietBiXD_testTrigger

-- Bảng ChucVu
CREATE TABLE ChucVu (
    IDChucVu CHAR(5) PRIMARY KEY,
    TenChucVu NVARCHAR(50) 
);

-- Bảng PhanQuyen
CREATE TABLE PhanQuyen (
    IDQuyen CHAR(5) PRIMARY KEY,
    TenQuyen NVARCHAR(50) NOT NULL
);

-- Bảng TaiKhoan
CREATE TABLE TaiKhoan (
    IDTaiKhoan CHAR(5) PRIMARY KEY,
    TenTaiKhoan NVARCHAR(50) NOT NULL,
    MatKhau VARCHAR(50) NOT NULL,
    TrangThai VARCHAR(20),
    IDChucVu CHAR(5) NOT NULL FOREIGN KEY REFERENCES ChucVu(IDChucVu),
    IDPhanQuyen CHAR(5) FOREIGN KEY REFERENCES PhanQuyen(IDQuyen)
);
--alter tabl

-- Bảng NhanVien
CREATE TABLE NhanVien (
    IDNhanVien CHAR(5) PRIMARY KEY,
    TenNhanVien NVARCHAR(100) NOT NULL,
    IDTaiKhoan CHAR(5) NOT NULL FOREIGN KEY REFERENCES TaiKhoan(IDTaiKhoan),
    SDT VARCHAR(12) 
	--CHECK (LEN(SDT) = 10 AND SDT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
			CHECK (
				-- Định dạng thông thường
				(
					LEN(SDT) = 10 AND 
					(
						-- Cho số di động
						SDT LIKE '0[3-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
						OR
						-- Cho số bàn mã vùng 2 số
						SDT LIKE '02[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
						OR
						-- Cho số bàn mã vùng 3 số
						SDT LIKE '02[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
					)
				)
				OR
				-- Định dạng quốc tế
				(
					LEN(SDT) IN (11, 12) AND 
					SDT LIKE '+84[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
				)
			),
    Email VARCHAR(100) CHECK (Email LIKE '%@%')
);

-- Bảng KhachHang
CREATE TABLE KhachHang (
    IDKhachHang CHAR(5) PRIMARY KEY,
    TenKhachHang NVARCHAR(100) NOT NULL,
    Email VARCHAR(100) CHECK (Email LIKE '%@%'),
    SDT VARCHAR(12) 
	--CHECK (LEN(SDT) = 10 AND SDT LIKE '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
			CHECK (
				-- Định dạng thông thường
				(
					LEN(SDT) = 10 AND 
					(
						-- Cho số di động
						SDT LIKE '0[3-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
						OR
						-- Cho số bàn mã vùng 2 số
						SDT LIKE '02[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
						OR
						-- Cho số bàn mã vùng 3 số
						SDT LIKE '02[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
					)
				)
				OR
				-- Định dạng quốc tế
				(
					LEN(SDT) IN (11, 12) AND 
					SDT LIKE '+84[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'
				)
			),
    DiaChi NVARCHAR(200),
    IDTaiKhoan CHAR(5) NOT NULL FOREIGN KEY REFERENCES TaiKhoan(IDTaiKhoan)
);

-- Bảng DanhMucThietBi
CREATE TABLE DanhMucThietBi (
    IDDanhMuc CHAR(5) PRIMARY KEY,
    TenDanhMuc NVARCHAR(100) NOT NULL
);

-- Bảng ThietBi
CREATE TABLE ThietBi (
    IDTB CHAR(5) PRIMARY KEY,
    TenTB NVARCHAR(100) NOT NULL,
    MoTa NVARCHAR(500),
    GiaThue Decimal CHECK (GiaThue > 0),
    SoLuong INT CHECK (SoLuong >= 0),
    DongCo NVARCHAR(50),
    CongSuat NVARCHAR(50),
    KichThuoc NVARCHAR(100),
    TaiTrongNang NVARCHAR(100),
    DungTichGau NVARCHAR(100),
    ChieuCao NVARCHAR(100),
    LoaiNhienLieu NVARCHAR(100),
    TanSo NVARCHAR(50),
    NhaSanXuat NVARCHAR(100),
    IDDanhMuc CHAR(5) NOT NULL FOREIGN KEY REFERENCES DanhMucThietBi(IDDanhMuc)
);

-- Bảng DonHang
CREATE TABLE DonHang (
    IDDonHang INT PRIMARY KEY IDENTITY,
    IDKhachHang CHAR(5) NOT NULL FOREIGN KEY REFERENCES KhachHang(IDKhachHang),
    NgayLap DATE NOT NULL DEFAULT GETDATE(),
    TrangThai NVARCHAR(50),
    NgayThanhToan VARCHAR(50),
    HinhThucThanhToan NVARCHAR(50)
);
--ALTER TABLE DonHang
--ALTER COLUMN TrangThai NVARCHAR(50);
--ALTER TABLE DonHang
--ALTER COLUMN HinhThucThanhToan NVARCHAR(50);

-- Bảng ThoiGianThue
CREATE TABLE ThoiGianThue (
    IDThoiGianThue CHAR(5) PRIMARY KEY,
    IDDonHang INT NOT NULL FOREIGN KEY REFERENCES DonHang(IDDonHang),
    NgayBatDauThue DATETIME,
    NgayKetThucThue DATETIME
);

-- Bảng ChiTietDonHang
CREATE TABLE ChiTietDonHang (
    IDChiTietDonHang CHAR(5) PRIMARY KEY,
    IDDonHang INT NOT NULL FOREIGN KEY REFERENCES DonHang(IDDonHang),
    IDThietBi CHAR(5) NOT NULL FOREIGN KEY REFERENCES ThietBi(IDTB),
    SoLuongDatThue INT,
    DonGia Decimal,
    IDThoiGianThue CHAR(5) FOREIGN KEY REFERENCES ThoiGianThue(IDThoiGianThue)
);

-- Bảng DanhGia
CREATE TABLE DanhGia (
    IDDanhGia CHAR(5) PRIMARY KEY,
    LoiDanhGia NVARCHAR(500),
    IDThietBi CHAR(5) FOREIGN KEY REFERENCES ThietBi(IDTB),
    SoSao INT NULL,
    HinhAnh VARCHAR(200) NULL,
    Video VARCHAR(200) NULL,
    IDChiTietDonHang CHAR(5) FOREIGN KEY REFERENCES ChiTietDonHang(IDChiTietDonHang)
);

-- Bảng HopDong
CREATE TABLE HopDong (
    IDHopDong CHAR(5) PRIMARY KEY,
    IDKhachHang CHAR(5) NOT NULL FOREIGN KEY REFERENCES KhachHang(IDKhachHang),
    TrangThai NVARCHAR(50),
    NgayTao DATE NOT NULL,
    IDNhanVien CHAR(5) NOT NULL FOREIGN KEY REFERENCES NhanVien(IDNhanVien)
);

-- Bảng ChiTietHopDong
CREATE TABLE ChiTietHopDong (
    IDChiTietHopDong CHAR(5) PRIMARY KEY,
    IDHopDong CHAR(5) NOT NULL FOREIGN KEY REFERENCES HopDong(IDHopDong),
    IDDonHang INT NOT NULL FOREIGN KEY REFERENCES DonHang(IDDonHang)
);

ALTER TABLE ThoiGianThue
ADD CONSTRAINT CK_NgayThue CHECK (NgayBatDauThue < NgayKetThucThue);

-- Bảng ThanhToan
CREATE TABLE ThanhToan (
    IDThanhToan CHAR(5) PRIMARY KEY,
    IDHopDong CHAR(5) NOT NULL FOREIGN KEY REFERENCES HopDong(IDHopDong),
    PhuongThucThanhToan NVARCHAR(50),
    NgayThanhToan DATE NOT NULL,
    SoTienThanhToan MONEY CHECK (SoTienThanhToan > 0),
    TrangThaiThanhToan NVARCHAR(50)
);

-- Bảng HoaDon
CREATE TABLE HoaDon (
    IDHoaDon CHAR(5) PRIMARY KEY,
    IDKhachHang CHAR(5) NOT NULL FOREIGN KEY REFERENCES KhachHang(IDKhachHang),
    IDHopDong CHAR(5) NOT NULL FOREIGN KEY REFERENCES HopDong(IDHopDong),
    NgayLapHoaDon DATE NOT NULL
);

-- Bảng ChiTietHoaDon
CREATE TABLE ChiTietHoaDon (
    IDChiTietHoaDon CHAR(5) PRIMARY KEY,
    IDHoaDon CHAR(5) NOT NULL FOREIGN KEY REFERENCES HoaDon(IDHoaDon),
    IDThietBi CHAR(5) NOT NULL FOREIGN KEY REFERENCES ThietBi(IDTB),
    SoLuongThue INT CHECK (SoLuongThue > 0),
    GiaThue Decimal CHECK (GiaThue > 0)
);

-- Thêm dữ liệu cho bảng ChucVu
INSERT INTO ChucVu VALUES
('CV001', N'Quản lý'),
('CV002', N'Nhân viên'),
('CV003', N'Kế toán'),
('CV004', N'Hỗ trợ khách hàng'),
('CV005', N'Giám đốc'),
('CV006', N'Trợ lý'),
('CV007', N'Kỹ thuật viên');
INSERT INTO ChucVu VALUES
('CV008', N'Khách')
--select * from ChucVu

-- Thêm dữ liệu cho bảng PhanQuyen
INSERT INTO PhanQuyen VALUES
('PQ001', N'Quản trị hệ thống'),
('PQ002', N'Nhân viên quản lý'),
('PQ003', N'Khách hàng thường'),
('PQ004', N'Kế toán viên'),
('PQ005', N'Nhân viên hỗ trợ'),
('PQ006', N'Nhân viên giao nhận'),
('PQ007', N'Nhân viên bảo trì');
--select * from PhanQuyen

-- Thêm dữ liệu cho bảng TaiKhoan
INSERT INTO TaiKhoan (IDTaiKhoan, TenTaiKhoan, MatKhau, TrangThai, IDChucVu, IDPhanQuyen) VALUES
('TK001', N'admin', 'pass1', N'Hoạt động', 'CV001', 'PQ001'),
('TK002', N'nvien1', 'pass2', N'Hoạt động', 'CV002', 'PQ002'),
('TK003', N'nvien2', 'pass3', N'Hoạt động', 'CV003', 'PQ005'),
('TK004', N'nvien3', 'pass4', N'Bị khóa', 'CV004', 'PQ005'),
('TK005', N'khachhang1', 'pass5', N'Hoạt động', 'CV008', 'PQ003'),
('TK006', N'khachhang2', 'pass6', N'Hoạt động', 'CV008', 'PQ003'),
('TK007', N'khachhang3', 'pass7', N'Hoạt động', 'CV008', 'PQ003'),
('TK008', N'khachhang4', 'pass8', N'Hoạt động', 'CV008', 'PQ003'),
('TK009', N'khachhang5', 'pass9', N'Hoạt động', 'CV008', 'PQ003'),
('TK010', N'khachhang6', 'pass10', N'Hoạt động', 'CV008', 'PQ003'),
('TK011', N'khachhang7', 'pass11', N'Hoạt động', 'CV008', 'PQ003'),
('TK012', N'ketoan1', 'pass12', N'Hoạt động', 'CV006', 'PQ004'),
('TK013', N'kthuat1', 'pass13', N'Hoạt động', 'CV007', 'PQ007');
--select * from TaiKhoan


-- Thêm dữ liệu cho bảng NhanVien
INSERT INTO NhanVien (IDNhanVien, TenNhanVien, IDTaiKhoan, SDT, Email) VALUES
('NV001', N'Nguyễn Công Phượng', 'TK001', '0912345678', 'a@gmail.com'),
('NV002', N'Nguyễn Văn Toàn', 'TK002', '0912345679', 'b@gmail.com'),
('NV003', N'Lê Văn Đô', 'TK003', '0912345680', 'c@gmail.com'),
('NV004', N'Trương Văn Thái Quý', 'TK012', '0912345681', 'd@gmail.com'),
('NV005', N'Lê Văn Đô Ki', 'TK013', '0912345682', 'e@gmail.com');
--('NV006', N'Nguyễn Quang Hải', 'TK007', '0912345683', 'f@gmail.com'),
--('NV007', N'Đặng Văn Lâm', 'TK007', '0912345684', 'g@gmail.com');
--select * from NhanVien

-- Thêm dữ liệu cho bảng KhachHang
INSERT INTO KhachHang (IDKhachHang, TenKhachHang, Email, SDT, DiaChi, IDTaiKhoan) VALUES
('KH001', N'Nguyễn Thanh Tùng', 'tung@gmail.com', '0911111111', N'Hà Nội', 'TK005'),
('KH002', N'Lê Minh Hải', 'hai@gmail.com', '0922222222', N'Hải Phòng', 'TK006'),
('KH003', N'Trần Ngọc Ánh', 'anh@gmail.com', '0933333333', N'Hồ Chí Minh', 'TK007'),
('KH004', N'Phạm Quỳnh Mai', 'mai@gmail.com', '0944444444', N'Đà Nẵng', 'TK008'),
('KH005', N'Hoàng Đình Khoa', 'khoa@gmail.com', '0955555555', N'Cần Thơ', 'TK009'),
('KH006', N'Vũ Thị Hoa', 'hoa@gmail.com', '0966666666', N'Bắc Ninh', 'TK010'),
('KH007', N'Lý Văn Tâm', 'tam@gmail.com', '0977777777', N'Bình Dương', 'TK011');
--select * from KhachHang

-- Thêm dữ liệu cho bảng DanhMucThietBi
INSERT INTO DanhMucThietBi VALUES
('DM001', N'Máy xúc'),
('DM002', N'Máy ủi'),
('DM003', N'Máy cẩu'),
('DM004', N'Máy khoan'),
('DM005', N'Máy nén khí'),
('DM006', N'Máy trộn bê tông'),
('DM007', N'Máy đào đất');
--select * from DanhMucThietBi


-- Thêm dữ liệu cho bảng ThietBi
INSERT INTO ThietBi (IDTB, TenTB, MoTa, GiaThue, SoLuong, DongCo, CongSuat, KichThuoc, TaiTrongNang, DungTichGau, ChieuCao, LoaiNhienLieu, TanSo, NhaSanXuat, IDDanhMuc)
VALUES
('TB001', N'Máy xúc đất', N'Dùng để xúc đất', 500000, 100, N'Động cơ Diesel', N'100 HP', N'2x3m', N'2 tấn', N'1m³', N'3m', N'Diesel', N'60Hz', N'CAT', 'DM001'),
('TB002', N'Máy ủi đất', N'Ủi đất công trường', 450000, 100, N'Động cơ Diesel', N'90 HP', N'2x2.5m', N'1.5 tấn', N'0.8m³', N'2.5m', N'Diesel', N'50Hz', N'Komatsu', 'DM002'),
('TB003', N'Máy cẩu', N'Dùng trong xây dựng cao tầng', 700000, 100, N'Động cơ Điện', N'120 HP', N'3x4m', N'5 tấn', N'2m³', N'5m', N'Điện', N'50Hz', N'Liebherr', 'DM003'),
('TB004', N'Máy khoan tay', N'Khoan lỗ', 300000, 100, N'Động cơ Điện', N'20 HP', N'0.5x1m', N'0.2 tấn', N'0.1m³', N'1.5m', N'Điện', N'60Hz', N'Makita', 'DM004'),
('TB005', N'Máy nén khí', N'Nén khí áp suất cao', 200000, 100, N'Động cơ Diesel', N'50 HP', N'1.5x1.5m', N'N/A', N'N/A', N'1m', N'Diesel', N'50Hz', N'Hitachi', 'DM005'),
('TB006', N'Máy trộn bê tông', N'Trộn bê tông công nghiệp', 600000, 100, N'Động cơ Diesel', N'80 HP', N'2x3.5m', N'N/A', N'N/A', N'3m', N'Diesel', N'50Hz', N'CementMix', 'DM006'),
('TB007', N'Máy đào đất mini', N'Dùng trong công trường nhỏ', 400000, 100, N'Động cơ Điện', N'70 HP', N'1.5x2.5m', N'1 tấn', N'0.5m³', N'2m', N'Điện', N'60Hz', N'Bobcat', 'DM007');

--select * from ThietBi

-- Thêm dữ liệu cho bảng DonHang
INSERT INTO DonHang (IDKhachHang, NgayLap, TrangThai, NgayThanhToan, HinhThucThanhToan) VALUES
('KH001', GETDATE(), N'Đã thanh toán', '2025-01-31', 'Chuyển khoản'),
('KH002', GETDATE(), N'Đã thanh toán', '2025-01-30', 'Thẻ tín dụng'),
('KH003', GETDATE(), N'Đã hủy', Null, 'Chuyển khoản'),
('KH004', GETDATE(), N'Đang chờ', Null, 'Tiền mặt'),
('KH005', GETDATE(), N'Đã thanh toán', '2025-01-27', 'Thẻ tín dụng'),
('KH006', GETDATE(), N'Đang chờ', Null, 'Tiền mặt'),
('KH007', GETDATE(), N'Đã thanh toán', '2025-01-25', 'Chuyển khoản');
--select * from DonHang

INSERT INTO ThoiGianThue (IDThoiGianThue, IDDonHang, NgayBatDauThue, NgayKetThucThue) VALUES
('TG001', 1, '2024-12-30', '2025-01-31'),
('TG002', 2, '2024-12-31', '2025-01-30'),
('TG003', 3, '2024-12-30', '2025-01-29'),
('TG004', 4, '2024-12-31', '2025-01-28'),
('TG005', 5, '2024-12-30', '2025-01-27'),
('TG006', 6, '2024-12-31', '2025-01-26'),
('TG007', 7, '2024-12-30', '2025-01-25');
--select * from ThoiGianThue

INSERT INTO ChiTietDonHang (IDChiTietDonHang, IDDonHang, IDThietBi, SoLuongDatThue, DonGia, IDThoiGianThue) VALUES
('CT001', 1, 'TB001', 2, 500000, 'TG001'),
('CT002', 2, 'TB002', 1, 300000, 'TG002'),
('CT003', 3, 'TB003', 1, 700000, 'TG003'),
('CT004', 4, 'TB004', 3, 200000, 'TG004'),
('CT005', 5, 'TB005', 2, 400000, 'TG005'),
('CT006', 6, 'TB006', 1, 600000, 'TG006'),
('CT007', 7, 'TB007', 4, 250000, 'TG007');

--select * from ChiTietDonHang

-- Bảng DanhGia
INSERT INTO DanhGia (IDDanhGia, LoiDanhGia, IDThietBi, SoSao, HinhAnh, Video, IDChiTietDonHang)
VALUES
('DG001', N'Sản phẩm rất tốt', 'TB001', 5, NULL, NULL, 'CT001'),
('DG002', N'Hoạt động ổn định', 'TB003', 4, NULL, NULL, 'CT002'),
('DG003', N'Giá hợp lý', 'TB005', 4, NULL, NULL, 'CT003'),
('DG004', N'Dùng tốt trong công trường', 'TB004', 5, NULL, NULL, 'CT004'),
('DG005', N'Sản phẩm đáng mua', 'TB006', 5, NULL, NULL, 'CT005'),
('DG006', N'Sử dụng lâu dài', 'TB007', 4, NULL, NULL, 'CT006'),
('DG007', N'Phù hợp với nhu cầu', 'TB002', 5, NULL, NULL, 'CT007');


INSERT INTO HopDong (IDHopDong, IDKhachHang, TrangThai, NgayTao, IDNhanVien) VALUES
('HD001', 'KH001', N'Đã ký kết', GETDATE(), 'NV002'),
('HD002', 'KH002', N'Đã ký kết', GETDATE(), 'NV002'),
('HD003', 'KH003', N'Đã hủy', GETDATE(), 'NV005'),
('HD004', 'KH004', N'Chờ ký kết', GETDATE(), 'NV005'),
('HD005', 'KH005', N'Đã ký kết', GETDATE(), 'NV002'),
('HD006', 'KH006', N'Chờ ký kết', GETDATE(), 'NV005'),
('HD007', 'KH007', N'Đã ký kết', GETDATE(), 'NV002');
--select * from HopDong

INSERT INTO ChiTietHopDong (IDChiTietHopDong, IDHopDong, IDDonHang) VALUES
('CT001', 'HD001', 1),
('CT002', 'HD002', 2),
('CT003', 'HD003', 3),
('CT004', 'HD004', 4),
('CT005', 'HD005', 5),
('CT006', 'HD006', 6),
('CT007', 'HD007', 7);
--select * from ChiTietHopDong

INSERT INTO ThanhToan (IDThanhToan, IDHopDong, PhuongThucThanhToan, NgayThanhToan, SoTienThanhToan, TrangThaiThanhToan) VALUES
('TT001', 'HD001', N'Tiền mặt', '2025-01-31', 1000000, N'Đã thanh toán'),
('TT002', 'HD002', N'Thẻ tín dụng', '2025-01-30', 300000, N'Đã thanh toán'),
('TT003', 'HD003', N'Chuyển khoản', '2025-01-29', 700000, N'Chưa thanh toán'),
('TT004', 'HD004', N'Tiền mặt', '2025-01-28', 600000, N'Chưa thanh toán'),
('TT005', 'HD005', N'Thẻ tín dụng', '2025-01-27', 800000, N'Đã thanh toán'),
('TT006', 'HD006', N'Chuyển khoản', '2025-01-26', 1200000, N'Chưa thanh toán'),
('TT007', 'HD007', N'Tiền mặt', '2025-01-25', 1000000, N'Đã thanh toán');
--select * from ThanhToan

INSERT INTO HoaDon (IDHoaDon, IDKhachHang, IDHopDong, NgayLapHoaDon) VALUES
('HD001', 'KH001', 'HD001', GETDATE()),
('HD002', 'KH002', 'HD002', GETDATE()),
('HD003', 'KH003', 'HD003', GETDATE()),
('HD004', 'KH004', 'HD004', GETDATE()),
('HD005', 'KH005', 'HD005', GETDATE()),
('HD006', 'KH006', 'HD006', GETDATE()),
('HD007', 'KH007', 'HD007', GETDATE());
--select * from HoaDon

INSERT INTO ChiTietHoaDon (IDChiTietHoaDon, IDHoaDon, IDThietBi, SoLuongThue, GiaThue) VALUES
('CT001', 'HD001', 'TB001', 2, 500000),
('CT002', 'HD002', 'TB002', 1, 300000),
('CT003', 'HD003', 'TB003', 1, 700000),
('CT004', 'HD004', 'TB004', 3, 200000),
('CT005', 'HD005', 'TB005', 2, 400000),
('CT006', 'HD006', 'TB006', 1, 600000),
('CT007', 'HD007', 'TB007', 4, 250000);

--select * from ChiTietHoaDon




--=====================================================procedure============================================================
--Danh sách thanh toán
CREATE PROCEDURE DanhSachThanhToan
AS
BEGIN
    SELECT 
        KH.TenKhachHang,
        TB.TenTB AS ThietBiThue,
        TT.NgayThanhToan,
        TG.NgayBatDauThue AS NgayThue,
        CT.DonGia * CT.SoLuongDatThue AS TienThue,
        CASE 
            WHEN TT.TrangThaiThanhToan = N'Đã thanh toán' THEN N'Đã trả'
            ELSE N'Chưa trả'
        END AS TrangThai
    FROM 
        ThanhToan TT
        INNER JOIN HopDong HD ON TT.IDHopDong = HD.IDHopDong
        INNER JOIN KhachHang KH ON HD.IDKhachHang = KH.IDKhachHang
        INNER JOIN ChiTietHopDong CTHD ON HD.IDHopDong = CTHD.IDHopDong
        INNER JOIN DonHang DH ON CTHD.IDDonHang = DH.IDDonHang
        INNER JOIN ChiTietDonHang CT ON DH.IDDonHang = CT.IDDonHang
        INNER JOIN ThietBi TB ON CT.IDThietBi = TB.IDTB
        INNER JOIN ThoiGianThue TG ON CT.IDThoiGianThue = TG.IDThoiGianThue
    ORDER BY TT.NgayThanhToan;
END
exec DanhSachThanhToan


-- Tính doanh thu theo ngày
CREATE PROCEDURE DoanhThuTheoThoiGian (@TuNgay DATE, @DenNgay DATE)
AS
BEGIN
    SELECT 
        dh.NgayThanhToan AS Ngay,
        SUM(ctdh.DonGia * ctdh.SoLuongDatThue) AS TongDoanhThu
    FROM DonHang dh
    INNER JOIN ChiTietDonHang ctdh ON dh.IDDonHang = ctdh.IDDonHang
    WHERE dh.NgayThanhToan BETWEEN @TuNgay AND @DenNgay
    GROUP BY dh.NgayThanhToan
    ORDER BY dh.NgayThanhToan;
END
exec DoanhThuTheoThoiGian '2024-12-01' , '2025-01-31';
drop procedure DoanhThuTheoThoiGian

--Thông tin thanh toán theo đơn hàng
CREATE PROCEDURE ThongTinDonHangThanhToanTheoDonHang
AS
BEGIN
    SELECT 
        DonHang.IDDonHang,
        ThanhToan.NgayThanhToan,
        DonHang.TrangThai,
        ThanhToan.PhuongThucThanhToan,
        ThanhToan.SoTienThanhToan
    FROM DonHang
    LEFT JOIN ChiTietHopDong ON DonHang.IDDonHang = ChiTietHopDong.IDDonHang
    LEFT JOIN HopDong ON ChiTietHopDong.IDHopDong = HopDong.IDHopDong
    LEFT JOIN ThanhToan ON HopDong.IDHopDong = ThanhToan.IDHopDong;
END;
exec ThongTinDonHangThanhToanTheoDonHang


CREATE PROCEDURE TimKiemThietBiTheoTen
    @TenTB NVARCHAR(100)
AS
BEGIN
    -- Kiểm tra xem có thiết bị nào khớp với tên không
    IF EXISTS (SELECT * FROM ThietBi WHERE TenTB LIKE '%' + @TenTB + '%')
    BEGIN
        -- Nếu tìm thấy, hiển thị tất cả thông tin của thiết bị
        SELECT IDTB, TenTB, MoTa, GiaThue, SoLuong, DongCo,CongSuat,KichThuoc,TaiTrongNang,DungTichGau,ChieuCao,LoaiNhienLieu,TanSo,NhaSanXuat,IDDanhMuc,
            (SELECT TenDanhMuc FROM DanhMucThietBi WHERE IDDanhMuc = ThietBi.IDDanhMuc) AS TenDanhMuc
        FROM ThietBi
        WHERE TenTB LIKE '%' + @TenTB + '%'
    END
    ELSE
    BEGIN
        -- Nếu không tìm thấy, in ra thông báo
        PRINT N'Không có thiết bị nào được tìm thấy với tên: ' + @TenTB
    END
END
exec TimKiemThietBiTheoTen N'Ủi';

--Khách hàng đăng ký
CREATE PROCEDURE KhachHangDangKy
    @HoTen NVARCHAR(100),
    @TenTaiKhoan NVARCHAR(50),
    @MatKhau VARCHAR(50),
    @SoDienThoai CHAR(10)
AS
BEGIN
    -- Khai báo biến để kiểm tra
    DECLARE @ErrorMessage NVARCHAR(200) = '';
    DECLARE @NewIDTaiKhoan VARCHAR(5);
    DECLARE @NewIDKhachHang VARCHAR(5);

    -- Kiểm tra tên tài khoản đã tồn tại chưa
    IF EXISTS (SELECT * FROM TaiKhoan WHERE TenTaiKhoan = @TenTaiKhoan)
    BEGIN
        SET @ErrorMessage = N'Tên tài khoản đã tồn tại. Vui lòng chọn tên tài khoản khác.';
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN;
    END

    -- Kiểm tra số điện thoại đã tồn tại chưa
    IF EXISTS (SELECT * FROM KhachHang WHERE SDT = @SoDienThoai)
    BEGIN
        SET @ErrorMessage = N'Số điện thoại đã được đăng ký. Vui lòng sử dụng số điện thoại khác.';
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN;
    END

    -- Bắt đầu giao dịch
    BEGIN TRANSACTION;

    BEGIN TRY
        -- Tạo ID mới cho tài khoản (đảm bảo ID không trùng)
        SET @NewIDTaiKhoan = (
            SELECT 'TK' + RIGHT('000' + CAST(
                ISNULL(MAX(CAST(REPLACE(IDTaiKhoan, 'TK', '') AS INT)), 0) + 1 
            AS VARCHAR(3)), 3)
            FROM TaiKhoan
        );

        -- Tạo ID mới cho khách hàng
        SET @NewIDKhachHang = (
            SELECT 'KH' + RIGHT('000' + CAST(
                ISNULL(MAX(CAST(REPLACE(IDKhachHang, 'KH', '') AS INT)), 0) + 1 
            AS VARCHAR(3)), 3)
            FROM KhachHang
        );

        -- Thêm tài khoản mới
        INSERT INTO TaiKhoan (IDTaiKhoan, TenTaiKhoan, MatKhau, TrangThai, IDChucVu, IDPhanQuyen) 
		VALUES (@NewIDTaiKhoan, @TenTaiKhoan, @MatKhau, N'Hoạt động', 
											'CV008',--Mặc định là khách
											'PQ003'); -- Mặc định là khách hàng thường
											
        -- Thêm khách hàng mới
        INSERT INTO KhachHang (IDKhachHang, TenKhachHang, SDT, IDTaiKhoan) 
		VALUES (@NewIDKhachHang, @HoTen, @SoDienThoai, @NewIDTaiKhoan);

        -- Commit giao dịch
        COMMIT TRANSACTION;

        -- Trả về thông tin đăng ký thành công
        SELECT 
            @NewIDTaiKhoan AS IDTaiKhoan, 
            @NewIDKhachHang AS IDKhachHang, 
            N'Đăng ký thành công' AS Message;
    END TRY
    BEGIN CATCH
        -- Rollback nếu có lỗi
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;

        -- Thông báo lỗi
        SET @ErrorMessage = ERROR_MESSAGE();
        RAISERROR(@ErrorMessage, 16, 1);
        RETURN;
    END CATCH
END
drop procedure KhachHangDangKy
exec KhachHangDangKy N'Nguyễn Vũ Khanh','khanhkhiemton', 'nvk09112004', '0795605214'
select * from KhachHang


--Tổng hợp hợp đồng
CREATE PROCEDURE sp_BaoCaoTongHopHopDong
    @TuNgay DATE,
    @DenNgay DATE
AS
BEGIN
    SELECT hd.IDHopDong, kh.TenKhachHang, nv.TenNhanVien as NhanVienPhuTrach,hd.NgayTao, hd.TrangThai,
        COUNT(DISTINCT cthd.IDDonHang) as SoDonHang,
       ISNULL(SUM(tt.SoTienThanhToan), 0) as TongTienThanhToan,
       	tt.TrangThaiThanhToan  
    FROM HopDong hd
    INNER JOIN KhachHang kh ON hd.IDKhachHang = kh.IDKhachHang
    INNER JOIN NhanVien nv ON hd.IDNhanVien = nv.IDNhanVien
    LEFT JOIN ChiTietHopDong cthd ON hd.IDHopDong = cthd.IDHopDong
    LEFT JOIN ThanhToan tt ON hd.IDHopDong = tt.IDHopDong
    WHERE hd.NgayTao BETWEEN @TuNgay AND @DenNgay
    GROUP BY hd.IDHopDong, kh.TenKhachHang, nv.TenNhanVien, hd.NgayTao, hd.TrangThai, tt.TrangThaiThanhToan
    ORDER BY hd.NgayTao DESC
END
GO
drop proc sp_BaoCaoTongHopHopDong
exec sp_BaoCaoTongHopHopDong '2024-12-01' , '2025-01-31';

--============================================================================================================================================
--TINH TONG TRA VE GIA TRI
CREATE FUNCTION TinhTongTienDonHang (
    @IDDonHang INT
)
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TongTien DECIMAL(18, 2);

    SELECT @TongTien = SUM(SoLuongDatThue * DonGia)
    FROM ChiTietDonHang
    WHERE IDDonHang = @IDDonHang;

    RETURN @TongTien;
END;
GO
select *,dbo.TinhTongTienDonHang(1)from ChiTietDonHang where IDDonHang=1

--TINH TONG TRA VE TABLE
CREATE FUNCTION LayTongTienTheoDonHang ()
RETURNS TABLE
AS
RETURN
(
    SELECT IDDonHang ,SUM(SoLuongDatThue * DonGia) AS TongTien 
    FROM ChiTietDonHang
    GROUP BY IDDonHang
);
GO
SELECT * FROM dbo.LayTongTienTheoDonHang();


--KIEM TRA TRANG THAI THANH TOAN
CREATE FUNCTION LayTrangThaiThanhToan (
    @IDThanhToan VARCHAR(5)
)
RETURNS NVARCHAR(20)
AS
BEGIN
    DECLARE @TrangThai NVARCHAR(20);

    SELECT @TrangThai = TrangThaiThanhToan
    FROM ThanhToan
    WHERE IDThanhToan = @IDThanhToan;

    RETURN @TrangThai;
END;
GO
SELECT * from ThanhToan
SELECT dbo.LayTrangThaiThanhToan('TT001') AS TrangThai;

--TINH SO NGAY THUE
SELECT * FROM ChiTietDonHang

CREATE FUNCTION TinhSoNgayThue (
    @NgayBatDau DATE,
    @NgayKetThuc DATE
)
RETURNS INT
AS
BEGIN
    RETURN DATEDIFF(DAY, @NgayBatDau, @NgayKetThuc);
END;
GO

SELECT IDDonHang, dbo.TinhSoNgayThue(NgayBatDauThue, NgayKetThucThue) AS SoNgayThue
FROM ThoiGianThue;

--TINH TONG DOANH THU
CREATE FUNCTION TinhTongDoanhThu ()
RETURNS DECIMAL(18, 2)
AS
BEGIN
    DECLARE @TongDoanhThu DECIMAL(18, 2);

    SELECT @TongDoanhThu = SUM(ctdh.SoLuongDatThue * ctdh.DonGia)
   FROM ChiTietDonHang ctdh
    INNER JOIN DonHang dh ON ctdh.IDDonHang = dh.IDDonHang

    RETURN @TongDoanhThu;
END;
GO

SELECT dbo.TinhTongDoanhThu() AS TongDoanhThu;

--TINH SO SAO TRUNG BINH
CREATE FUNCTION TinhDiemTrungBinhDanhGia (
    @IDThietBi VARCHAR(5)
)
RETURNS DECIMAL(3, 2)
AS
BEGIN
    DECLARE @DiemTrungBinh DECIMAL(3, 2);

    SELECT @DiemTrungBinh = AVG(SoSao * 1.0)
    FROM DanhGia
    WHERE IDThietBi = @IDThietBi;

    RETURN @DiemTrungBinh;
END;
GO

SELECT dbo.TinhDiemTrungBinhDanhGia('TB001') AS DiemTrungBinh;


--===============================================================================================================================

-- cập nhật số lượng khi insert, update, delete
CREATE TRIGGER trg_UpdateSoLuongThietBi
ON ChiTietDonHang
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;

    -- Xử lý cho INSERT
    IF EXISTS (SELECT * FROM inserted)
    BEGIN
        DECLARE @IDThietBi CHAR(5), @SoLuongDatThue INT;
        
        SELECT @IDThietBi = IDThietBi, @SoLuongDatThue = SoLuongDatThue
        FROM inserted;

        -- Kiểm tra số lượng trong kho
        IF EXISTS (
            SELECT 1 
            FROM ThietBi 
            WHERE IDTB = @IDThietBi AND SoLuong >= @SoLuongDatThue
        )
        BEGIN
            -- Trừ số lượng thiết bị trong kho
            UPDATE ThietBi
            SET SoLuong = SoLuong - @SoLuongDatThue
            WHERE IDTB = @IDThietBi;
        END
        ELSE
        BEGIN
            -- Nếu không đủ số lượng, thông báo lỗi và rollback
            RAISERROR (N'Số lượng thiết bị không đủ trong kho!', 16, 1);
            ROLLBACK TRANSACTION;
        END
    END

    -- Xử lý cho UPDATE
    IF EXISTS (SELECT * FROM inserted) AND EXISTS (SELECT * FROM deleted)
    BEGIN
        DECLARE @IDThietBiOld CHAR(5), @SoLuongOld INT, @IDThietBiNew CHAR(5), @SoLuongNew INT;
        
        SELECT @IDThietBiOld = IDThietBi, @SoLuongOld = SoLuongDatThue
        FROM deleted;

        SELECT @IDThietBiNew = IDThietBi, @SoLuongNew = SoLuongDatThue
        FROM inserted;

        -- Hoàn trả số lượng cũ
        UPDATE ThietBi
        SET SoLuong = SoLuong + @SoLuongOld
        WHERE IDTB = @IDThietBiOld;

        -- Kiểm tra số lượng mới
        IF EXISTS (
            SELECT 1 
            FROM ThietBi 
            WHERE IDTB = @IDThietBiNew AND SoLuong >= @SoLuongNew
        )
        BEGIN
            -- Trừ số lượng mới
            UPDATE ThietBi
            SET SoLuong = SoLuong - @SoLuongNew
            WHERE IDTB = @IDThietBiNew;
        END
        ELSE
        BEGIN
            -- Nếu không đủ số lượng, thông báo lỗi và rollback
            RAISERROR (N'Số lượng thiết bị không đủ trong kho!', 16, 1);
            ROLLBACK TRANSACTION;
        END
    END

    -- Xử lý cho DELETE
    IF EXISTS (SELECT * FROM deleted)
    BEGIN
        DECLARE @IDThietBiDelete CHAR(5), @SoLuongDelete INT;
        
        SELECT @IDThietBiDelete = IDThietBi, @SoLuongDelete = SoLuongDatThue
        FROM deleted;

        -- Hoàn trả số lượng vào kho
        UPDATE ThietBi
        SET SoLuong = SoLuong + @SoLuongDelete
        WHERE IDTB = @IDThietBiDelete;
    END
END;
GO


-- Test INSERT
INSERT INTO ChiTietDonHang (IDChiTietDonHang, IDDonHang, IDThietBi, SoLuongDatThue, DonGia, IDThoiGianThue)
VALUES ('CT008', 1, 'TB001', 11, 500000, 'TG001');

-- Test UPDATE
UPDATE ChiTietDonHang
SET SoLuongDatThue = 2
WHERE IDChiTietDonHang = 'CT002';
--select * from ChiTietDonHang

-- Test DELETE
DELETE FROM ChiTietDonHang
WHERE IDChiTietDonHang = 'CT008';
 
 select * from ChiTietDonHang
 go
 select * from ThietBi


 -- Trigger kiểm tra khi thêm thiết bị mới
ALTER TRIGGER TR_ThemThietBi
ON ThietBi
INSTEAD OF INSERT
AS
BEGIN
    DECLARE @NewIDTB varchar(10)

    -- Tạo ID mới cho thiết bị
    SET @NewIDTB = (
        SELECT 'TB' + RIGHT('000' + CAST(
            ISNULL(MAX(CAST(REPLACE(IDTB, 'TB', '') AS INT)), 0) + 1 
        AS VARCHAR(3)), 3)
        FROM ThietBi
    )

    -- Kiểm tra dữ liệu đầu vào
    IF EXISTS (
        SELECT * FROM inserted 
        WHERE GiaThue <= 0 OR SoLuong < 0
    )
    BEGIN
        RAISERROR (N'Giá thuê phải lớn hơn 0 và số lượng không được âm', 16, 1)
        RETURN
    END

    -- Kiểm tra ID danh mục có tồn tại
    IF NOT EXISTS (
        SELECT * FROM DanhMucThietBi dm
        INNER JOIN inserted i ON dm.IDDanhMuc = i.IDDanhMuc
    )
    BEGIN
        RAISERROR (N'ID danh mục không tồn tại', 16, 1)
        RETURN
    END

    -- Thêm thiết bị mới với ID đã được tạo
    INSERT INTO ThietBi (
        IDTB, TenTB, MoTa, GiaThue, SoLuong, DongCo, CongSuat,KichThuoc, TaiTrongNang, DungTichGau, ChieuCao,LoaiNhienLieu, TanSo, NhaSanXuat, IDDanhMuc)
    SELECT 
        @NewIDTB, TenTB, MoTa, GiaThue, SoLuong, DongCo, CongSuat,KichThuoc, TaiTrongNang, DungTichGau, ChieuCao,LoaiNhienLieu, TanSo, NhaSanXuat, IDDanhMuc   
    FROM inserted
END
--drop trigger TR_ThemThietBi
INSERT INTO ThietBi (TenTB, MoTa, GiaThue, SoLuong, DongCo, CongSuat, KichThuoc, TaiTrongNang, DungTichGau, ChieuCao, LoaiNhienLieu, TanSo, NhaSanXuat, IDDanhMuc)
VALUES
(N'Máy khoang từ', N'Dùng trong ngành cơ khí chế tạo', 400000, 100, N'Động cơ Điện', N'70 HP', N'1.5x2.5m', N'1 tấn', N'0.5m³', N'2m', N'Điện', N'60Hz', N'Bobcat', 'DM004');

select * from ThietBi
select * from DanhMucThietBi


-- Trigger kiểm tra khi sửa thiết bị
CREATE TRIGGER TR_SuaThietBi
ON ThietBi
INSTEAD OF UPDATE
AS
BEGIN
    -- Kiểm tra dữ liệu đầu vào
    IF EXISTS (
        SELECT * FROM inserted 
        WHERE GiaThue <= 0 OR SoLuong < 0
    )
    BEGIN
        RAISERROR (N'Giá thuê phải lớn hơn 0 và số lượng không được âm', 16, 1)
        RETURN
    END

    -- Kiểm tra ID danh mục có tồn tại
    IF NOT EXISTS (
        SELECT * FROM DanhMucThietBi dm
        INNER JOIN inserted i ON dm.IDDanhMuc = i.IDDanhMuc
    )
    BEGIN
        RAISERROR (N'ID danh mục không tồn tại', 16, 1)
        RETURN
    END

    -- Sửa thiết bị
    UPDATE ThietBi
    SET 
       TenTB = i.TenTB, MoTa = i.MoTa, GiaThue = i.GiaThue,SoLuong = i.SoLuong,DongCo = i.DongCo,CongSuat = i.CongSuat,KichThuoc = i.KichThuoc,TaiTrongNang = i.TaiTrongNang,
       DungTichGau = i.DungTichGau,ChieuCao = i.ChieuCao,LoaiNhienLieu = i.LoaiNhienLieu,TanSo = i.TanSo,NhaSanXuat = i.NhaSanXuat,IDDanhMuc = i.IDDanhMuc 
    FROM ThietBi tb
    INNER JOIN inserted i ON tb.IDTB = i.IDTB
END
UPDATE ThietBi
SET NhaSanXuat = N'Hitachi'
WHERE IDTB = 'TB008';
select * from ThietBi

-- Trigger kiểm tra khi xóa thiết bị
CREATE TRIGGER TR_XoaThietBi
ON ThietBi
INSTEAD OF DELETE
AS
BEGIN
    -- Kiểm tra nếu thiết bị đang được sử dụng trong bảng ChiTietDonHang hoặc DanhGia
    IF EXISTS (
        SELECT * FROM deleted d
        WHERE EXISTS (
            SELECT 1 FROM ChiTietDonHang ctdh WHERE ctdh.IDThietBi = d.IDTB
            UNION ALL
            SELECT 1 FROM DanhGia dg WHERE dg.IDThietBi = d.IDTB
        )
    )
    BEGIN
        RAISERROR (N'Thiết bị đang được tham chiếu trong bảng khác, không thể xóa', 16, 1)
        RETURN
    END

    -- Xóa thiết bị
    DELETE FROM ThietBi
    WHERE IDTB IN (SELECT IDTB FROM deleted)
END
DELETE FROM ThietBi WHERE IDTB = 'TB008';
select * from ThietBi