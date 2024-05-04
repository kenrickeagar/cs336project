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
	<%
	
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			
            String query = "SELECT seller_id, SUM(unit_price) AS total_unit_price FROM Items WHERE winner_id IS NOT NULL GROUP BY seller_id;";
            PreparedStatement pstmt = con.prepareStatement(query);
			ResultSet result = pstmt.executeQuery();
			
			%>
	
		<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>    
			<td>
				<%while (result.next()) {
					out.print("<p>Seller " + result.getString("seller_id") + " Total Earnings:</p>");
					out.print("<p>" + result.getString("total_unit_price") + "</p>");
				}
				%>
			</td>
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