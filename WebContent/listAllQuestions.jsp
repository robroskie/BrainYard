<!-- List all questions for a selected category -->
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="LoginFilter.jsp" %>

<!doctype html>
<html lang="en">
    
    <head>
 
        <link rel="stylesheet" href="profileStyle.css">
        
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <title>BrainYard: Questions</title>
    
        <link rel="stylesheet" href="./standard.css">
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
        <script>
            jQuery(document).ready(function ($) {
                $('[data-href]').click(function () {
                    window.location = $(this).data("href");
                });
            });
        </script>
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




<div class="container pt-3">
    <h3 style="text-align: center;">Questions that have been posted</h3>
<% 
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";


String s="Hi";


try 
{	// Load driver class
	Class.forName("com.mysql.jdbc.Driver");
}
catch (java.lang.ClassNotFoundException e) {
	System.err.println("ClassNotFoundException: " +e);	
}
try ( Connection con = DriverManager.getConnection(url, uid, pw);
      Statement stmt = con.createStatement();) 
{		
	// ResultSet rst = stmt.executeQuery("SELECT * FROM Questions ORDER BY TimeUntilClose ASC");		
    ResultSet rst = stmt.executeQuery("SELECT QId, UserId, Description, Category, TimeUntilClose, postTime, CONCAT(DaysRemaining,   ' Day(s),   <br>    ', HoursRemaining, ' Hour(s) <br>', MinutesRemaining, ' Minute(s) <br> ', SecondsRemaining, ' Second(s)'), Expired FROM Questions ORDER BY TimeUntilClose ASC");	
    
    out.println("<table class='table'><thead><tr><th>QId</th><th>UserId</th><th>Description</th><th>Category</th><th>Closing Date</th><th>Time Posted</th><th>Time Remaining</th><th> </th></tr></thead><tbody>");

    while (rst.next()) {
        int tempQid = rst.getInt(1);
    
        out.println("<tr><td>"+rst.getInt(1)+"</td>"+"<td>"+rst.getInt(2)+"</td>"+"<td>"+rst.getString(3)+"</td>"+"<td>"+rst.getInt(4)+"</td><td>"+rst.getTimestamp(5)+"</td><td>"+rst.getTimestamp(6)+"</td><td>"+rst.getString(7)+"<form action=\"./addAnswer.jsp\" method=\"post\"><td><button id=\"button\" class="+rst.getString(8)+" type=\"submit\" name=\"QId\" value=\""+rst.getInt(1)+"\"><small>Answer me!</small></td></form> " + "<form action=\"./ThreadedComments.jsp\" method=\"post\"><td><button id=\"button2\" class="+rst.getString(8)+" type=\"submit\" name=\"QId\" value=\""+rst.getInt(1)+"\"><small>See Answers</small></td>  </form>   </tr>");

    }
    
    out.println("</tbody></table>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
%>
</div>

<script src="listallQuestionsScript.js"></script>
    
    <!-- Modal -->
    <div id="LogButton" class="modal fade" role="dialog">

        <div class="modal-dialog">
            <!-- Modal content-->
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Sign into BrainYard</h4>
                    <button type="button" class="close" data-dismiss="modal">&times;</button>
                </div>

                <div class="modal-body">
                    <!-- <p>This is where our sign in code/status will go.</p> -->
                    
                    <div class="container-md">
                        <object type="text/html" data="./authorizationavi.jsp" width="450px" height="600px"
                            style="overflow:auto;">
                        </object>
                    </div>

                </div>
                <div class="modal-footer">
                    <button onClick="window.location.reload();" type="button" class="btn btn-default" data-dismiss="modal">Close</button>
                </div>

            </div>
        </div>
    </div>
</body>
</html>


