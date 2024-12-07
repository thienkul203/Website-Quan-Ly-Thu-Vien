IF EXISTS (SELECT name FROM sys.databases WHERE name = 'QLThuVien')
BEGIN
    DROP DATABASE QLThuVien;
END
CREATE DATABASE QLThuVien;
GO
USE QLThuVien;
GO
-- Tạo bảng TacGia
CREATE TABLE TacGia (
    MaTacGia NVARCHAR(10) PRIMARY KEY,
    TenTacGia NVARCHAR(50),
    GhiChu NVARCHAR(255)
);

-- Tạo bảng NhaXuatBan
CREATE TABLE NhaXuatBan (
    MaNXB NVARCHAR(10) PRIMARY KEY,
    TenNXB NVARCHAR(50),
    GhiChu NVARCHAR(255)
);

-- Tạo bảng LoaiSach
CREATE TABLE LoaiSach (
    MaLoai NVARCHAR(10) PRIMARY KEY,
    TenLoaiSach NVARCHAR(50),
    GhiChu NVARCHAR(255)
);

-- Tạo bảng Sach
CREATE TABLE Sach (
    MaSach NVARCHAR(10) PRIMARY KEY,
    TenSach NVARCHAR(50),
    MaTacGia NVARCHAR(10) FOREIGN KEY REFERENCES TacGia(MaTacGia),
    MaNXB NVARCHAR(10) FOREIGN KEY REFERENCES NhaXuatBan(MaNXB),
    MaLoai NVARCHAR(10) FOREIGN KEY REFERENCES LoaiSach(MaLoai),
    SoTrang INT,
    GiaBan DECIMAL(18, 2),
    SoLuong INT,
	HinhAnh NVARCHAR(50)
);

-- Tạo bảng NhanVien
CREATE TABLE NhanVien (
    MaNhanVien NVARCHAR(10) PRIMARY KEY,
    TenNhanVien NVARCHAR(50),
    SoDienThoai NVARCHAR(10),
    GioiTinh NVARCHAR(10),
    DiaChi NVARCHAR(100),
    MatKhau NVARCHAR(10),
	VaiTro NVARCHAR(10)
);

-- Tạo bảng SinhVien
CREATE TABLE SinhVien (
    MaSV NVARCHAR(10) PRIMARY KEY,
    TenSV NVARCHAR(50),
    NganhHoc NVARCHAR(50),
    KhoaHoc NVARCHAR(50),
    SoDienThoai int
);

-- Tạo bảng MuonTraSach
CREATE TABLE MuonTraSach (
    MaPhieuMuon INT PRIMARY KEY IDENTITY(1,1),
    MaSV NVARCHAR(10) FOREIGN KEY REFERENCES SinhVien(MaSV),
    MaSach NVARCHAR(10) FOREIGN KEY REFERENCES Sach(MaSach),
    NgayMuon DATE,
    NgayTra DATE,
    GhiChu NVARCHAR(255)
);

SELECT MaSV, COUNT(*) 
FROM MuonTraSach
GROUP BY MaSV;
SELECT COUNT(*) AS TongSoSachDangMuon
FROM MuonTraSach
WHERE MaSV = 'SV001' ;


INSERT INTO TacGia (MaTacGia, TenTacGia, GhiChu) VALUES 
('TG001', 'Nguyễn Nhật Ánh', 'Tác giả nổi tiếng với các tác phẩm về tuổi thơ'),
('TG002', 'Trần Đăng Khoa', 'Tác giả của nhiều bài thơ nổi tiếng'),
('TG003', 'Tô Hoài', 'Tác giả của Dế Mèn Phiêu Lưu Ký'),
('TG004', 'Nam Cao', 'Nhà văn hiện thực phê phán'),
('TG005', 'Vũ Trọng Phụng', 'Nhà văn phê phán xã hội');

