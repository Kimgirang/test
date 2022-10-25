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
	border-radius:7px;
	padding:10px 0px 0px 0px;
	background-color:white;
}

.container h2{
	padding-bottom:10px;
	border-bottom:1px solid #6667AB;
	color:#6667AB;
}

.container ul{
	list-style:none;
	padding-left:0px;
}
.wrap-profile{
display:flex;
padding-left:30%;
}
.profilePhoto{
width:50px;
height:50px;
overflow:hidden;
border-radius: 70%;
display:flex;
margin-right:20px;

}
.profilePhoto>a{
width:100%;
height:100%;
}
.profile{
width:100%;
height:100%;
}
.wrap-profile > .id-tag{
margin:auto 0;
font-size:1.1rem;
color:#6667AB;
}
ul > li{
margin-bottom:10px;
}
</style>
</head>	
<body style="background-color:#f5f5f5;">


	
	<div class="container" style="text-align:center;">
		<h2>검색된 회원</h2>
		<ul>
		<c:forEach var="memberDTO" items="${searchedList }">
			<li>
			<div class="wrap-profile">
			<div class="profilePhoto">
			<a href="/sns/controller/AcHomePage?m2id=${memberDTO.getMid() }"><img class="profile" src="../profilephoto/${memberDTO.getPfp() }"/></a>
			</div>
			<a class="id-tag" href="/sns/controller/AcHomePage?m2id=${memberDTO.getMid() }">${memberDTO.getMid() }</a>
			</div>
	
		</c:forEach>
		</ul>
	</div>
	
	
	
	
	
</body>
</html>