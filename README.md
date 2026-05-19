1. GIỚI THIỆU CHUNG
- Tên dự án: Froken3p Shop
- Mục tiêu: Xây dựng một website thương mại điện tử chuyên nghiệp với đầy đủ chức năng quản lý, phân loại sản phẩm và theo dõi đơn hàng dành cho cả quản trị viên và khách hàng.
- Kiến trúc: Mô hình MVC (Model - View - Controller).

2. CÔNG NGHỆ SỬ DỤNG
- Framework (Backend): ASP.NET Core MVC (.NET 10.0)
- Ngôn ngữ lập trình: C#
- Cơ sở dữ liệu: SQL Server
- Frontend: HTML, CSS, JavaScript, Razor Pages/Views

3. TÍNH NĂNG CHÍNH

3.1. Dành cho Khách hàng (User)
- Phân loại sản phẩm đa dạng: Quần áo, Giày dép, Mũ nón,...
- Logic chọn Size động (Dynamic size selection): Hỗ trợ các thuộc tính thay đổi tùy theo loại mặt hàng.
- Giỏ hàng & Thanh toán: Thêm sản phẩm vào giỏ, điều chỉnh số lượng và tiến hành đặt hàng.
- Quản lý đơn hàng: Xem lịch sử đặt hàng, theo dõi trạng thái đơn hàng (Đang xử lý, Đang giao, Đã giao,...).

3.2. Dành cho Quản trị viên (Admin)
- Quản lý sản phẩm & danh mục: Thêm, sửa, xóa sản phẩm và các thuộc tính/kích cỡ.
- Quản lý đơn hàng: Theo dõi tất cả đơn hàng trên hệ thống, cập nhật trạng thái đơn hàng.
- Thống kê & Báo cáo: Theo dõi doanh thu của cửa hàng, số lượng đơn hàng thành công/hủy.

4. CẤU TRÚC THƯ MỤC DỰ ÁN
- /Controllers: Chứa các controller điều hướng xử lý logic (ví dụ: HomeController.cs,...).
- /Models: Chứa các lớp định nghĩa cấu trúc dữ liệu, ViewModels (ví dụ: ErrorViewModel.cs,...).
- /Views: Chứa các file giao diện người dùng (.cshtml) được phân chia theo từng Controller (Home, Shared,...).
- /wwwroot: Nơi chứa các tài nguyên tĩnh như CSS, JavaScript, thư viện ngoài và hình ảnh.
- Program.cs: File thiết lập cấu hình pipeline, đăng ký các dịch vụ (Dependency Injection).
- appsettings.json: File lưu trữ các cấu hình chung của hệ thống, đặc biệt là chuỗi kết nối CSDL (Connection Strings).
- ShopeeCloneWeb.slnx: File Solution của dự án.

5. HƯỚNG DẪN CÀI ĐẶT & CHẠY DỰ ÁN
Bước 1: Mở Solution `ShopeeCloneWeb.slnx`

Bước 2: Cấu hình chuỗi kết nối SQL Server (Connection String) vào file `appsettings.json`.

Bước 3: Mở Package Manager Console và chạy các lệnh Migration (nếu có sử dụng Entity Framework Core) để tạo database:
   > Add-Migration Initial
   > Update-Database
 
Bước 4: Nhấn F5 hoặc sử dụng lệnh `dotnet run` để khởi chạy ứng dụng web.

Bước 5: Truy cập địa chỉ http://localhost:<port> trên trình duyệt để sử dụng.
