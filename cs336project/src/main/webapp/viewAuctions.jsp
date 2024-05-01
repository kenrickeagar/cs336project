<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.time.LocalDateTime,java.time.format.DateTimeFormatter"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<a href="HomePage.jsp">Go Back Home </a>
	<br>
		<form method="get" action="viewAuctions.jsp">
			<table align = 'center'>
				<tr>
					<td>Sort By</td>
					<td><select id="view_auctions" name="view_auctions">
							<option value="All Bids">See All Bids</option>
							<option value="All Bids (Sorted)">See All Bids (Sorted)</option>
							<option value="My Bids">See My Bids</option>
							<option value="My Bids(sorted)">My Bids (Sorted)</option>
						</select>
					</td>
				</tr>
			</table>			
			<center><input type="submit" value="Submit"></center>
		</form>
	<br>
	<br>
		<form method="get" action="viewAuctions.jsp">
			<table align = "center">
				<tr>    
					<td>Enter Username</td><td><input type="text"  name="search_user"></td>
				</tr>
			</table>
		<center><input type="submit" value="Search"></center>
		</form>
	<br>
	<%
	
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			String username = (String)session.getAttribute("username");
			if(username == null){
				response.sendRedirect("userLogin.jsp");
			}
            String query = "SELECT id FROM Users WHERE username = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, username);
			ResultSet result = pstmt.executeQuery();
			result.next();
			String currID = result.getString(1);
			
			
			String dd_menu = request.getParameter("view_auctions");
			String search_user = request.getParameter("search_user");
			String str;
			ResultSet result2 = null;
			
			if(dd_menu == null || dd_menu.equals("All Bids")){
				str = "SELECT username, item_name, amount, time_of_bid from bids join items using (i_id) join users on buyer_id = id";
				PreparedStatement pstmt2 = con.prepareStatement(str);
				result2 = pstmt2.executeQuery();
			} else if(dd_menu.equals("All Bids (Sorted)")){
					str = "SELECT username, item_name, amount, time_of_bid from bids join items using (i_id) join users on buyer_id = id ORDER BY username";
					PreparedStatement pstmt2 = con.prepareStatement(str);
					result2 = pstmt2.executeQuery();
				
			} else if(dd_menu.equals("My Bids")){
				str="SELECT buyer_id,username, item_name, amount, time_of_bid from bids join items using (i_id) join users on buyer_id = id WHERE buyer_id = ? ";
				PreparedStatement pstmt2 = con.prepareStatement(str);
				pstmt2.setString(1, currID);
				result2 = pstmt2.executeQuery();
			}else if(dd_menu.equals("My Bids(sorted)")){
				str="SELECT buyer_id,username, item_name, amount, time_of_bid from bids join items using (i_id) join users on buyer_id = id WHERE buyer_id = ? ORDER BY item_name";
				PreparedStatement pstmt2 = con.prepareStatement(str);
				pstmt2.setString(1, currID);
				result2 = pstmt2.executeQuery();
			} 
			
			if(search_user != null){
				str = "SELECT username, item_name, amount, time_of_bid from bids join items using (i_id) join users on buyer_id = id WHERE username = ?";
				PreparedStatement pstmt2 = con.prepareStatement(str);
				pstmt2.setString(1, search_user);
				result2 = pstmt2.executeQuery();
			}	
			
			
			%>
	<table align = "center" border = '1'>
		<tr>    
			<th>Username</th>
			<th>Item Name</th>
			<th>Bid Amount</th>
			<th>Time Of Bid</th>
			</tr>
				<%while(result2.next()){
					%>
					<tr>
					<td><%=result2.getString(1) %></td>
					<td><%=result2.getString(2) %></td>
					<td><%=result2.getString(3) %></td>
					<td><%=result2.getString(4) %></td>
					
					
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