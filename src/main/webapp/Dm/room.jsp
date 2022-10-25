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
	    <c:if test="${listdm == null }">
	       <script>
	          location.href="/sns/controller/selectDm?pageRoute=selectDm&room=${param.room}";
	       </script>
	    </c:if>	    

		<div class="container">	   
			<c:if test="${len-1>0 }">
				<h2>${listdm.get(0).getId()}번 채팅방</h2><br/>
				<c:forEach var="i"  begin="0" end="${len-1}">
					<div style="display:flex;">
						<p style="margin-left:15px;">${listdm.get(i).getMessage()}</p><hr>	
												
					</div> 	<hr/>			
				</c:forEach>
			</c:if>
		</div>
		
	</body>
</html>