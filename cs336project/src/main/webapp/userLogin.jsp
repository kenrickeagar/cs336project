<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login - BuyMe</title>
</head>
<body>
	<h1 align = 'center'>User Login</h1>
	<br>
		<form method="get" action="user_pass_lookup.jsp">
			<table align = 'center'>
				<tr>    
					<td>Username</td><td><input type="text" name="user"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="pass"></td>
				</tr>
			</table>
			<center><input type="submit" value="Login"> <td><a href="Register.jsp"> Register Here</a></td></center>
			
			<center><a  href="adminLogin.jsp"> Admin Login Here</a></center>
			<center><a href="customerRepLogin.jsp"> Customer Rep Login Here</a></center>
		</form>
	<br>
</body>
</html>
