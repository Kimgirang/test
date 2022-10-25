<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="member.memberDAO" %>  
<%@page import="member.memberDTO" %>
<%@page import="board.boardDAO" %>  
<%@page import="board.boardDTO" %>  
<%@taglib prefix = "c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ko">
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
th b{padding:0;}
</style>
</head>

<body>
<jsp:include page="managerNav.jsp"></jsp:include>
<div class="container" style="border:1px solid; border-color:#6667AB;">
	<c:choose>
		<c:when test="${list==null}">
			<jsp:forward page="/controller/manager"></jsp:forward>
		</c:when>
	</c:choose>

  <h2>회원목록</h2>  
  <div class="table-responsive">          
<!--   <table class="table table-bordered"> -->
  <table class="table table-striped w-auto ">
    <thead>
      <tr>
            <th><b>아이디</b></th>
            <th><b>비밀번호</b></th>
            <th><b>이메일</b></th>
            <th><b>핸드폰</b></th>
            <th><b>이름</b></th>
            <th><b>생년월일</b></th>
            <th><b>계정활성화</b></th>
            <th><b>게시글</b></th>
            <th><b>공개여부</b></th>
            <th><b>회원수정</b></th>  
            <th><b>회원삭제</b></th>               
      </tr>
    </thead>
    <tbody>
        <c:choose>
            <c:when test="${empty list}">
                <tr>
                    <td colspan="5">
                        <b>등록된 회원이 없습니다.</b>
                    </td>
                </tr>
            </c:when>
            
            <c:when test="${!empty list}">
                <c:forEach var="list" items="${list}">
                	
                    <tr>
                        <td>${list.getMid()}</td>
                        <td>${list.getPw()}</td>
                        <td>${list.getEmail()}</td>
                        <td>${list.getPhone()}</td>
                        <td>${list.getName()}</td>
                        <td>${list.getBirth()}</td>
 
                        <c:choose>
                        	<c:when test="${list.getIsprivate() eq 'no'}">
                        		<td>공개</td>
                        	</c:when>
                        	<c:otherwise>
                        		<td>비공개</td>
                        	</c:otherwise>
                        </c:choose>                        		         
                        <td><a href="/sns/controller/postList?manageID=${list.getMid()}" class="btn btn-light btn-lg active" role="button" aria-pressed="true" style="font-size: 0.68rem">목록</a></td>				
						<td><a href="/sns/controller/isprivateChange?mid=${list.getMid()}&isprivate=${list.getIsprivate()}" class="btn btn-light btn-lg active" role="button" aria-pressed="true" style="font-size: 0.68rem">전환</a></td>	
                        <td><a href="/sns/manager/update.jsp?manageID=${list.getMid()}"class="btn btn-light btn-lg active" role="button" aria-pressed="true" style="font-size: 0.68rem">회원수정</a></td>	
                        <td><a href="/sns/controller/mdelete?manageID=${list.getMid()}"class="btn btn-light btn-lg active" role="button" aria-pressed="true" style="font-size: 0.68rem">회원삭제</a></td>	
                </c:forEach>
            </c:when>
        </c:choose>

    </tbody>
  </table>
  </div>
</div>

</body>
</html>
