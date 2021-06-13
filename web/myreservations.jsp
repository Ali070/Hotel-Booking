<%-- 
    Document   : myreservations
    Created on : Jan 10, 2021, 9:38:04 PM
    Author     : User
--%>

<%@page import="java.util.Calendar"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Class.forName("com.mysql.jdbc.Driver").newInstance(); %>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>reservations Page</title>
        <link rel="stylesheet" href="Style.css?version=50">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    </head>
    <body class="myrsv_bdy">
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
        <%
            String username = request.getSession().getAttribute("Username").toString();
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/hotel";
            String user = "root";
            String password = "Bickaso@lo#123";
            Connection con = DriverManager.getConnection(url, user, password);
            Statement stmt = con.createStatement();
            ResultSet RS = stmt.executeQuery("SELECT * FROM reservation WHERE Username='" + username + "'");
            if (!RS.isBeforeFirst()) {%>
            <h2 class="norsv" style="color: white;">You have No Reservations</h2>
        <%
        } else {
            String nights = "";
            String hotelname = "";

        %>
        <div class="myrsv">
            <h1>Reservations :</h1>
            <table>
                <%                while (RS.next()) {

                %>
                <tr>
                    <th>Reservation ID</th> 
                    <th>Username</th> 
                    <th>Hotel Name</th> 
                    <th>Check In</th>
                    <th>checkout</th>
                    <th>price</th>
                    <th>Room Name</th>
                    <th>Nights</th>
                    <th>Phone Number</th>
                    <th>Email</th>
                </tr>
                <tr>

                    <td><%=RS.getString("idreservation")%></td>
                    <td><%=RS.getString("Username")%></td>
                    <td><%=RS.getString("hotelname")%></td>
                    <td><%=RS.getString("checkin")%></td>
                    <td><%=RS.getString("checkout")%></td>
                    <td><%=RS.getString("price")%></td>
                    <td><%=RS.getString("roomname")%></td>
                    <td><%=RS.getString("nights")%></td>
                    <td><%=RS.getString("phonenumber")%></td>
                    <td><%=RS.getString("email")%></td>
                    <%nights = RS.getString("nights");
                        hotelname = RS.getString("hotelname");%>
                </tr>
                <%}
                %>
            </table>
        </div>
        <div class="chnrsv">
            <h1>Change Reservation :</h1>
            <br>
            <form action="Cancel" class="chngform">
                <table>
                    <thead>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Enter Reservation ID</td>
                            <td class="exptd"><input type="number" name="id" required /></td>
                    <input type="hidden" value="change" name="chng">
                    <%session.setAttribute("change", 1);%>
                    <input type="hidden" value="<%=nights%>" name="nights">
                    <input type="hidden" value="<%=hotelname%>" name="hotelname">
                    </tr>
                    <tr>
                        <td><input type="submit" value="change" class="chngbtn"/></td>
                    </tr>
                    </tbody>
                </table>
            </form>
        </div>
                    <p class="mess1" >${param.message}</p>
        <div class="chnrsv">
            <h1>Cancel Reservation :</h1>
            <br>
            <form action="Cancel" class="chngform">
                <table>
                    <thead>
                    </thead>
                    <tbody>
                        <tr>
                            <td>Enter Reservation ID</td>
                            <td><input type="text" name="id" value="" required/></td>
                        </tr>
                        <tr>
                            <td><input type="submit" value="Cancel" class="chngbtn"/></td>
                        </tr>
                    <input type="hidden" value="cncel" name="chng">
                    <input type="hidden" value="<%=nights%>" name="nights">
                    <input type="hidden" value="<%=hotelname%>" name="hotelname">
                    </tbody>
                </table>
                    
            </form>
        </div>
                   <p class="mess1" >${param.message2}</p> 
        <%}
        %>
        
    </body>

</html>
