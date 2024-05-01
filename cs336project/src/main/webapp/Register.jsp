<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration Page</title>
</head>
<body>
<h1 align = 'center'>Register Here</h1>
	<br>
		<form method="post" action="register_adder.jsp">
			<table align = 'center'>
				<tr>    
					<td>Username</td><td><input type="text" name="user"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="pass"></td>
				</tr>
			</table>
			<center><input type="submit" value="Register"> <a href="userLogin.jsp"> User Login</a></center>
		</form>
	<br>
</body>
</html>