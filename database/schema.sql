-- Sistem Informasi Sekolah Database Schema
-- Created for complete school management system

-- Create Database
CREATE DATABASE IF NOT EXISTS sistem_informasi_sekolah;
USE sistem_informasi_sekolah;

-- ============================================
-- TABLE: Users (Pengguna)
-- ============================================
CREATE TABLE IF NOT EXISTS users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    email VARCHAR(100) UNIQUE,
    nama VARCHAR(150) NOT NULL,
    role ENUM('admin', 'guru', 'siswa', 'orangtua', 'kepala_sekolah') NOT NULL,
    status ENUM('aktif', 'nonaktif') DEFAULT 'aktif',
    foto VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_username (username),
    INDEX idx_role (role),
    INDEX idx_status (status)
);

-- ============================================
-- TABLE: Sekolah (Data Sekolah)
-- ============================================
CREATE TABLE IF NOT EXISTS sekolah (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama_sekolah VARCHAR(255) NOT NULL,
    npsn VARCHAR(20),
    alamat TEXT,
    kota VARCHAR(100),
    provinsi VARCHAR(100),
    telepon VARCHAR(20),
    email VARCHAR(100),
    website VARCHAR(255),
    kepala_sekolah VARCHAR(150),
    logo VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- TABLE: Tahun Ajaran
-- ============================================
CREATE TABLE IF NOT EXISTS tahun_ajaran (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tahun_ajaran VARCHAR(20) UNIQUE NOT NULL,
    tahun_mulai INT,
    tahun_akhir INT,
    semester INT,
    tanggal_mulai DATE,
    tanggal_akhir DATE,
    status ENUM('aktif', 'tidak_aktif') DEFAULT 'tidak_aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- ============================================
-- TABLE: Guru
-- ============================================
CREATE TABLE IF NOT EXISTS guru (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    nip VARCHAR(30) UNIQUE,
    nama_lengkap VARCHAR(150) NOT NULL,
    jenis_kelamin ENUM('L', 'P'),
    tanggal_lahir DATE,
    alamat TEXT,
    telepon VARCHAR(20),
    email VARCHAR(100),
    pendidikan_terakhir VARCHAR(100),
    bidang_keahlian VARCHAR(150),
    status_pegawai ENUM('tetap', 'kontrak', 'honorer') DEFAULT 'tetap',
    status ENUM('aktif', 'nonaktif') DEFAULT 'aktif',
    foto VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_nip (nip),
    INDEX idx_status (status)
);

-- ============================================
-- TABLE: Siswa
-- ============================================
CREATE TABLE IF NOT EXISTS siswa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    nisn VARCHAR(30) UNIQUE,
    nis VARCHAR(20) UNIQUE,
    nama_lengkap VARCHAR(150) NOT NULL,
    jenis_kelamin ENUM('L', 'P'),
    tanggal_lahir DATE,
    tempat_lahir VARCHAR(100),
    alamat TEXT,
    telepon VARCHAR(20),
    nama_ayah VARCHAR(150),
    nama_ibu VARCHAR(150),
    pekerjaan_ayah VARCHAR(100),
    pekerjaan_ibu VARCHAR(100),
    telepon_ortu VARCHAR(20),
    status_siswa ENUM('aktif', 'nonaktif', 'lulus', 'pindah') DEFAULT 'aktif',
    foto VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_nisn (nisn),
    INDEX idx_nis (nis),
    INDEX idx_status (status_siswa)
);

-- ============================================
-- TABLE: Orang Tua
-- ============================================
CREATE TABLE IF NOT EXISTS orangtua (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT UNIQUE NOT NULL,
    siswa_id INT NOT NULL,
    nama_lengkap VARCHAR(150) NOT NULL,
    hubungan VARCHAR(50),
    pekerjaan VARCHAR(100),
    alamat TEXT,
    telepon VARCHAR(20),
    email VARCHAR(100),
    status ENUM('aktif', 'nonaktif') DEFAULT 'aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (siswa_id) REFERENCES siswa(id) ON DELETE CASCADE,
    INDEX idx_siswa (siswa_id)
);

-- ============================================
-- TABLE: Kelas
-- ============================================
CREATE TABLE IF NOT EXISTS kelas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tahun_ajaran_id INT NOT NULL,
    nama_kelas VARCHAR(50) NOT NULL,
    tingkat INT,
    jumlah_siswa INT DEFAULT 0,
    wali_kelas_id INT,
    ruang_kelas VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id),
    FOREIGN KEY (wali_kelas_id) REFERENCES guru(id),
    INDEX idx_tahun_ajaran (tahun_ajaran_id),
    INDEX idx_tingkat (tingkat)
);

