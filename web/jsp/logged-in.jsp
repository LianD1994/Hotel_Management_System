<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="Hotel_Reservation_System.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<%!String con_url = "jdbc:mysql://localhost:3306/hotel?autoReconnect=true&useSSL=false";
	String con_user = "root";
	String con_pass = "KAWO";%>

<%
	//List for keeping track of all the info before payment
	ArrayList<resInfo> resInfoList = new ArrayList<>();
	request.getSession().setAttribute("resInfoList", resInfoList);

	if (request.getSession().getAttribute("pid").equals(1)) {
		request.getSession().setAttribute("pid", 3);
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(con_url, con_user, con_pass);
		Statement st = con.createStatement();
		ResultSet resultSet = st.executeQuery("select * from customer");
		boolean userExist = false;
		while (resultSet.next()) {
			String uname = resultSet.getString("username");
			if (username != null) {
				if (username.equals(uname)) {
					if (password.equals(resultSet.getString("password"))) {
						userExist = true;
						request.getSession().setAttribute("cid", resultSet.getInt("CID"));
					}
					break;
				}
			}
		}
		if (!userExist) {
			response.sendRedirect("mainPage.jsp");
			request.getSession().setAttribute("LoginError", 1);
			request.getSession().setAttribute("username", username);
			request.getSession().setAttribute("password", password);
		} else {
			int cid = (int) request.getSession().getAttribute("cid");
			resultSet = st.executeQuery("select first_name from customer where CID = '" + cid + "'");

			if (resultSet.next()) {
				String first_name = resultSet.getString("first_name");
				out.println("<div align='center'><h1>Welcome to the Hotel Reservation System, " + first_name + " !</h></div>");
			}
		}
	} else if (request.getSession().getAttribute("pid").equals(2)) {
		request.getSession().setAttribute("pid", 3);
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(con_url, con_user, con_pass);
		Statement st = con.createStatement();
		ResultSet resultSet = st.executeQuery("select* from customer");
		boolean userExist = false;
		while (resultSet.next()) {
			String uname = resultSet.getString("username");
			if (username != null) {
				if (username.equals(uname)) {
					userExist = true;
					request.getSession().setAttribute("cid", resultSet.getInt("CID"));
					break;
				}
			}
		}
		int cid = (int) request.getSession().getAttribute("cid");
		resultSet = st.executeQuery("select first_name from customer where CID = '" + cid + "'");

		if (resultSet.next()) {
			String first_name = resultSet.getString("first_name");
			out.println("<div align='center'><h1>Welcome to the Hotel Reservation System, " + first_name + " !</h></div>");
		}
		if (userExist) {
			System.out.println("Username already taken");
			request.getSession().setAttribute("registrationerror", 0);
			response.sendRedirect("registration.jsp");
		} else {
			String username1 = request.getParameter("username");
			String password1 = request.getParameter("password");
			String firstname = request.getParameter("fname");
			String lastname = request.getParameter("lname");
			String g = null;
			String gender = null;
			gender = request.getParameter("gender");
			if (gender == null) {
				System.out.println("Must choose gender");
				request.getSession().setAttribute("registrationerror", 1);
				response.sendRedirect("registration.jsp");
			} else {
				if (gender.equals("male")) {
					g = "M";
				} else if (gender.equals("female")) {
					g = "F";
				}
				String email = request.getParameter("email");
				String phone = request.getParameter("phone");
				String country = request.getParameter("country");
				String othercountry = request.getParameter("countrylist");
				String street = request.getParameter("street");
				String city = request.getParameter("city");
				String state = request.getParameter("state");
				String zip = request.getParameter("zip");
				if (country == null) {
					System.out.println("Must choose country");
					request.getSession().setAttribute("registrationerror", 2);
					response.sendRedirect("registration.jsp");
				} else if (city == null) {
					System.out.println("City can't be null");
					request.getSession().setAttribute("registrationerror", 4);
					response.sendRedirect("registration.jsp");
				} else if (country.equals("us") && (street == null || zip == null || state == null)) {
					System.out.println("Must complete all address fields");
					request.getSession().setAttribute("registrationerror", 5);
					response.sendRedirect("registration.jsp");
				} else {
					String query_string = null;
					if (country == "us") {
						query_string = "insert into customer values (NULL, '" + firstname + "', '" + lastname
								+ "', '" + g + "', '" + country + "', '" + street + "', '" + state + "', '"
								+ city + "', '" + zip + "', '" + email + "', '" + phone + "', '" + username1
								+ "', '" + password1 + "')";
					} else {
						query_string = "insert into customer values (NULL, '" + firstname + "', '" + lastname
								+ "', '" + g + "', '" + othercountry + "', '" + street + "', '" + state + "', '"
								+ city + "', '" + zip + "', '" + email + "', '" + phone + "', '" + username1
								+ "', '" + password1 + "')";
					}
					int i = st.executeUpdate(query_string);
					if (i > 0) {
						System.out.println("Success");
						out.println("<div align='center'><h1>Welcome to the Hotel Reservation System, " + firstname + " !</h></div>");
					} else {
						System.out.println("Failed");
					}
				}
			}
		}
	} else if (request.getSession().getAttribute("pid").equals(3)) {
		Class.forName("com.mysql.jdbc.Driver");
		Connection con = DriverManager.getConnection(con_url, con_user, con_pass);
		Statement st = con.createStatement();
		ResultSet resultSet = st.executeQuery("select* from customer");
		int cid = (int) request.getSession().getAttribute("cid");
		resultSet = st.executeQuery("select first_name from customer where CID = '" + cid + "'");

		if (resultSet.next()) {
			String first_name = resultSet.getString("first_name");
			out.println("<div align='center'><h1>Welcome to the Hotel Reservation System, " + first_name + " !</h></div>");
		}
	}
%>
<html>
<head>
<title>logged-in</title>
</head>
<body>
	<div align="center">
		<form action="/jsp/makeReservation.jsp">
			<input type="submit" value="Make reservation">
		</form>
		<form action="/jsp/manageReservation.jsp">
			<input type="submit" value="Manage reservation">
		</form>
		<form action="/jsp/updateInfo.jsp">
			<input type="submit" value="Update Info">
		</form>
		</br> <input type="button" value="Sign Out"
			onClick="window.location = 'mainPage.jsp';">
	</div>
</body>
</html>