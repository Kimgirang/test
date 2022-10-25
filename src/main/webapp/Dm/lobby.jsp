<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
	<head>
		<jsp:include page="../CssLink/HomeCSS.jsp"></jsp:include>   
		<meta charset="UTF-8">
	<title>lobby</title>
	</head> 

	<body style="background-color: #f5f5f5;">       
	    <jsp:include page="../Nav/HomeNav.jsp"/>  
	    <c:if test="${listDm == null }">
	       <script>
	          location.href="/sns/controller/selectDm?pageRoute=selectDm";
	       </script>
	    </c:if>	    

		<div class="container">	   
			<c:if test="${Len-1>0 }">
				<c:forEach var="i"  begin="0" end="${Len-1}">
					<div style="display:flex;">
						<button onclick="location.href='../Dm/room.jsp?room=${listDm.get(i).getId()}'"
						class="btn btn-secondary" style="background-color:#6667AB;">
						${listDm.get(i).getId()}번 채팅방 </button>
						
						<p onclick="location.href='../Dm/room.jsp?room=${listDm.get(i).getId()}'" style="margin-top:5px; margin-left:15px;">	
						${listDm.get(i).getMessage()} </p>							
					</div> <hr>				
				</c:forEach>
			</c:if>
		</div>
	   
	</body>
</html>