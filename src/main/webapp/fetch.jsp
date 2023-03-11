<%@page import="java.sql.*"%>
<%
    String name = request.getParameter("name");
    String output = "";
    if (name != null && !name.equals("")) {
        try {
        	Class.forName("org.postgresql.Driver");
    	    Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/busTicketingDB","postgres","root");
    	    
            Statement stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users WHERE LOWER(name) || UPPER(name) LIKE '%" + name + "%'");
            while (rs.next()) {
                output += "<div>" + rs.getString("name") + "</div>";
            }
            connection.close();
        } catch (Exception e) {
            System.out.println(e);
        }
    }
    out.print(output);
%>
