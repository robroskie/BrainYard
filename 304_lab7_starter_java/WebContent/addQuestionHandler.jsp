<%@ page import="java.sql.*" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Date" %>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <title>Query results using JSP!</title>

    <link rel="stylesheet" href="standard.css">
</head>

<nav class="navbar navbar-expand-lg navbar-light bg-light">

    <a href="HelloWorld.jsp" class="navbar-left"><img src=".\Resources/Brain_Yard_logo.png" width="150 px"></a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">

            <li class="nav-item active">
                <a class="nav-link" href="./index.jsp">Home <span class="sr-only">(current)</span></a>
            </li>

            <li class="nav-item">
                <a class="nav-link" href="./loaddata.jsp">Load Data</a>
            </li>

            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false">
                    Dropdown
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="./AjaxTest/ajaxtest.jsp">Ajax Test</a>
                    <a class="dropdown-item" href="./testQuery.jsp">testQuery.jsp</a>
                    <a class="dropdown-item" href="./listAllQuestions.jsp">listAllQuestions.jsp</a>
                    <a class="dropdown-item" href="./addQuestion.jsp">addQuestion.jsp</a>
                    <a class="dropdown-item" href="./addQuestionHandler.jsp">addQuestionHandler.jsp</a>
                    <a class="dropdown-item" href="./correctAnswers.jsp">correctAnswers.jsp</a>

                    <div class="dropdown-divider"></div>
                    <a class="dropdown-item" href="#">Something else here</a>
                </div>
            </li>
            <li class="nav-item">
                <a class="nav-link disabled" href="#">Disabled</a>
            </li>
        </ul>

        <form class="form-inline my-2 my-lg-0">
            <input class="form-control mr-sm-2" type="search" placeholder="Search" aria-label="Search">
            <button class="btn btn-outline-success my-2 my-sm-0" type="submit">Search</button>
        </form>

        <!-- Trigger the modal with a button -->
        <button type="button" class="btn btn-info btn-md little-margin-left" data-toggle="modal"
            data-target="#LogButton">Login
            to the site</button>

    </div>
</nav>






    <body>



        
    <!-- Add a question -->
    <%
    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";
    

    // Parse values
    
        String category = request.getParameter("category");
        String description = request.getParameter("description");
        int userid = Integer.parseInt(request.getParameter("userid"));
    



    try 
    {	// Load driver class
        Class.forName("com.mysql.jdbc.Driver");
    }
    catch (java.lang.ClassNotFoundException e) {
        System.err.println("ClassNotFoundException: " +e);	
    }

    String SQL = "INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (?,?,?,?,?)";
    String SQL2 = "SELECT CategoryId FROM Categories WHERE subjTitle=?";


//INSERT Questions(UserId, Description, Category, TimeUntilClose, postTime) VALUES (1, 'How does a Cas9 protein recognize its complementing genetic target sequence?', 4, '2012-04-11 12:12:12', '2012-05-11 12:12:12');

    try ( Connection con = DriverManager.getConnection(url, uid, pw); PreparedStatement ps = con.prepareStatement(SQL);  PreparedStatement ps2 = con.prepareStatement(SQL2);) {
        //Get integer value from category string

        
        long millis=System.currentTimeMillis();  
        java.sql.Date date=new java.sql.Date(millis); 

        ps.setInt(1, userid);;
        ps.setString(2, description);
        
        //This value needs to be category mapped from the string value to corresponding int value	
        ps.setInt(3, 6);
        ps.setDate(4, date);	
        ps.setDate(5, date);	
        int updateQuery = ps.executeUpdate();	

        if(updateQuery != 0)
            out.println("successfully updated"); 


        ps2.setString(1,category);
        int rs2 = ps2.executeUpdate();
        
        out.println("rs2 is: " + rs2);
        
        //rs2.next();
        
        //int categoryNum = rs2.getInt(1);
        //out.println(categoryNum);





        

    }
    catch (SQLException ex) { 
        	out.println(ex); 
    }

    %>

        <!-- Print added question -->
        <p>Added question from category of:<strong> <%=category%> </strong></p>
        <p>Question description:<i> <%=description%> </i>.</p>

    </body>
</html>



