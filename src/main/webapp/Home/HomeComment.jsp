<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"    uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>HomeComment</title>
</head>   
<body>

   <jsp:include page="../Nav/HomeNav.jsp"/>
   
   <br><br>
   <div class = "container">
      <p>─────────────────────────────────────────────────────────────
      
      <p>작성자 프사 <a href="/sns/controller/AcHomePage?m2id=${listBoardDetail[0].id}">${listBoardDetail[0].pfp}</a> 아이디 <a href="/sns/controller/AcHomePage?m2id=${listBoardDetail[0].id}">${listBoardDetail[0].id}</a>
      <p>게시글 내용 ${listBoardDetail[0].content}
      <p>게시글 날짜 ${listBoardDetail[0].birth}
      <p>─────────────────────────────────────────────────────────────
      <c:forEach var="listCommentDetail" items="${listCommentDetail}" varStatus="status">
      	 <p>cid = ${listCommentDetail.commentId}</p>
         <p>댓글 작성자 프사 <a href="/sns/controller/AcHomePage?m2id=${listCommentDetail.id}">${listCommentDetail.pfp}</a> 아이디 <a href="/sns/controller/AcHomePage?m2id=${listCommentDetail.id}">${listCommentDetail.cid}</a>
         <p>댓글 내용 ${listCommentDetail.content}
         <p>댓글 날짜 ${listCommentDetail.birth} 좋아요 ${listCommentDetail.likeCount}
         <c:if test="${memberId eq listCommentDetail.cid}">
            <button class="btn btn-secondary" onclick="location.href='/sns/controller/deleteComment?pageRoute=deleteComment&cid=${listCommentDetail.commentId}&commentDetail=HomeComment&bid=${listBoardDetail[0].bid}'">삭제</button>
         </c:if>
         <p>────────────────────────────
      </c:forEach>
      <form method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=${listBoardDetail[0].bid}&commentDetail=HomeComment">
         <input name="comment" type="text" class="form-control" id="comment" placeholder="댓글 달기" style="width: 200px; float: left;">
         <button type="submit" class="btn btn-secondary" onclick="/sns/controller/insertComment?pageRoute=insertComment&bid=${listBoardDetail[0].bid}&commentDetail=HomeComment">등록</button>
      </form>
      <p>─────────────────────────────────────────────────────────────
   </div>
   
   
   
   
   
   
</body>
</html>