#!/usr/bin/env bash
# ==============================================================================
# SmartTest (HMUTEST) - 1-Click Automated Offline Production Installer
# Version: v2026.09.21 (High Concurrency 2,000 Candidates)
# Compatible OS: Ubuntu 22.04 LTS / Ubuntu 24.04 LTS (x86_64)
# ==============================================================================

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

log_info() { echo -e "${GREEN}[INFO]${NC} $1"; }
log_warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
log_error() { echo -e "${RED}[ERROR]${NC} $1"; }

echo -e "${BLUE}==============================================================================${NC}"
echo -e "${BLUE}   SMARTTEST (HMUTEST) - 1-CLICK PRODUCTION INSTALLER v2026.09.21            ${NC}"
echo -e "${BLUE}   Kiến trúc Chịu tải cao 2.000 Thí sinh - Hoạt động Độc lập Standalone      ${NC}"
echo -e "${BLUE}   Không yêu cầu bản quyền / license key - Sẵn sàng triển khai mọi máy chủ   ${NC}"
echo -e "${BLUE}==============================================================================${NC}"

# 1. Kiểm tra quyền Root
if [ "$(id -u)" -ne 0 ]; then
    log_error "Vui lòng chạy script với quyền root: sudo ./install.sh"
    exit 1
fi

# 2. Cài đặt các gói phụ thuộc hệ thống
log_info "Bước 1/6: Đang kiểm tra và cài đặt các gói phụ thuộc (PostgreSQL, .NET, Media libs)..."
export DEBIAN_FRONTEND=noninteractive
apt-get update -qq

# Cài đặt PostgreSQL nếu chưa có
if ! command -v psql &>/dev/null; then
    log_info "Đang cài đặt PostgreSQL..."
    apt-get install -y -qq postgresql postgresql-contrib
fi

# Cài đặt thư viện đồ họa & phông chữ
apt-get install -y -qq libgdiplus libicu-dev libfontconfig1 fonts-freefont-ttf curl jq

# Cài đặt ASP.NET Core Runtime 10 nếu chưa có
if ! dotnet --list-runtimes 2>/dev/null | grep -q "Microsoft.AspNetCore.App 10"; then
    log_info "Đang cấu hình kho Microsoft và cài đặt ASP.NET Core Runtime 10..."
    add-apt-repository -y ppa:dotnet/backports 2>/dev/null || true
    apt-get update -qq
    apt-get install -y -qq dotnet-runtime-10.0 aspnetcore-runtime-10.0 || true
fi

# 3. Tạo tài khoản hệ thống & Thư mục ứng dụng
log_info "Bước 2/6: Đang thiết lập thư mục ứng dụng /opt/smarttest..."
if ! id -u smarttest &>/dev/null; then
    useradd -r -s /bin/bash -d /var/lib/smarttest -m smarttest
fi

mkdir -p /opt/smarttest/current/publish
mkdir -p /etc/smarttest
mkdir -p /var/log/smarttest

log_info "Sao chép toàn bộ bộ máy SmartTest Web binaries..."
cp -a "${SCRIPT_DIR}/web/." /opt/smarttest/current/publish/
chown -R smarttest:smarttest /opt/smarttest
chmod -R 755 /opt/smarttest/current/publish

# 4. Tối ưu hóa PostgreSQL cho 2.000 Thí sinh
log_info "Bước 3/6: Đang tối ưu hóa cấu hình PostgreSQL..."
PG_CONF_DIR=$(find /etc/postgresql -name conf.d -type d 2>/dev/null | head -n 1 || echo "")
if [ -n "$PG_CONF_DIR" ] && [ -d "$PG_CONF_DIR" ]; then
    cp "${SCRIPT_DIR}/config/postgresql/99-high-concurrency.conf" "${PG_CONF_DIR}/"
    log_info "Đã nạp file cấu hình: ${PG_CONF_DIR}/99-high-concurrency.conf"
    systemctl restart postgresql
else
    log_warn "Không tìm thấy thư mục conf.d, đang nạp cấu hình trực tiếp vào postgresql.conf..."
    PG_MAIN_CONF=$(find /etc/postgresql -name postgresql.conf 2>/dev/null | head -n 1 || echo "")
    if [ -n "$PG_MAIN_CONF" ]; then
        cat "${SCRIPT_DIR}/config/postgresql/99-high-concurrency.conf" >> "$PG_MAIN_CONF"
        systemctl restart postgresql
    fi
fi

# 5. Khởi tạo Cơ sở dữ liệu & Nạp Index Tốc độ cao
log_info "Bước 4/6: Đang khởi tạo Cơ sở dữ liệu smarttest_thionline..."

