<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Selected Items</title>
</head>
<body>
<%
	
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String itemID = request.getParameter("i_id");
			session.setAttribute("itemID", itemID);
		
			
            String query = "SELECT * FROM Items WHERE i_id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, itemID);
			ResultSet result = pstmt.executeQuery();
		
			
			String query2 = "SELECT username,amount,time_of_bid FROM Bids JOIN Users ON buyer_id = id WHERE i_id = ?";
			PreparedStatement pstmt2 = con.prepareStatement(query2);
			pstmt2.setString(1, itemID);
		
			ResultSet result2 = pstmt2.executeQuery();
			
			String query3 = "SELECT username FROM Users JOIN Items ON seller_id = id WHERE i_id = ?";
			PreparedStatement prep3 = con.prepareStatement(query3);
			prep3.setString(1, itemID);
			
			ResultSet result3 = prep3.executeQuery();
			result3.next();
			
			%>
	
		<!--  Make an HTML table to show the results in: -->
	<h1 align = "center"> Item Info</h1>	
		
	<table align = "center" border = '1'>
		<tr>    
			<th>Item Name</th>
			<th>Description</th>
			<th>Size</th>
			<th>Current Price</th>
			<th>Auction Ends</th>
			<th>Seller</th>
			</tr>
				<%while(result.next()){
					%>
					<tr>
					<td><%=result.getString(2) %></td>
					<td><%=result.getString(5) %></td>
					<td><%=result.getString(7) %></td>
					<td><%=result.getString(3) %></td>
					<td><%=result.getString(8) %></td>
					<td><%=result3.getString(1) %></td>
					
				<%}%>
	</table>

	
	<h1 align = "center"> Current Bids For This Item</h1>
	
	<table align = "center" border = '1'>
	
	<tr>    
			<th>User</th>
			<th>Amount</th>
			<th>Time Bid Placed</th>
			</tr>
				<%while(result2.next()){
					%>
					<tr>
					<td><%=result2.getString(1) %></td>
					<td><%=result2.getString(2) %></td>
					<td><%=result2.getString(3) %></td>
				<%}%>
	
	
	
	
	</table>
	
	<h1 align = "center"> Make A Bid For This Item</h1>
	
	<form method="post" action="addBid.jsp">
			<table align = "center">
				<tr>    
					<td>Bid Amount</td><td><input type="text" name="bid_amount"></td>
				</tr>
			</table>
		<center><input type="submit" value="Make Bid"></center>
		
		<%
			con.close();
			//close the connection.
			db.closeConnection(con);
			%>
		</form>		
			
		

		<%} catch (Exception e) {
			out.print(e);
		}%>
		
		
		
		
		
</body>
</html>