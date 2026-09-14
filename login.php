<?php
// Login Page
require_once 'config/config.php';

$error = '';
$success = '';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $username = sanitize($_POST['username'] ?? '');
    $password = $_POST['password'] ?? '';
    
    if (empty($username) || empty($password)) {
        $error = 'Username dan password harus diisi';
    } else {
        $auth = new Auth($conn);
        $login_result = $auth->login($username, $password);
        
        if ($login_result === true) {
            $success = 'Login berhasil! Mengalihkan...';
            header('Location: ' . BASE_URL . 'dashboard.php');
            exit;
        } else {
            $error = $login_result;
        }
    }
}
?>
<!DOCTYPE html>
<html lang="id">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - <?php echo SITE_TITLE; ?></title>
    <link rel="stylesheet" href="<?php echo BASE_URL; ?>assets/css/bootstrap.min.css">
    <link rel="stylesheet" href="<?php echo BASE_URL; ?>assets/css/font-awesome.min.css">
    <style>
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .login-container {
            background: white;
            border-radius: 10px;
            box-shadow: 0 10px 50px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 400px;
            padding: 40px;
        }
        .login-header {
            text-align: center;
            margin-bottom: 30px;
        }
        .login-header h1 {
            color: #667eea;
            font-size: 28px;
            margin-bottom: 10px;
        }
        .login-header p {
            color: #999;
            font-size: 14px;
        }
        .form-control {
            border-radius: 5px;
            border: 1px solid #ddd;
            padding: 12px;
            margin-bottom: 15px;
            font-size: 14px;
        }
        .form-control:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 0.2rem rgba(102, 126, 234, 0.25);
        }
        .btn-login {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            border: none;
            padding: 12px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 5px;
            width: 100%;
            margin-top: 10px;
            cursor: pointer;
            transition: transform 0.2s;
        }
        .btn-login:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        .alert {
            border-radius: 5px;
            margin-bottom: 20px;
        }
        .icon-input {
            position: relative;
        }
        .icon-input i {
            position: absolute;
            left: 12px;
            top: 12px;
            color: #999;
        }
        .icon-input .form-control {
            padding-left: 40px;
        }
        .demo-info {
            background: #f0f8ff;
            border-left: 4px solid #667eea;
            padding: 15px;
            margin-top: 20px;
            border-radius: 5px;
            font-size: 12px;
        }
        .demo-info strong {
            display: block;
            margin-bottom: 5px;
            color: #667eea;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="login-header">
            <h1><i class="fa fa-graduation-cap"></i></h1>
            <h1><?php echo SITE_NAME; ?></h1>
            <p>Sistem Informasi Sekolah</p>
        </div>

        <?php if (!empty($error)): ?>
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                <i class="fa fa-exclamation-circle"></i> <?php echo $error; ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <?php endif; ?>

        <?php if (!empty($success)): ?>
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                <i class="fa fa-check-circle"></i> <?php echo $success; ?>
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        <?php endif; ?>

        <form method="POST" action="">
            <div class="icon-input">
                <i class="fa fa-user"></i>
                <input type="text" class="form-control" name="username" placeholder="Username" required>
            </div>
            
            <div class="icon-input">
                <i class="fa fa-lock"></i>
                <input type="password" class="form-control" name="password" placeholder="Password" required>
            </div>
            
            <button type="submit" class="btn-login">
                <i class="fa fa-sign-in"></i> Login
            </button>
        </form>

        <div class="demo-info">
            <strong>Demo Login:</strong>
            Username: admin<br>
            Password: admin123
        </div>
    </div>

    <script src="<?php echo BASE_URL; ?>assets/js/bootstrap.bundle.min.js"></script>
</body>
</html>