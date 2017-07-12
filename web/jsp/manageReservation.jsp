<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Manage Reservations</title>
</head>
<body>
	<div align="center">
		<h1>Manage Reservations</h1>
	</div>

	<%!String con_url = "jdbc:mysql://localhost:3306/hotel?autoReconnect=true&useSSL=false";
	String con_user = "root";
	String con_pass = "KAWO";%>

	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(con_url,con_user,con_pass);
			Statement st = con.createStatement();
			int cid = (int)request.getSession().getAttribute("cid");
			System.out.println("This is cid from request session: " + cid);

			ResultSet resultset = st.executeQuery(
					"select Room_no, HotelID from makesreservation m, reservesRoom r where CID = '"+cid+"'  and m.InvoiceNo = r.InvoiceNo;");

			int Room_no = 0;
			int HotelID = 0;

			out.println("<div align='center'>");
			out.println("<TABLE BORDER='1'>");
			out.println("<TR>");
			out.println("<TH>Hotel</TH>");
			out.println("<TH>Reserved Rooms</TH>");
			out.println("</TR>");
			out.println("</div>");
			
			while (resultset.next()) {
				Room_no = resultset.getInt("Room_no");
				HotelID = resultset.getInt("HotelID");
				out.println("<TR>");
				out.println("<TD align='center'>" + HotelID + "</TD>");
				out.println("<TD align='center'>" + Room_no + "</TD>");
				out.println("</TR>");
			}
			
			out.println("<TD align='center'></TD>");
			out.println("<TD align='center'></TD>");
	%>
	<form action="Review.jsp" method="POST">
	<TR>
	<TD align="center">Enter Hotel</TD>
	<TD><input type="text" name="hid"
				placeholder="Enter Hotel ID" required></TD>
	</TR>
	

	<TR>
		
			<TD align="center">Enter Room</TD>
			<TD><input type="text" name="rno"
				placeholder="Enter Room Number" required></TD>
			<TD><input type="submit" value="Write a review for this room">
				<input type="submit" value="Cancel Reservation"
				onClick="form.action = 'CancelRes.jsp'" /></TD>
		
	</TR>
	</form>
	<%
			out.println("<TR>");
			out.println("</TABLE>");
			out.println("<BR>");

		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(con_url,con_user,con_pass); 
			Statement st = con.createStatement();
			int cid = (int) request.getSession().getAttribute("cid");
			System.out.println("This is cid from request session: " + cid);

			ResultSet resultset = st.executeQuery(
					"select bType, HotelID from makesreservation m, includesBreakfast b where CID = '"+cid+"'  and m.InvoiceNo = b.InvoiceNo;");

			String bType = null;
			int HotelID = 0;

			out.println("<TABLE BORDER='1'>");
			out.println("<TR>");
			out.println("<TH>Hotel</TH>");
			out.println("<TH>Included Breakfasts</TH>");
			out.println("</TR>");

			while (resultset.next()) {
				bType = resultset.getString("bType");
				HotelID = resultset.getInt("HotelID");
				out.println("<TR>");
				out.println("<TD align='center'>" + HotelID + "</TD>");
				out.println("<TD align='center'>" + bType + "</TD>");
				out.println("</TR>");
			}
			
			out.println("<TD align='center'></TD>");
			out.println("<TD align='center'></TD>");
	%>
	<form action="Review.jsp" method="POST">
	<TR>
	<TD align="center">Enter Hotel</TD>
	<TD><input type="text" name="hid"
				placeholder="Enter Hotel ID" required></TD>
	</TR>
	

	<TR>
		
			<TD align="center">Enter Breakfast</TD>
			<TD><input type="text" name="bType"
				placeholder="Enter Breakfast" required></TD>
			<TD><input type="submit" value="Write a review for this breakfast">
		
	</TR>
</form>
	<%
			out.println("<TR>");
			out.println("</TABLE>");
			out.println("<BR>");

		} catch (Exception e) {
			e.printStackTrace();
		}
	%>

	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
			Connection con = DriverManager.getConnection(con_url,con_user,con_pass); 
			Statement st = con.createStatement();
			int cid = (int) request.getSession().getAttribute("cid");
			System.out.println("This is cid from request session: " + cid);

			ResultSet resultset = st.executeQuery(
					"select sType, HotelID from makesreservation m, containsService s where CID = '"+cid+"'  and m.InvoiceNo = s.InvoiceNo;");

			String sType = null;
			int HotelID = 0;

			out.println("<TABLE BORDER='1'>");
			out.println("<TR>");
			out.println("<TH>Hotel</TH>");
			out.println("<TH>Included Services</TH>");
			out.println("</TR>");

			while (resultset.next()) {
				sType = resultset.getString("sType");
				HotelID = resultset.getInt("HotelID");
				out.println("<TR>");
				out.println("<TD align='center'>" + HotelID + "</TD>");
				out.println("<TD align='center'>" + sType + "</TD>");
				out.println("</TR>");
			}
			
			out.println("<TD align='center'></TD>");
			out.println("<TD align='center'></TD>");
	%>
	<form action="Review.jsp" method="POST">
	<TR>
	<TD align="center">Enter Hotel</TD>
	<TD><input type="text" name="hid"
				placeholder="Enter Hotel ID" required></TD>
	</TR>
	

	<TR>
		<TD align="center">Enter Service</TD>
		<TD><input type="text" name="sType"
			placeholder="Enter Room Number" required></TD>
		<TD><input type="submit" value="Write a review for this service">
	</TR>
</form>
	<%

			out.println("</TABLE>");
			out.println("<BR>");

		} catch (Exception e) {
			e.printStackTrace();
		}
	%>
	<input type="button" value="Return" onClick="window.location = 'logged-in.jsp';">
</body>
</html>