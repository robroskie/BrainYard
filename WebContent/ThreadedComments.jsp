<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
<%@ include file="LoginFilter.jsp" %>

<!doctype html>
<html lang="en">

<head>
    <script src="ThreadedCommentsScript.js"></script>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
        integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    
    <link rel="stylesheet" href="./standard.css">
    <link rel="stylesheet" href="./StyleDocs/threaded.css" />

    <title>Threaded Comments | Bootstrap 4</title>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.6.0.js"
        integrity="sha256-H+K7U5CnXl1h5ywQfKtSj8PCmoN9aaq30gDh27Xc0jk=" crossorigin="anonymous"></script>
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

<body>
<div class='container comments-box'>
    <ul class='timeline-comments'>  

    <% 
    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";


    int QId =  Integer.parseInt(request.getParameter("QId"));
    String UserId;
    String Description;
    String Category;
    String ClosingDate;
    String TimePosted;
    String TimeRemaining;
    String sql="SELECT QId, UserId, Description, Category, TimeUntilClose, postTime, CONCAT(DaysRemaining,   ' Day(s), ', HoursRemaining, ' Hour(s), ', MinutesRemaining, ' Minute(s), ', SecondsRemaining, ' Second(s)'), Expired FROM Questions WHERE QId = ? ORDER BY TimeUntilClose ASC";
    
    String Sql2="SELECT UserName FROM BUser WHERE UserId=?";
    String UN;

    try 
    {	// Load driver class
        Class.forName("com.mysql.jdbc.Driver");
    }
    catch (java.lang.ClassNotFoundException e) {
        System.err.println("ClassNotFoundException: " +e);	
    }
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
        PreparedStatement ps=con.prepareStatement(sql);PreparedStatement ps2=con.prepareStatement(Sql2);) 
    {		
        
        ps.setInt(1,QId);
        ResultSet rst=ps.executeQuery();
    
        rst.next();
        QId = rst.getInt(1);
        UserId = String.valueOf(rst.getInt(2));
        Description = String.valueOf(rst.getString(3));
        Category = String.valueOf(rst.getInt(4));
        ClosingDate = String.valueOf(rst.getTimestamp(5));
        TimePosted = String.valueOf(rst.getTimestamp(6));
        TimeRemaining = String.valueOf(rst.getString(7));

        ps2.setString(1,UserId);
        ResultSet rst1=ps2.executeQuery();
        rst1.next();
        UN=String.valueOf(rst1.getString(1));


        out.println("<li class='timeline-comment'>");
        out.println("    <div class='timeline-comment-wrapper'>");
        out.println("        <div class='card'>");
        out.println("            <div class='card-header d-flex align-items-center'>");
        out.println("                <a href='#' class='d-flex align-items-center'>");
        out.println("                    <img class='rounded-circle' src='Avatars/" + UserId + ".png' alt='avatar' />");
        out.println("                    <h5>" + UN + "</h5>");
        out.println("                </a>");
        out.println("                <div class='comment-date' data-toggle='tooltip' title=" + TimePosted + " data-placement='top'  data-original-title=" + TimePosted + ">" + TimePosted + " </div>");
        out.println("                <small class='text-muted ml-2'> Category: " + Category + "</small>");
        out.println("            </div>");
        out.println("            <div class='card-body'>");
        out.println("                <p class='card-text'>");
        out.println(                    Description);
        out.println("                </p>");
        out.println("            </div>");
        out.println("            <div class='card-footer bg-white p-2'>");
        out.println("                <button type='button' class='btn btn-secondary btn-sm'>Reply</button>");
        out.println("                <small class='text-muted ml-2'> Time Remaining: " + TimeRemaining + "</small>");
        out.println("            </div>");
        out.println("        </div>");
        out.println("    </div>");
    } catch (SQLException ex) { 	
        out.println(ex); 
    }
    %>

    <ul class='timeline-comments'>  
    <%
    String AnswerID;
    String QuestionID;
    //String Description;
    String AverageRating;
    String UserName;
    

    sql="SELECT Answers.AnsId AS AnswerID, BUser.UserId, UserName, Description, AVG(Score) AS Rating, Answers.PTime AS TimePosted, RatingId FROM BUser, Answers, Ratings WHERE BUser.UserId=Answers.userId AND Answers.AnsId=Ratings.AnsId AND QId=? GROUP BY Answers.AnsId, BUser.UserId, UserName, Description, Answers.PTime, RatingId ORDER BY Rating DESC";
    
    try 
    {	// Load driver class
        Class.forName("com.mysql.jdbc.Driver");
    }
    catch (java.lang.ClassNotFoundException e) {
        System.err.println("ClassNotFoundException: " +e);	
    }
    try ( Connection con = DriverManager.getConnection(url, uid, pw);
        PreparedStatement ps=con.prepareStatement(sql);) 
    {		
	
        ps.setInt(1,QId);
        
        ResultSet rst=ps.executeQuery();
        
        while (rst.next()) {
            AnswerID = String.valueOf(rst.getInt(1));
            UserId=String.valueOf(rst.getInt(2));
            UserName=String.valueOf(rst.getString(3));
            Description = String.valueOf(rst.getString(4));
            AverageRating = String.valueOf(rst.getInt(5));
            TimePosted=String.valueOf(rst.getString(6));
            
            out.println("<li class='timeline-comment'>");
            out.println("    <div class='timeline-comment-wrapper'>");
            out.println("        <div class='card'>");
            out.println("            <div class='card-header d-flex align-items-center'>");
            out.println("                <a href='#' class='d-flex align-items-center'>");
            out.println("                    <img class='rounded-circle' src='Avatars/" + UserId + ".png' alt='avatar' />");
            out.println("                    <h5>"+ UserName +"</h5>");
            out.println("                </a>");
            out.println("                <div class='comment-date' data-toggle='tooltip' title=" + TimePosted + " data-placement='top'  data-original-title=" + TimePosted + ">" + TimePosted + " </div>");
            out.println("            </div>");
            out.println("            <div class='card-body'>");
            out.println("                <p class='card-text'>");
            out.println(                    Description);
            out.println("                </p>");
            out.println("            </div>");
            out.println("            <div class='card-footer bg-white p-2'>");
            //out.println("                <button type='button' class='btn btn-secondary btn-sm'>Reply</button>");
            out.println("                <small class='text-muted ml-2'> Average Rating: " + AverageRating + "</small>"); 
            
            out.println("                 <br><small style='padding-left: 20px;' > My rating </small>"); 
           
            out.println("<FORM style='padding-left: 20px;'  action='ThreadedCommentsHandler.jsp' method='post' id='form' class='' value=''> <P> <input type='range' name='ratingValue' min='1' max='5' value='1' class='slider' id='myRange'> <INPUT type='submit' name='Send'> </P> </FORM>");
            
            out.println("            </div>");
            out.println("        </div>");
            out.println("    </div>");
            out.println("</li>");
        }
        
    } catch (SQLException ex) { 	
        out.println(ex); 
    }
    %>
</li>
</ul>
</div>

    <!-- Optional JavaScript -->
    <!-- jQuery first, then Popper.js, then Bootstrap JS -->
    <script src="https://code.jquery.com/jquery-3.3.1.slim.min.js" integrity="sha384-q8i/X+965DzO0rT7abK41JStQIAqVgRVzpbzo5smXKp4YfRvH+8abtTE1Pi6jizo" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js" integrity="sha384-ZMP7rVo3mIykV+2+9J3UJ46jBk0WLaUAdn689aCwoqbBJiSnjAK/l8WvCWPIPm49" crossorigin="anonymous"></script>
    <script src="./assets/js/bootstrap.min.js"></script>
    <script>
        /* Activate tooltip */
        $('[data-toggle="tooltip"]').tooltip();
    </script>

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
                        <object type="text/html" data="./authorizationavi.jsp" width="450px" height="500px"
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