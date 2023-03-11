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
				<h3 class="text-white text-xl">Bus Details</h3>
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
						<th class="pr-[135px] pl-5">ID</th>
						<th class="pr-[135px]">BUS NUMBER</th>
						<th class="pr-[135px]">BUS TYPE</th>
						<th class="pr-[135px]">BUS SEATS</th>
						<th class="pr-[135px]">DATE</th>
						<th class="pr-5">ACTION</th>
					</tr>
				</thead>
				<tbody>
						<%
							Statement statement2 = connection.createStatement();
							ResultSet rs =statement2.executeQuery("SELECT * FROM busses");
							while(rs.next()){
							%>
							<tr class="h-9 even:bg-gray-800 text-blue-100">
								<td><%= rs.getString("id") %></td>
								<td><%= rs.getString("bus_number") %></td>
								<td><%= rs.getString("bus_type") %></td>
								<td><%= rs.getString("bus_seats") %></td>
								<td>
									<%= formattedDateTime %>
								<td>
									<a href="delete.jsp?id=<%=rs.getString("id") %>">									
									<button name="delete" class="bg-red-500 w-8 rounded-sm"><i class="fa fa-trash text-white"></i></button>
									</a>
									<a href="bus_details.jsp?id=<%= rs.getString("id") %>">
										<button onclick="edit()" class="bg-green-500 w-8 rounded-sm"><i class="fa fa-edit text-white"></i></button>
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
			<div id="form_container" class="m-auto top-[0%] absolute h-[390px] w-[350px] bg-gray-800 rounded-md hidden inset-0 ">
				<div class="text-right p-3">
					<button onclick="closeModal()"><i class="fa fa-times text-red-500"></i></button>
				</div>
				<div class="text-center text-xl -mt-6 pb-4 text-blue-200"><h2>Bus Registration</h2></div><hr>
				<form action="bus_details.jsp" method="post" class="pt-5 flex-col items-center justify-center pl-20 ">
					<label class="text-white">Bus No</label><br>
					<input  class="h-9 rounded-md outline-none bg-blue-50" type="text" name="number" required><br><br>
					
					<label class="text-white">Bus Type</label><br>
					<input class="h-9 rounded-md outline-none bg-blue-50" type="text" name="type" required><br><br>
					
					<label class="text-white">Bus Seats</label><br>
					<input class="h-9 rounded-md outline-none bg-blue-50" type="text" name="seats" required><br><br>
					
					<div class="text-center -ml-20"><input type="submit" name="submit" value="ADD" class=" rounded-md text-white h-8 w-20 bg-blue-600" ></div>
				</form>
			</div>
		</div>
	</div>
	
		<!-- Edit bus details -->
		<!-- Edit bus details -->
		<div class="h-sreen  w-screen flex items-center justify-center bg-white">
			<div id="edit" class="m-auto top-[0%] absolute h-[390px] w-[350px] bg-gray-800 rounded-md hidden inset-0 ">
				<div class="text-right p-3">
					<button onclick="closeModal()"><i class="fa fa-times text-red-500"></i></button>
				</div>
				<div class="text-center text-xl -mt-6 pb-4 text-blue-200"><h2>Bus Registration</h2></div><hr>
				<form action="bus_details.jsp" method="post" class="pt-5 flex-col items-center justify-center pl-20 ">
					<label class="text-white">Bus No</label><br>
					<input  class="h-9 rounded-md outline-none bg-blue-50" type="text" name="number" required><br><br>
					
					<label class="text-white">Bus Type</label><br>
					<input class="h-9 rounded-md outline-none bg-blue-50" type="text" name="type" required><br><br>
					
					<label class="text-white">Bus Seats</label><br>
					<input class="h-9 rounded-md outline-none bg-blue-50" type="text" name="seats" required><br><br>
					
					<div class="text-center -ml-20"><input type="submit" name="submit" value="ADD" class=" rounded-md text-white h-8 w-20 bg-blue-600" ></div>
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
    	function edit(){
    		document.getElementById("edit").style.display="block";
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
    	
    	function edit(){
    		document.getElementById("edit").style.display="block";
    	}
    	
    	
    	$("#search").click(function() {
            var roll_no= $('#roll_no').val();
            city_name.value = city_name; 
            $.ajax({
               url: "fetch.jsp",
               type: 'POST',
               data: {roll_no: roll_no},
               success: function(data) {
                    $('#city_name').val(data);
                    alert(data);
                     var city_name = data;   
               }
           });
   });
    	
    	
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
			String Bus_Number =request.getParameter("number");
			String Bus_Type = request.getParameter("type");
			String Bus_Seats = request.getParameter("seats");
			
			
			//checking that two busses wth the same number can't exist
			//checking that two busses wth the same number can't exist
			Statement statement1 = connection.createStatement();
			ResultSet result = statement1.executeQuery("SELECT * FROM busses WHERE LOWER(bus_number) = '"+Bus_Number.toLowerCase()+"'");
			if(result.next()){
					%>
		       		 	<script>
							alert("Bus already exist");
							window.location.href="bus_details.jsp";
						</script>
						
					<%
		       		
				}else{
					
					//inserting into the database
					//inserting into the database
					Statement statements = connection.createStatement();
					int inserts =statements.executeUpdate("INSERT INTO seats (bus_number,bus_type,reserving,reserved) VALUES ('"+Bus_Number+"','"+Bus_Type+"','"+Bus_Seats+"','0')");
					
					//inserting into the database
					//inserting into the database
					Statement statement = connection.createStatement();
					int insert =statement.executeUpdate("INSERT INTO busses (bus_number,bus_type,bus_seats) VALUES ('"+Bus_Number+"','"+Bus_Type+"','"+Bus_Seats+"')");
					if(insert>0){
						%>
			       		<script>
								alert("New Bus Added Successfully");
								window.location.href="bus_details.jsp";
							</script>
			       	<% 
					}else{
						%>
			       		<script>
							alert("Unable to Add Bus");
						</script>
			       	<% 
				}
			}
			
			
	       	
	       	
			
		}catch(Exception e){
			out.print(e);
		}
	}
	

%>






