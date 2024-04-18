<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Item List</title>
</head>
<body>
<%
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String str = "SELECT * FROM items where cid = ? ";
			//Run the query against the database.
			PreparedStatement pstmt = con.prepareStatement(str);
            pstmt.setString(1, "PANTS");
			ResultSet result = pstmt.executeQuery();
	%>
	
	<form method = "post" action = "showSelectedItem.jsp">
	<table border = '1'> 
	<tr>
	<th>Item Name</th>
	<th> Unit Price </th>
	<th> See Item </th>
	</tr>
	<% while(result.next()){
		%>
		<tr>
		<td><%=result.getString(2) %></td>
		<td><%=result.getString(3) %></td>
		<td> <button name = "i_id" type = "submit" value= "<%=result.getString(1) %>" >SeeItem</button></td>
		
		
	<%}%>
	
	
	</table>

	</form>
	
</body>
</html>