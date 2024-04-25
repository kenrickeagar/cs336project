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
			
			String item_name = request.getParameter("item_name");
			String min_price = request.getParameter("min_price");
			String start_price = request.getParameter("unit_price");
			String description = request.getParameter("description");
			String category = request.getParameter("category");
			String cat_attribute = request.getParameter("cat_attribute");
			String auction_end = request.getParameter("closing_date_time");
		
			
            String query = "INSERT INTO Items (item_name, min_price, description, cid, subcatAttribute, closing_date_time,unit_price ) VALUES (?, ?, ?, ?, ?, ?, ?);";
            PreparedStatement pstmt = con.prepareStatement(query);
            pstmt.setString(1, request.getParameter("item_name"));
            pstmt.setString(2, request.getParameter("min_price"));
            pstmt.setString(3, request.getParameter("description"));
            pstmt.setString(4, request.getParameter("category"));
            pstmt.setString(5, request.getParameter("cat_attribute"));
            pstmt.setString(6, request.getParameter("closing_date_time"));
            pstmt.setString(7, request.getParameter("unit_price"));
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                // Insert successful
                response.sendRedirect("HomePage.jsp");
            } else {
                // Insert failed
				response.sendRedirect("Sell.jsp");
            }
			
			%>
	
		<!--  Make an HTML table to show the results in: -->
	<table>
		<tr>    
			<td>

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