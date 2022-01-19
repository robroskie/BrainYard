<%@ page import="java.sql.*" %>

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

<%
    // HttpSession session = request.getSession(); 
    // session.setAttribute("user", user);
    if(session.getAttribute("authenticatedUser") != null){
        
    //  <!-- Connection Information -->
    String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
    String uid = "SA";
    String pw = "YourStrong@Passw0rd";
    

    try {	
        Class.forName("com.mysql.jdbc.Driver");
    }
    catch (java.lang.ClassNotFoundException e) {
        System.err.println("ClassNotFoundException: " +e);	
    }

    //Get total number of questions by userid
    String SQL = "SELECT UserId, COUNT(Qid) FROM Questions WHERE UserId=? GROUP BY UserId";

    //Get total number of answers by userid
    String SQL1 = "SELECT userId, COUNT(AnsId) FROM Answers WHERE userId=? GROUP BY userId";


    

    try ( Connection con = DriverManager.getConnection(url, uid, pw); PreparedStatement ps = con.prepareStatement(SQL); PreparedStatement ps1 = con.prepareStatement(SQL1);) {
        //Get integer value from category string
        int userId = (int)session.getAttribute("userId");
        
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();	
        rs.next();
        String numQuestions = rs.getString(2);
        session.setAttribute("numQuestions", numQuestions);
        ps.close();

        ps1.setInt(1, userId);
        ResultSet rs1 = ps1.executeQuery();	
        rs1.next();
        String numAns = rs1.getString(2);
        session.setAttribute("numAns", numAns);   

  
    }

    catch (SQLException ex) { 
        	out.println(ex); 
    }

    String SQL3="SELECT UserName, (COUNT(DISTINCT Qid)*UStatus.BitX) AS BitAmo, (COUNT(DISTINCT Qid)*UStatus.EthX) AS EthAmo, (COUNT(DISTINCT Qid)*UStatus.DogX) AS DogeAmo, ROUND(AVG(Avgscore),2) AS userAvg FROM BUser,UStatus,CorAnswers WHERE BUser.UserStatus=UStatus.StatId AND BUser.UserId=CorAnswers.userId AND BUser.UserName=? GROUP BY UserName,UStatus.BitX, UStatus.EthX, UStatus.DogX";
    try ( Connection con = DriverManager.getConnection(url, uid, pw); PreparedStatement ps = con.prepareStatement(SQL3);) {
        String usname=(String)session.getAttribute("authenticatedUser");
        ps.setString(1,usname);

        ResultSet rest=ps.executeQuery();
        rest.next();
        String Bitamo=rest.getString(2);
        String Ethamo=rest.getString(3);
        String Dogeamo=rest.getString(4);
        Float userAvg=rest.getFloat(5);

        session.setAttribute("Bitamo", Bitamo);
        session.setAttribute("Ethamo", Ethamo);
        session.setAttribute("Dogeamo", Dogeamo);
        session.setAttribute("userAvg",userAvg);
    }
    catch(SQLException ex){
        out.println(ex);
    }
}

%>
    
<body>
    <div class="container pt-2 d-flex justify-content-center">
        <div class="card p-3" >
            <div class="d-flex align-items-center">
                <div class="image"> <img style="width: 150px; border-radius: 50%;" src="<%=String.valueOf(session.getAttribute("profilePic"))%>"> </div>
                <div class="ml-3 w-100">
                    <div class="flex-row pt-2">
                    <h4 class="mb-0 mt-0"><%= session.getAttribute("userId")%></h4> 
                    <span>User ID</span>
                    <h4 class="mb-0 mt-0"><%= session.getAttribute("University")%></h4> <span>School</span>
                    <div class="p-2 mt-2 bg-primary d-flex justify-content-between rounded text-white stats">
                        <div class="d-flex flex-column"> <span class="articles">Questions  </span> <span class="number1"> <%= session.getAttribute("numQuestions")%> </span> </div>
                        <div class="d-flex flex-column"> <span class="followers">Answers  </span> <span class="number2"><%= session.getAttribute("numAns")%></span> </div>
                        <div class="d-flex flex-column"> <span class="rating">Rating</span> <span class="number3"><%= session.getAttribute("userAvg")%></span> </div>
                    </div>
                    </div>
                    <div class="button mt-2 btn-sm" style="text-align: center;"> <form action="addQuestion.jsp" method="post">  <button class="btn btn-sm btn-primary w-100 ml-2"><span></span>Ask a question</button></form>  </div>
                    <div class="button mt-2 btn-sm" style="text-align: center; box-sizing: content-box; "><form action="checkOUT.jsp" method="post">  <button class="btn btn-sm btn-primary w-100 ml-2"  style="text-align: center;">Add <h1>$$$</h1>Wallet</button></form> </div>
                </div>
            </div>
        </div>
    </div>
    <div class="container2 mt-2 d-flex justify-content-center">
        <div class="card p-3">
            <div class="d-flex align-items-center">
                <div class="w-100">
                    <h4 class="mb-0 mt-0" id="balheader">Your Balances</h4>
                    <div class="p-2 mt-2 bg-primary d-flex justify-content-between rounded text-white stats">
                         <div class="d-flex flex-column">  <span class="articles coins" id="bitcoin">Bitcoin <img src="Resources/bitcoin.jpg" id="bitcoinimg" align="right" width="25" height="25"></span><html>  <span class="number1">"<%=String.valueOf(session.getAttribute("Bitamo"))%>" </span>  </div>
                        <div class="d-flex flex-column"> <span class="followers coins" id="eth">Etherum <img src="Resources/eth.png" align="right" width="22" height="22"></span> <span class="number2">"<%=String.valueOf(session.getAttribute("Ethamo"))%>"</span> </div>
                        <div class="d-flex flex-column"> <span class="rating coins" id="dogecoin">Dogecoin <img src="Resources/doge.png" align="right" width="22" height="22"> </span> <span class="number3">"<%=String.valueOf(session.getAttribute("Dogeamo"))%>"</span> </div>
                    </div>
                    <div class="flex-row pt-2">
                        <div class="col text-center">
                            <a href="validateLogout.jsp" class="btn btn-info" role="button">Log Out</a>
                        </div>
                    </div>
                 
            </div>
        </div>
    </div>
</body>
</html>

