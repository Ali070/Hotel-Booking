<%-- 
    Document   : index
    Created on : Dec 29, 2020, 9:15:27 PM
    Author     : User
--%>

<%@page import="javafx.scene.control.Alert"%>
<%@page import="java.sql.Date"%>
<%@page import="java.util.Calendar"%>
<% Class.forName("com.mysql.jdbc.Driver").newInstance(); %>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home</title>
        <link rel="stylesheet" href="Style.css?version=51">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">

    </head>
    <body class="homeBody">
        <header>
            <a href="index.jsp" class="brand">Brand</a>
            <div class="menu">
                <div class="btn">
                    <i class="fas fa-times close-btn"></i>
                </div>
                <%
                    String profileName = "";
                    Calendar calendar = Calendar.getInstance();
                    Date date = new Date(calendar.getTime().getTime());
                    calendar.setTime(date);
                    calendar.add(Calendar.MONTH, 1);
                    Date currentDatePlusOne = new Date(calendar.getTime().getTime());
                    try {
                        String username = request.getSession().getAttribute("Username").toString();
                        profileName = request.getSession().getAttribute("DisplayName").toString();
                        if (profileName.equals("admin")) {%>
                <a href="Signout">Sign out</a>
                <a href="adminPage.jsp"><%=profileName%></a>
            </div>
            <% } else {%>
            <a href="Signout">Sign out</a>
            <a href="Profile.jsp"><%=profileName%></a>
            <a href="myreservations.jsp">My Reservation</a>
        </div>
        <%
            }
        } catch (Exception e) {
        %>
        <a href="SignUp.jsp">Sign up</a>
        <a href="Login.jsp">Login</a>
    </div>
    <%
        }

    %>
    <div class="btn">
        <i class="fas fa-bars menu-btn"></i>
    </div>
</header>
    <script type="text/javascript">
            window.addEventListener("scroll", function () {
                var header = document.querySelector("header");
                header.classList.toggle('sticky', window.scrollY > 0);
            });
            var menu = document.querySelector('.menu');
            var menuBtn = document.querySelector('.menu-btn');
            var closeBtn = document.querySelector('.close-btn');

            menuBtn.addEventListener("click", () => {
                menu.classList.add('active');
            });

            closeBtn.addEventListener("click", () => {
                menu.classList.remove('active');
            });
        </script>
<br>
<div class="book_Cont">
    <form method="post" action="resultSearch.jsp">
        <input list="locations" name="location" placeholder="Where are you going?" class="loc" required>
        <datalist id="locations">
            <option value="Alexandria">
            <option value="Cairo">
            <option value="Hurghada">
            <option value="Sharm El sheikh">
            <option value="Giza">
        </datalist>
        <input type="date" name="checkin" min="<%= date.toString()%>" max="<%=currentDatePlusOne.toString()%>" class="chk" required>
        <input type="date" name="checkout" min="<%= date.toString()%>" max="<%=currentDatePlusOne.toString()%>"class="chk" required>
        <input type="number" name="adult" placeholder="Adults" min="1" max="10" class="person" required>
        <input type="number" name="child" placeholder="Childs" min="1" max="10" class="person" required>
        <input type="submit" name="submit" value="Search" class="srchBtn">
    </form>
</div> 
<div class="footer">
</div>
<p class="message">${param.message}</p>       
</body>
</html>
