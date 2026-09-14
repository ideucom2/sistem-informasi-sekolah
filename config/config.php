<?php
// Application Configuration
session_start();

// Base URL
define('BASE_URL', 'http://localhost/sistem-informasi-sekolah/');
define('SITE_TITLE', 'Sistem Informasi Sekolah');
define('SITE_NAME', 'SIS - Sekolah');

// Application Settings
define('APP_DEBUG', true);
define('APP_ENV', 'development');

// Upload directories
define('UPLOAD_DIR', __DIR__ . '/../uploads/');
define('UPLOAD_DOCS', UPLOAD_DIR . 'dokumen/');
define('UPLOAD_FOTO', UPLOAD_DIR . 'foto/');
define('UPLOAD_BUKTI', UPLOAD_DIR . 'bukti_pembayaran/');

// Create upload directories if not exist
@mkdir(UPLOAD_DIR, 0755, true);
@mkdir(UPLOAD_DOCS, 0755, true);
@mkdir(UPLOAD_FOTO, 0755, true);
@mkdir(UPLOAD_BUKTI, 0755, true);

// Time Zone
date_default_timezone_set('Asia/Jakarta');

// Include database configuration
require_once __DIR__ . '/database.php';

// Error Reporting
if (APP_DEBUG) {
    error_reporting(E_ALL);
    ini_set('display_errors', 1);
} else {
    error_reporting(0);
    ini_set('display_errors', 0);
}
?>