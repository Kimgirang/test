<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>Searched</title>
<!-- add Nav -->
<jsp:include page="../Nav/HomeNav.jsp" flush="true" />
<style>
.container{
	border:1px solid #6667AB;
	border-radius:10px;
	padding:10px;
	background-color:white;
	
}
</style>
</head>	
<body style="background-color:#f5f5f5;">


	
	<div class="container" style="text-align:center;">
		<h1>알림</h1>
		<c:choose>
			<c:when test="${empty notiList}">
			<p>알림없음
			</c:when>
			<c:when test="${not empty notiList}">
				<c:forEach var="i" begin="0" end="${notiList.size()-1 }">
					<p>${notiList.get(i) }</p>
				</c:forEach>
			</c:when>
		</c:choose>
		
	</div>
	
	
	
	
	
</body>
</html>