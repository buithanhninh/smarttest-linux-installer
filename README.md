# SmartTest Linux Installer

Kho lưu trữ private cho bộ cài SmartTest chạy Linux với PostgreSQL.

## Release assets

- `smarttest_linux.rar`: bộ cài gốc do đơn vị cung cấp.
- `smarttest_linux_deploy_20260804.tar.gz`: gói triển khai Linux đã đóng gói ngày 04/08/2026.

Các file binary lớn được lưu trong mục **Releases**, không commit trực tiếp vào Git.

## Kiểm tra toàn vẹn

```text
7C07B7068A918915709323E5F4CEB72878890E59650A712C2B0823BF02C6B139  smarttest_linux.rar
EBA4CE324F9AFBB947F5570F5E88ED5E66C8009A6D4A6C9829132948CA6435AC  smarttest_linux_deploy_20260804.tar.gz
```

Kiểm tra trên Linux:

```bash
sha256sum -c SHA256SUMS.txt
```

Kiểm tra trên Windows PowerShell:

```powershell
Get-FileHash -Algorithm SHA256 .\smarttest_linux.rar
Get-FileHash -Algorithm SHA256 .\smarttest_linux_deploy_20260804.tar.gz
```

## Môi trường đã xác minh

- Ubuntu 24.04 LTS
- PostgreSQL 16
- ASP.NET Core Runtime 10
- Kestrel HTTP tại `127.0.0.1:3154`
- Cloudflare Tunnel làm reverse proxy HTTPS

## Lưu ý triển khai

- Không commit token Cloudflare, mật khẩu PostgreSQL hoặc file môi trường production.
- Gói ứng dụng có thể chứa cấu hình và khóa tích hợp cũ. Giữ repo private và rotate credential trước khi chia sẻ thêm collaborator.
- Bộ cài không chứa `SmartUniConnector.dll` và `HupConnector.dll`; cấu hình production hiện tắt các connector này.
- Cần license SmartTest hợp lệ từ nhà cung cấp để sử dụng đầy đủ chức năng quản trị.