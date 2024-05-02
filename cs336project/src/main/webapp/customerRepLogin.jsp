<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<h1 align = 'center'>Customer Rep Login</h1>
	<br>
		<form method="get" action="crLookup.jsp">
			<table align = 'center'>
				<tr>    
					<td>Username</td><td><input type="text" name="user"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="pass"></td>
				</tr>
			</table>
			<center><input type="submit" value="Login"> <a href="crLookup.jsp"> User Login</a></center>
			
		</form>
	<br>
</body>
</html>