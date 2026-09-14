<?php
// Authentication Helper

class Auth {
    private $conn;

    public function __construct($connection) {
        $this->conn = $connection;
    }

    // Login function
    public function login($username, $password) {
        $stmt = $this->conn->prepare("SELECT id, username, password, role, status FROM users WHERE username = ?");
        $stmt->bind_param('s', $username);
        $stmt->execute();
        $result = $stmt->get_result();

        if ($result->num_rows > 0) {
            $user = $result->fetch_assoc();
            if (password_verify($password, $user['password'])) {
                if ($user['status'] == 'aktif') {
                    $_SESSION['user_id'] = $user['id'];
                    $_SESSION['username'] = $user['username'];
                    $_SESSION['role'] = $user['role'];
                    return true;
                } else {
                    return 'Akun tidak aktif';
                }
            } else {
                return 'Password salah';
            }
        }
        return 'Username tidak ditemukan';
    }

    // Check if user is logged in
    public static function isLoggedIn() {
        return isset($_SESSION['user_id']);
    }

    // Get current user ID
    public static function getUserId() {
        return $_SESSION['user_id'] ?? null;
    }

    // Get current user role
    public static function getRole() {
        return $_SESSION['role'] ?? null;
    }

    // Logout
    public static function logout() {
        session_destroy();
        header('Location: ' . BASE_URL . 'login.php');
        exit;
    }

    // Check role
    public static function hasRole($role) {
        return self::getRole() == $role;
    }

    // Check if user has any of the roles
    public static function hasAnyRole($roles) {
        $userRole = self::getRole();
        return in_array($userRole, $roles);
    }
}
?>