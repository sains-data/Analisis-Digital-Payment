# Panduan Mengatasi Masalah Login Superset

## Masalah: Invalid Login di Superset

Jika Anda mengalami masalah "invalid login" saat mencoba masuk ke Apache Superset, berikut adalah beberapa langkah yang dapat dilakukan untuk mengatasinya.

## Solusi 1: Gunakan Fix Toolkit

Kami telah menyediakan script otomatis untuk memperbaiki masalah login. Jalankan script ini dari PowerShell:

```powershell
# Di direktori root proyek
.\fix-superset-login.ps1
```

Pilih opsi yang dibutuhkan:
1. Reset kredensial admin saja - cocok jika container berjalan normal
2. Reset container Superset - opsi lebih radikal jika ada masalah konfigurasi
3. Test koneksi ke Superset - memastikan API Superset dapat diakses
4. Perbaiki dependensi di container - mengatasi masalah dependensi dan permissions
5. Diagnosa dan perbaiki koneksi localhost - mengatasi masalah "localhost refused to connect"
6. Keluar - keluar dari toolkit

## Solusi 2: Reset Container Secara Manual

Jika toolkit tidak berhasil, Anda dapat me-reset container secara manual:

```powershell
# Hentikan container
docker-compose stop superset superset-init

# Hapus container
docker-compose rm -f superset superset-init

# Hapus volume (opsional, jika ingin reset total)
docker volume rm test__superset_home

# Jalankan kembali
docker-compose up -d superset superset-init
```

Tunggu 30-60 detik hingga container selesai inisialisasi, lalu coba login kembali.

## Solusi 3: Setup Kredensial Secara Manual

Jika container sudah berjalan tetapi kredensialnya bermasalah:

```powershell
# Jalankan perintah ini untuk membuat admin baru
docker-compose exec superset superset fab create-admin --username admin --firstname Superset --lastname Admin --email admin@superset.com --password admin --force

# Inisialisasi permissions
docker-compose exec superset superset init
```

## Solusi 4: Update Konfigurasi

Edit file `superset/superset_config.py` dan pastikan pengaturan otentikasi sudah benar:
```python
AUTH_TYPE = 1  # Database authentication
AUTH_USER_REGISTRATION = True
AUTH_USER_REGISTRATION_ROLE = "Admin"
```

## Informasi Debugging

### Melihat Log Superset

```powershell
docker-compose logs superset
```

### Memeriksa Status Container

```powershell
docker-compose ps
```

### Menguji API Superset

```powershell
Invoke-RestMethod -Uri "http://localhost:8088/api/v1/health" -Method GET
```

## Kredensial Default

Setelah reset atau inisialisasi:
- **URL**: http://localhost:8088
- **Username**: admin
- **Password**: admin

## Mengatasi Masalah "localhost refused to connect"

Jika Anda melihat pesan error "localhost refused to connect" saat mencoba mengakses dashboard Superset:

### Langkah 1: Gunakan Tool Diagnosa

Gunakan fitur diagnosa otomatis yang telah disediakan:

```powershell
# Jalankan toolkit
.\fix-superset-login.ps1

# Pilih opsi 5 - Diagnosa dan perbaiki koneksi localhost
```

Tool akan secara otomatis:
- Memeriksa status container Superset
- Memastikan port 8088 tersedia dan tidak digunakan aplikasi lain
- Menguji koneksi ke localhost
- Memeriksa file hosts dan pengaturan firewall
- Memverifikasi konfigurasi Superset

### Langkah 2: Periksa Firewall dan Antivirus

Terkadang firewall atau antivirus memblokir koneksi localhost:

1. Pastikan firewall mengizinkan port 8088:
   - Buka Windows Defender Firewall > Advanced Settings
   - Tambahkan inbound rule untuk port 8088 (TCP)

2. Nonaktifkan antivirus sementara untuk menguji koneksi

### Langkah 3: Periksa File Hosts

Pastikan file hosts memiliki entri yang benar untuk localhost:

1. Buka file hosts (memerlukan hak administrator):
   ```powershell
   notepad C:\Windows\System32\drivers\etc\hosts
   ```

2. Pastikan ada baris berikut (tambahkan jika belum ada):
   ```
   127.0.0.1 localhost
   ```

3. Simpan file dan restart browser

### Langkah 4: Cara Alternatif Akses

Jika localhost tidak berfungsi, coba cara akses alternatif:

1. Gunakan alamat IP lokal alih-alih localhost:
   ```
   http://127.0.0.1:8088
   ```

2. Jika di dalam VM atau WSL, coba gunakan IP Docker:
   ```powershell
   # Temukan IP Docker
   docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $(docker-compose ps -q superset)
   ```
