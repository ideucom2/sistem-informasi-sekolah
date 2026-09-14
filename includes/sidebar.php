<?php
// Sidebar Navigation based on User Role
?>
<div class="sidebar bg-light">
    <nav class="nav flex-column">
        <?php if ($user_role == 'admin'): ?>
            <a class="nav-link" href="<?php echo BASE_URL; ?>dashboard.php"><i class="fa fa-dashboard"></i> Dashboard</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>admin/users/index.php"><i class="fa fa-users"></i> Manajemen Pengguna</a>
            
            <!-- Akademik -->
            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown"><i class="fa fa-book"></i> Akademik</a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/siswa/index.php">Manajemen Siswa</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/guru/index.php">Manajemen Guru</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/kelas/index.php">Manajemen Kelas</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/matapelajaran/index.php">Manajemen Mata Pelajaran</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/jadwal/index.php">Manajemen Jadwal</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/nilai/index.php">Manajemen Nilai</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/rapor/index.php">Manajemen Rapor</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/kurikulum/index.php">Manajemen Kurikulum</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/agenda/index.php">Manajemen Agenda</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/piket/index.php">Manajemen Piket</a></li>
            </ul>
            
            <!-- Kesiswaan -->
            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown"><i class="fa fa-users-circle"></i> Kesiswaan</a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/bk/index.php">BK (Bimbingan Konseling)</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/kesiswaan/index.php">Manajemen Kesiswaan</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/kehadiran/index.php">Kehadiran</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/izin/index.php">Izin & Cuti</a></li>
            </ul>
            
            <!-- Keuangan -->
            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown"><i class="fa fa-money"></i> Keuangan</a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/spp/index.php">Manajemen SPP</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/pembayaran/index.php">Pembayaran</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/invoice/index.php">Invoice & Kwitansi</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/beasiswa/index.php">Manajemen Beasiswa</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/laporan-keuangan/index.php">Laporan Keuangan</a></li>
            </ul>
            
            <!-- Administrasi -->
            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown"><i class="fa fa-file-text"></i> Administrasi</a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/surat/index.php">Surat Menyurat</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/dokumen/index.php">Manajemen Dokumen</a></li>
            </ul>
            
            <!-- Pengaturan -->
            <a class="nav-link dropdown-toggle" href="#" data-bs-toggle="dropdown"><i class="fa fa-cog"></i> Pengaturan</a>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/sekolah/index.php">Data Sekolah</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/tahunajaran/index.php">Tahun Ajaran</a></li>
                <li><a class="dropdown-item" href="<?php echo BASE_URL; ?>admin/alumni/index.php">Alumni</a></li>
            </ul>

        <?php elseif ($user_role == 'guru'): ?>
            <a class="nav-link" href="<?php echo BASE_URL; ?>guru/dashboard.php"><i class="fa fa-dashboard"></i> Dashboard</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>guru/kelas/index.php"><i class="fa fa-book"></i> Kelas Mengajar</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>guru/nilai/index.php"><i class="fa fa-list"></i> Manajemen Nilai</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>guru/kehadiran/index.php"><i class="fa fa-check-square"></i> Kehadiran Siswa</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>guru/rapor/index.php"><i class="fa fa-file"></i> Rapor</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>guru/agenda/index.php"><i class="fa fa-calendar"></i> Agenda</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>guru/pesan/index.php"><i class="fa fa-envelope"></i> Pesan</a>

        <?php elseif ($user_role == 'siswa'): ?>
            <a class="nav-link" href="<?php echo BASE_URL; ?>siswa/dashboard.php"><i class="fa fa-dashboard"></i> Dashboard</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>siswa/jadwal/index.php"><i class="fa fa-calendar"></i> Jadwal Pelajaran</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>siswa/nilai/index.php"><i class="fa fa-star"></i> Nilai</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>siswa/rapor/index.php"><i class="fa fa-file"></i> Rapor</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>siswa/kehadiran/index.php"><i class="fa fa-check"></i> Kehadiran</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>siswa/pembayaran/index.php"><i class="fa fa-credit-card"></i> Status Pembayaran</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>siswa/bk/index.php"><i class="fa fa-heart"></i> Konseling</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>siswa/pengumuman/index.php"><i class="fa fa-bell"></i> Pengumuman</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>siswa/pesan/index.php"><i class="fa fa-envelope"></i> Pesan</a>

        <?php elseif ($user_role == 'orangtua'): ?>
            <a class="nav-link" href="<?php echo BASE_URL; ?>orangtua/dashboard.php"><i class="fa fa-dashboard"></i> Dashboard</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>orangtua/anak/index.php"><i class="fa fa-child"></i> Data Anak</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>orangtua/nilai/index.php"><i class="fa fa-star"></i> Nilai Anak</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>orangtua/kehadiran/index.php"><i class="fa fa-check"></i> Kehadiran Anak</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>orangtua/pembayaran/index.php"><i class="fa fa-credit-card"></i> Pembayaran SPP</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>orangtua/pengumuman/index.php"><i class="fa fa-bell"></i> Pengumuman</a>
            <a class="nav-link" href="<?php echo BASE_URL; ?>orangtua/pesan/index.php"><i class="fa fa-envelope"></i> Pesan</a>
        <?php endif; ?>
    </nav>
</div>