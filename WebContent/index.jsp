<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="SessionLoggedCheck.jsp" %>
<%@ include file="loaddata.jsp" %>

<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css"
        integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <title>BrainYard: Main Page</title>
    
    <link rel="stylesheet" href="./standard.css">
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
    <div id="carouselExampleIndicators" class="carousel slide" data-ride="carousel">
        <ol class="carousel-indicators">
            <li data-target="#carouselExampleIndicators" data-slide-to="0" class="active"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="1"></li>
            <li data-target="#carouselExampleIndicators" data-slide-to="2"></li>
        </ol>

        <div class="carousel-inner">
            <!-- <h1 style="position:absolute; z-index: 20; color: black; top: 25%;">Centered</h1> -->
            <div class="carousel-item active">
                <img class="d-block w-100" src="./Resources/1.svg" alt="First slide"
                    style="height: 800px; object-fit:cover; object-position: bottom;">
                <!-- <div class="hero-text" style="z-index: 20; color: white; text-shadow: 1px 1px 4px #000000;">
                    <h1 style="font-size:50px">BrainYard</h1>
                    <h3>Please start by loading the database.</h3>
                </div> -->
            </div>



            <div class="carousel-item">
                <img class="d-block w-100" src="./Resources/2.svg"
                    alt="Second slide" style="height: 800px; object-fit: cover; object-position: bottom;">
                <!-- <div class="hero-text" style="z-index: 20; color: white; text-shadow: 1px 1px 4px #000000;">
                    <h1 style="font-size:50px">Collaborate</h1>
                    <h3>Work together with a community of students</h3>
                </div> -->
            </div>
            <div class="carousel-item">
                <img class="d-block w-100"
                    src="./Resources/3.svg" alt="Third slide"
                    style="height: 800px; object-fit: cover; object-position: bottom;">
            </div>
        </div>
        <a class="carousel-control-prev" href="#carouselExampleIndicators" role="button" data-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="sr-only">Previous</span>
        </a>
        <a class="carousel-control-next" href="#carouselExampleIndicators" role="button" data-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="sr-only">Next</span>
        </a>
    </div>
    

    <div class="container-fluid pt-2">
        <div class="row" style="padding:10px; background-color: #b8e7de; height: 600px;">
            <div class ="col">
                <div class="hero-text" style="align-content:center;">
                    <h1 style="font-size:50px; color: #3b8c80;">BrainYard</h1>
                    <p style="color: black;"> Want to know more about us? Visit our GitHub Page. </p>
                    <a style="color: black;" href="https://github.com/joegaspari/BrainYard"> https://github.com/joegaspari/BrainYard </a>
                </div>
            </div>
        </div>
    </div>
    <div class="container-fluid pt-2" style="width: 100%;">
        <div class="row justify-content-center" style=" height: 300px;">
            <div class ="col" style=" background-size: contain; background-position: center; background-repeat: no-repeat; background-color:beige; border-right: 5px solid white;">
                <div class="hero-text">
                    <h1 style="font-size:50px; color: #3b8c80;">Questions about the team?</h1>
                    <p style="color: black;"> Reach out to us via Canvas. </p>
                </div>
            </div>
            <div class ="col" style="background-color: aquamarine; border-left: 5px solid white;">
                <div class="hero-text">
                    <h1 style="font-size:50px; color: #3b8c80;">Exchange Brainyard Points for Bitcoin.</h1>
                    <p style="color: black;"> Coming soon. </p>
                </div>
            </div>
        </div>
        
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