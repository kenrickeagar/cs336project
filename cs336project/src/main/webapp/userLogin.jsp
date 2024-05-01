<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login - BuyMe</title>
</head>
<body>
	Login Here
	<br>
		<form method="get" action="user_pass_lookup.jsp">
			<table>
				<tr>    
					<td>Username</td><td><input type="text" name="user"></td>
				</tr>
				<tr>
					<td>Password</td><td><input type="text" name="pass"></td>
				</tr>
			</table>
			<input type="submit" value="Login"> <td><a href="Register.jsp"> Register Here</a></td>
		</form>
	<br>
</body>
</html>