-- ============================================
-- TABLE: Siswa-Kelas (Many to Many)
-- ============================================
CREATE TABLE IF NOT EXISTS siswa_kelas (
    id INT PRIMARY KEY AUTO_INCREMENT,
    siswa_id INT NOT NULL,
    kelas_id INT NOT NULL,
    tahun_ajaran_id INT NOT NULL,
    nomor_urut INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (siswa_id) REFERENCES siswa(id) ON DELETE CASCADE,
    FOREIGN KEY (kelas_id) REFERENCES kelas(id) ON DELETE CASCADE,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id),
    UNIQUE KEY unique_siswa_kelas (siswa_id, kelas_id, tahun_ajaran_id),
    INDEX idx_kelas (kelas_id),
    INDEX idx_tahun_ajaran (tahun_ajaran_id)
);

-- ============================================
-- TABLE: Mata Pelajaran
-- ============================================
CREATE TABLE IF NOT EXISTS mata_pelajaran (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kode_mapel VARCHAR(50) UNIQUE,
    nama_mapel VARCHAR(150) NOT NULL,
    deskripsi TEXT,
    kkm INT DEFAULT 75,
    jam_pelajaran INT,
    status ENUM('aktif', 'nonaktif') DEFAULT 'aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_nama (nama_mapel),
    INDEX idx_status (status)
);

-- ============================================
-- TABLE: Jadwal Pelajaran
-- ============================================
CREATE TABLE IF NOT EXISTS jadwal_pelajaran (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tahun_ajaran_id INT NOT NULL,
    kelas_id INT NOT NULL,
    mata_pelajaran_id INT NOT NULL,
    guru_id INT NOT NULL,
    hari VARCHAR(20),
    jam_mulai TIME,
    jam_selesai TIME,
    ruangan VARCHAR(50),
    kapasitas INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id),
    FOREIGN KEY (kelas_id) REFERENCES kelas(id),
    FOREIGN KEY (mata_pelajaran_id) REFERENCES mata_pelajaran(id),
    FOREIGN KEY (guru_id) REFERENCES guru(id),
    INDEX idx_kelas (kelas_id),
    INDEX idx_guru (guru_id)
);

-- ============================================
-- TABLE: Nilai
-- ============================================
CREATE TABLE IF NOT EXISTS nilai (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tahun_ajaran_id INT NOT NULL,
    kelas_id INT NOT NULL,
    siswa_id INT NOT NULL,
    mata_pelajaran_id INT NOT NULL,
    guru_id INT NOT NULL,
    nilai_uts DECIMAL(5,2),
    nilai_uas DECIMAL(5,2),
    nilai_tugas DECIMAL(5,2),
    nilai_praktik DECIMAL(5,2),
    nilai_akhir DECIMAL(5,2),
    grade VARCHAR(2),
    keterangan VARCHAR(100),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id),
    FOREIGN KEY (kelas_id) REFERENCES kelas(id),
    FOREIGN KEY (siswa_id) REFERENCES siswa(id),
    FOREIGN KEY (mata_pelajaran_id) REFERENCES mata_pelajaran(id),
    FOREIGN KEY (guru_id) REFERENCES guru(id),
    UNIQUE KEY unique_nilai (siswa_id, mata_pelajaran_id, tahun_ajaran_id),
    INDEX idx_siswa (siswa_id),
    INDEX idx_mapel (mata_pelajaran_id)
);

-- ============================================
-- TABLE: Kehadiran
-- ============================================
CREATE TABLE IF NOT EXISTS kehadiran (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tahun_ajaran_id INT NOT NULL,
    kelas_id INT NOT NULL,
    siswa_id INT NOT NULL,
    tanggal DATE NOT NULL,
    status ENUM('hadir', 'izin', 'sakit', 'alpa') DEFAULT 'hadir',
    keterangan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id),
    FOREIGN KEY (kelas_id) REFERENCES kelas(id),
    FOREIGN KEY (siswa_id) REFERENCES siswa(id),
    UNIQUE KEY unique_kehadiran (siswa_id, tanggal),
    INDEX idx_siswa (siswa_id),
    INDEX idx_tanggal (tanggal)
);

