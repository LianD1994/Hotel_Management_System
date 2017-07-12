<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="Hotel_Reservation_System.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Payment Success</title>
</head>
<%!String con_url = "jdbc:mysql://localhost:3306/hotel?autoReconnect=true&useSSL=false";
	String con_user = "root";
	String con_pass = "KAWO";%>

<%
try{
Class.forName("com.mysql.jdbc.Driver"); 
Connection con = DriverManager.getConnection(con_url,con_user,con_pass);
Statement st= con.createStatement();

ArrayList<resInfo> infoList = (ArrayList<resInfo>)request.getSession().getAttribute("resInfoList");

// insert into table creditcard
// ==========================================
String name = request.getParameter("name");
String card_no = request.getParameter("cardnumber");
String queryString = "insert into creditcard value("+card_no+", NULL, '"+name+"', 0, NULL, NULL)";
int i = st.executeUpdate(queryString);
if(i>0){
	System.out.println("creditcard success");
}else{
	System.out.println("creditcard fail");
} 

// insert into table reservation
// ==============================================
Date date = new Date();
DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
String today = dateFormat.format(date);
queryString = "insert into reservation value(NULL, '"+today+"')";
int check = st.executeUpdate(queryString);
if(check>0){
	System.out.println("reservation success");
}else{
	System.out.println("reservation fail");
} 

// insert into table reservesroom
// ===============================================
// get the invoiceNo
queryString = "select * from reservation";
ResultSet resultset = st.executeQuery(queryString);
String InvoiceNo = null;
while(resultset.next()){
	InvoiceNo = resultset.getString("InvoiceNo");
}

for(i=0;i<infoList.size();i++){
	int HotelID = infoList.get(i).getHotelID();
	int room_no = infoList.get(i).getRoomNo();
	String checkinDate = infoList.get(i).getCheckinDate();
	String checkoutDate = infoList.get(i).getCheckoutDate();
	
	queryString = "insert into reservesroom value("+HotelID+", "+room_no+", "+InvoiceNo+", '"+checkinDate+"', '"+checkoutDate+"')";
	check = st.executeUpdate(queryString);
	if(check>0){
		System.out.println("reservation success");
	}else{
		System.out.println("reservation fail");
	} 
}

//insert into table makesreservation
// =================================================
// get the CID
int CID = Integer.parseInt(request.getSession().getAttribute("cid").toString());
queryString = "insert into makesreservation value('"+CID+"', "+card_no+", "+InvoiceNo+")";
check = st.executeUpdate(queryString);
if(check>0){
	System.out.println("makesreservation success");
}else{
	System.out.println("makesreservation fail");
} 

}catch(Exception e){
	e.printStackTrace();
}
%>
<body>
<div align="center"><h1>You have successfully made you payment</h1>
<form name="done" action="/jsp/logged-in.jsp">
	<input type="submit" value="Go back">
</form>
</div>
</body>
</html>