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
		
			
           
			
			//This big chunck is for the autoBid feature everything here currently works
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
			} //end of autobid feature
			

			 String query = "SELECT * FROM Items WHERE i_id = ?";
	            PreparedStatement pstmt = con.prepareStatement(query);
	            pstmt.setString(1, itemID);
				ResultSet result = pstmt.executeQuery(); //iid query info
				
			String query2 = "SELECT username,amount,time_of_bid FROM Bids JOIN Users ON buyer_id = id WHERE i_id = ?";
			PreparedStatement pstmt2 = con.prepareStatement(query2);
			pstmt2.setString(1, itemID);
		
			ResultSet result2 = pstmt2.executeQuery(); //bid information
			
			String query3 = "SELECT username FROM Users JOIN Items ON seller_id = id WHERE i_id = ?";
			PreparedStatement prep3 = con.prepareStatement(query3);
			prep3.setString(1, itemID);
			
			ResultSet result3 = prep3.executeQuery();
			result3.next();
			
			
			result.next();
			DateTimeFormatter formatter1 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
			boolean isOpen = true; //will represent if auction is open or not
			if(Timestamp.valueOf(LocalDateTime.now().format(formatter1)).after(Timestamp.valueOf(result.getString(8)))){
				isOpen = false; 
			}
			
			String getWinnerQuery = "SELECT buyer_id,username, amount from bids join users on buyer_id = id where amount = (select max(amount) from bids where i_id = ?)";
			 PreparedStatement wpstmt = con.prepareStatement(getWinnerQuery);
			 wpstmt.setString(1, itemID);
			ResultSet winnerResult = wpstmt.executeQuery(); //winner query info has buyer id and highest bid amount
			winnerResult.next(); //results from query
			
			
			String similarQuery = "SELECT item_name, description, subcatAttribute,unit_price FROM items WHERE cid = ? AND subcatAttribute = ? AND i_id <> ?";
			PreparedStatement spstmt = con.prepareStatement(similarQuery);
			 spstmt.setString(1, result.getString(6));
			 spstmt.setString(2, result.getString(7));
			 spstmt.setString(3, result.getString(1));
			 ResultSet similarResult = spstmt.executeQuery();
			%>
			
		<!--  Make an HTML table to show the results in: -->
	<%if(!isOpen){ //if the auction is NOT open display the correct title
		%>
		<h1 align = "center"> Item Info: AUCTION CLOSED</h1>
		<% } else{%>
	<h1 align = "center"> Item Info</h1>	
	<% } %>
		
	<table align = "center" border = '1'>
		<tr>    
			<th>Item Name</th>
			<th>Description</th>
			<th>Size</th>
			<th>Current Price</th>
			<th>Auction Ends</th>
			<th>Seller</th>
			</tr>
				
					<tr>
					<td><%=result.getString(2) %></td>
					<td><%=result.getString(5) %></td>
					<td><%=result.getString(7) %></td>
					<td><%=result.getString(3) %></td>
					<td><%=result.getString(8) %></td>
					<td><%=result3.getString(1) %></td>
					
				
	</table>

	
	<h1 align = "center">Bids For This Item</h1>
	
	<table align = "center" border = '1'>
	
	<tr>    
			<th>User</th>
			<th>Amount</th>
			<th>Time Bid Placed</th>
			</tr>
				<%while(result2.next()){ //Go through the cols of the item query
					%>
					<tr>
					<td><%=result2.getString(1) %></td>
					<td><%=result2.getString(2) %></td>
					<td><%=result2.getString(3) %></td>
				<%}%>
	
	
	</table>
	
	
	<%if(!isOpen){ // if the auction is not open display the winner information%>
	
	<%if(Double.parseDouble(winnerResult.getString(3)) < Double.parseDouble(result.getString(4))){%>
	<h1 align = "center">NO AUCTION WINNER MIN PRICE NOT SATISFIED</h1>
	
	<%} else {%>
		<h1 align = "center">AUCTION WINNER</h1>
		
		<table align = "center" border = '1'>
		<tr>    
			<th>User</th>
			<th>Winning Amount</th>
			
			<tr>
					<td><%=winnerResult.getString(2) %></td>
					<td><%=winnerResult.getString(3) %></td>
					
		</tr>
		
		
		</table>
		<% String updateItemWinnerQuery = "UPDATE Items SET winner_id = ? WHERE i_id = ? "; // update the winner of the item
		PreparedStatement upItemWinner = con.prepareStatement(updateItemWinnerQuery);
		upItemWinner.setString(1, winnerResult.getString(1));
		upItemWinner.setString(2, itemID);
		upItemWinner.executeUpdate();
		
		%>
	<%}
	
	} else{//if auction IS STILL open display the regular item info%>
	
	
	
	<h1 align = "center"> Make A Bid For This Item</h1>
	
	<form method="post" action="addBid.jsp">
			<table align = "center">
				<tr>    
					<td>Bid Amount</td><td><input type="text" name="bid_amount"></td>
				</tr>
			</table>
		<center><input type="submit" value="Make Bid"></center>
		
	
			
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
		</form>
	<%} // end of item info you can input other table below this%>	
		
	<h1 align = "center">Similar Items</h1>	
		<table align = "center" border = '1'>
	<tr>    
			<th>Item Name</th>
			<th>Description</th>
			<th>Size</th>
			<th>Price</th>
			</tr>
				<%while(similarResult.next()){ //Go through the cols of the item query
					%>
					<tr>
					<td><%=similarResult.getString(1) %></td>
					<td><%=similarResult.getString(2) %></td>
					<td><%=similarResult.getString(3) %></td>
					<td><%=similarResult.getString(4) %></td>
				<%}%>
	
	
	</table>
		
		
		
		
		
		
		
		
		
		
		
		
		
		
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
