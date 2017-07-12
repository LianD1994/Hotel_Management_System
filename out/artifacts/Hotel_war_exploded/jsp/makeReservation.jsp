<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%@ page import="java.io.*"%>
<%@ page import="java.util.*"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="Hotel_Reservation_System.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<title>makeReservation</title>
</head>

<script type="text/javascript">
	function validate_form() {
		var check_in = document.forms["search"]["check-in"].value;
		var check_out = document.forms["search"]["check-out"].value;
		var date1 = new Date(check_in);
		var date2 = new Date(check_out);
		if (date2 < date1) {
			alert("Check-out date cannot be before check-in date");
			return false;
		}
		return true;
	}
</script>

<body>
	<div align="center">
		<h1>Search for your hotel</h1>
		<form name="search"
			action="/jsp/makeReservation.jsp"
			onsubmit="return validate_form()">
			<table>
				<tr>
					<td>Country</td>
					<td><input name="country" placeholder="Country" required></td>
				</tr>

				<tr>
					<td>State</td>
					<td><input name="state" placeholder="State" required></td>
				</tr>

				<tr>
					<td>Check-in date</td>
					<td><input type="date" placeholder="yyyy-mm-dd"
						name="check-in" required></td>
				</tr>

				<tr>
					<td>Check-out date</td>
					<td><input type="date" placeholder="yyyy-mm-dd"
						name="check-out" required></td>
				</tr>

				<tr>
					<td>Room Type</td>
					<td><select name="room_type" required>
							<option value="Single">Single</option>
							<option value="Double">Double</option>
							<option value="Suite">Suite</option>
					</select></td>
				</tr>
			</table>

			<input type="submit" value="Search">

		</form>
	</div>
	<%!String con_url = "jdbc:mysql://localhost:3306/hotel?autoReconnect=true&useSSL=false";
	String con_user = "root";
	String con_pass = "KAWO";%>


	<%
		String country = request.getParameter("country");
		String state = request.getParameter("state");
		String checkin = request.getParameter("check-in");
		String checkout = request.getParameter("check-out");
		String room_type = request.getParameter("room_type");

		try {
			String CID = request.getSession().getAttribute("cid").toString();
			System.out.println("CID IS " + CID);

			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(con_url, con_user, con_pass);
			Statement st = con.createStatement();

			if (country != null && state != null && checkin != null && checkout != null && room_type != null) {
				// available hotel with given info from user
				String queryString = "select * from hasofferroomisaroom h, hotel l where h.HotelID = l.HotelID and Country = '"
						+ country + "' and State = '" + state + "' and Type = '" + room_type
						+ "' and (h.HotelID, h.Room_no) not in (select HotelID, Room_no from reservesroom where OutDate > '"
						+ checkin + "' and InDate < '" + checkout + "')";
				ResultSet resultset = null;
				resultset = st.executeQuery(queryString);

				String HotelID = null;
				String roomNumber = null;
				String discount = null;
				String sdate = null;
				String edate = null;
				while (resultset.next()) {

					HotelID = resultset.getString("HotelID");
					roomNumber = resultset.getString("Room_no");
					country = resultset.getString("Country");
					state = resultset.getString("State");
					room_type = resultset.getString("Type");
					discount = resultset.getString("Discount");
					sdate = resultset.getString("SDate");
					edate = resultset.getString("EDate");
	%>
	<BR>
	<TABLE BORDER="1">
		<TR>
			<TH>Hotel ID</TH>
			<TH>Room Number</TH>
			<TH>Country</TH>
			<TH>State</TH>
			<TH>Type</TH>
			<TH>Discount</TH>
			<TH>Start Date</TH>
			<TH>End Date</TH>
		</TR>
		<TR>
			<TD><%=HotelID%></TD>
			<TD><%=roomNumber%></TD>
			<TD><%=country%></TD>
			<TD><%=state%></TD>
			<TD><%=room_type%></TD>
			<TD><%=discount%></TD>
			<TD><%=sdate%></TD>
			<TD><%=edate%></TD>
		</TR>
	</TABLE>
	<BR>
	<%
		}
	%>
	<div align="center">
		<BR>
		<h1>Please select your room</h1>
		<form name="reserve"
			action="/jsp/makeReservation.jsp">
			<table>
				<tr>
					<td>Hotel ID</td>
					<td><input name="HotelID" placeholder="Hotel ID" required></td>
				</tr>

				<tr>
					<td>Room number</td>
					<td><input name="roomNum" placeholder="Room number" required></td>
				</tr>

				<tr>
					<td>Check-in date</td>
					<td><input type="date" placeholder="yyyy-mm-dd"
						name="check-in2" required></td>
				</tr>

				<tr>
					<td>Check-out date</td>
					<td><input type="date" placeholder="yyyy-mm-dd"
						name="check-out2" required></td>
				</tr>
			</table>

			<input type="submit" value="reserve">
		</form>
	</div>
	<%
		}

			String id = request.getParameter("HotelID");
			String num = request.getParameter("roomNum");
			String checkin2 = request.getParameter("check-in2");
			String checkout2 = request.getParameter("check-out2");

			if (id != null && num != null && checkin2 != null && checkout2 != null) {
				// keep track of all the info for insertion after payment is made
				resInfo info = new resInfo();
				info.setHotelID(Integer.parseInt(id));
				info.setRoomNo(Integer.parseInt(num));
				info.setCheckinDate(checkin2);
				info.setCheckoutDate(checkout2);

				// get the global list in the session
				ArrayList<resInfo> infoList = (ArrayList<resInfo>) request.getSession().getAttribute("resInfoList");
				// add info obj to the global list
				infoList.add(info);
				System.out.println(infoList.size());
				// set the local list to the global list
				request.getSession().setAttribute("resInfoList", infoList);
	%>
	<h1>
		You have selected room number
		<%=num%>
		at Hotel
		<%=id%>. You can select another room or go to the payment page. Your
		reservation will not be completed until you make the payment.
	</h1>
	<div align="center">
	<form name="pay" action="/jsp/paymentPage.jsp">
		<input type="submit" value="Go to Payment Page">
	</form>
	<br>
	<br>
	<form name="reserve"
		action="/jsp/makeReservation.jsp">
		<table>
			<tr>
				<td>Hotel ID</td>
				<td><input name="HotelID" placeholder="Hotel ID" required></td>
			</tr>

			<tr>
				<td>Room number</td>
				<td><input name="roomNum" placeholder="Room number" required></td>
			</tr>

			<tr>
				<td>Check-in date</td>
				<td><input type="date" placeholder="yyyy-mm-dd"
					name="check-in2" required></td>
			</tr>

			<tr>
				<td>Check-out date</td>
				<td><input type="date" placeholder="yyyy-mm-dd"
					name="check-out2" required></td>
			</tr>
		</table>
		<input type="submit" value="Reserve">
	</form>
	</div>
	<%
		//}
			}

		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	<div align="center">
		<input type="button" value="Return"
			onClick="window.location = 'logged-in.jsp';">
	</div>
</body>
</html>

