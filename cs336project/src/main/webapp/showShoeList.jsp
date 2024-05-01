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
<a href="HomePage.jsp">Go Back Home </a>
<%
			
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Make a SELECT query from the table specified by the 'command' parameter at the index.jsp
			String sort_by = request.getParameter("sort_by");
			String search_shoes = request.getParameter("search_shoes");
			String str;
			ResultSet result = null;
			if(search_shoes != null ){
				
				str = "SELECT * FROM Items WHERE cid = 'SHOES' AND item_name LIKE CONCAT('%',?,'%')";
				PreparedStatement pstmt = con.prepareStatement(str);
			    pstmt.setString(1, search_shoes);
				 result = pstmt.executeQuery();
						}else{
			if(sort_by == null || sort_by.isBlank() || sort_by.isEmpty() || sort_by.equals("No Selection")){
				str = "SELECT * FROM Items WHERE cid = ?";
				PreparedStatement pstmt = con.prepareStatement(str);
	            pstmt.setString(1, "SHOES");
				 result = pstmt.executeQuery();
			}
			else if(sort_by.equals("unit_price ASC")){
				str = "SELECT * FROM Items WHERE cid = 'SHOES' ORDER BY unit_price ASC ";
				PreparedStatement pstmt = con.prepareStatement(str);
				 result = pstmt.executeQuery();
			} else if(sort_by.equals("unit_price DESC")){
				str = "SELECT * FROM Items WHERE cid = 'SHOES' ORDER BY unit_price DESC ";
				PreparedStatement pstmt = con.prepareStatement(str);
				 result = pstmt.executeQuery();
			}else if(sort_by.equals("item_name")){
				str = "SELECT * FROM Items WHERE cid = 'SHOES' ORDER BY item_name ";
				PreparedStatement pstmt = con.prepareStatement(str);
				 result = pstmt.executeQuery();
			}else if(sort_by.equals("subcatAttribute ASC")){
				str = "SELECT * FROM Items WHERE cid = 'SHOES' ORDER BY subcatAttribute ASC";
				PreparedStatement pstmt = con.prepareStatement(str);
				 result = pstmt.executeQuery();
			}else if(sort_by.equals("subcatAttribute DESC")){
				str = "SELECT * FROM Items WHERE cid = 'SHOES' ORDER BY subcatAttribute DESC";
				PreparedStatement pstmt = con.prepareStatement(str);
				 result = pstmt.executeQuery();
			}
			
						}
	%>
	
	
		<br>
		<form method="get" action="showShoeList.jsp">
			<table align = 'center'>
				<tr>
					<td>Sort By</td>
					<td><select id="sort_by" name="sort_by">
							<option value="No Selection">No Selection</option>
							<option value="unit_price ASC">Price (Ascending)</option>
							<option value="unit_price DESC">Price (Descending)</option>
							<option value="item_name">Alphabetical Order</option>
							<option value="subcatAttribute ASC">Size (Ascending)</option>
							<option value="subcatAttribute DESC">Size (Descending)</option>
						</select>
					</td>
				</tr>
			</table>			
			<center><input type="submit" value="Sort"></center>
		</form>
	<br>
	
	<br>
		<form method="post" action="showShoeList.jsp">
			<table align = "center">
				<tr>    
					<td>Enter Keyword</td><td><input type="text"  name="search_shoes"></td>
				</tr>
			</table>
		<center><input type="submit" value="Search"></center>
		</form>
	<br>
	
	<form method = "post" action = "showSelectedItem.jsp">
	<table align = "center" border = '1'> 
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