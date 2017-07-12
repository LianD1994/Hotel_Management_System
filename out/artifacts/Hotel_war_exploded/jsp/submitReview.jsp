<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Submit Review</title>
</head>
<body>



	<%!String con_url = "jdbc:mysql://localhost:3306/hotel?autoReconnect=true&useSSL=false";
	String con_user = "root";
	String con_pass = "KAWO";
	int isRoomReview = 0;
	int isBreakfastReview = 0;
	int isServiceReview = 0;%>

	<%
		int cid = (int) request.getSession().getAttribute("cid");
		System.out.println(cid);
		String roomrev = request.getParameter("roomrev");
		String roomrating = request.getParameter("roomrating");
		if (roomrev != null) {
			isRoomReview = 1;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(con_url,con_user,con_pass);
				Statement st = con.createStatement();

				int i = st.executeUpdate("insert into writtenroombreakfastservicereview values (null, '"
						+ roomrating + "', '" + roomrev + "', '" + isRoomReview + "', null, null, '" + cid + "')");
				ResultSet rs = st.executeQuery(
						"select max(ReviewID) from writtenroombreakfastservicereview where CID = '" + cid + "'");
				int rid = 0;
				if (rs.next()) {
					rid = rs.getInt("max(ReviewID)");
				}
				rs = st.executeQuery(
						"select Room_no from reservesroom r, makesreservation m where m.InvoiceNo = r.InvoiceNo");
				int room_no = 0;
				if (rs.next()) {
					room_no = rs.getInt("Room_no");
				}
				rs = st.executeQuery(
						"select HotelID from reservesroom r, makesreservation m where m.InvoiceNo = r.InvoiceNo");
				int hid = 0;
				if (rs.next()) {
					hid = rs.getInt("HotelID");
				}
				int j = st.executeUpdate(
						"insert into evaluatesroom value('" + rid + "', '" + hid + "', '" + room_no + "' )");

				if (i > 0 && j > 0) {
					out.println("Thank you for your feedback.");
				} else {
					out.println("Something went wrong.");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}

		String breakfastrev = request.getParameter("breakfastrev");
		String breakfastrating = request.getParameter("breakfastrating");
		if (breakfastrev != null) {
			isBreakfastReview = 1;
			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(con_url,con_user,con_pass);
				Statement st = con.createStatement();

				int i = st.executeUpdate(
						"insert into writtenroombreakfastservicereview values (null, '" + breakfastrating + "', '"
								+ breakfastrev + "', null, '" + isBreakfastReview + "', null, '" + cid + "')");
				ResultSet rs = st.executeQuery(
						"select max(ReviewID) from writtenroombreakfastservicereview where CID = '" + cid + "'");
				int rid = 0;
				if (rs.next()) {
					rid = rs.getInt("max(ReviewID)");
				}
				rs = st.executeQuery(
						"select bType from includesbreakfast b, makesreservation m where m.InvoiceNo = b.InvoiceNo");
				String bType = null;
				if (rs.next()) {
					bType = rs.getString("bType");
				}
				rs = st.executeQuery(
						"select HotelID from includesbreakfast b, makesreservation m where m.InvoiceNo = b.InvoiceNo");
				int hid = 0;
				if (rs.next()) {
					hid = rs.getInt("HotelID");
				}
				int j = st.executeUpdate(
						"insert into assesesbreakfast value('" + rid + "', '" + hid + "', '" + bType + "' )");

				if (i > 0 && j > 0) {
					out.println("Thank you for your feedback.");
				} else {
					out.println("Something went wrong.");
				}
			} catch (Exception e) {
				e.printStackTrace();

			}
		}

		String servicerev = request.getParameter("servicerev");
		System.out.println("this is servicerev: " + servicerev);
		String servicerating = request.getParameter("servicerating");
		if (servicerev != null) {
			isServiceReview = 1;

			try {
				Class.forName("com.mysql.jdbc.Driver");
				Connection con = DriverManager.getConnection(con_url,con_user,con_pass);
				Statement st = con.createStatement();

				int i = st.executeUpdate(
						"insert into writtenroombreakfastservicereview values (null, '" + servicerating + "', '"
								+ servicerev + "', null, null, '" + isServiceReview + "', '" + cid + "')");
				ResultSet rs = st.executeQuery(
						"select max(ReviewID) from writtenroombreakfastservicereview where CID = '" + cid + "'");
				int rid = 0;
				if (rs.next()) {
					rid = rs.getInt("max(ReviewID)");
				}
				rs = st.executeQuery(
						"select sType from containsService s, makesreservation m where m.InvoiceNo = s.InvoiceNo");
				String sType = null;
				if (rs.next()) {
					sType = rs.getString("sType");
				}
				rs = st.executeQuery(
						"select HotelID from containsService s, makesreservation m where m.InvoiceNo = s.InvoiceNo");
				int hid = 0;
				if (rs.next()) {
					hid = rs.getInt("HotelID");
				}
				int j = st.executeUpdate(
						"insert into ratesService value('" + rid + "', '" + hid + "', '" + sType + "' )");

				if (i > 0 && j > 0) {
					out.println("Thank you for your feedback.");
				} else {
					out.println("Something went wrong.");
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	%>

	<div align="center">
		<form action="logged-in.jsp">
			<input type="submit" value="Back to login page">
		</form>
	</div>

</body>
</html>