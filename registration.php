<?php
session_start();
?>
<html>
<h1>This is Registration page</h1>
    <p>Here you will register.</p>
    <form action='./login.php' method='post'>
        <?php if(isset($_GET['error'])){?>
            <p class='error'> <?php echo $_GET['error']; ?></p>
        <?php } ?>
        <label for="Email">Enter Email:</label><br>
        <input type="text" id="Email" name="Email" placeholder="Email" autocomplete="off"><br>
        <label for="password">Enter Password:</label><br>
        <input type="password" id="Password" name="Password" placeholder="Password" autocomplete="off"><br>
        <button type='submit' value='Submit' name='Submit'>Login</button>
        </form> 
</html>