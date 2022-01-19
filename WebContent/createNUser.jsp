<!doctype html>
<html lang="en">

<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <title>Login Page!</title>

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
                    <a class="dropdown-item" href="./myProfile.jsp">myBrain</a>
                </div>
            </li>
        </ul>
        <a href="index.jsp" class="navbar-right"><img src="<%=String.valueOf(session.getAttribute("profilePic"))%>" width="50 px" style="border-radius: 90%;"></a>
        
        <button type="button" class="btn btn-info btn-md little-margin-left" data-toggle="modal"
            data-target="#LogButton">"<%=String.valueOf(session.getAttribute("authenticatedUser"))%>"</button>
        
    </div>
</nav>

<form action="createUserHandler.jsp" method="post">
    <!-- progressbar -->
   
    <!-- fieldsets -->
    <fieldset>
      <h2 class="fs-title">Create your account</h2>
      <h3 class="fs-subtitle">This is step 1</h3>
      <input type="text" name="email" placeholder="Student Email" />
      <input type="text" name="username" placeholder="User Name"/>
      <input type="password" name="pass" placeholder="Password" />
      <input type="password" name="cpass" placeholder="Confirm Password" />
      <input type="button" name="next" class="next action-button" value="Next" />
    </fieldset>
    <fieldset>
      <h2 class="fs-title">Personal Details</h2>
      <h3 class="fs-subtitle">We will never sell it</h3>
      <input type="text" name="University" placeholder="University" />
      <select name="Major" id="Major">
        <option value="Anthropology">Anthropology</option>
        <option value="Applied Science">Applied Science</option>
        <option value="Art History">Art History</option>
        <option value="Biology">Biology</option>
        <option value="Chemistry">Chemistry</option>
        <option value="Creative Writing">Creative Writing</option>
        <option value="Computer Science">Computer Science</option>
        <option value="Economics">Economics</option>
        <option value="Environmental">Environmental</option>
        <option selected="selected" value="Psychology">Psychology</option>
        <option value="Mathematics">Mathematics</option>
        <option value="History">History</option>
        <option value="Physics">Physics</option>
        <option value="Management">Management</option>
        <option value="null">null</option>
    </select>
      <input type="text" name="Current-Year" placeholder="Year" />
      <input type="value" name="GPA" placeholder="0.0" />
      <input type="text" name="Preferred-Email" placeholder="CrazyBrain@how/we/can/reach/you/best.ca" />
      <input type="button" name="previous" class="previous action-button" value="Previous" />
      <input type="button" name="next" class="next action-button" value="Next" />
    </fieldset>
    <fieldset>
      <h2 class="fs-title">Wallet Details</h2>
      <h3 class="fs-subtitle">Enter your Coin wallet adress!</h3>
      <input type="text" name="BitCoin" placeholder="BitAddress" />
      <input type="text" name="Ethereum" placeholder="EtheAddress" />
      <input type="text" name="Doge" placeholder="DogeAddress" />

      <input type="button" name="previous" class="previous action-button" value="Previous" />
      <input type="submit" name="submit" class="submit action-button" value="Submit" />
    </fieldset>
  </form>