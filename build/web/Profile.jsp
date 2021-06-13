<%-- 
    Document   : Profile
    Created on : Dec 29, 2020, 10:34:03 PM
    Author     : User
--%>

<%@page import="java.net.URLEncoder"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<% Class.forName("com.mysql.jdbc.Driver").newInstance(); %>
<%@page import="java.sql.*"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="Style.css">
        <title>Profile</title>
    </head>
    <body class="profbody">
        <%
            Class.forName("com.mysql.jdbc.Driver");
            String url = "jdbc:mysql://localhost:3306/hotel";
            String user = "root";
            String password = "Bickaso@lo#123";
            String username = request.getSession().getAttribute("Username").toString();
            Connection con = DriverManager.getConnection(url, user, password);
            Statement stmt = con.createStatement();
            String line = "SELECT* FROM client WHERE Username='" + username + "'";
            ResultSet set = stmt.executeQuery(line);
            set.beforeFirst();
            set.next();
            String pass = set.getString("password");
            String email = set.getString("email");
            String address = set.getString("Address");
            String phoneNumber = set.getString("PhoneNumber");
            String DisplayName = set.getString("displayname");
            String Age = set.getString("Age");
        %>
        <div class="profcontainer">
            <p class="exp">Profile Page</p>
        <form method="get">
            <label>Username:</label><p><%out.println(username);%></p><br>
            <label>Email:</label><input type="email" name="email" value="<% out.println(email);%>" required><br>
            <label>Password:</label><input type="password" name="password" value="<% out.println(password);%>" required><br>
            <label>Address:</label><input type="text" name="address" value="<% out.println(address);%>" required><br>
            <label>Phone Number:</label><input type="text" name="phone" value="<% out.println(phoneNumber);%>" required><br>
            <label>Display Name:</label><input type="text" name="DisplayName" value="<% out.println(DisplayName);%>" required><br>
            <label>Age:</label><input type="text" name="age" value="<% out.println(Age);%>" required><br> 
            <button type="submit" name="subm" class="btnUpd">Update</button>
            <button type="submit" name="subm1" class="btnDel">Delete</button>
            <br>
        </form>
        <p> ${param.message}</p>
        </div>
        <%
            String submit = request.getParameter("subm");
            String submit1 = request.getParameter("subm1");
            if (submit != null) {
                String newpass = request.getParameter("password");
                String newemail = request.getParameter("email");
                String newaddress = request.getParameter("address");
                String newphoneNumber = request.getParameter("phone");
                String newDisplayName = request.getParameter("DisplayName");
                String newAge = request.getParameter("age");
                
                    String line2 = "UPDATE hotel.client SET password = '" + newpass + "', email = '" + newemail + "', displayname = '" + newDisplayName + "', PhoneNumber = '" + newphoneNumber + "', Age = '" + newAge + "', Address = '" + newaddress + "' WHERE (Username = '" + username + "')";
                    stmt.executeUpdate(line2);
               
                String message = "Account Updated successfully";
                response.sendRedirect("Profile.jsp?message=" + URLEncoder.encode(message, "UTF-8"));
                stmt.close();
                con.close();
            }
            if (submit1 != null) {
                stmt.executeUpdate("DELETE FROM client WHERE Username = '" + username + "'");
                response.sendRedirect("Signout");
            }
        %>
    </body>
</html>
