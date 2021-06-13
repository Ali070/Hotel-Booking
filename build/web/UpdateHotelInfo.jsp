<%-- 
    Document   : UpdateHotelInfo
    Created on : Jan 12, 2021, 11:14:55 PM
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Update Hotel</title>
         <link rel="stylesheet" href="Style.css?version=51">
         <meta name="viewport" content="width=device-width, initial-scale=1.0">
         <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    </head>
    <body class="loginBody">
        <header>
            <a href="index.jsp" class="brand">Brand</a>
            <div class="menu">
                <div class="btn">
                    <i class="fas fa-times close-btn"></i>
                </div>
                <a href="viewReservations.jsp">View Reservations</a>
                <a href="checkingclients.jsp">Checking Clients</a>
                <a href="adminPage.jsp">Admin Page</a>
            </div>
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
        <%
            String hotelname = "";
            try{
                hotelname = request.getParameter("hotelname");
                session.setAttribute("hotelname", hotelname);
            }catch(Exception e){
                hotelname = session.getAttribute("hotelname").toString();
            }
        %>
        <div class="loginContainer">
        <p>Enter hotel new Information:</p>
        <form action="Update" method="post">
            <input type="text" placeholder="Location" name="location" required><br>
            <input type="number" placeholder="Phone Number" name="phone" required><br>
            <input type="number" placeholder="Mobile Number" name="mobile" required><br>
            <input type="text" placeholder="Facilities" name="facil" required><br>
            <input type="email" placeholder="Email" name="email" required><br>
            <input type="number" placeholder="Stars" min="1" max="5" name="star" required><br>
            <input type="number" placeholder="Distance from center in Km" name="distance" required><br>
            <input type="submit" class="btnLogin" value="ADD" >
        </form>
        <form action="updatePhoto" method="post" enctype = "multipart/form-data">
            <input type="file" name="file" multiple>
            <input type="submit" class="btnLogin" value="ADD Photos" >
        </form>
        <p style="color: crimson;" class="message">${param.message}</p>
        </div>
    </body>
</html>