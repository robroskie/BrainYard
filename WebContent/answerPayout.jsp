<!-- Query to Show a question and all related answers -->


<!-- calculate the top rated answer based on average ratings -->

<!-- List all questions for a selected category -->
<%@ page import="java.sql.*,java.net.URLEncoder" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF8"%>
<%@ include file="LoginFilter.jsp" %>

<!doctype html>
<html lang="en">
    
    <head>

    <body>
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
      Statement stmt = con.createStatement();
      PreparedStatement ps = con.prepareStatement("SELECT * FROM Answers WHERE QId=?");){		
			
    ps.setInt(1,3);
    
    ResultSet rst = stmt.executeQuery("SELECT Description FROM Questions");	
    ResultSet rst2 = ps.executeQuery();
   
    rst.next();
    
    out.println("<h2>"+rst.getString(1)+"</h2>");

    while(rst2.next()){
        out.println("<div>"+ rst2.getString(6));
    }

}

catch (SQLException ex) { 	
    out.println(ex); 
}
%>


</body>
</html>


