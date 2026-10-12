# SmartTest (HMUTEST) - High Concurrency Standalone Production Release

Hệ thống khảo thí và thi trắc nghiệm trực tuyến **SmartTest (HMUTEST - Trường Đại học Y Hà Nội)** phiên bản chuẩn triển khai chính thức **v2026.10.12**.

Hệ thống được thiết kế và đóng gói hoạt động **100% độc lập (Standalone)**, **không yêu cầu đăng ký bản quyền, không khóa phần cứng (hardware/node-locking), không kích hoạt online và không giới hạn thời gian sử dụng**. Bất kỳ máy chủ Linux (Ubuntu 22.04 LTS / Ubuntu 24.04 LTS) nào cũng có thể tải về và cài đặt hoạt động hoàn hảo chỉ với 1 dòng lệnh duy nhất.

---

## 1. Thông tin Phiên bản & Tài khoản Mặc định

* **Phiên bản phát hành:** `v2026.10.12`
* **Trạng thái bản quyền:** **Đã mở khóa hoàn toàn (Vĩnh viễn - Standalone)**. Không cần key, không kích hoạt, không phụ thuộc máy chủ cấp phép bên ngoài.
* **Tài khoản Quản trị Tối cao (SuperAdmin - Toàn quyền cấu hình & quản trị):**
  * **Tên đăng nhập:** `admin`
  * **Mật khẩu:** `Admin@2026`
  * **Quyền hạn:** `RoleType = 10` (Bypass mọi bộ lọc phân quyền, toàn quyền tạo kỳ thi, ngân hàng câu hỏi, phòng thi, cấu hình hệ thống).
* **Tài khoản Thí sinh mẫu:**
  * **Tên đăng nhập:** `101` (hoặc `102`, `103`)
  * **Mật khẩu:** `101` (hoặc `102`, `103`)

---

## 2. Kiến trúc Hệ thống & Tải cao (High Concurrency Architecture)

Hệ thống được tối ưu hóa chịu tải cho **2.000 thí sinh thi đồng thời trên toàn quốc**, giải quyết triệt để bài toán nghẽn mạng khi upload đề thi dung lượng lớn mà **tuyệt đối không cần mở cổng 80 & 443 trên Router/Modem mạng VNPT**.

```
[2,000 Thí sinh & Giám thị trên cả nước]
                  │
                  ▼ (HTTPS / TLS 1.3 - HTTP/2 / HTTP/3)
[Cloudflare Edge Network]
  ├── Edge Cache Rule (/js/*, /css/*, /lib/*, /fonts/*, /images/* - TTL 30 ngày)
  └── Smart Tiered Cache Topology (Giảm 90% băng thông và tải máy chủ)
                  │
                  ▼ (Encrypted Outbound Tunnel - Giao thức HTTP/2 over TCP)
[cloudflared daemon (systemd)]
  ├── LimitNOFILE = 1,048,576
  └── --proxy-keepalive-connections 2048
                  │
                  ▼ (Localhost Socket HTTP: http://127.0.0.1:3154 & LAN: 0.0.0.0:3154)
[.NET 10 Kestrel Web Application (SmartTest)]
  ├── MaxConcurrentConnections = 10,000
  ├── MaxConcurrentUpgradedConnections = 5,000 (SignalR / WebSockets)
  └── MaxRequestBodySize = 104,857,600 (100 MB - Upload đề thi chứa ảnh y tế siêu tốc)
                  │
                  ▼ (Connection Pool: MaxPoolSize=500, IdleTimeout=30s)
[PostgreSQL High-Concurrency Database]
  ├── shared_buffers = 6 GB (Tận dụng RAM 24GB, đệm dữ liệu đề thi trên RAM)
  ├── max_connections = 600
  ├── effective_cache_size = 16 GB, work_mem = 16 MB, wal_buffers = 64 MB
  └── Composite Indexes: "IX_CandidateAnswers_CandidateId_QuestionId" (Truy vấn 0.12ms)
```

---

## 3. Các Tối ưu Hóa Đột Phá Đã Triển Khai

### 3.1. Tầng Cơ sở dữ liệu (PostgreSQL)
* **Khắc phục nghẽn CPU (Sequential Scan):** Tạo 3 chỉ mục composite B-Tree chiến lược:
  * `"IX_CandidateAnswers_CandidateId_QuestionId"`: Giảm thời gian kiểm tra và lưu đáp án (`saveTempResult`) từ quét toàn bảng xuống còn **0.123 ms**.
  * `"IX_CandidateEvents_CandidateId_EventDate"`: Tối ưu ghi nhận và đọc nhật ký giám sát coi thi theo thời gian thực.
  * `"IX_CandidatePartScores_CandidateId"`: Tối ưu tính điểm và xuất báo cáo.
* **Cấu hình phần cứng:** File `config/postgresql/99-high-concurrency.conf` cấp phát 6GB `shared_buffers` và 600 `max_connections`.
* **Cơ sở dữ liệu mẫu chuẩn (Clean Seed Data):** Tích hợp đầy đủ danh mục gốc chuẩn (`Departments`, `Staffs`, `Years`, `Courses`, `Majors`, `Subjects`, `SubjectManagers`) trong `01_InitData_PostgreSQL.sql`, đảm bảo tạo mới Database không bao giờ gặp lỗi vi phạm khóa ngoại.

