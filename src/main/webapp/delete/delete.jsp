<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
 <%
  //database connection
	//database connection
	Class.forName("org.postgresql.Driver");
	Connection connection =DriverManager.getConnection("jdbc:postgresql://localhost:5432/busTicketingDB", "postgres","root");
	

		try{
			//deleting buss record from the database
			//deleting buss record from the database
				String id =request.getParameter("id");
				
				Statement statement3 = connection.createStatement();
				int delete = statement3.executeUpdate("DELETE FROM busses WHERE id='"+id+"'");
				%>
					<script type="text/javascript">
						window.location.href="bus_details.jsp";
					</script>
				<%
		}catch(Exception e){
			out.print(e);
		}
		
		

		
	
    %>
    