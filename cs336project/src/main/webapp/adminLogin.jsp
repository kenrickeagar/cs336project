<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	<h1 align = 'center'>Admin Login</h1>
	<br>
		<form method="get" action="adminLookup.jsp">
			<table align = 'center'>
				<tr>    
					<td>Username</td><td><input type="text" name="user"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="pass"></td>
				</tr>
			</table>
		<center><input type="submit" value="Login"> <td><a href="userLogin.jsp"> User Login</a></td></center>
			
		</form>
	<br>
</body>
</html>