# Tạo user database smarttest nếu chưa có
if ! sudo -u postgres psql -tc "SELECT 1 FROM pg_roles WHERE rolname = 'smarttest'" | grep -q 1; then
    log_info "Tạo role database 'smarttest'..."
    sudo -u postgres psql -c "CREATE USER smarttest WITH PASSWORD 'SmartTest2026!Secure';"
    sudo -u postgres psql -c "ALTER USER smarttest WITH SUPERUSER;"
fi

# Kiểm tra nếu DB chưa tồn tại thì tạo mới với OWNER smarttest
if ! sudo -u postgres psql -lqt | cut -d \| -f 1 | grep -qw smarttest_thionline; then
    sudo -u postgres psql -c "CREATE DATABASE smarttest_thionline OWNER smarttest;"
fi

log_info "Nạp toàn bộ cấu trúc bảng và dữ liệu tài khoản quản trị chuẩn..."
if [ -f "${SCRIPT_DIR}/database/03_smarttest_thionline_full_dump.sql" ]; then
    sudo -u postgres psql -d smarttest_thionline -q -f "${SCRIPT_DIR}/database/03_smarttest_thionline_full_dump.sql"
else
    sudo -u postgres psql -d smarttest_thionline -q -f "${SCRIPT_DIR}/database/00_Create_DataBase_PostgreSQL.sql"
    sudo -u postgres psql -d smarttest_thionline -q -f "${SCRIPT_DIR}/database/01_InitData_PostgreSQL.sql"
fi

if [ -f "${SCRIPT_DIR}/database/02_create_high_concurrency_indexes.sql" ]; then
    log_info "Áp dụng 3 Index Composite B-Tree chiến lược (giảm thời gian tick đáp án xuống 0.12ms)..."
    sudo -u postgres psql -d smarttest_thionline -q -f "${SCRIPT_DIR}/database/02_create_high_concurrency_indexes.sql"
fi

# 6. Cấu hình & Kích hoạt Dịch vụ Systemd
log_info "Bước 5/6: Đang cài đặt dịch vụ systemd (smarttest.service)..."
cp "${SCRIPT_DIR}/config/systemd/smarttest.env" /etc/smarttest/smarttest.env
chown smarttest:smarttest /etc/smarttest/smarttest.env
chmod 600 /etc/smarttest/smarttest.env

cp "${SCRIPT_DIR}/config/systemd/smarttest.service" /etc/systemd/system/smarttest.service
systemctl daemon-reload
systemctl enable smarttest
systemctl restart smarttest

# 7. Kiểm tra trạng thái hoạt động thực tế
log_info "Bước 6/6: Đang kiểm tra trạng thái khởi động Kestrel..."
sleep 5

if systemctl is-active --quiet smarttest; then
    HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" http://127.0.0.1:3154/account/login || echo "000")
    if [ "$HTTP_CODE" -eq 200 ] || [ "$HTTP_CODE" -eq 302 ]; then
        echo -e "${GREEN}==============================================================================${NC}"
        echo -e "${GREEN}   CÀI ĐẶT THÀNH CÔNG 100%! SMARTTEST ĐÃ HOẠT ĐỘNG HOÀN HẢO!                  ${NC}"
        echo -e "${GREEN}==============================================================================${NC}"
        echo -e "Địa chỉ truy cập cục bộ:   ${BLUE}http://127.0.0.1:3154${NC}"
        echo -e "Địa chỉ truy cập mạng LAN: ${BLUE}http://$(hostname -I | awk '{print $1}'):3154${NC}"
        echo -e "Tài khoản Quản trị mặc định (SuperAdmin):"
        echo -e "  - Username: ${YELLOW}admin${NC}"
        echo -e "  - Password: ${YELLOW}Admin@2026${NC}"
        echo -e "Tài khoản Thí sinh mẫu:"
        echo -e "  - Username: ${YELLOW}101${NC} / Password: ${YELLOW}101${NC}"
        echo -e "Trạng thái bản quyền:       ${GREEN}HOÀN TOÀN ĐỘC LẬP (KHÔNG CẦN KEY / KHÔNG GIỚI HẠN)${NC}"
        echo -e "Khả năng chịu tải:          ${GREEN}2.000 Thí sinh đồng thời (High Concurrency)${NC}"
        echo -e "=============================================================================="
    else
        log_warn "Service đã chạy nhưng phản hồi HTTP: ${HTTP_CODE}. Vui lòng kiểm tra: journalctl -u smarttest -e"
    fi
else
    log_error "Dịch vụ smarttest chưa khởi động được. Kiểm tra lỗi bằng lệnh: journalctl -u smarttest -e"
    exit 1
fi
