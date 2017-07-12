<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Sample</title>
</head>
<body>

SAMPLE

<form action="test1.html">
    <input type="submit" value="Go to Test1 Page" />
</form>

<form action="test2.html">
    <input type="submit" value="Go to Test2 Page" />
</form>

<form action="test3.html">
    <input type="submit" value="Go to Test3 Page" />
</form>


<% 

try {
	Class.forName("com.mysql.jdbc.Driver");
	Connection myConn = DriverManager.getConnection("jdbc:mysql://localhost:3306/hotel_reservation_system?autoReconnect=true&useSSL=false","root","group10");
	Statement myStatement = myConn.createStatement();
	/*myStatement.execute("insert into customer values (200, 'yo@gmail.com', '456 rutgers', 555555555, 'dog')");
	myStatement.execute("insert into customer values (300, 'HEYYYY@gmail.com', '1010 rutgers', 998753, 'cat')"); */
	ResultSet myRs = myStatement.executeQuery("select Type from hasofferroomisaroom");

	while (myRs.next()) {
		//out.println(myRs.getString("Email") + ", " + myRs.getString("name"));
		out.println(myRs.getString("Type"));
	}
} 

catch (Exception e){
	e.printStackTrace();
}

%>
</body>
</html>