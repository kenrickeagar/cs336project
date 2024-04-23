<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Login</title>
	</head>
	<body>
		<form method="get" action="user_pass_lookup.jsp">
				<table>
					<tr>    
						<td>Username</td><td><input type="text" name="user"></td>
					</tr>
					<tr>
						<td>Password</td><td><input type="text" name="pass"></td>
					</tr>
			</table>
			<input type="submit" value="Login">
		</form>
	</body>
</html>