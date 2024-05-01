<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Alert - BuyMe</title>
</head>
<body>
<a href="HomePage.jsp">Go Back Home </a>
<h1 align = "center"> Enter An Item Name To Be Alerted When Its Available!</h1>
	<br>
		<form method="post" action="addAlert.jsp">
			<table align = "center">
				<tr>    
					<td>Enter Here</td><td><input type="text"  name="item_alert"></td>
				</tr>
			</table>
		<center><input type="submit" value="Send Alert"></center>
		</form>
	<br>
</body>
</html>
