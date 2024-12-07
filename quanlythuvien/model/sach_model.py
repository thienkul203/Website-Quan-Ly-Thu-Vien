from csdl import get_connection

def getsach():
    try:
        conn = get_connection()
        cursor = conn.cursor()
        
        query = """
        SELECT * FROM Sach
        """
        
        cursor.execute(query)
        sachs = cursor.fetchall()
        return sachs

    except Exception as e:
        print("Lỗi khi truy vấn dữ liệu từ cơ sở dữ liệu:", e)
        return None

    finally:
        if conn:
            conn.close()


def them_sach_new(txtmaSach, txttenSach, txttacGia, txtnhaXuatBan, txtloaiSach, txtsoTrang, txtgiaBan, txtsoLuong, txthinhAnh):
    try:
        conn = get_connection()
        cursor = conn.cursor()

        # Kiểm tra mã sách đã tồn tại
        check_query = "SELECT COUNT(*) FROM Sach WHERE MaSach = ?"
        cursor.execute(check_query, (txtmaSach,))
        if cursor.fetchone()[0] > 0:
            return "Mã sách đã tồn tại"

        # Thêm sách mới
        query = """
            INSERT INTO Sach (MaSach,TenSach, MaTacGia, MaNXB, MaLoai, SoTrang, GiaBan, SoLuong, HinhAnh)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)
        """
        cursor.execute(query, (txtmaSach, txttenSach, txttacGia, txtnhaXuatBan, txtloaiSach, txtsoTrang, txtgiaBan, txtsoLuong, txthinhAnh))
        conn.commit()
        return "Thêm sách thành công!"
    except Exception as e:
        print("Lỗi khi thêm sách vào cơ sở dữ liệu:", e)
        return "Lỗi khi thêm sách"
    finally:
        if conn:
            conn.close()

def sua_sach_new(txtmaSach, txttenSach, txttacGia, txtnhaXuatBan, txtloaiSach, txtsoTrang, txtgiaBan, txtsoLuong, txthinhAnh):
    try:
        conn = get_connection()
        cursor = conn.cursor()

        query = """
        UPDATE Sach
        SET TenSach = ?, MaTacGia = ?, MaNXB = ?, MaLoai = ?, SoTrang = ?, GiaBan = ?, SoLuong = ?, HinhAnh = ?
        WHERE MaSach = ?
        """

        cursor.execute(query, (txttenSach, txttacGia, txtnhaXuatBan, txtloaiSach, txtsoTrang, txtgiaBan, txtsoLuong, txthinhAnh, txtmaSach))
        conn.commit()
        print("Cập nhật sách thành công!")

    except Exception as e:
        print("Lỗi khi cập nhật dữ liệu trong cơ sở dữ liệu:", e)

    finally:
        if conn:
            conn.close()

def xoa_sach_new(txtmaSach):
    try:
        conn = get_connection()
        cursor = conn.cursor()

        # Kiểm tra dữ liệu liên quan
        query_check = "SELECT COUNT(*) FROM MuonTraSach WHERE MaSach = ?"
        cursor.execute(query_check, (txtmaSach,))
        related_count = cursor.fetchone()[0]

        if related_count > 0:
            return "Không thể xóa sách. Sách đang được sử dụng trong bảng MuonTraSach."

        # Xóa bản ghi trong bảng Sach
        query_delete = "DELETE FROM Sach WHERE MaSach = ?"
        cursor.execute(query_delete, (txtmaSach,))

        conn.commit()  # Commit transaction
        return "Xóa sách thành công!"

    except Exception as e:
        print("Chi tiết lỗi:", str(e))  # Ghi log lỗi chi tiết
        return "Xóa sách không thành công. Vui lòng kiểm tra dữ liệu liên quan."

    finally:
        if conn:
            conn.close()
