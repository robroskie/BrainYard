<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<%
	String authenticatedUser = null;
    String oldpage = String.valueOf(request.getRequestURL());
	session = request.getSession(true);

	try
	{
		session.setAttribute("sourcePage", oldpage);
		authenticatedUser = checkLogin(out,request,session);
	}
	
	catch(IOException e)
	{	System.err.println(e); }

	if(authenticatedUser == "Log In") {
		response.sendRedirect("login.jsp");		// Failed login - redirect back to login page with a message 
	}
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

<%!
	public String validateLogin(JspWriter out,HttpServletRequest request, HttpSession session) throws IOException
	{
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String retStr = null;

		if(username == null || password == null)
				return null;
		if((username.length() == 0) || (password.length() == 0))
				return null;
        
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
        
        String sql="SELECT University, UserName, Password, UserId, profilepic FROM BUser WHERE UserName=? AND Password=?";
    
		try(Connection con = DriverManager.getConnection(url, uid, pw); PreparedStatement ps=con.prepareStatement(sql);)
		{
			ps.setString(1,username);
            ps.setString(2,password);

            ResultSet rst=ps.executeQuery();
            rst.next();
            String University=rst.getString(1);
            String retUsName=rst.getString(2);
            String retPasswor=rst.getString(3);
            int userId=rst.getInt(4);
			String profilePic=rst.getString(5);

            
            if(username.equals(retUsName) && password.equals(retPasswor))
                retStr=retUsName;
            
			if(retStr != null){	
                session.removeAttribute("loginMessage");
			    session.setAttribute("authenticatedUser",username);
                session.setAttribute("userId",userId);
                session.setAttribute("University", University);
				session.setAttribute("profilePic", profilePic);
				

		        } else {
			    	session.setAttribute("loginMessage","Could not connect to the system using that username/password.");
                }
		
			// TODO: Check if userId and password match some customer account. If so, set retStr to be the username.
					
		} 
		catch (SQLException ex) {
			out.println(ex);
		}

		return retStr;
		
    }
%>

