<%@ page import="java.sql.*" %>

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <title>Query Results using JSP</title>

    <link rel="stylesheet" href="standard.css">
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    
    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
</head>

<body>
    <div class="container pt-3">
    <% 

    String category = request.getParameter("arg1");
    String SQL = "SELECT * FROM Questions WHERE Category = ? ORDER BY TimeUntilClose ASC";
    
    if(category == null) {
        SQL = "SELECT * FROM Questions ORDER BY TimeUntilClose ASC";
    } else if (category.equals("0")) {
        SQL = "SELECT * FROM Questions ORDER BY TimeUntilClose ASC";
        category = null;
    }
    

    String url="jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid="SA"; 
    String pw="YourStrong@Passw0rd"; 

    try {
        // Load driver class 
        Class.forName("com.mysql.jdbc.Driver"); 
    } catch (java.lang.ClassNotFoundException e) { 
        System.err.println("ClassNotFoundException: " +e);
    }
    
     

    try ( 
        Connection con = DriverManager.getConnection(url, uid, pw); 
        PreparedStatement ps = con.prepareStatement(SQL);
    )

        {	
            if(category != null) {
                ps.setString(1,category);
            }
            
            ResultSet rst = ps.executeQuery();
                //ResultSet rst = stmt.executeQuery("SELECT * FROM Questions ORDER BY TimeUntilClose ASC"); 

            out.println("<table class='table'><thead><tr><th>QId</th><th>UserId</th><th>Description</th><th>Category</th><th>TimeUntilClose</th><th>postTime</th></tr></thead><tbody>");
            
            while (rst.next()) {
                out.println("<tr><td>"+rst.getInt(1)+"</td>"+"<td>"+rst.getInt(2)+"</td>"+"<td>"+rst.getString(3)+"</td>"+"<td>"+rst.getInt(4)+"</td><td>"+rst.getTimestamp(5)+"</td><td>"+rst.getTimestamp(6)+"</td></tr>");
            }
            
            out.println("</tbody></table>");
            
        } catch (SQLException ex) { out.println(ex); }
    %>
    </div>
</body>
</html>