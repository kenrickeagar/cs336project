<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>View Alerts</title>
</head>
<body>
<a href="HomePage.jsp">Go Back Home </a>
<%
	
		try {
			//Get the database connection
			ApplicationDB db = new ApplicationDB();	
			Connection con = db.getConnection();		

			//Create a SQL statement
			Statement stmt = con.createStatement();
			
			//Alert if they won an auction
            String query = "SELECT i_id, item_name, username,winner_id FROM Items JOIN Users ON id= winner_id WHERE username = ?";
            PreparedStatement pstmt = con.prepareStatement(query);
            String currentUser = (String)session.getAttribute("username");
            if(currentUser == null){
				response.sendRedirect("userLogin.jsp");
		}
            pstmt.setString(1, currentUser);
			ResultSet result = pstmt.executeQuery();
			
			//Query to get id based off username
			String getIDquery = "SELECT id from users where username = ?";
			PreparedStatement idstmt = con.prepareStatement(getIDquery);
			idstmt.setString(1, currentUser);
			ResultSet resultid = idstmt.executeQuery();
			resultid.next();
			String currentID = resultid.getString(1);
			
			//Alert if somebody placed a higher bid on their manual bid
			
			String query2 = "SELECT i_id, item_name,unit_price, MAX(amount) as maxBID from bids join items using (i_id) where buyer_id = ? group by i_id having maxBID<unit_price";
			PreparedStatement pstmt2 = con.prepareStatement(query2);
			pstmt2.setString(1, currentID);
			ResultSet result2 = pstmt2.executeQuery();
			
			//Alert if somebody placed a higher bid on their max auto bid limit
			String query3 = "SELECT i_id, item_name,unit_price, amount,id from auto_bids join items using (i_id) where id = ? having unit_price > amount";
			PreparedStatement pstmt3 = con.prepareStatement(query3);
			pstmt3.setString(1, currentID);
			ResultSet result3 = pstmt3.executeQuery();
			
			//Alert if somebody set an alert for an item to become avilible
			String query4 = "SELECT i_id, item_name,cid from items join item_alert on item_name like concat('%',item_description,'%') where id = ?";
			PreparedStatement pstmt4 = con.prepareStatement(query4);
			pstmt4.setString(1, currentID);
			ResultSet result4 = pstmt4.executeQuery();		
			%>
	
	<table align="center" border = '1'>
	
		<%while(result.next()){ %>
			<tr>
				<td>
					<p> ALERT CONGRATULATIONS YOU WON THE AUCTION FOR: <%=result.getString(2)%></p>
		
	<%} %>
	</table>
<table align="center" border = '1'>
	
		<%while(result2.next()){ %>
			<tr>
				<td>
					<p> ALERT SOMEBODY PLACED A HIGHER BID ON ITEM: <%=result2.getString(2)%></p>
		
	<%} %>
	</table>
	
	<table align="center" border = '1'>
	
		<%while(result3.next()){ %>
			<tr>
				<td>
					<p> ALERT SOMEBODY PLACED A HIGHER THEN THE LIMIT ON YOUR AUTO BID FOR:<%=result3.getString(2)%></p>
		
	<%} %>
	</table>
	
	<table align="center" border = '1'>
	
		<%while(result4.next()){ %>
			<tr>
				<td>
					<p> ALERT ITEM :<%=result4.getString(2)%> IS NOW AVAILABLE</p>
		
	<%} %>
	</table>
			
		<%} catch (Exception e) {
			out.print(e);
		}%>
</body>
</html>