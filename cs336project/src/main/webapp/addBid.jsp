<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime,java.time.format.DateTimeFormatter" %>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>create and add bid </title>
</head>
<body>


<%

		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String bidAmount = request.getParameter("bid_amount");
			String itemID = (String) session.getAttribute("itemID");
			String user_name = (String) session.getAttribute("username");
			if(user_name == null){
					response.sendRedirect("userLogin.jsp");
			}
			String idQuery = "SELECT id from Users WHERE username = ?";
			PreparedStatement pstmt = con.prepareStatement(idQuery);
			pstmt.setString(1, user_name);
			ResultSet result = pstmt.executeQuery();
			result.next();
			String buyID = result.getString(1);
			
			String checkQuery = "SELECT unit_price from Items WHERE i_id = ?";
			PreparedStatement pCheck = con.prepareStatement(checkQuery);
			pCheck.setString(1, itemID);
			ResultSet rCheck = pCheck.executeQuery();
			rCheck.next();
			Double checkMe = Double.parseDouble(rCheck.getString(1));
			
			if(Double.parseDouble(bidAmount) < checkMe){
				out.print("<h1>Error: Bid Must Be Higher Than Current Price</h1>");
	            out.print("<a href='HomePage.jsp'>Go Back Home</a>");
			}

			else{
            String query = "UPDATE Items SET unit_price = ? WHERE i_id = ?";
            PreparedStatement pstmt2 = con.prepareStatement(query);
            pstmt2.setString(1, bidAmount);
            pstmt2.setString(2, itemID);
			pstmt2.executeUpdate();
			
			String query2 = "INSERT INTO Bids (i_id, amount, buyer_id, time_of_bid) VALUES (?, ?,?, ?)";
			PreparedStatement p3 = con.prepareStatement(query2);
            p3.setString(1, itemID);
            p3.setString(2, bidAmount);
            p3.setString(3, buyID);
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
            LocalDateTime.now().format(formatter);
            p3.setTimestamp(4,Timestamp.valueOf(LocalDateTime.now().format(formatter)));
            
            p3.executeUpdate();
            out.print("<h1>Bid Succesfully Placed</h1>");
            out.print("<a href='HomePage.jsp'>Go Back Home</a>");
			}
			%>
	
		<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>    
			
		</tr>	
			<%
			con.close();
			//close the connection.
			db.closeConnection(con);
			%>
		</table>

			
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>
</html>