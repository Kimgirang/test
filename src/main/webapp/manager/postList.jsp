<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.memberDAO" %>  
<%@page import="member.memberDTO" %>
<%@page import="board.boardDAO" %>  
<%@page import="board.boardDTO" %>  
<%@taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
  <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/css/bootstrap.min.css">
  <script src="https://cdn.jsdelivr.net/npm/jquery@3.6.0/dist/jquery.slim.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"></script>
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.1/dist/js/bootstrap.bundle.min.js"></script>

<meta charset="UTF-8">
<title>관리자 페이지</title>
<style>
body{background-color: #f5f5f5;}
.container{border-color:#f5f5f5;
	padding:10px;
	text-align:center;
    border-radius: 10px;
    background-color: white;
    border-color:#6667AB;
    margin-top:50px;}
h2{padding: 30px;}
td{padding:10px;}
</style>
</head>
<body>
<jsp:include page="managerNav.jsp"></jsp:include>
	<div class="container" style="border:1px solid; border-color:#6667AB;">
		<c:choose>
			<c:when test="${list2==null}">
				<jsp:forward page="/controller/postList"></jsp:forward>
			</c:when>
		</c:choose>
	
	  <h2>게시글 목록</h2>  
<!-- 	      <div class="table-responsive">   -->
	        <table class="table table-striped">  
	    		<thead>        
	        		<tr>
			            <th><b>글번호</b></th>
			            <th><b>내용</b></th>
			            <th><b>작성날짜</b></th>
			            <th><b>삭제</b></th>
			        </tr>
			    </thead>
				<tbody>
			        <c:choose>
			            <c:when test="${empty list2}">
			                <tr>
			                    <td colspan="5">
			                        <b>등록된 글이 없습니다.</b>
			                    </td>
			                </tr>
			            </c:when>
			            
			            <c:when test="${!empty list2}">
			                <c:forEach var="list2" items="${list2}">				
								<tr>
							      <td>${list2.getBid()}</td>
							      <td>${list2.getContent()}</td>
							      <td>${list2.getBirth()}</td>
				                  <td><a href="/sns/controller/postDel?bid=${list2.getBid()}&id=${list2.getId()}"class="btn btn-light btn-lg active" role="button" aria-pressed="true" style="font-size: 0.68rem">삭제</a></td>	                  		                    
					    		</tr>   
			                </c:forEach>
			            </c:when>
			        </c:choose>			
				</tbody>
	    	</table>
	    </div>
    
</body>
</html>






