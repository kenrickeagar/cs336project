<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>


<%
	
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String itemID = (String)session.getAttribute("itemID"); //get the items id 
			String user_name = (String) session.getAttribute("username");
			if(user_name == null){
					response.sendRedirect("userLogin.jsp");
			}
			String idQuery = "SELECT id from Users WHERE username = ?";
			PreparedStatement pstmt = con.prepareStatement(idQuery);
			pstmt.setString(1, user_name);
			ResultSet result = pstmt.executeQuery();
			result.next();
			String buyID = result.getString(1); //current user id number
			
			
			String increment = request.getParameter("increment_bid");
			String max_bid = request.getParameter("max_bid"); //get the users max bid
		
			
            String addQuery = "INSERT INTO Auto_Bids (i_id, id,prev_price,amount,increment) VALUES (?,?,?,?,?)";
			
            PreparedStatement apstmt = con.prepareStatement(addQuery);
            apstmt.setString(1, itemID);
            apstmt.setString(2, buyID);
            apstmt.setString(3, "0"); //default
            apstmt.setString(4, max_bid);
            apstmt.setString(5, increment);
			apstmt.executeUpdate();
			
			out.print("<h1>Auto Bid Succesfully Placed and An Initial Bid Has Been Placed</h1>");
            out.print("<a href='HomePage.jsp'>Go Back Home</a>");
			
			%>

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