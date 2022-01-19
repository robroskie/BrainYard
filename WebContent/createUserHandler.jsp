<%@ page import="java.sql.*" %>
<%@ include file="LoginFilter.jsp" %>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <title>BrainYard: Main Page</title>

    <link rel="stylesheet" href="./standard.css">
    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    
    <link rel="stylesheet" href="profileStyle.css">

    <script src="https://code.jquery.com/jquery-3.6.0.js" integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk="
        crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"
        integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49"
        crossorigin="anonymous"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"
        integrity="sha384-ChfqqxuZUCnJSK3+MXmPNIyE6ZbWh2IMqE241rYiqJxyMiZ6OW/JmZQ5stwEULTy"
        crossorigin="anonymous"></script>
</head>

<nav class="navbar navbar-expand-lg navbar-light bg-light">

    <a href="index.jsp" class="navbar-left"><img src="./Resources/BrainYardLogo.png" width="50 px" style="border-radius: 90%;"></a>

    <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent"
        aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
        <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
        <ul class="navbar-nav mr-auto">

            <li class="nav-item active">
                <a class="nav-link" href="./index.jsp">Home <span class="sr-only">(current)</span></a>
            </li>

            <li class="nav-item dropdown">
                
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdown" role="button" data-toggle="dropdown"
                    aria-haspopup="true" aria-expanded="false">
                    Queries
                </a>

                <div class="dropdown-menu" aria-labelledby="navbarDropdown">
                    <a class="dropdown-item" href="./listAllQuestions.jsp">Browse Questions</a>
                    <a class="dropdown-item" href="./listAllQuestionsByCategory.jsp">Browse Questions by Category</a>
                    <a class="dropdown-item" href="./addQuestion.jsp">Submit A Question</a>
                    <a class="dropdown-item" href="./correctAnswers.jsp">Correct Answers</a>
                    <a class="dropdown-item" href="./answerHandler.jsp">List Your Answers</a>
                    <a class="dropdown-item" href="./myProfile.jsp">My Profile</a>
            
                </div>
            </li>
        </ul>

        <a href="index.jsp" class="navbar-right"><img src="<%=String.valueOf(session.getAttribute("profilePic"))%>" width="50 px" style="border-radius: 90%;"></a>

        <button type="button" class="btn btn-info btn-md little-margin-left" data-toggle="modal"
            data-target="#LogButton"> <%= session.getAttribute("loginbutton") %>
        </button>
        
    </div>
</nav>
<!-- Connection Information -->
    <%
   
    

   
    String email = request.getParameter("email");
    String username = request.getParameter("username");
    String password = request.getParameter("pass");
    String university = request.getParameter("University");
    String major = request.getParameter("Major");
    String currYear = request.getParameter("Current-Year");
    String GPA = request.getParameter("GPA");
    
    String pemail = request.getParameter("Preferred-Email");
    String bitadr = request.getParameter("BitCoin");
    String etheadr= request.getParameter("Ethereum");
    String dogadr = request.getParameter("Doge");

    try 
    {	// Load driver class
        Class.forName("com.mysql.jdbc.Driver");
    }
    catch (java.lang.ClassNotFoundException e) {
        System.err.println("ClassNotFoundException: " +e);	
    }

    String SQL = "INSERT BUser(StudentEmail, Faculty, University, UserName, Password, GPA, CurrentYear, PreferredEmail) VALUES (?,?,?,?,?,?,?,?)";
    String SQL2 ="SELECT UserId FROM BUser WHERE UserName=?";
    String SQL3 = "INSERT PayMethod(UserId, DogeAd, BitAd, EthAd) VALUES (?,?,?,?)";
   
    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";
    
    try ( Connection con = DriverManager.getConnection(url, uid, pw);PreparedStatement ps = con.prepareStatement(SQL);) {
        
        ps.setString(1, email);
        ps.setString(2, major);
        ps.setString(3, university);
        ps.setString(4, username);
        ps.setString(5, password);
        ps.setString(6, GPA);
       
        int rowInsert=ps.executeUpdate();

            if(rowInsert != 0){
                 out.println("Successfully added you as a user! you're Fresh Meat now!"); }
        
     }

    catch (SQLException ex) { 
                        //out.println(ex); 
     }
        
     try ( Connection con = DriverManager.getConnection(url, uid, pw); PreparedStatement ps2 = con.prepareStatement(SQL2);PreparedStatement ps3 = con.prepareStatement(SQL3);) {
                  
        ps2.setString(1, username);
        ResultSet rs=ps2.executeQuery();
        rs.next();
        int userId=rs.getInt(1);
        
        ps3.setInt(1, userId);
        ps3.setString(2, dogadr);
        ps3.setString(3, bitadr);
        ps3.setString(4, etheadr);

        int payInsert=ps3.executeUpdate();
        if(payInsert != 0)
            out.println("Successfully updated your wallet Addresses!"); 
        
     }catch (SQLException ex) { 
                //out.println(ex); 
        }

    %>