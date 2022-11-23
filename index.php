<!DOCTYPE html>
<html>

<head>
<title>Login</title>
</head>

<body>
    <h1>This is the Login Page</h1>
    <p>Here you will login.</p>
    <form action='./login.php' method='post'>
        <?php if(isset($_GET['error'])) { ?>
            <p class='error'> <?php echo $_GET['error']; ?></p>
            <?php } ?>
        <label for="username">Enter Username:</label><br>
        <input type="text" id="username" name="username" placeholder="Username" autocomplete="off"><br>
        <label for="password">Enter Password:</label><br>
        <input type="text" id="password" name="password" placeholder="Password" autocomplete="off"><br>
        <button type='submit' value='Submit' name='Submit'>Login</button>
        </form>
</body>
</html>

