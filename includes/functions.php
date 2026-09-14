<?php
// Common Functions

// Sanitize input
function sanitize($data) {
    global $conn;
    return $conn->real_escape_string(htmlspecialchars($data, ENT_QUOTES, 'UTF-8'));
}

// Format date
function formatDate($date) {
    $months = array(
        '01' => 'Januari', '02' => 'Februari', '03' => 'Maret',
        '04' => 'April', '05' => 'Mei', '06' => 'Juni',
        '07' => 'Juli', '08' => 'Agustus', '09' => 'September',
        '10' => 'Oktober', '11' => 'November', '12' => 'Desember'
    );
    
    if (empty($date) || $date == '0000-00-00') {
        return '-';
    }
    
    $date_parts = explode('-', $date);
    return $date_parts[2] . ' ' . $months[$date_parts[1]] . ' ' . $date_parts[0];
}

// Format currency
function formatCurrency($amount) {
    return 'Rp ' . number_format($amount, 0, ',', '.');
}

// Generate unique ID
function generateId($prefix = '') {
    return $prefix . time() . rand(1000, 9999);
}

// Check file upload
function validateFileUpload($file, $allowed_types = array('pdf', 'doc', 'docx', 'jpg', 'jpeg', 'png')) {
    if (empty($file['name'])) {
        return array('success' => false, 'message' => 'File tidak dipilih');
    }

    $file_ext = strtolower(pathinfo($file['name'], PATHINFO_EXTENSION));
    if (!in_array($file_ext, $allowed_types)) {
        return array('success' => false, 'message' => 'Tipe file tidak diperbolehkan');
    }

    if ($file['size'] > 5 * 1024 * 1024) { // 5 MB
        return array('success' => false, 'message' => 'Ukuran file terlalu besar (max 5 MB)');
    }

    return array('success' => true, 'message' => 'File valid');
}

// Upload file
function uploadFile($file, $destination) {
    $file_name = uniqid() . '_' . basename($file['name']);
    $file_path = $destination . $file_name;

    if (move_uploaded_file($file['tmp_name'], $file_path)) {
        return array('success' => true, 'filename' => $file_name, 'path' => $file_path);
    }
    return array('success' => false, 'message' => 'Gagal mengupload file');
}

// Redirect
function redirect($url) {
    header('Location: ' . $url);
    exit;
}

// Get user data
function getUserData($userId) {
    global $conn;
    $stmt = $conn->prepare("SELECT * FROM users WHERE id = ?");
    $stmt->bind_param('i', $userId);
    $stmt->execute();
    return $stmt->get_result()->fetch_assoc();
}
?>