-- ============================================
-- TABLE: Rapor
-- ============================================
CREATE TABLE IF NOT EXISTS rapor (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tahun_ajaran_id INT NOT NULL,
    kelas_id INT NOT NULL,
    siswa_id INT NOT NULL,
    semester INT,
    rata_rata DECIMAL(5,2),
    ranking INT,
    catatan_akademik TEXT,
    catatan_kepribadian TEXT,
    status_naik ENUM('naik', 'tinggal', 'lulus') DEFAULT 'naik',
    ttd_guru VARCHAR(255),
    ttd_kepala VARCHAR(255),
    tanggal_cetak DATE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id),
    FOREIGN KEY (kelas_id) REFERENCES kelas(id),
    FOREIGN KEY (siswa_id) REFERENCES siswa(id),
    UNIQUE KEY unique_rapor (siswa_id, tahun_ajaran_id, semester),
    INDEX idx_siswa (siswa_id)
);

-- ============================================
-- TABLE: Pembayaran SPP
-- ============================================
CREATE TABLE IF NOT EXISTS pembayaran_spp (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tahun_ajaran_id INT NOT NULL,
    siswa_id INT NOT NULL,
    bulan INT,
    tahun INT,
    jumlah DECIMAL(12,2),
    tanggal_pembayaran DATE,
    status ENUM('belum_bayar', 'lunas', 'cicil') DEFAULT 'belum_bayar',
    metode_pembayaran VARCHAR(50),
    nomor_bukti VARCHAR(50),
    keterangan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id),
    FOREIGN KEY (siswa_id) REFERENCES siswa(id),
    INDEX idx_siswa (siswa_id),
    INDEX idx_status (status)
);

-- ============================================
-- TABLE: Invoice
-- ============================================
CREATE TABLE IF NOT EXISTS invoice (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nomor_invoice VARCHAR(50) UNIQUE NOT NULL,
    siswa_id INT NOT NULL,
    tanggal_invoice DATE,
    tanggal_jatuh_tempo DATE,
    jumlah DECIMAL(12,2),
    keterangan TEXT,
    status ENUM('draft', 'terkirim', 'lunas', 'dibatalkan') DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (siswa_id) REFERENCES siswa(id),
    INDEX idx_siswa (siswa_id),
    INDEX idx_status (status)
);

-- ============================================
-- TABLE: Beasiswa
-- ============================================
CREATE TABLE IF NOT EXISTS beasiswa (
    id INT PRIMARY KEY AUTO_INCREMENT,
    siswa_id INT NOT NULL,
    jenis_beasiswa VARCHAR(100),
    nominal_beasiswa DECIMAL(12,2),
    tanggal_mulai DATE,
    tanggal_selesai DATE,
    status ENUM('aktif', 'nonaktif', 'selesai') DEFAULT 'aktif',
    keterangan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (siswa_id) REFERENCES siswa(id) ON DELETE CASCADE,
    INDEX idx_siswa (siswa_id),
    INDEX idx_status (status)
);

-- ============================================
-- TABLE: Pengumuman
-- ============================================
CREATE TABLE IF NOT EXISTS pengumuman (
    id INT PRIMARY KEY AUTO_INCREMENT,
    judul VARCHAR(255) NOT NULL,
    isi TEXT NOT NULL,
    penulis_id INT,
    tanggal_dibuat DATE,
    tanggal_berlaku DATE,
    tanggal_berakhir DATE,
    prioritas ENUM('rendah', 'normal', 'tinggi') DEFAULT 'normal',
    status ENUM('draft', 'publish', 'arsip') DEFAULT 'draft',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (penulis_id) REFERENCES users(id),
    INDEX idx_status (status),
    INDEX idx_prioritas (prioritas)
);