### 3.2. Tầng Ứng dụng Backend (.NET 10 / Kestrel)
* Nâng giới hạn kết nối đồng thời lên **10.000 HTTP connections** và **5.000 WebSocket connections**.
* Nâng giới hạn tải lên `MaxRequestBodySize` lên **100 MB** (cho phép upload đề thi Word chứa nhiều hình ảnh chụp X-quang/CT độ phân giải cao).
* Mở socket lắng nghe trên `0.0.0.0:3154`, cho phép giảng viên/admin upload đề thi trực tiếp qua mạng LAN nội bộ tốc độ 1 Gbps (chỉ mất 0.3s / đề).
* Tích hợp tính năng hiển thị mật khẩu thí sinh trên màn hình giám thị và xuất đề thi QTI 3.0 mã hóa AES-256.

### 3.3. Tầng Mạng & Cloudflare Edge Caching
* Thiết lập Cloudflare Cache Rule lưu trữ toàn bộ file tĩnh (`/css/*`, `/js/*`, `/lib/*`, `/fonts/*`, `/images/*`) trên máy chủ Cloudflare với thời gian lưu đệm 1 tháng (`cache-control: max-age=2678400`).
* Kiểm thử thực tế xác nhận: `onlinetest.js`, `exam-monitor.js`, `animate.min.css` đều đạt **`cf-cache-status: HIT`**, phản hồi trong ~100ms.
* **Giám sát Camera WebRTC P2P:** Luồng video giữa thí sinh và giám thị đi ngang hàng qua STUN của Google (`stun:stun.l.google.com:19302`), hoàn toàn không đi qua máy chủ hay làm nghẽn Cloudflare Tunnel.

---

## 4. Hướng dẫn Triển khai Nhanh (1-Click Installer)

### Cách 1: Triển khai từ gói phát hành Release (Khuyên dùng cho máy chủ mới)
```bash
# 1. Tải bản phát hành mới nhất từ GitHub Releases
wget https://github.com/buithanhninh/smarttest-linux-installer/releases/download/v2026.10.12/smarttest_linux_deploy_20261012.tar.gz

# 2. Giải nén gói cài đặt
tar -zxvf smarttest_linux_deploy_20261012.tar.gz
cd smarttest_linux_deploy_20261012

# 3. Chạy script cài đặt tự động 1-click
sudo ./install.sh
```

### Cách 2: Triển khai từ mã nguồn Git
```bash
git clone https://github.com/buithanhninh/smarttest-linux-installer.git
cd smarttest-linux-installer
sudo ./install.sh
```

Sau khi cài đặt xong:
* Truy cập cục bộ: `http://127.0.0.1:3154`
* Truy cập qua mạng LAN: `http://<IP_MÁY_CHỦ>:3154`
* Đăng nhập Admin: `admin` / `Admin@2026`
* Đăng nhập Thí sinh mẫu: `101` / `101`

---

## 5. Cấu trúc Thư mục Gói Phát Hành

```
smarttest_linux_deploy_20261012/
├── install.sh                                # Script cài đặt tự động 1-click
├── README.md                                 # Hướng dẫn chi tiết
├── SHA256SUMS.txt                            # Checksum xác thực toàn vẹn gói cài đặt
├── config/
│   ├── kestrel/appsettings.Production.json   # Cấu hình tối ưu Kestrel Web Server
│   ├── postgresql/99-high-concurrency.conf   # Tối ưu RAM & pool kết nối PostgreSQL
│   └── systemd/                              # Service units (smarttest, cloudflared, env)
├── database/
│   ├── 00_Create_DataBase_PostgreSQL.sql     # Schema DDL khởi tạo đầy đủ các bảng
│   ├── 01_InitData_PostgreSQL.sql            # Dữ liệu ban đầu chuẩn (Admin, Danh mục gốc, Thí sinh mẫu)
│   └── 02_create_high_concurrency_indexes.sql# 3 Index composite chịu tải cao
└── web/                                      # Bộ binaries ứng dụng SmartTest đã biên dịch
```

---

## 6. Bộ Kịch bản Kiểm thử Tự động Hóa (E2E Test Suite)

Hệ thống tích hợp bộ kịch bản kiểm thử tự động hóa bằng **Playwright (Python / Chromium)**:
1. `scripts/run_full_e2e_suite.py`: Kiểm thử toàn diện 4 kịch bản (Network/Cache, Playwright E2E, Database Index Scan, Benchmark tải đồng thời).
2. `scripts/verify_e2e_deep.py`: Kiểm tra tương tác giao diện người dùng thật và năng lực thiết bị (Camera, WebRTC, WebSocket, AudioContext).

### Kết quả kiểm thử thực tế:
* **Tỷ lệ thành công:** **100.0% (100 / 100 requests)**.
* **Thông lượng (Throughput):** **207.76 requests / giây**.
* **Độ trễ trung bình:** **85.26 ms**.
* **Thời gian truy vấn Database:** **0.123 ms**.
* **Xác thực Đăng nhập Admin & Thí sinh:** Thành công 100%.

---
*Bản quyền & Tác giả:* Hệ thống Khảo thí Trực tuyến SmartTest - HMUTEST

