<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Sell</title>
</head>
<body>

<a href="HomePage.jsp">Go Back Home </a>
<h1> Sell Item</h1>
	<br>
		<form method="post" action="add_item.jsp">
			<table>
				<tr>
					<td>Item Name</td>
					<td><input type="text" name="item_name"></td>
				</tr>
				<tr>
					<td>Starting Price</td>
					<td><input type="text" name="unit_price"></td>
				</tr>
				<tr>
					<td>Minimum Price</td>
					<td><input type="text" name="min_price"></td>
				</tr>
					<tr>
					<td>Description</td>
					<td><input type="text" name="description"></td>
				</tr>
				<tr>
					<td>Category</td>
					<td><select id="category" name="category">
							<option value="SHIRTS">Shirts</option>
							<option value="PANTS">Pants</option>
							<option value="SHOES">Shoes</option>
						</select>
					</td>
				</tr>
				<tr>
					<td>Category Attribute</td>
					<td><input type="text" name="cat_attribute"></td>
				</tr>
				<tr>    
					<td>Auction End</td>
					<td><input type="datetime-local" id="closing_date_time" name="closing_date_time" step="1"></td>
				</tr>
			</table>
			<input type="submit" value="Post Item">
		</form>
	<br>
</body>
</html>