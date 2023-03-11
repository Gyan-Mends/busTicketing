<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%
  //database connection
	//database connection
	Class.forName("org.postgresql.Driver");
	Connection connection =DriverManager.getConnection("jdbc:postgresql://localhost:5432/busTicketingDB", "postgres","root");
	

    %>
    <%@ page import="java.time.LocalDateTime" %>
<%@ page import="java.time.format.DateTimeFormatter" %>
<% 
	LocalDateTime currentTime = LocalDateTime.now();
   	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    String formattedDateTime = currentTime.format(formatter);

  %>
  
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

<body class="bg-gray-600" style="font-family: poppins;">
	
	<jsp:include page="nav.jsp"/>
	
	<div class="pageContent ml-60 pt-10 pr-10">
	
	<!-- TABLE FOR BUS DETAILS -->
	<!-- TABLE FOR BUS DETAILS -->
	<div class="">
		<div class="grid grid-cols-1 lg:grid-cols-2">
			<div class="flex pb-3">	
				<h3 class="text-white text-xl">Route Details</h3>
				<button onclick="show()" class=" ml-4 bg-blue-600 p-2 w-10 rounded-md text-white outline-none"><i class="fa fa-plus "></i></button>
			</div> 
			<div class="ml-40">
				<form action="">
					<input onkeyup="mySearch()" id="myInput" class="h-9 w-[250px] rounded-md p-2 outline-none" type="search" placeholder="Search by bus number">
					<button class="bg-blue-600 h-9 w-10 rounded-md text-white"><i class="fa fa-search"></i></button>
				</form>
			</div>
		</div><hr>
		
		<div class="mt-10 flex items-center justify-center">
			<table id="myTable">
				<thead  class=" bg-blue-600 pl-4 text-blue-100 w-[800px]  h-9 ">
					<tr class="text-center">
						<th class="pr-[40px] pl-5">ID</th>
						<th class="pr-[40px]">BUS NUMBER</th>
						<th class="pr-[40px]"> BUS TYPE</th>
						<th class="pr-[40px]">DEPARTURE </th>
						<th class="pr-[40px]">DESTINATION</th>
						<th class="pr-[40px]">FARE </th>
						<th class="pr-[40px]">SEATS </th>
						<th class="pr-[40px] text-center">STATUS</th>
						<th class="pr-[40px] ">DATE</th>
						<th class="pr-5">ACTION</th>
					</tr>
				</thead>
				<tbody>
						<%
							Statement statement2 = connection.createStatement();
							ResultSet rs =statement2.executeQuery("SELECT * FROM route");
							while(rs.next()){
							%>
							<tr class="h-9 even:bg-gray-800 text-blue-100">
								<td><%= rs.getString("id") %></td>
								<td><%= rs.getString("bus_number") %></td>
								<td><%= rs.getString("bus_type") %></td>
								<td><%= rs.getString("departure") %></td>
								<td><%= rs.getString("destination") %></td>
								<td><%= rs.getString("fare") %></td>
								<td><%= rs.getString("seat") %></td>
								<td class=""><%= rs.getString("status") %></td>
								<td class=""><%= rs.getString("date") %></td>
								
								<td class="flex">
									<a href="status.jsp?id=<%=rs.getString("id") %>">									
									<button name="delete" class="bg-blue-600 w-8 rounded-sm mt-1"><i class="fa fa-check text-white"></i></button>
									</a>
									<a href="route_delete.jsp?id=<%=rs.getString("id") %>">									
									<button name="delete" class="bg-red-500 w-8 rounded-sm ml-2 mt-1"><i class="fa fa-trash text-white"></i></button>
									</a>
									<a href="bus_details.jsp?id=<%= rs.getString("id") %>">
										<button onclick="edit()" class="ml-2 bg-green-500 w-8 rounded-sm mt-1"><i class="fa fa-edit text-white"></i></button>
									</a>
								</td>
							</tr>
							<%
							}
						
						%>
				</tbody>
			</table>
		</div>
	</div>
		
		<!-- ADD BUS -->
		<!-- ADD BUS -->
		<div class="h-sreen  w-screen flex items-center justify-center bg-white">
			<div id="form_container" class="m-auto top-[0%] absolute h-[450px] w-[550px] bg-gray-800 rounded-md hidden inset-0 ">
				<div class="text-right p-3">
					<button onclick="closeModal()"><i class="fa fa-times text-red-500"></i></button>
				</div>
				<div class="text-center text-xl -mt-6 pb-2 text-blue-200"><h2>Route Registration</h2></div><hr>
				<form action="route.jsp" method="post" class="pt-5 flex-col items-center justify-center pl-10 grid grid-cols-1 lg:grid-cols-2 gap-10">
					<div>
						<label class="text-white">Bus Number</label><br>
					<input  class="h-9 rounded-md outline-none bg-blue-50" type="text" name="number" required><br><br>
												
					<label class="text-white">Bus Type</label><br>
					<input class="h-9 rounded-md outline-none bg-blue-50" type="text" name="type" required><br><br>
						
					<label class="text-white">From</label><br>
					<input class="h-9 rounded-md outline-none bg-blue-50" type="text" name="from" required><br><br>
					
					<label class="text-white">Seats</label><br>
					<input class="h-9 rounded-md outline-none bg-blue-50" type="text" name="seat" required><br><br>
												
					</div>	
					
					<div>
					<label class="text-white">To</label><br>
					<input class="h-9 rounded-md outline-none bg-blue-50" type="text" name="to" required><br><br>
						
					<label class="text-white">Fare</label><br>
					<input class="h-9 rounded-md outline-none bg-blue-50" type="text" name="fare" required><br><br>
					
					<label class="text-white">Status</label><br>
					<select name="status" class="h-9 rounded-md outline-none bg-blue-50 w-[200px]">
						<option></option>
						<option>Loading</option>
					</select>
																	
					</div>	
						<div class="m-auto ml-[210px]"><input type="submit" name="submit" value="ADD" class=" rounded-md text-white h-8 w-20 bg-blue-600" ></div>		
				</form>
			</div>
		</div>
	</div>
	<!-- Scripts -->
    <!-- Scripts -->
    <script type="text/javascript">
    	function show(){
    		document.getElementById("form_container").style.display="block";
    	}
    	function  closeModal(){
    		document.getElementById("form_container").style.display="none";
    	}
    	
    	function mySearch(){
    		 // Declare variables
    		  var input, filter, table, tr, td, i, txtValue;
    		  input = document.getElementById("myInput");//getting the search input
    		  filter = input.value.toUpperCase();//converting the input to upper case
    		  table = document.getElementById("myTable");//getting the data in the table
    		  tr = table.getElementsByTagName("tr");
    		  // Loop through all table rows, and hide those who don't match the search query
    		 // Loop through all table rows, and hide those who don't match the search query
    		  for (i = 0; i < tr.length; i++) {
    		    td = tr[i].getElementsByTagName("td")[1];
    		    if (td) {
    		      txtValue = td.textContent || td.innerText;
    		      if (txtValue.toUpperCase().indexOf(filter) > -1) {
    		        tr[i].style.display = "";
    		      } else {
    		        tr[i].style.display = "none";
    		      }
    		    }
    		  }
    	}
    	
    	
    </script>
    <script src="Assets/tailwind.js"></script>
      <script src="Assets/jquery-3.6.0.min.js"></script>
    
