<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime,java.time.format.DateTimeFormatter"%>
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
			ResultSet result = pstmt.executeQuery(); //iid query info
		
			
			String autoQuery = "SELECT amount, increment,prev_price,id,i_id,unit_price FROM Items JOIN Auto_Bids USING (i_id) WHERE i_id = ?";
			PreparedStatement prepAuto = con.prepareStatement(autoQuery);
			prepAuto.setString(1, itemID);
			ResultSet autoResult = prepAuto.executeQuery(); //get list of autobids 
			//max_amount = 1 increment = 2 pre_price = 3 uid = 4 i_id = 5 unit price = 6
			while(autoResult.next()){
				Double actual_price = Double.parseDouble(autoResult.getString(6)) ;
				Double prev_price = Double.parseDouble(autoResult.getString(3));
				Double max_amount = Double.parseDouble(autoResult.getString(1));
				Double increment = Double.parseDouble(autoResult.getString(2));
				if(prev_price < actual_price){ //if somebody bid higher than us the current iid price will be greater than our stored price
					if(actual_price < max_amount){ //if somebody bid higher create a new bid and add it
						String makeNewBid = "INSERT INTO Bids(amount,time_of_bid,buyer_id,i_id) VALUES (?,?,?,?)";
						PreparedStatement addme = con.prepareStatement(makeNewBid);
						addme.setString(1,Double.toString(actual_price + increment));
						DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd hh:mm:ss");
			            LocalDateTime.now().format(formatter);
			            addme.setTimestamp(2,Timestamp.valueOf(LocalDateTime.now().format(formatter)));
						addme.setString(3,autoResult.getString(4));
						addme.setString(4,itemID);
						addme.executeUpdate();
						
						//now update the autobid with new prev_price value
						String updatePriceQuery = "UPDATE Auto_Bids SET prev_price = ? WHERE id = ?";
						PreparedStatement updateMe = con.prepareStatement(updatePriceQuery);
						updateMe.setString(1,Double.toString(actual_price + increment));
						updateMe.setString(2,autoResult.getString(4));
						updateMe.executeUpdate();
						
						String updateBid = "UPDATE Items SET unit_price = ? WHERE i_id = ?";
			            PreparedStatement upBid = con.prepareStatement(updateBid);
			            upBid.setString(1, Double.toString(actual_price + increment));
			            upBid.setString(2, itemID);
						upBid.executeUpdate();
					}
				}
			}
			

			
			String query2 = "SELECT username,amount,time_of_bid FROM Bids JOIN Users ON buyer_id = id WHERE i_id = ?";
			PreparedStatement pstmt2 = con.prepareStatement(query2);
			pstmt2.setString(1, itemID);
		
			ResultSet result2 = pstmt2.executeQuery(); //bid information
			
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
		
	<h1 align = "center"> Make An Automatic Bid For This Item</h1>	
	<form method="post" action="addAutoBid.jsp">
			<table align = "center">
				<tr>    
					<td>Max Bid Amount</td><td><input type="text" name="max_bid"></td>
				</tr>
					<td>Increment</td><td><input type="text" name="increment_bid"></td>
				<tr> </tr>
			</table>
		<center><input type="submit" value="Make Automatic Bid"></center>
		
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