INSERT INTO NhaXuatBan (MaNXB, TenNXB, GhiChu) VALUES 
('NXB001', 'Nhà Xuất Bản Trẻ', 'Chuyên xuất bản sách thiếu nhi và văn học'),
('NXB002', 'Nhà Xuất Bản Giáo Dục', 'Chuyên xuất bản sách giáo dục'),
('NXB003', 'Nhà Xuất Bản Văn Học', 'Xuất bản sách văn học cổ điển và hiện đại'),
('NXB004', 'Nhà Xuất Bản Khoa Học Kỹ Thuật', 'Chuyên xuất bản tài liệu khoa học'),
('NXB005', 'Nhà Xuất Bản Thông Tin', 'Chuyên xuất bản các tài liệu tham khảo');

INSERT INTO LoaiSach (MaLoai, TenLoaiSach, GhiChu) VALUES 
('LS001', 'Tiểu Thuyết', 'Sách thuộc thể loại tiểu thuyết'),
('LS002', 'Giáo Khoa', 'Sách giáo khoa dùng cho học sinh'),
('LS003', 'Thơ', 'Sách tập thơ'),
('LS004', 'Kỹ Thuật', 'Sách về kỹ thuật và công nghệ'),
('LS005', 'Tài Liệu Tham Khảo', 'Các tài liệu dùng để tham khảo');

INSERT INTO Sach (MaSach, TenSach, MaTacGia, MaNXB, MaLoai, SoTrang, GiaBan, SoLuong, HinhAnh) VALUES 
('S001', 'Cho tôi xin một vé đi tuổi thơ', 'TG001', 'NXB001', 'LS001', 150, 50000, 20, 'images/cho-toi-xin-mot-ve.jpg'),
('S002', 'Dế Mèn Phiêu Lưu Ký', 'TG003', 'NXB001', 'LS001', 200, 70000, 15, 'images/de-men.jpg'),
('S003', 'Lão Hạc', 'TG004', 'NXB002', 'LS001', 100, 40000, 10, 'images/lao-hac.jpg'),
('S004', 'Vợ Nhặt', 'TG005', 'NXB003', 'LS001', 120, 45000, 12, 'images/vo-nhat.jpg'),
('S005', 'Từ điển tiếng Anh', 'TG002', 'NXB005', 'LS005', 300, 120000, 8, 'images/tu-dien-anh.jpg');

INSERT INTO NhanVien (MaNhanVien, TenNhanVien, SoDienThoai, GioiTinh, DiaChi, MatKhau, VaiTro) VALUES 
('NV001', 'Nguyễn Văn A','0123456789', 'Nam', 'Hà Nội', '123456', 'Thủ thư'),
('NV002', 'Trần Thị B', '0987654321', 'Nữ', 'TP. HCM', 'abcdef', 'Quản lý'),
('NV003', 'Phạm Văn C',  '0112233445', 'Nam', 'Đà Nẵng', '654321', 'Nhân viên');

INSERT INTO SinhVien (MaSV, TenSV, NganhHoc, KhoaHoc, SoDienThoai) VALUES 
('SV001', 'Lê Văn D', 'Công nghệ thông tin', 'K25', 123123123),
('SV002', 'Nguyễn Thị E', 'Kinh tế', 'K26', 456456456),
('SV003', 'Trần Văn F', 'Y học', 'K25', 789789789),
('SV004', 'Đỗ Thị G', 'Luật', 'K27', 321321321),
('SV005', 'Phan Văn H', 'Văn học', 'K26', 654654654);

INSERT INTO MuonTraSach (MaSV, MaSach, NgayMuon, NgayTra, GhiChu) VALUES 
('SV001', 'S001', '2024-10-01', '2024-10-10', 'Trả đúng hạn'),
('SV002', 'S002', '2024-09-15', '2024-09-25', 'Trả muộn'),
('SV003', 'S003', '2024-08-20', '2024-09-01', 'Sách hỏng một phần'),
('SV004', 'S004', '2024-10-05', '2024-10-15', 'Trả đúng hạn'),
('SV005', 'S005', '2024-07-30', '2024-08-10', 'Sách mới');


