<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
<meta charset="UTF-8">
<title>Payment Page</title>
</head>
<body>

	<%!String con_url = "jdbc:mysql://localhost:3306/hotel?autoReconnect=true&useSSL=false";
	String con_user = "root";
	String con_pass = "KAWO";%>

	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(con_url, con_user, con_pass);
			Statement st = con.createStatement();

			ArrayList<resInfo> info = (ArrayList<resInfo>) request.getSession().getAttribute("resInfoList");
			int totalPrice = 0;
			for (int i = 0; i < info.size(); i++) {
				int HotelID = info.get(i).getHotelID();
				int room_no = info.get(i).getRoomNo();

				DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
				Date checkinDate = dateFormat.parse(info.get(i).getCheckinDate());
				Date checkoutDate = dateFormat.parse(info.get(i).getCheckoutDate());

				String checkin = dateFormat.format(checkinDate);
				String checkout = dateFormat.format(checkoutDate);
				long diff = checkoutDate.getTime() - checkinDate.getTime();
				int range = (int) TimeUnit.DAYS.convert(diff, TimeUnit.MILLISECONDS);

				String queryString = "select * from hasofferroomisaroom where HotelID = " + HotelID
						+ " and Room_no = " + room_no + "";
				ResultSet resultset = st.executeQuery(queryString);
				String price = null;
				while (resultset.next()) {
					price = resultset.getString("Price");
				}

				System.out.println(price);
				totalPrice += Integer.parseInt(price) * range;
	%>
	<div align="center">
		<table>
			<tr>
				<td>HotelID: <%=HotelID%> Room Number: <%=room_no%> Price: <%=price%>
					From: <%=checkin%> To: <%=checkout%> Range: <%=range%> days
				</td>
			</tr>
			</div>

			<%
				}
			%>

			<div align="center">
			<tr>
				<td>Total Amount: <%=totalPrice%></td>
			</tr>
		</table>
	</div>

	<form name="creditCard"
		action="/jsp/successPayment.jsp">
		<div align="center">
			<table>

				<tr>
					<td>Name</td>
					<td><input name="name" placeholder="name" required></td>
				</tr>
				<tr>
					<td>Card Number</td>
					<td><input name="cardnumber" placeholder="card number"
						required></td>
				</tr>
				<tr>
					<td>Expiration Date:</td>
					<td><select name="mStr" style="">
							<option value="-1">Month</option>
							<option value="0">January</option>
							<option value="1">February</option>
							<option value="2">March</option>
							<option value="3">April</option>
							<option value="4">May</option>
							<option value="5">June</option>
							<option value="6">July</option>
							<option value="7">August</option>
							<option value="8">September</option>
							<option value="9">October</option>
							<option value="10">November</option>
							<option value="11">December</option>
					</select></td>
					<td><select name="expiry">
							<option value=''>Year</option>
							<?php 
	    for ($i = date('Y'); $i <= date('Y')+10; $i++) {
        echo '<option value="'.$i.'">'.$i.'</option>';
    	} ?>
					</select></td>
				</tr>
				<tr>
					<td>CVD</td>
					<td><input name="cvd" placeholder="CVD" required></td>
				</tr>
			</table>

			<input type="submit" value="Pay now">
		</div>
	</form>
</body>
<%
	} catch (Exception e) {
		e.printStackTrace();
	}
%>
<div align="center">
	<input type="button" value="Return"
		onClick="window.location = 'logged-in.jsp';">
</div>
</html>