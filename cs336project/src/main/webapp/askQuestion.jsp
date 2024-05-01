<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Ask Question</title>
</head>
<body>
<a href="HomePage.jsp">Go Back Home </a>
	<h1 align = "center"> Ask a Question !</h1>
	<br>
		<form method="post" action="postQuestion.jsp">
			<table align = "center">
				<tr>    
					<td>Enter Question</td><td><input type="text"  name="question"></td>
				</tr>
			</table>
		<center><input type="submit" value="Ask"></center>
		</form>
	<br>
	
	<h1 align = "center"> Or Search Existing Question!</h1>
	<br>
		<form method="post" action="searchQuestion.jsp">
			<table align = "center">
				<tr>    
					<td>Enter Question</td><td><input type="text"  name="search_question"></td>
				</tr>
			</table>
		<center><input type="submit" value="Search"></center>
		</form>
	<br>
</body>
</html>