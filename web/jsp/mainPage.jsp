<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%
	request.getSession().setAttribute("pid", 1);
%>
<html>
<head>
<meta charset="UTF-8">
<title>Main Page</title>
</head>
<body>
	<div align="center">
		<h1>
			<b>Hotel Reservation System</b>
		</h1>
	</div>
	<form action="logged-in.jsp" method="POST">
		<div
			style="background-image: url(../images/hotel1.jpg); height: 720px; width: 1240px; border: 1px"
			align="center">
			<table>
				<%
					if (request.getSession().getAttribute("LoginError") != null) {
						if (request.getSession().getAttribute("LoginError").equals(1)) {
				%>
				<div align="center">
				<tr>
					<td>Username</td>
					<td><input type="text" name="username"
						value=<%=(String) request.getSession().getAttribute("username")%>></td>
				</tr>
				</div>
				<%
					}
					} else {
				%>
				<tr>
					<td>Username</td>
					<td><input type="text" name="username"></td>
				</tr>
				<%
					}
				%>
				<%
					if (request.getSession().getAttribute("LoginError") != null) {
						if (request.getSession().getAttribute("LoginError").equals(1)) {
				%>
				<tr>
					<td>Password</td>
					<td><input type="text" name="password"
						value=<%=(String) request.getSession().getAttribute("password")%>></td>
				</tr>
				<%
					}
					} else {
				%>
				<tr>
					<td>Password</td>
					<td><input type="text" name="password"></td>
				</tr>
				<%
					}
				%>
				<tr>
					<td><input type="submit" value="Log In"> <input
						type="submit" value="Sign Up"
						onClick="form.action = 'registration.jsp'" /></td>
				</tr>
				<%
					if (request.getSession().getAttribute("LoginError") != null) {
						if (request.getSession().getAttribute("LoginError").equals(1)) {
				%>
				<tr>
					<td>Incorrect username or password</td>
				</tr>
				<%
					}
					}
				%>
			</table>
		</div>
	</form>
</body>
</html>