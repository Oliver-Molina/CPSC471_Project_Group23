<?php
session_start();
?>
<style>
    .input_form{
        font-family:'helvetica';
        border: 3px solid black;
        padding-top:12px;
        padding-bottom:12px;
    }
    .input_form.center{
        margin-left:auto;
        margin-right:auto;
        padding-top:12px;
    }
    input{
        border:1px solid black;
    }
    form{
        padding-left:10px;
    }
</style>
<html>
<h1 style='font-family:helvetica;padding-top:10px;'>Sign up for an account</h1>
    <div class = 'input_form'>
        <input_form class=center>
        <form action='./reg_manager.php' method='post'>
        <?php if(isset($_GET['error'])){?>
            <p class='error'> <?php echo $_GET['error']; ?></p>
        <?php } ?>
        <label for="Org">Enter Organization ID:</label><br>
        <input type="text" id='Org' name = "OrgID" autocomplete="off"maxlength="10" required><br>
        <label for='Fname'>First Name:</label>
        <label for='Lname' style='padding-left:70px'>Last Name:</label><br>
        <input type="text" id="Fname" name ='Fname' autocomplete='off' maxlength="15" required>
        <input type="text" id="Lname" name='Lname' autocomplete='off' style="padding-left:5px" maxlength="15" required><br>
        <label for="Gender">Gender</label><br>
        <select style='border:1px;padding-top:5px;padding-bottom:5px'id="Gender" name="Gender">
            <option value = "Male">Male</option>
            <option value = "Female">Female</option>
            <option value = "Non-Binary">Non-Binary</option>
            <option value= "Other" selected>Other</option>
        </select><br>
        <label for='Email'>Email Address:</label><br>
        <input type="text" id="Email" name="Email" placeholder="Email" autocomplete="off"maxlength="320" required><br>
        <label for="password">Enter Password:</label><br>
        <input type="password" id="Password" name="Password" placeholder="Password" autocomplete="off"maxlength="32"required><br>
        <label for='Password2'>Confirm Password:</label><br>
        <input type="password" id="Password2" name="Password2" placeholder="Password" autocomplete="off"maxlength="32" required><br>
        <button type='submit' value='Submit' name='Register'>Register</button>
        </form>
        </input_form>
    </div>
</html>