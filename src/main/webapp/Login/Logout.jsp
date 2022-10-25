<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>
<jsp:useBean id="member" class="member.memberDTO" scope="session" />

<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>?</title>
</head>	
<body>

   	<jsp:include page="../Nav/HomeNav.jsp"></jsp:include>   	
   	<% 
   		session.removeAttribute("memberId");
   		request.getRequestDispatcher("Login.jsp").forward(request, response);
   	%>	
</body>
</html>