-- ============================================
-- TABLE: Pesan/Chat
-- ============================================
CREATE TABLE IF NOT EXISTS pesan (
    id INT PRIMARY KEY AUTO_INCREMENT,
    pengirim_id INT NOT NULL,
    penerima_id INT NOT NULL,
    judul VARCHAR(255),
    isi TEXT NOT NULL,
    status ENUM('belum_dibaca', 'dibaca') DEFAULT 'belum_dibaca',
    tanggal_kirim TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (pengirim_id) REFERENCES users(id) ON DELETE CASCADE,
    FOREIGN KEY (penerima_id) REFERENCES users(id) ON DELETE CASCADE,
    INDEX idx_penerima (penerima_id),
    INDEX idx_status (status)
);

-- ============================================
-- TABLE: Agenda Kelas
-- ============================================
CREATE TABLE IF NOT EXISTS agenda (
    id INT PRIMARY KEY AUTO_INCREMENT,
    kelas_id INT NOT NULL,
    guru_id INT NOT NULL,
    tanggal DATE,
    jam_mulai TIME,
    jam_selesai TIME,
    kegiatan TEXT,
    keterangan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (kelas_id) REFERENCES kelas(id) ON DELETE CASCADE,
    FOREIGN KEY (guru_id) REFERENCES guru(id),
    INDEX idx_kelas (kelas_id),
    INDEX idx_tanggal (tanggal)
);

-- ============================================
-- TABLE: Piket
-- ============================================
CREATE TABLE IF NOT EXISTS piket (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tahun_ajaran_id INT NOT NULL,
    kelas_id INT NOT NULL,
    tanggal DATE,
    hari VARCHAR(20),
    siswa_id INT,
    tugas TEXT,
    status ENUM('belum', 'selesai') DEFAULT 'belum',
    keterangan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id),
    FOREIGN KEY (kelas_id) REFERENCES kelas(id),
    FOREIGN KEY (siswa_id) REFERENCES siswa(id),
    INDEX idx_kelas (kelas_id),
    INDEX idx_tanggal (tanggal)
);

-- ============================================
-- TABLE: BK (Bimbingan Konseling)
-- ============================================
CREATE TABLE IF NOT EXISTS bk (
    id INT PRIMARY KEY AUTO_INCREMENT,
    siswa_id INT NOT NULL,
    guru_id INT,
    tanggal DATE,
    jam TIME,
    topik VARCHAR(255),
    deskripsi TEXT,
    hasil_konseling TEXT,
    rekomendasi TEXT,
    status ENUM('terjadwal', 'selesai', 'batal') DEFAULT 'terjadwal',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (siswa_id) REFERENCES siswa(id) ON DELETE CASCADE,
    FOREIGN KEY (guru_id) REFERENCES guru(id),
    INDEX idx_siswa (siswa_id),
    INDEX idx_tanggal (tanggal)
);

-- ============================================
-- TABLE: Izin & Cuti
-- ============================================
CREATE TABLE IF NOT EXISTS izin_cuti (
    id INT PRIMARY KEY AUTO_INCREMENT,
    siswa_id INT NOT NULL,
    tipe ENUM('izin', 'cuti', 'sakit') DEFAULT 'izin',
    tanggal_mulai DATE,
    tanggal_selesai DATE,
    alasan TEXT,
    bukti_dokumen VARCHAR(255),
    status ENUM('pending', 'disetujui', 'ditolak') DEFAULT 'pending',
    disetujui_oleh INT,
    catatan TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (siswa_id) REFERENCES siswa(id) ON DELETE CASCADE,
    FOREIGN KEY (disetujui_oleh) REFERENCES users(id),
    INDEX idx_siswa (siswa_id),
    INDEX idx_status (status)
);

-- ============================================
-- TABLE: Surat
-- ============================================
CREATE TABLE IF NOT EXISTS surat (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nomor_surat VARCHAR(50) UNIQUE NOT NULL,
    tanggal_surat DATE,
    perihal VARCHAR(255),
    penerima VARCHAR(255),
    isi TEXT,
    tipe_surat VARCHAR(100),
    status ENUM('draft', 'final', 'terkirim') DEFAULT 'draft',
    file_dokumen VARCHAR(255),
    ttd_kepala VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_status (status)
);

