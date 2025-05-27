# Solusi Masalah Login Superset

## Tools yang Tersedia

Untuk membantu Anda mengatasi masalah login Superset, beberapa script telah dibuat:

1. **fix-superset-login.ps1** / **fix-superset-login.sh**
   - Tool utama untuk memperbaiki masalah login
   - Menyediakan berbagai opsi perbaikan

2. **manage-superset-volume.ps1**
   - Tool untuk mengelola volume Superset
   - Dapat membuat backup dan restore volume

3. **SUPERSET_LOGIN_GUIDE.md**
   - Dokumentasi solusi masalah login
   - Panduan langkah-demi-langkah untuk troubleshooting

## Langkah Solusi Cepat

1. Pastikan semua container berjalan:
   ```powershell
   docker-compose ps
   ```

2. Reset kredensial admin:
   ```powershell
   .\fix-superset-login.ps1
   # Pilih opsi 1
   ```

3. Jika masih bermasalah, reset container Superset:
   ```powershell
   .\fix-superset-login.ps1
   # Pilih opsi 2
   ```

4. Akses Superset di browser:
   - URL: http://localhost:8088
   - Username: admin
   - Password: admin

## Perubahan Konfigurasi yang Dibuat

1. Menambahkan dependensi di container Superset:
   - flask-cors
   - sqlalchemy 1.4.46
   - sasl dan thrift_sasl

2. Menambahkan pengaturan autentikasi di superset_config.py:
   ```python
   AUTH_TYPE = 1
   AUTH_USER_REGISTRATION = True
   AUTH_USER_REGISTRATION_ROLE = "Admin"
   AUTH_ROLE_ADMIN = "Admin"
   AUTH_ROLE_PUBLIC = "Public"
   ```

3. Memperbaiki volume sharing antara container superset dan superset-init

## Setelah Login Berhasil

Setelah Anda berhasil login ke Superset, hal-hal yang perlu dilakukan:

1. Membuat koneksi database ke Hive:
   - Data > Databases > + Database
   - Pilih "Apache Hive"
   - SQL Alchemy URI: `hive://hive@spark-master:10000/default`
   - Display Name: "Credit Card DB"

2. Membuat dataset:
   - Data > Datasets > + Dataset
   - Pilih database "Credit Card DB"
   - Pilih tabel "credit_card_data"

3. Membuat chart dan dashboard:
   - Chart > + Chart
   - Dashboard > + Dashboard

## Troubleshooting Lanjutan

Jika semua langkah di atas tidak berhasil, coba cara berikut:

1. Periksa log container:
   ```powershell
   docker-compose logs superset
   docker-compose logs superset-init
   ```

2. Reset total volume:
   ```powershell
   .\manage-superset-volume.ps1
   # Pilih opsi 2
   ```

3. Periksa koneksi jaringan antar container:
   ```powershell
   docker network inspect test__hadoop
   ```

4. Periksa status REST API Superset:
   ```powershell
   Invoke-RestMethod -Uri "http://localhost:8088/api/v1/health" -Method GET -ErrorAction SilentlyContinue
   ```

## Masalah "localhost refused to connect"

Jika Anda mendapat error "localhost refused to connect" ketika mengakses Superset:

### Menggunakan Tool Diagnosis Otomatis

Tool diagnosis otomatis tersedia di script `fix-superset-login.ps1` (Windows) atau `fix-superset-login.sh` (Linux/Mac):

1. Jalankan script diagnosa:
   ```powershell
   # Untuk Windows
   .\fix-superset-login.ps1
   # Pilih opsi 5 - Diagnosa dan perbaiki koneksi localhost
   ```
   
   ```bash
   # Untuk Linux/Mac
   ./fix-superset-login.sh
   # Pilih opsi 5 - Diagnosa dan perbaiki koneksi localhost
   ```

2. Tool akan melakukan pemeriksaan dan perbaikan:
   - Status container Superset
   - Binding port 8088
   - Koneksi localhost
   - Konfigurasi file hosts
   - Konfigurasi firewall
   - Konfigurasi Superset (SUPERSET_WEBSERVER_ADDRESS)

3. Ikuti instruksi yang diberikan oleh tool untuk memperbaiki masalah

### Pemeriksaan Manual

Jika tool otomatis tidak berhasil, lakukan pemeriksaan manual:

1. Pastikan container Superset berjalan
   ```powershell
   docker-compose ps superset
   ```

2. Verifikasi port 8088 tidak digunakan oleh aplikasi lain
   ```powershell
   netstat -ano | findstr :8088  # Windows
   netstat -tuln | grep :8088    # Linux/Mac
   ```

3. Periksa logs untuk error
   ```powershell
   docker-compose logs superset --tail 50
   ```

4. Coba akses dengan IP langsung daripada localhost
   ```
   http://127.0.0.1:8088
   ```
