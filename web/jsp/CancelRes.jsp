<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cancel Reservation Confirmation</title>
</head>
<body>
	<div align="center">
		<h1>Cancel Reservation</h1>
	</div>

	<%!String con_url = "jdbc:mysql://localhost:3306/hotel?autoReconnect=true&useSSL=false";
	String con_user = "root";
	String con_pass = "KAWO";%>

	<%
		String rno = request.getParameter("rno");
		String hid = request.getParameter("hid");

		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(con_url, con_user, con_pass);
		Statement st = con.createStatement();
		int i = st.executeUpdate(
				"delete from reservesroom where HotelID = '" + hid + "' and Room_no = '" + rno + "'");
		if (i > 0) {
			out.println("Successfully cancelled reservation.");
		} else
			out.println("Something went wrong.");
	%>

	<div align="center">
		<form action="logged-in.jsp">
			<input type="submit" value="Back to login page">
		</form>
	</div>

</body>
</html>