-- ============================================
-- TABLE: Dokumen
-- ============================================
CREATE TABLE IF NOT EXISTS dokumen (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nama_dokumen VARCHAR(255) NOT NULL,
    deskripsi TEXT,
    kategori VARCHAR(100),
    file_dokumen VARCHAR(255) NOT NULL,
    uploader_id INT,
    tanggal_upload DATE,
    status ENUM('aktif', 'arsip') DEFAULT 'aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (uploader_id) REFERENCES users(id),
    INDEX idx_kategori (kategori),
    INDEX idx_status (status)
);

-- ============================================
-- TABLE: Kurikulum
-- ============================================
CREATE TABLE IF NOT EXISTS kurikulum (
    id INT PRIMARY KEY AUTO_INCREMENT,
    tahun_ajaran_id INT NOT NULL,
    tingkat INT,
    nama_kurikulum VARCHAR(255),
    deskripsi TEXT,
    standar_kompetensi TEXT,
    file_kurikulum VARCHAR(255),
    status ENUM('aktif', 'nonaktif') DEFAULT 'aktif',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (tahun_ajaran_id) REFERENCES tahun_ajaran(id),
    INDEX idx_tingkat (tingkat),
    INDEX idx_status (status)
);

-- ============================================
-- TABLE: Alumni
-- ============================================
CREATE TABLE IF NOT EXISTS alumni (
    id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    nisn VARCHAR(30) UNIQUE,
    nama_lengkap VARCHAR(150) NOT NULL,
    jenis_kelamin ENUM('L', 'P'),
    tanggal_lahir DATE,
    tahun_lulus INT,
    kelas_terakhir VARCHAR(50),
    alamat TEXT,
    telepon VARCHAR(20),
    email VARCHAR(100),
    pekerjaan VARCHAR(100),
    perusahaan VARCHAR(150),
    alamat_pekerjaan TEXT,
    status ENUM('bekerja', 'melanjutkan_studi', 'lainnya') DEFAULT 'lainnya',
    foto VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id),
    INDEX idx_nisn (nisn),
    INDEX idx_tahun_lulus (tahun_lulus)
);

-- ============================================
-- Insert Sample Data
-- ============================================

-- Insert admin user
INSERT INTO users (username, password, email, nama, role, status) 
VALUES ('admin', '$2y$10$nOUIs5kJ7naTuTQk08B3KuYjSH.B8qdDkG8nIloKB.E4T6DlS3m0W', 'admin@sekolah.com', 'Administrator', 'admin', 'aktif');

-- Insert sample sekolah data
INSERT INTO sekolah (nama_sekolah, npsn, alamat, kota, provinsi, telepon, email, website, kepala_sekolah) 
VALUES ('SMA Negeri 1 Contoh', '20400100', 'Jalan Pendidikan No. 1', 'Contoh Kota', 'Contoh Provinsi', '0812345678', 'info@sma1contoh.com', 'www.sma1contoh.com', 'Kepala Sekolah Contoh');

-- Insert sample tahun ajaran
INSERT INTO tahun_ajaran (tahun_ajaran, tahun_mulai, tahun_akhir, semester, tanggal_mulai, tanggal_akhir, status) 
VALUES ('2024/2025', 2024, 2025, 1, '2024-07-01', '2024-12-31', 'aktif');

INSERT INTO tahun_ajaran (tahun_ajaran, tahun_mulai, tahun_akhir, semester, tanggal_mulai, tanggal_akhir, status) 
VALUES ('2024/2025', 2024, 2025, 2, '2025-01-01', '2025-06-30', 'tidak_aktif');

-- Create initial triggers and procedures if needed
DELIMITER //

CREATE TRIGGER update_kelas_jumlah_siswa AFTER INSERT ON siswa_kelas
FOR EACH ROW
BEGIN
    UPDATE kelas SET jumlah_siswa = (SELECT COUNT(*) FROM siswa_kelas WHERE kelas_id = NEW.kelas_id)
    WHERE id = NEW.kelas_id;
END//

CREATE TRIGGER update_kelas_jumlah_siswa_delete AFTER DELETE ON siswa_kelas
FOR EACH ROW
BEGIN
    UPDATE kelas SET jumlah_siswa = (SELECT COUNT(*) FROM siswa_kelas WHERE kelas_id = OLD.kelas_id)
    WHERE id = OLD.kelas_id;
END//

DELIMITER ;