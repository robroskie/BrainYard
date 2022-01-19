<!-- List all questions for a selected category -->
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8" %>
<%@ include file="LoginFilter.jsp" %>

<!doctype html>
<html lang="en">

    <head>
        <!-- Required meta tags -->
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    
        <link rel="stylesheet" href="profileStyle.css">

        <!-- Bootstrap CSS -->
        <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
        <title>BrainYard: Questions by Category</title>
    
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
            function changeContent(arg1) {
                $('#content').load('./UniversalQuery.jsp?arg1=' + arg1);
            }
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
                        <a class="dropdown-item" href="./ThreadedComments.jsp">ThreadedComments</a>
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
    <div class="container pt-3">
        <h4>Use the dropdown bar to select the category of question that you want to see!</h4>
    </div>


    <div class="container pt-3">
        <select id ="ddl" name="ddl" onmousedown="this.value='';" onchange="changeContent(this.value);">
                <option value='0' selected>All</option>
                <option value='1'>Anthropology</option>
                <option value='2'>Applied Science</option>
                <option value='3'>Art History</option>
                <option value='4'>Biology</option>
                <option value='5'>Chemistry</option>
                <option value='6'>Creative Writing</option>
                <option value='7'>Computer Science</option>
                <option value='8'>Economics</option>
                <option value='9'>Environmental Sciences</option>
                <option value='10'>Psychology</option>
                <option value='11'>Mathematics</option>
                <option value='12'>History</option>
                <option value='13'>Physics</option>
                <option value='14'>Management</option>
                <option value='Herpology'>Herpology</option>
                
            </select>
    </div>

    <div class="container pt-3" id="content">
        
            <% 
        
            String category = null;
            
            String SQL = "SELECT * FROM Questions WHERE Category = ? ORDER BY TimeUntilClose ASC";
            
            if(category == null) {
                out.println("Showing all categories");
                SQL = "SELECT * FROM Questions ORDER BY TimeUntilClose ASC";
            } else {
                out.println("Category ID: " + category);
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