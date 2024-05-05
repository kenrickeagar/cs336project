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

		
			//Query if delete user is pressed
			String delete_user = request.getParameter("delete_user");
			if(delete_user != null && !delete_user.isBlank()){
            String delete_query = "DELETE FROM Users WHERE id = ?";
            PreparedStatement delete_pstmt = con.prepareStatement(delete_query);
            delete_pstmt.setString(1, delete_user);
            delete_pstmt.executeUpdate();
            response.sendRedirect("crHomePage.jsp");
			}
			
			String mod_id = request.getParameter("mod_id");
			String modify_username = request.getParameter("mod_username");
			if(modify_username != null && !modify_username.isBlank()){
	            String modUser_query = "UPDATE Users SET username = ? WHERE id = ?";
	            PreparedStatement modUser_pstmt = con.prepareStatement(modUser_query);
	            modUser_pstmt.setString(1, modify_username);
	            modUser_pstmt.setString(2, mod_id);
	            modUser_pstmt.executeUpdate();
	            response.sendRedirect("crHomePage.jsp");
				}
			
			String modify_password = request.getParameter("mod_password");
			if(modify_password != null && !modify_password.isBlank()){
	            String modPassword_query = "UPDATE Users SET password = ? WHERE id = ?";
	            PreparedStatement modPassword_pstmt = con.prepareStatement(modPassword_query);
	            modPassword_pstmt.setString(1, modify_password);
	            modPassword_pstmt.setString(2, mod_id);
	            modPassword_pstmt.executeUpdate();
	            response.sendRedirect("crHomePage.jsp");
				}
			
			String delete_item = request.getParameter("delete_item");
			if(delete_item != null && !delete_item.isBlank()){
            String deleteItem_query = "DELETE FROM Items WHERE i_id = ?";
            PreparedStatement deleteItem_pstmt = con.prepareStatement(deleteItem_query);
            deleteItem_pstmt.setString(1, delete_item);
            deleteItem_pstmt.executeUpdate();
            response.sendRedirect("crHomePage.jsp");
			}
			
			String delete_bid = request.getParameter("delete_bid");
			if(delete_bid != null && !delete_bid.isBlank()){
            String deleteBid_query = "DELETE FROM Bids WHERE b_id = ?";
            PreparedStatement deleteBid_pstmt = con.prepareStatement(deleteBid_query);
            deleteBid_pstmt.setString(1, delete_bid);
            deleteBid_pstmt.executeUpdate();
            response.sendRedirect("crHomePage.jsp");
			}
			
			%>
	
		<!--  Make an HTML table to show the results in: -->

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