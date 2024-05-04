<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Administrator Home</title>
</head>
<body>
<a href="adminLogin.jsp">LogOut </a>
<h1 align = 'center'>Welcome Admin</h1>

<%
	
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String username = request.getParameter("cr_user_create");
			String password = request.getParameter("cr_pass_create");
			
			boolean isCreated = false;
			if(username != null && password != null && !username.isBlank() && !password.isBlank()){
            String query = "INSERT INTO Customer_Reps (username,password) VALUES (?,?) ";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, username);
            pstmt.setString(2, password);
			pstmt.executeUpdate();
			isCreated = true;
			} else {
				isCreated = false;
			}
			%>
			
			
			
			
			
	


<h1 align = 'center'>Create A Customer Rep Account</h1>
<br>
		<form method="post" action="adminHomePage.jsp">
			<table align = "center">
				<tr>    
					<td>Enter Username</td><td><input type="text"  name="cr_user_create"></td>
				</tr>
				<tr>    
					<td>Enter Password</td><td><input type="text"  name="cr_pass_create"></td>
				</tr>
			</table>
		<center><input type="submit" value="Create"></center>
		</form>
		<%if(isCreated){ %>
		<p align = 'center'>Customer Rep Successfully Created!</p>
		<%} %>
<br>
<h1 align = 'center'>Generate Sales</h1>
<br>
		<form method="post" action="generateReport.jsp">
		<center><input type="submit" value="Total Earnings"></center>
		</form>
<br>
<br>
		<form method="post" action="generateReportItem.jsp">
		<center><input type="submit" value="Earnings per Item"></center>
		</form>
<br>
<br>
		<form method="post" action="generateReportItemType.jsp">
		<center><input type="submit" value="Earnings per Item Type"></center>
		</form>
<br>
<br>
		<form method="post" action="generateReportEndUser.jsp">
		<center><input type="submit" value="Earnings per End User"></center>
		</form>
<br>
<br>
		<form method="post" action="generateReportSellingItem.jsp">
		<center><input type="submit" value="Best Selling Items"></center>
		</form>
<br>
<br>
		<form method="post" action="generateReportBuyer.jsp">
		<center><input type="submit" value="Best Buyers"></center>
		</form>
<br>
	<%
			con.close();
			//close the connection.
			db.closeConnection(con);
			%>
	<%} catch (Exception e) {
			out.print(e);
		}%>
</body>
</html>