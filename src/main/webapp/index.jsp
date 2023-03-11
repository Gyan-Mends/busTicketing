


<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
   
    
    
   

    
    
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <!-- Assets -->
    <!-- Assets -->
    <link rel="stylesheet" href="Assets/fonts/fonts.css">
    <link rel="stylesheet" href="Assets/fontawesome/css/all.css">
</head>
<body style="font-family: poppins;" class="dark:bg-gray-800 ">
    <div class="h-screen flex items-center justify-center">
        <div class="h-[300px] w-[300px] dark:bg-gray-600 rounded-md  pt-4">
            <h3 class="text-white text-xl mb-7 text-center">ADMIN LOGIN</h3><hr class="-mt-5">
            <form class="text-center mt-4" action="index.jsp" method="post">
                <label class="text-white -ml-40" for="">Email</label><br>
                <input class="h-8 rounded-sm outline-none bg-blue-50" type="email" name="email"><br><br>

                <label class="text-white -ml-[120px]" for="">Password</label><br>
                <input class="h-8 rounded-sm outline-none bg-blue-50" type="password" name="password"><br>

                <div class="text-right w-60">
                    <a class="text-sm text-right text-red-400" href="">Forgot password</a><br><br>
                </div>

                <input class="bg-blue-600 p-1 w-20 rounded-sm text-white" type="submit" name="submit">
            </form>
        </div>
    </div>
<!-- Scripts -->
<!-- Scripts -->
<script src="Assets/tailwind.js"></script>
</body>
</html>

<%@ page import="java.sql.*"  %>
<%  
	if(request.getParameter("submit") != null){
		//database  connection
		//database  connection
		Class.forName("org.postgresql.Driver");
	    Connection connection = DriverManager.getConnection("jdbc:postgresql://localhost:5432/busTicketingDB","postgres","root");
	    
	    //retrieving data from the input field
	    //retrieving data from the input field
		String Email = request.getParameter("email");
	    String Password = request.getParameter("password");
	    session.setAttribute("email", Email);
	    session.setAttribute("password",Password);
	    
	    //checking if the admin details exist in the datbase
	    //checking if the admin details exist in the datbase
		Statement statement =connection.createStatement();
	    ResultSet rs = statement.executeQuery("SELECT * FROM admin_login WHERE email ='"+Email+"' AND password='"+Password+"'");
	  	if(rs.next()){
	  		response.sendRedirect(" admin_dashboard.jsp");
	  	}else{
	  		%>
            	<script>
        			alert(" Invalid Email or Password ");
    			</script>
    		<%
	  		response.sendRedirect("index.jsp");
	  	}
	}
%>
