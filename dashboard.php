<?php
// Dashboard
require_once 'config/config.php';
require_once 'includes/auth.php';
require_once 'includes/functions.php';

if (!Auth::isLoggedIn()) {
    header('Location: ' . BASE_URL . 'login.php');
    exit;
}

$user_role = Auth::getRole();
$current_user = getUserData(Auth::getUserId());

// Get statistics based on role
$stats = array();
$tahun_ajaran_aktif = $conn->query("SELECT id FROM tahun_ajaran WHERE status = 'aktif' LIMIT 1")->fetch_assoc();
$tahun_ajaran_id = $tahun_ajaran_aktif['id'] ?? 1;

if ($user_role == 'admin') {
    $stats['total_siswa'] = $conn->query("SELECT COUNT(*) as count FROM siswa WHERE status_siswa = 'aktif'")->fetch_assoc()['count'];
    $stats['total_guru'] = $conn->query("SELECT COUNT(*) as count FROM guru WHERE status = 'aktif'")->fetch_assoc()['count'];
    $stats['total_kelas'] = $conn->query("SELECT COUNT(*) as count FROM kelas WHERE tahun_ajaran_id = $tahun_ajaran_id")->fetch_assoc()['count'];
    $stats['total_pengguna'] = $conn->query("SELECT COUNT(*) as count FROM users WHERE status = 'aktif'")->fetch_assoc()['count'];
} elseif ($user_role == 'guru') {
    // Get guru ID
    $guru = $conn->query("SELECT id FROM guru WHERE user_id = " . Auth::getUserId())->fetch_assoc();
    $guru_id = $guru['id'] ?? 0;
    
    $stats['kelas_mengajar'] = $conn->query("SELECT COUNT(DISTINCT kelas_id) as count FROM jadwal_pelajaran WHERE guru_id = $guru_id AND tahun_ajaran_id = $tahun_ajaran_id")->fetch_assoc()['count'];
    $stats['total_siswa'] = $conn->query("SELECT COUNT(DISTINCT siswa_id) as count FROM siswa_kelas WHERE kelas_id IN (SELECT DISTINCT kelas_id FROM jadwal_pelajaran WHERE guru_id = $guru_id)")->fetch_assoc()['count'];
} elseif ($user_role == 'siswa') {
    // Get siswa ID
    $siswa = $conn->query("SELECT id FROM siswa WHERE user_id = " . Auth::getUserId())->fetch_assoc();
    $siswa_id = $siswa['id'] ?? 0;
    
    $pembayaran = $conn->query("SELECT COUNT(*) as belum FROM pembayaran_spp WHERE siswa_id = $siswa_id AND status = 'belum_bayar'")->fetch_assoc()['belum'];
    $stats['pembayaran_belum'] = $pembayaran;
}

include 'includes/header.php';
?>
<div class="container-fluid">
    <div class="row mt-4">
        <div class="col-md-3">
            <?php include 'includes/sidebar.php'; ?>
        </div>
        <div class="col-md-9">
            <div class="content">
                <div class="page-header mb-4">
                    <h1><i class="fa fa-tachometer"></i> Dashboard</h1>
                    <p class="text-muted">Selamat datang, <?php echo $current_user['nama']; ?>!</p>
                </div>

                <?php if ($user_role == 'admin'): ?>
                    <div class="row">
                        <div class="col-md-3">
                            <div class="card bg-primary text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="card-title text-white-50">Total Siswa</h6>
                                            <h2 class="mb-0"><?php echo $stats['total_siswa']; ?></h2>
                                        </div>
                                        <i class="fa fa-users fa-3x text-white-50"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-success text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="card-title text-white-50">Total Guru</h6>
                                            <h2 class="mb-0"><?php echo $stats['total_guru']; ?></h2>
                                        </div>
                                        <i class="fa fa-chalkboard-user fa-3x text-white-50"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-warning text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="card-title text-white-50">Total Kelas</h6>
                                            <h2 class="mb-0"><?php echo $stats['total_kelas']; ?></h2>
                                        </div>
                                        <i class="fa fa-door-open fa-3x text-white-50"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-3">
                            <div class="card bg-danger text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="card-title text-white-50">Total Pengguna</h6>
                                            <h2 class="mb-0"><?php echo $stats['total_pengguna']; ?></h2>
                                        </div>
                                        <i class="fa fa-user-tie fa-3x text-white-50"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php elseif ($user_role == 'guru'): ?>
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card bg-info text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="card-title text-white-50">Kelas Mengajar</h6>
                                            <h2 class="mb-0"><?php echo $stats['kelas_mengajar']; ?></h2>
                                        </div>
                                        <i class="fa fa-book-open fa-3x text-white-50"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card bg-secondary text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="card-title text-white-50">Total Siswa</h6>
                                            <h2 class="mb-0"><?php echo $stats['total_siswa']; ?></h2>
                                        </div>
                                        <i class="fa fa-users fa-3x text-white-50"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php elseif ($user_role == 'siswa'): ?>
                    <div class="row">
                        <div class="col-md-12">
                            <div class="card bg-danger text-white">
                                <div class="card-body">
                                    <div class="d-flex justify-content-between align-items-center">
                                        <div>
                                            <h6 class="card-title text-white-50">Pembayaran SPP Menunggu</h6>
                                            <h2 class="mb-0"><?php echo $stats['pembayaran_belum']; ?> Bulan</h2>
                                        </div>
                                        <i class="fa fa-money fa-3x text-white-50"></i>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                <?php endif; ?>

                <div class="row mt-4">
                    <div class="col-md-12">
                        <div class="card">
                            <div class="card-header bg-primary text-white">
                                <h5 class="mb-0"><i class="fa fa-info-circle"></i> Informasi Sistem</h5>
                            </div>
                            <div class="card-body">
                                <p><strong>Sistem Operasi:</strong> <?php echo php_uname(); ?></p>
                                <p><strong>Versi PHP:</strong> <?php echo phpversion(); ?></p>
                                <p><strong>Server:</strong> <?php echo $_SERVER['SERVER_SOFTWARE']; ?></p>
                                <p><strong>Database:</strong> MySQL</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<style>
.sidebar {
    border-radius: 5px;
    padding: 20px;
    min-height: 100vh;
}
.sidebar .nav-link {
    color: #333;
    margin-bottom: 5px;
    border-radius: 5px;
    padding: 10px 15px;
    transition: all 0.3s;
}
.sidebar .nav-link:hover {
    background-color: #e9ecef;
    color: #667eea;
}
.sidebar .dropdown-toggle::after {
    float: right;
    margin-top: 5px;
}
.sidebar .dropdown-menu {
    border: none;
    background-color: #f8f9fa;
    border-left: 3px solid #667eea;
}
.sidebar .dropdown-item {
    padding-left: 30px;
    font-size: 14px;
}
.sidebar .dropdown-item:hover {
    background-color: #e9ecef;
    color: #667eea;
}
.card {
    border: none;
    border-radius: 10px;
    box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
    margin-bottom: 20px;
}
.card-body {
    padding: 20px;
}
.page-header {
    border-bottom: 2px solid #667eea;
    padding-bottom: 15px;
}
.page-header h1 {
    color: #667eea;
    font-weight: bold;
}
.content {
    background-color: #fff;
    border-radius: 10px;
    padding: 20px;
}
.bg-primary, .bg-success, .bg-warning, .bg-danger, .bg-info, .bg-secondary {
    border-radius: 10px;
}
</style>

<?php include 'includes/footer.php'; ?>