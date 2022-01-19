<%@ page language="java" import="java.io.*,java.sql.*"%>

<%
	String authenticatedUser = null;
    
	session = request.getSession(true);

	try
	{
		authenticatedUser = checkLogin(out,request,session);
	}
	
	catch(IOException e)
	{	System.err.println(e); }

	session.setAttribute("loginbutton", authenticatedUser);	
%>

<%!
	String checkLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String retStr = null;

		//String url = "jdbc:sqlserver://db:1433;DatabaseName=tempdb;";
        //String uid = "SA";
        //String pw = "YourStrong@Passw0rd";
                
        try 
        {	
			if(
				String.valueOf(session.getAttribute("authenticatedUser")) != "null"
				) {
				session.setAttribute("loginstatus", true);	
				retStr = String.valueOf(session.getAttribute("authenticatedUser"));
			} else {
				retStr = "Log In";
				session.setAttribute("loginstatus", false);
				session.setAttribute("profilePic", "Avatars/Transparent.png");
			}
        }
        catch (Exception e) {
             System.err.println("Exception: " +e);	
        }
		return retStr;		
    }
%>