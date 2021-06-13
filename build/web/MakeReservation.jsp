<%-- 
    Document   : MakeReservation
    Created on : Jan 7, 2021, 3:10:28 AM
    Author     : User
--%>

<%@page import="java.util.Date"%>
<%@page import="java.util.Calendar"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reservation</title>
        <link rel="stylesheet" href="Style.css?version=50">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css">
    </head>
    <body class="mr_body">
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
            String hotelName = session.getAttribute("hotelname").toString();
            String temp = hotelName + "/" + "0" + ".jpg";
            ArrayList<String> roomsList = new ArrayList<>();
        %>

        <div class ="mr_ng">
            <h2><%= hotelName%></h2>
            <img  src = "images/<%out.print(temp);%>" width="500" height="333"/>
        </div>
        <div class="book_det">
        <span>Your booking details</span>
        <br>
            <%
                String nights = "";
                try{
                nights = request.getParameter("nights");}
                catch(Exception e){
                    out.print(e);
                }
                int count = Integer.parseInt(request.getParameter("count").toString());
                int sumPrice = 0;
                String checkIN = request.getSession().getAttribute("checkin").toString();
                String checkOut = request.getSession().getAttribute("checkout").toString();
            %>
            <label>Check-in</label><p><%= checkIN%></p>
            <br>
            <label>Check-out</label><p><%= checkOut%></p>
            <br>
            <label>Total length of stay:</label><p><%out.println(nights + " nights");%></p><br>
            <label>You selected: </label><br>
            <%
                for (int i = 0; i < count; i++) {
                    String roomtype = request.getParameter("room" + i);
                    String[] rooms = request.getParameter("roomNumber" + i).toString().split("-");

                    if (rooms.length == 2) {
                        sumPrice += Integer.parseInt(rooms[1]);
                        roomsList.add(rooms[0]+"_"+roomtype);
                %>
            <p><%out.println(rooms[0] + " " + roomtype);%></p><br>
            <%

                    }
                }

            %>
            <br>
            <label>The total price: </label><p><%= sumPrice%></p>
            <form action="viewHotel.jsp" method="post">
                <input type="hidden" name="nights" value="<%=nights%>">
                <input type="hidden" name="hotelname" value="<%=hotelName%>">
                <input type="submit" value="Change your selection" class="cngbtn">
            </form>
        </div>
        <br>
        <div class="add_rs">
        <span>Enter your details</span>
        <form method="post"action="AddReservation">
            <div>
                <input type="hidden" name="price" value="<%= sumPrice%>">
                <label for="firstName">First Name</label> 
                <input type="text" id="firstName" name="firstname" required>
                <br>
                <label for="lastName">Last Name</label> 
                <input type="text" id="lastName" name="lastname" required>
                <br>
                <label for="Email">Email Address</label> 
                <input type="email" id="Email" name="Email" required>
                <br>
                <label for="confirmEmail">Confirm email</label> 
                <input type="email" id="confirmEmail" name="confirm" onchange="validate()" required>
                <br>
                <label for="phone">Phone Number:</label> 
                <input type="number" id="phone" name="Phone" required>
                <br>
                <span>Enter your Payment Information:</span><br><br>
                <label for="CardNO.">Card Number:</label>
                <input type="number" id="CardNO." min="0" name="cardnumber" placeholder="Card No.">
                <br>
                <label for="expired">Expired Date:</label>
                <input type="date" id="expired" name="expireddate" placeholder="Expired date">
                <span id="error"style="color: red;"></span>
            </div>
            </div>
            <br>
            <%
                Class.forName("com.mysql.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3306/hotel";
                String user = "root";
                String password = "Bickaso@lo#123";
                Connection con = DriverManager.getConnection(url, user, password);
                Statement stmt = con.createStatement();
                int counter = 0;
                for (int i = 0; i < count; i++) {
                    String roomtype = request.getParameter("room" + i);
                    String[] rooms = request.getParameter("roomNumber" + i).toString().split("-");
                    String RoomFacilities = "";
                    String smoking = "";
                    if (rooms.length == 2) {
                        ResultSet RS = stmt.executeQuery("SELECT* FROM rooms WHERE name='" + hotelName + "' AND roomtype='" + roomtype + "'");
                        RS.beforeFirst();
                        RS.next();
                        for (int j = 0; j < Integer.parseInt(rooms[0]); j++) {

                            RoomFacilities = RS.getString("roomfacilities");
                            smoking = RS.getString("smoking");
                            String check = RS.getString("breakfast");
                            
                            if (check.equalsIgnoreCase("yes")) {
                                check = "breakfast included";
                            } else {
                                check = "breakfast not included";
                            }
            %>
            <div class="room">
                <h3><%= roomtype%></h3>
                <p><%= RoomFacilities%></p>
                <p><%= smoking%></p>
                <p><%=check%></p>
                <p>Make changes online to your booking included</p>
                <input type="text" name="guest<%= j%>" placeholder="First name, Last name" required>
            </div>
            <%                   counter++;
                        }
                    }
                }
                
                for(int k=0;k<roomsList.size();k++){%>
                <input type="hidden" name="room<%=k%>" value="<%=roomsList.get(k)%>">
            <%
                    
                }
            %>
            <input type="hidden" name="size" value="<%=roomsList.size()%>">
            <br>
            <input type="submit" value="Make Reserve" id="MakeReserve" class="mkRsvbtn"> 
        </form>

        <script>
            function validate() {
                var email = document.getElementById("Email").value;
                var confirmEmail = document.getElementById("confirmEmail").value;
                if (email != confirmEmail) {
                    document.getElementById("error").innerHTML = "Enter email correctly";
                }
            }
        </script>


        <%
            String message = request.getParameter("message");
            if(message!=null){%>
            <script>
                alert("Reservation made successfully");
                document.getElementById("MakeReserve").disabled = true;
            </script>
            <form action="CancelReservation">
                <input type="submit" value="Cancel Reservation" class="cnclRsrvBtn">
            </form>
                <%
            }
        %>

    </body>
</html>
