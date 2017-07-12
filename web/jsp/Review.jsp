<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Review</title>
</head>
<body>



	<%
		String rno = request.getParameter("rno");
		if (rno != null) {
			out.println("<div align='center'>");
			out.println("<h1>Room Review</h1>");
			out.println("</div>");
			
			out.println("<form action='submitReview.jsp' method='POST'>");
			out.println("<div align='center'>");
			out.println("<textarea rows='10' cols='50' name='roomrev' placeholder='Write something about our room!' required ></textarea>");
			out.println("</div>");
			out.println("<div align='center'>");
			out.println("<body>Please enter a rating from 1-5:</body>");
			out.println("<input type='text' name='roomrating' placeholder='Enter rating' required>");
			out.println("<br>");
			out.println("<input type='submit' value='Submit'>");
			out.println("</div");
			out.println("</form>");
			
		}

		String bType = request.getParameter("bType");
		if (bType != null) {
			out.println("<div align='center'>");
			out.println("<h1>Breakfast Review</h1>");
			out.println("</div>");

			
			out.println("<form action='submitReview.jsp' method='POST'>");
			out.println("<div align='center'>");
			out.println("<textarea rows='10' cols='50' name='breakfastrev' placeholder='Write something about our breakfast!''></textarea>");
			out.println("</div>");
			out.println("<div align='center'>");
			out.println("<body>Please enter a rating from 1-5:</body>");
			out.println("<input type='text' name='breakfastrating' placeholder='Enter rating' required>");
			out.println("<br>");
			out.println("<input type='submit' value='Submit'>");
			out.println("</div");
			out.println("</form>");
		}

		String sType = request.getParameter("sType");
		if (sType != null) {
			out.println("<div align='center'>");
			out.println("<h1>Service Review</h1>");
			out.println("</div>");
			
			out.println("<form action='submitReview.jsp' method='POST'>");
			out.println("<div align='center'>");
			out.println("<textarea rows='10' cols='50' name='servicerev' placeholder='Write something about our service!''></textarea>");
			out.println("</div>");
			out.println("<div align='center'>");
			out.print("<body>Please enter a rating from 1-5:</body>");
			out.println("<input type='text' name='servicerating' placeholder='Enter rating' required>");
			out.println("<br>");
			out.println("<input type='submit' value='Submit'>");
			out.println("</div");
			out.println("</form>");
		}
	%>
	
<div align="center"><input type="button" value="Return" onClick="window.location = 'manageReservation.jsp';"></div>

</body>
</html>