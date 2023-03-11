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
				String Status = request.getParameter("status");
				
				Statement statement3 = connection.createStatement();
				int delete = statement3.executeUpdate("UPDATE route	SET status = (CASE	WHEN status = 'Loading' THEN 'Departed'	WHEN status = 'Departed' THEN 'Loading'	ELSE 	status	END)	WHERE id = '"+id+"'");
				
				//Updating reserved and reserving seat to their initial state when status is set to departed
				//Updating reserved and reserving seat to their initial state when status is set to departed
				Statement statement = connection.createStatement();
				ResultSet resultSet= statement.executeQuery("SELECT bus_number,seat FROM route WHERE id = '"+id+"' AND status='Departed'");
				String bus_number="";
				String seat ="";
				if(resultSet.next()){
					bus_number =resultSet.getString("bus_number");
					seat =resultSet.getString("seat");
					
					Statement statements = connection.createStatement();
					int update =statements.executeUpdate("UPDATE seats SET reserved = 0,reserving='"+seat+"' WHERE bus_number = '"+bus_number+"'");
					
				}
				%>
					<script type="text/javascript">
						window.location.href="route.jsp";
					</script>
				<%
		}catch(Exception e){
			out.print(e);
		}
	
    %>