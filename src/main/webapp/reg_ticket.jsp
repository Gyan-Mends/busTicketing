<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <%@ page import="java.sql.*" %>
    <%@ page import="java.util.Random" %>
<%@ page import="java.util.ArrayList" %>
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
				<h3 class="text-white text-xl">Ticket Details</h3> 
				<form action="reg_ticket.jsp" method="POST">
					<input class="ml-4 rounded-md h-9 pl-2 outline-none" name="destination" placeholder="Enter destination" type="text">
					<button name="ticket" onclick="show()" class=" ml-4 bg-blue-600 p-2 w-10 rounded-md text-white outline-none"><i class="fa fa-plus "></i></button>
				</form>
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
						<th class="pr-[20px] pl-5">ID</th>
						<th class="pr-[20px]">BUS NUMBER</th>
						<th class="pr-[20px]">PASSENGER NAME</th>
						<th class="pr-[20px]">PSSENGER PHONE</th>
						<th class="pr-[20px]">SEAT NUMBER </th>
						<th class="pr-[20px]">EMERGENCY NUMBER </th>
						<th class="pr-[20px]">FARE </th>
						<th class="pr-[20px]">DEPARTURE </th>
						<th class="pr-[20px]">DESTINATION</th>
						<th class="pr-[20px]">DATE</th>
						<th class="pr-5">ACTION</th>
					</tr>
				</thead>
				<tbody>
						<%
							Statement statement2 = connection.createStatement();
							ResultSet rs =statement2.executeQuery("SELECT * FROM tickets");
							while(rs.next()){
							%>
							<tr class="h-9 even:bg-gray-800 text-blue-100">
								<td><%= rs.getString("id") %></td>
								<td><%= rs.getString("bus_number") %></td>
								<td><%= rs.getString("passenger_name") %></td>
								<td><%= rs.getString("passenger_phone") %></td>
								<td><%= rs.getString("seat_number") %></td>
								<td><%= rs.getString("emergency_number") %></td>
								<td><%= rs.getString("fare") %></td>
								<td><%= rs.getString("departure") %></td>
								<td><%= rs.getString("destination") %></td>
								<td>
									<%= rs.getString("date") %>
								<td>
									<a href="ticket_delete.jsp?id=<%=rs.getString("id") %>">									
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
				<%
					if(request.getParameter("ticket") != null){
						//retrieving data from the form
						String Destination =request.getParameter("destination");
							
						Statement ticket_statement=connection.createStatement();
						ResultSet result=ticket_statement.executeQuery("SELECT  bus_number,departure,destination,fare,seats FROM route WHERE LOWER(destination)	LIKE '%"+Destination+"%' AND status='Loading'" ); 
						String name="";
						String from="";
						String to="";
						String fare="";
						int totalSeats
						
						if(result.next()){
							name = result.getString("bus_number");
							from = result.getString("departure");
							to = result.getString("destination");
							fare = result.getString("fare");
					        int totalSeats = result.getInt("seats");
					        
					     // create a list of seat numbers from 1 to the total number of seats
					        List<Integer> seatNumbers = new ArrayList<>();
					        for(int i=1; i<=totalSeats; i++){
					            seatNumbers.add(i);
					        }

					        // shuffle the list of seat numbers to randomize the order
					        Collections.shuffle(seatNumbers);

					        // sort the shuffled list of seat numbers in ascending order
					        Collections.sort(seatNumbers);

					        
					        // assign the first available seat number to the passenger and remove it from the list of available seat numbers
					        int seatNumber = seatNumbers.get(0);
					        seatNumbers.remove(0);
						}else{
							 %>
			               		<script>
			   						alert("No bus is currently loading to the destination you selected");
			   						window.location.href="reg_ticket.jsp";
			   					</script>
			               	<% 

						}
						
					%>
			<div id="form_container" class="m-auto top-[0%] absolute h-[500px] w-[600px] bg-gray-800 rounded-md  inset-0 ">
				<div class="text-right p-3">
					<button onclick="closeModal()"><i class="fa fa-times text-red-500"></i></button>
				</div>
				<div class="text-center text-xl -mt-6 pb-2 text-blue-200"><h2>Ticket Registration</h2></div><hr>
				<form action="reg_ticket.jsp" method="post" class="pt-5 flex-col items-center justify-center pl-10 grid grid-cols-1 lg:grid-cols-2 gap-10">
					
					<div>
						<label class="text-white">Bus No</label><br>
					<input value="<%= name %>"  class="h-9 rounded-md outline-none bg-blue-50 pl-3" type="text" name="number" readonly><br><br>
					
					<label class="text-white">Passenger Name</label><br>
					<input class="h-9 rounded-md outline-none bg-blue-50 pl-3" type="text" name="Pname" required><br><br>
					
					<label class="text-white">Passenger Phone</label><br>
					<input class="h-9 rounded-md outline-none bg-blue-50 pl-3" type="text" name="Pphone" required><br><br>
							
					<label class="text-white">From</label><br>
					<input value="<%= from %>" class="h-9 rounded-md outline-none bg-blue-50 p-3" type="text" name="from" readonly><br><br>
												
					</div>	
					
					<div>
						<label class="text-white">Seat Number</label><br>
					<input value="<%= seatNumber %>"  class="h-9 rounded-md outline-none bg-blue-50 pl-3" type="text" name="seat" required><br><br>
					
					<label class="text-white">Emergency Contact</label><br>
					<input class="h-9 rounded-md outline-none bg-blue-50 pl-3" type="text" name="Econtact" required><br><br>
					
					<label class="text-white">Fare</label><br>
					<input value="<%= fare %>" class="h-9 rounded-md outline-none bg-blue-50 pl-3" type="text" name="fare" readonly><br><br>
						
					<label class="text-white">To</label><br>
					<input value="<%= to %>" class="h-9 rounded-md outline-none bg-blue-50 pl-3" type="text" name="to" readonly><br>
												
					</div>	
					
						<div class="m-auto ml-[210px]"><input type="submit" name="submit" value="ADD" class=" rounded-md text-white h-8 w-20 bg-blue-600" ></div>
									
				</form>
			</div>
		</div>
	</div>
	<%
		}
					
	%>
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
			String Pname = request.getParameter("Pname");
			String Pphone = request.getParameter("Pphone");
			String From = request.getParameter("from");
			String Seat = request.getParameter("seat");
			String Econtact = request.getParameter("Econtact");
			String Fare = request.getParameter("fare");
			String To = request.getParameter("to");

			
			
			
			Statement sqlSelect =connection.createStatement();
			ResultSet sqlResult = sqlSelect.executeQuery("SELECT reserving From seats WHERE bus_number='"+Number+"' ");
			if (sqlResult.next()) {
			    int full = Integer.parseInt(sqlResult.getString("reserving"));
			    if (full == 0) {
			    	%>
		       			<script>
							alert("This bus is full. You can't issue ticket again");
							window.location.href="reg_ticket.jsp";
						</script>
		       		<% 
		       		
			    }else{
			    	//inserting into the database
					//inserting into the database
					Statement statement = connection.createStatement();
					int insert =statement.executeUpdate("INSERT INTO tickets (BUS_NUMBER,PASSENGER_NAME,PASSENGER_PHONE,SEAT_NUMBER,EMERGENCY_NUMBER,FARE,DEPARTURE,DESTINATION,DATE) VALUES ('"+Number+"','"+Pname+"','"+Pphone+"','"+Seat+"','"+Econtact+"','"+Fare+"','"+From+"','"+To+"','"+formattedDateTime+"')");
					
					if(insert>0){
						%>
			       		<script>
								alert("New Bus Added Successfully");
								window.location.href="reg_ticket.jsp";
							</script>
			       	<% 
					}else{
						%>
			       		<script>
							alert("Unable to Add Bus");
						</script>
			       	<% 
			       	
			       	
					}
			    	
			    	//updating the seat number
					//updating the seat number
					Statement statements = connection.createStatement();
					int update =statements.executeUpdate("UPDATE seats SET reserved = reserved + 1 WHERE bus_number = '"+Number+"'");
					
					//updating the seat number
					//updating the seat number
					Statement statement4 = connection.createStatement();
					int update2 =statement4.executeUpdate("UPDATE seats SET reserving = reserving - 1 WHERE bus_number = '"+Number+"'");
					
			    }
			}
			
		}catch(Exception e){
			out.print(e);
		}
	}
	

%>






