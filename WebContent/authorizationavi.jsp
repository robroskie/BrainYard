<%
Object authUser = session.getAttribute("authenticatedUser");
boolean authenticated = authUser == null ? false : true;
if (!authenticated){
   //String loginMessage = "You are not authorized to "+ "access the URL "+request.getRequestURL().toString(); 
   //session.setAttribute("loginMessage",loginMessage);
   //session.setAttribute("loginbutton","Log In");
   response.sendRedirect("login.jsp"); 
   return;
} else if (authenticated){
   response.sendRedirect("./myProfilenoNav.jsp"); 
   return;
}
%>