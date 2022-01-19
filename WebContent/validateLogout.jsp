<%@ page language="java" import="java.io.*,java.sql.*"%>
<%@ include file="jdbc.jsp" %>

<%  
	session.invalidate();
    response.sendRedirect("./ConfirmLogout.jsp");
%>