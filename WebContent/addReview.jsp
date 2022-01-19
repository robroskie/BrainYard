<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ page import="java.sql.*" %>
<%@ page import="java.sql.PreparedStatement" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.Date" %>
<!DOCTYPE html>
<html>
<head>
    <!-- Required meta tags -->
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

    <!-- Bootstrap CSS -->
    <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
    <title>List all answers!</title>

    <link rel="stylesheet" href="standard.css">
</head>

<h1>Use the dropdown bar to select the category of question that you want to see!</h1>



<% 
String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
String uid = "SA";
String pw = "YourStrong@Passw0rd";





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
	ResultSet rst = stmt.executeQuery("SELECT QID, Description, MAX(Rating) AS MaxRating FROM (SELECT QID, Description, AVG(Score) AS Rating FROM Answers, Ratings WHERE Answers.AnsId=Ratings.AnsId GROUP BY QID, Description) AS E1 GROUP BY QID, Description HAVING MaxRating=EE.Rating)";		
	out.println("<table><tr><th>QId</th><th>UserId</th><th>Description</th><th>Category</th><th>TimeUntilClose</th><th>postTime</th></tr>");
	while (rst.next())
	{	out.println("<tr><td>"+rst.getInt(1)+"</td></tr>");
	}
	out.println("</table>");
}
catch (SQLException ex) 
{ 	out.println(ex); 
}
%>

</body>
</html>