</body>
</html>

<%
	if(request.getParameter("submit") != null){
		try{
			
			//retrieving data from the database
			//retrieving data from the database
			String Number =request.getParameter("number");
			String Type = request.getParameter("type");
			String From = request.getParameter("from");
			String To = request.getParameter("to");
			String Fare = request.getParameter("fare");
			String Status = request.getParameter("status");
			String Seat = request.getParameter("seat");
			
			//checking if the bus is aleady registered in the system before you can add route
			//checking if the bus is aleady registered in the system before you can add route
			Statement statement1 =connection.createStatement();
			ResultSet resultset =statement1.executeQuery("SELECT bus_number,bus_seats,bus_type FROM busses WHERE LOWER(bus_number)='"+Number.toLowerCase()+"' AND LOWER(bus_seats)='"+Seat.toLowerCase()+"' AND LOWER(bus_type)='"+Type.toLowerCase()+"'");
			if(resultset.next()){
				//inserting into the database
				//inserting into the database
				Statement statement = connection.createStatement();
				int insert = statement.executeUpdate("INSERT INTO route (BUS_NUMBER, BUS_TYPE, DEPARTURE, DESTINATION, FARE, SEAT, STATUS, DATE) " +
	                    "VALUES ('" + Number + "', '" + Type + "', '" + From + "', '" + To + "', '" + Fare + "', '" + Seat + "', '" + Status + "', '" + formattedDateTime + "')");
				if(insert>0){
					%>
		       		<script>
							alert("New Route Added Successfully");
							window.location.href="route.jsp";
						</script>
		       	<% 
				}else{
					%>
		       		<script>
						alert("Unable to Add Bus");
					</script>
		       	<% 
		       	
		       	
				}
			}else{
				%>
	       		<script>
					alert("This bus is not registered in the system OR seat does not match with the one you used when registering the bus OR bus type doesn't match ");
				</script>
	       	<%
			}
				
			
			 
			
		}catch(Exception e){
			out.print(e);
		}
	}
	

%>






