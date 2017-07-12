<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="Hotel_Reservation_System.*"%>
<%@ page import="java.util.concurrent.TimeUnit"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>success update</title>
</head>
<body>
	<h1>Information update successful</h1>

	<%!String con_url = "jdbc:mysql://localhost:3306/hotel?autoReconnect=true&useSSL=false";
	String con_user = "root";
	String con_pass = "KAWO";%>

	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(con_url, con_user, con_pass);
			Statement st = con.createStatement();

			String CID = request.getSession().getAttribute("cid").toString();
			System.out.println("CID is " + CID);
			String queryString = null;

			String username1 = request.getParameter("username");
			if (username1 != "") {
				queryString = "update customer set username = '" + username1 + "' where CID = '" + CID + "'";
				st.executeUpdate(queryString);
			}

			String password1 = request.getParameter("password");
			if (password1 != "") {
				queryString = "update customer set password = '" + password1 + "' where CID = '" + CID + "'";
				st.executeUpdate(queryString);
			}

			String firstname = request.getParameter("fname");
			if (firstname != "") {
				queryString = "update customer set first_name = '" + firstname + "' where CID = '" + CID + "'";
				st.executeUpdate(queryString);
			}

			String lastname = request.getParameter("lname");
			if (lastname != "") {
				queryString = "update customer set last_name = '" + lastname + "' where CID = '" + CID + "'";
				st.executeUpdate(queryString);
			}

			String g = null;
			String gender = null;
			gender = request.getParameter("gender");
			if (gender != null) {
				if (gender.equals("male")) {
					g = "M";
				} else if (gender.equals("female")) {
					g = "F";
				}
				queryString = "update customer set gender = '" + g + "' where CID = '" + CID + "'";
				st.executeUpdate(queryString);
			}

			String email = request.getParameter("email");
			if (email != "") {
				System.out.println("email not null");
				queryString = "update customer set Email = '" + email + "' where CID = '" + CID + "'";
				st.executeUpdate(queryString);
			}

			String phone = request.getParameter("phone");
			if (phone != "") {
				System.out.println("phone not null");
				queryString = "update customer set phone_no=" + phone + " where CID = " + CID + "";
				st.executeUpdate(queryString);
			}

			String country = request.getParameter("country");
			if (country != "") {
				queryString = "update customer set country = '" + country + "' where CID = '" + CID + "'";
				st.executeUpdate(queryString);
			}

			String othercountry = request.getParameter("countrylist");
			if (othercountry != "") {
				queryString = "update customer set country = '" + othercountry + "' where CID = '" + CID + "'";
				st.executeUpdate(queryString);
			}

			String street = request.getParameter("street");
			if (street != "") {
				queryString = "update customer set street_address = '" + street + "' where CID = '" + CID + "'";
				st.executeUpdate(queryString);
			}

			String city = request.getParameter("city");
			if (city != "") {
				queryString = "update customer set city = '" + city + "' where CID = '" + CID + "'";
				st.executeUpdate(queryString);
			}

			String state = request.getParameter("state");
			if (state != "") {
				queryString = "update customer set state = '" + state + "' where CID = '" + CID + "'";
				st.executeUpdate(queryString);
			}

			String zip = request.getParameter("zip");
			if (zip != "") {
				queryString = "update customer set zip = '" + zip + "' where CID = '" + CID + "'";
				st.executeUpdate(queryString);
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

	<div align="center">
		<form action="logged-in.jsp">
			<input type="submit" value="Back to login page">
		</form>
	</div>

</body>
</html>