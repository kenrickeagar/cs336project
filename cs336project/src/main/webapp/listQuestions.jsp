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
			
			String itemID = request.getParameter("i_id");
			session.setAttribute("itemID", itemID);
		
			
            String query = "SELECT username, question, answer FROM Questions JOIN Users USING (id)";
            PreparedStatement pstmt = con.prepareStatement(query);
			ResultSet result = pstmt.executeQuery();
		
			
			%>
	
		<!--  Make an HTML table to show the results in: -->
	<h1 align = "center"> Item Info</h1>	
		
	<table align = "center" border = '1'>
		<tr>    
			<th>Username</th>
			<th>Question</th>
			<th>Answer</th>
			</tr>
				<%while(result.next()){
					%>
					<tr>
					<td><%=result.getString(1) %></td>
					<td><%=result.getString(2) %></td>
					
					<%if(result.getString(3) == null || result.getString(3).isEmpty()){
						%>
						<td><%="Not Answered Yet" %></td>
					<% }else{
					%>
					<td><%=result.getString(3) %></td>
					<%} %>
					
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