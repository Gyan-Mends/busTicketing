<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
	
	<button onclick="openForm()">Open Form</button>

<div id="popupForm" class="form-popup">
  <form action="${pageContext.request.contextPath}/submit-form" method="post" class="form-container">
    <h2>Enter Your Details</h2>
    <label for="name"><b>Name</b></label>
    <input type="text" placeholder="Enter your name" name="name" required>

    <label for="email"><b>Email</b></label>
    <input type="email" placeholder="Enter your email" name="email" required>

    <button type="submit" class="btn">Submit</button>
    <button type="button" class="btn cancel" onclick="closeForm()">Close</button>
  </form>
</div>

<style>
.form-popup {
  display: none;
  position: fixed;
  top: 0;
  bottom: 0;
  left: 0;
  right: 0;
  background-color: rgba(0, 0, 0, 0.5); /* Background color with opacity */
  z-index: 9999; /* Set a high z-index to display above other elements */
}

.form-container {
  position: absolute;
  top: 50%; /* Center the form vertically */
  left: 50%; /* Center the form horizontally */
  transform: translate(-50%, -50%);
  width: 300px;
  padding: 20px;
  background-color: white;
  border: 3px solid #f1f1f1;
  border-radius: 10px;
}

.form-container h2 {
  text-align: center;
  margin-top: 0;
}

.form-container input[type=text], .form-container input[type=email] {
  width: 100%;
  padding: 10px;
  margin: 8px 0;
  border: 1px solid #ccc;
  border-radius: 5px;
}

.form-container button[type=submit], .form-container button[type=button] {
  width: 100%;
  padding: 10px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.form-container button[type=submit] {
  background-color: #4CAF50;
  color: white;
}

.form-container button[type=submit]:hover {
  opacity: 0.8;
}

.form-container button[type=button] {
  background-color: #f44336;
  color: white;
  float: left;
}

.form-container button[type=button]:hover {
  opacity: 0.8;
}

.cancel {
  color: white;
  float: right;
  padding: 5px 10px;
  margin-top: -10px;
  background-color: #f44336;
  border-radius: 5px;
  cursor: pointer;
}

.cancel:hover {
  opacity: 0.8;
}
</style>

<script>
function openForm() {
  document.getElementById("popupForm").style.display = "block";
}

function closeForm() {
  document.getElementById("popupForm").style.display = "none";
}
</script>

	
	
</body>
</html>