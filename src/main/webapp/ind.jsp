<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Live Search Example</title>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.2.1/jquery.min.js"></script>
</head>
<body>
    <form>
        <input type="text" id="search" placeholder="Search by name...">
        <div id="search-results"></div>
    </form>
    <script>
        $(document).ready(function() {
            $("#search").on("keyup", function() {
                var name = $(this).val();
                if (name != "") {
                    $.ajax({
                        url: "fetch.jsp",
                        type: "post",
                        data: {name: name},
                        success: function(response) {
                            $("#search-results").html(response).show();
                        }
                    });
                } else {
                    $("#search-results").hide();
                }
            });
        });
    </script>
</body>
</html>
