<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<a href="userLogin.jsp">LogOut </a>
<h1 align = 'center'>Welcome Customer Rep</h1>

<h1 align = 'center'>Answer A Question</h1>


<%
	
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		
		
			
            String query = "SELECT * FROM Questions JOIN Users USING (id) ";
            PreparedStatement pstmt = con.prepareStatement(query);
     // 1 - user id 2 - qid 3 - question 4 - answer 5 username
			ResultSet result = pstmt.executeQuery();
			
     		String query2 = "SELECT * FROM Users";
     		PreparedStatement pstmt2 = con.prepareStatement(query2);
     		ResultSet result2 = pstmt2.executeQuery();
     		
     		String query3 = "SELECT * FROM Bids";
     		PreparedStatement pstmt3 = con.prepareStatement(query3);
     		ResultSet result3 = pstmt3.executeQuery();
     		
     		String query4 = "SELECT * FROM Items";
     		PreparedStatement pstmt4 = con.prepareStatement(query4);
     		ResultSet result4 = pstmt4.executeQuery();
			
			%>
	
		<!--  Make an HTML table to show the results in: -->
	<table align = "center" border = '1'> 
	<tr>
	<th>Question ID</th>
	<th>Username</th>
	<th>Question</th>
	<th> Current Answer </th>
	
	</tr>
	<% while(result.next()){
		%>
		<tr>
		<td><%=result.getString(2) %></td>
		<td><%=result.getString(5) %></td>
		<td><%=result.getString(3) %></td>
		<td><%=result.getString(4) %></td>

	<%}%>
	</table>
	
		<h1 align = 'center'>Enter New Answer</h1>
<br>
		<form method="get" action="crAnswer.jsp">
			<table align = "center">
				<tr>    
					<td>Enter Question ID</td><td><input type="text"  name="question_id"></td>
				</tr>
				<tr>    
					<td>Enter Answer</td><td><input type="text"  name="get_answer"></td>
				</tr>
			</table>
		<center><input type="submit" value="Answer"></center>
		</form>
		
	<br>
	
	<h1 align = 'center'>Delete A User</h1>
	<form method = "post" action = "crModifyUser.jsp">
		<table align = "center" border = '1'> 
	<tr>
	<th>User ID</th>
	<th>Username</th>
	<th>Password</th>
	<th> Delete User</th>
	
	</tr>
	<% while(result2.next()){
		%>
		<tr>
		<td><%=result2.getString(1) %></td>
		<td><%=result2.getString(2) %></td>
		<td><%=result2.getString(3) %></td>
		<td> <button name = "delete_user" type = "submit" value= "<%=result2.getString(1)%>" >Delete</button></td>

	<%}%>
	</table>
	</form>
		<h1 align = 'center'>Modify Username/Password</h1>
<br>
		<form method="get" action="crModifyUser.jsp">
			<table align = "center">
			<tr>    
					<td>Enter Users ID To Be Modified</td><td><input type="text"  name="mod_id"></td>
				</tr>
				<tr>    
					<td>Modify Username</td><td><input type="text"  name="mod_username"></td>
				</tr>
				<tr>    
					<td>Modify Password</td><td><input type="text"  name="mod_password"></td>
				</tr>
			</table>
		<center><input type="submit" value="Submit"></center>
		</form>
		
	<br>
<h1 align = 'center'>Remove Auction</h1>
	<form method = "post" action = "crModifyUser.jsp">
		<table align = "center" border = '1'> 
	<tr>
	<th>Item ID</th>
	<th>Item Name</th>
	<th>Current Price</th>
	<th>Min Price</th>
	<th> Description</th>
	<th> Category</th>
	<th> Size</th>
	<th> Closing Time</th>
	<th> Seller ID</th>
	<th> Winner ID</th>
	<th> Delete Item</th>
	</tr>
	<% while(result4.next()){
		%>
		<tr>
		<td><%=result4.getString(1) %></td>
		<td><%=result4.getString(2) %></td>
		<td><%=result4.getString(3) %></td>
		<td><%=result4.getString(4) %></td>
		<td><%=result4.getString(5) %></td>
		<td><%=result4.getString(6) %></td>
		<td><%=result4.getString(7) %></td>
		<td><%=result4.getString(8) %></td>
		<td><%=result4.getString(9) %></td>
		<td><%=result4.getString(10) %></td>
		<td> <button name = "delete_item" type = "submit" value= "<%=result4.getString(1)%>" >Delete</button></td>

	<%}%>
	</table>
	</form>
	
		<h1 align = 'center'>Remove Bid</h1>
	<form method = "post" action = "crModifyUser.jsp">
		<table align = "center" border = '1'> 
	<tr>
	<th>Bid ID</th>
	<th>Buyer ID</th>
	<th>Item ID</th>
	<th>Bid Amount Placed</th>
	<th> Time Of Bid</th>
	<th> Delete Bid</th>
	
	</tr>
	<% while(result3.next()){
		%>
		<tr>
		<td><%=result3.getString(1) %></td>
		<td><%=result3.getString(4) %></td>
		<td><%=result3.getString(5) %></td>
		<td><%=result3.getString(2) %></td>
		<td><%=result3.getString(3) %></td>
		<td> <button name = "delete_bid" type = "submit" value= "<%=result3.getString(1)%>" >Delete</button></td>

	<%}%>
	</table>
	</form>			
			
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