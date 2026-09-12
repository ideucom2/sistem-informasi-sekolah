# Sistem Informasi Sekolah

Aplikasi web komprehensif untuk manajemen sekolah dengan fitur akademik, keuangan, administrasi, portal pengguna, dan komunikasi.

## 🚀 Fitur Utama

### 1. Manajemen Akademik
- 📚 Manajemen siswa (data pribadi, riwayat akademik)
- 👨‍🏫 Manajemen guru dan staff
- 🏫 Manajemen kelas dan jadwal pelajaran
- 📝 Manajemen nilai dan rapor
- 📖 Manajemen mata pelajaran
- 📅 Manajemen agenda kelas
- 🧹 Manajemen piket
- 💬 Manajemen BK (Bimbingan Konseling)
- 👥 Manajemen kesiswaan
- 📋 Manajemen kurikulum
- 👔 Manajemen kepala sekolah
- 🎓 Manajemen alumni

### 2. Manajemen Keuangan
- 💰 Pembayaran SPP/biaya sekolah
- 🧾 Invoice dan kwitansi
- 📊 Laporan keuangan
- 🎁 Manajemen beasiswa

### 3. Manajemen Administrasi
- 📮 Surat menyurat
- 📁 Manajemen dokumen
- ✅ Kehadiran siswa dan guru
- 🚫 Izin dan cuti

### 4. Portal Pengguna
- 🎓 Portal Siswa (lihat nilai, jadwal, pembayaran)
- 👨‍👩‍👧 Portal Orang Tua (monitoring anak)
- 👨‍🏫 Portal Guru (manajemen kelas, nilai)
- 📜 Portal Alumni
- ⚙️ Portal Admin (dashboard & laporan)

### 5. Komunikasi
- 🔔 Notifikasi dan pengumuman
- 💬 Sistem pesan/chat
- 📅 Agenda sekolah

## 📋 Tech Stack

- **Backend**: Node.js + Express.js
- **Database**: MySQL dengan Sequelize ORM
- **Frontend**: EJS Template Engine
- **Authentication**: JWT + Session
- **Security**: Helmet, CORS, bcryptjs
- **File Upload**: Multer
- **Email**: Nodemailer

## 🛠️ Instalasi

### Prerequisites
- Node.js v14+ 
- MySQL v5.7+
- npm atau yarn

### Setup

1. Clone repository
```bash
git clone https://github.com/ideucom2/sistem-informasi-sekolah.git
cd sistem-informasi-sekolah
```

2. Install dependencies
```bash
npm install
```

3. Setup environment variables
```bash
cp .env.example .env
# Edit .env dengan konfigurasi lokal Anda
```

4. Setup database
```bash
# Create database
mysql -u root -p -e "CREATE DATABASE sistem_informasi_sekolah;"

# Run migrations
npm run migrate
```

5. Start aplikasi
```bash
npm run dev
```

Aplikasi akan berjalan di `http://localhost:3000`

## 📁 Struktur Project

```
sistem-informasi-sekolah/
├── config/              # Konfigurasi database dan aplikasi
├── models/              # Database models (Sequelize)
├── controllers/         # Business logic
├── routes/              # API routes
├── views/               # EJS templates
├── public/              # Static files (CSS, JS, images)
├── middleware/          # Custom middleware
├── utils/               # Utility functions
├── migrations/          # Database migrations
├── seeds/               # Database seeders
├── services/            # Business services
├── validators/          # Input validation
├── tests/               # Unit & integration tests
├── .env.example         # Environment variables example
└── server.js            # Entry point
```

## 🔐 Keamanan

- Password di-hash menggunakan bcryptjs
- JWT untuk API authentication
- Session management untuk web
- CORS configuration
- Helmet untuk HTTP security headers
- Input validation dan sanitization

## 📝 Default User Accounts

Setelah seeding, akun default:

| Role | Email | Password |
|------|-------|----------|
| Admin | admin@sekolah.com | admin123 |
| Guru | guru@sekolah.com | guru123 |
| Siswa | siswa@sekolah.com | siswa123 |
| Orang Tua | orangtua@sekolah.com | orangtua123 |

## 🧪 Testing

```bash
npm test
```

## 📖 API Documentation

Dokumentasi API tersedia di `/api/docs`

## 🤝 Kontribusi

1. Fork repository
2. Buat branch feature (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add some AmazingFeature'`)
4. Push ke branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

## 📄 Lisensi

Project ini dilisensikan di bawah MIT License - lihat file [LICENSE](LICENSE) untuk detail.

## 👨‍💻 Author

**ideucom2** - [GitHub Profile](https://github.com/ideucom2)

## 📞 Support

Jika Anda memiliki pertanyaan atau masalah, silakan buka issue di repository ini.

---

**Last Updated**: 2026-09-12
