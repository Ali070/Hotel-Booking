<%-- 
    Document   : SignUp
    Created on : Dec 29, 2020, 12:06:01 AM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Class.forName("com.mysql.jdbc.Driver").newInstance(); %>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Sign Up</title>
        <link rel="stylesheet" href="Style.css">
        <script src="https://www.google.com/recaptcha/api.js"></script>
    </head>
    <body class="signupBody">
        
        <div class="signupContainer">
        <form method="post" action="CreateAccount">
            <p>Sign Up</p>
            <input type="text" name="username" id="username" onchange="validate()" class="form-control" placeholder="username"  required>
            <span id="sp" class="sp"></span>
            <input type="email" id="email" name="email" class="form-control" placeholder="email" required>
            <input type="text" id="address" name="address" class="form-control" placeholder="address" required>
            <input type="number" id="phonenum" name="phone" class="form-control" placeholder="phone number" required>
            <input type="text" id="dispname" name="DisplayName" class="form-control" placeholder="display name" required>
            <input type="text" id="age" name="age" class="form-control" placeholder="age" required> 
            <button type="submit" name="subm" id="submit" class="btnSignUp">Sign up</button><p></p>
            <div class="g-recaptcha" data-sitekey="6LfQtB4UAAAAAD8dYz3NfgE54Jgd4MRD4ctt43oe" required></div>
            <p class="message">Have an account? <a href="Login.jsp">Sign in</a></p>
        </form>
            
        <script>
            function validate(){
                var username = document.getElementById("username").value;
                var message  = "*Username is already taken*";
                var xmlhttp = new XMLHttpRequest();
                xmlhttp.open("GET","ValidateUserName?username="+username,true);
                xmlhttp.send();
                xmlhttp.onreadystatechange=function (){
                    if(xmlhttp.readyState==4 && xmlhttp.status==200){
                        document.getElementById("message").innerHTML = xmlhttp.responseText;
                        if(xmlhttp.responseText!=""){
                            document.getElementById("submit").disabled = true;
                            document.getElementById("sp").innerHTML = message;
                            document.getElementById("sp").hidden = false;
                        }else{
                            document.getElementById("submit").disabled = false;
                            document.getElementById("sp").hidden = true;
                        }
                    }
                }
            }
        </script>
        <p style="color: red;">${param.message}</p>
        </div>
        <p id="message" style="color: red;"></p>
        
        
             
    </body>
</html>
