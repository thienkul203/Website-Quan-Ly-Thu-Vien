
from flask import Blueprint, request, render_template, redirect, url_for, flash
from model.tacgia_model import gettacgia, them_tac_gia, sua_tac_gia, xoa_tac_gia

# Định nghĩa Blueprint
tacgia_bp = Blueprint('tacgia', __name__, url_prefix='/tacgia')


@tacgia_bp.route('/')
def get_tacgia():
    tacgias = gettacgia()
    return render_template('tacgia.html', tacgias=tacgias)

@tacgia_bp.route('/them', methods=['POST'])
def them_tacgia():
    maTacGia = request.form.get('maTacGia')
    tenTacGia = request.form.get('tenTacGia')
    ghiChu = request.form.get('ghiChu')

    if not maTacGia:
        flash('Vui lòng nhập mã tac gia', 'danger')
        return redirect(url_for('tacgia.get_tacgia'))
    if not tenTacGia:
        flash('Vui lòng nhập tên loại sách', 'danger')
        return redirect(url_for('tacgia.get_tacgia'))

    # Gọi hàm them_loai_sach
    message = them_tac_gia(maTacGia, tenTacGia, ghiChu)
    if message == "Mã tac gia đã tồn tại":
        flash(message, 'danger')
    elif message == "Thêm tac gia thành công!":
        flash(message, 'success')
    else:
        flash(message, 'danger')

    return redirect(url_for('tacgia.get_tacgia'))

@tacgia_bp.route('/sua', methods=['POST'])
def sua_tacgia():
    maTacGia = request.form.get('maTacGia')
    tenTacGia = request.form.get('tenTacGia')
    ghiChu = request.form.get('ghiChu')

    if not maTacGia or not tenTacGia:
        flash('Vui lòng nhập đầy đủ thông tin!', 'danger')
        return redirect(url_for('tacgia.get_tacgia'))

    # Kiểm tra mã tác giả tồn tại
    if sua_tac_gia(maTacGia, tenTacGia, ghiChu) == "Mã Tác giả không tồn tại":
        flash('Mã Tác Giả không tồn tại!', 'danger')
    else:
        flash('Cập nhật tác giả thành công!', 'success')

    return redirect(url_for('tacgia.get_tacgia'))


@tacgia_bp.route('/xoa/<maTacGia>', methods=['POST'])
def xoa_tacgia(maTacGia):
    message = xoa_tac_gia(maTacGia)

    if message == "Xóa loại sách thành công!":
        flash(message, 'success')
    else:
        flash(message, 'danger')  # Hiển thị lỗi nếu không thể xóa

    return redirect(url_for('tacgia.get_tacgia'))