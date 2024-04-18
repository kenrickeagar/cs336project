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
			
			String itemID = request.getParameter("i_id");
		
		
			
            String query = "SELECT * FROM Items WHERE i_id = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, itemID);
			ResultSet result = pstmt.executeQuery();
			
			%>
	
		<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>    
			<th>Item Name</th>
			<th>Price</th>
			<th>Description</th>
			</tr>
				<%while(result.next()){
					%>
					<tr>
					<td><%=result.getString(2) %></td>
					<td><%=result.getString(3) %></td>
					<td><%=result.getString(4) %></td>
					
				<%}%>
				
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