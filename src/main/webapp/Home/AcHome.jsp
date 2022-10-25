<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c"    uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<head>

<%
   String m2id=request.getParameter("m2id");
   if(m2id!=null){
      if (request.getAttribute("boardlist") == null) {
         response.sendRedirect("/sns/controller/selectAc?pageRoute=selectAc&m2id="+m2id);
      } 
   } else { %>  <%} 
   
%>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<style>   <%@ include file="style.jsp" %>   
</style><meta charset="UTF-8">
<title>AcHome - 계정 홈</title>
<jsp:include page="../Nav/AcNav.jsp"/>




</head>   



<body style="background-color:#f5f5f5;">
   


   <div class="container" id="profile">
      <div class="box" style="margin-right:80px;">
          <img class="profile" src="../profilephoto/${memberlist.getPfp() }">
          <p> 
      </div>      
      <div class="profile" style="margin-top:10px;">
         <div style="display:flex;">
            <h3 style="margin-right:30px;">${memberlist.getMid() }</h3>
            <button class="btn btn-secondary" style="background-color:#6667AB;"
               onclick="location.href='/sns/controller/follow?pageRoute=follow&mid=${memberlist.getMid()}'">팔로우</button>
            </div>
         <div style="display:flex; margin-top:20px;">
             <p style="margin-right:20px;"> 게시물 : ${len } 
             <p style="margin-right:20px;"> 팔로워 : ${follower } 
             <p> 팔로우 : 0
          </div>
          <div style="margin-top:10px;">
             <p> ${memberlist.getIntro() } 
          </div>
          
      </div>
      
   </div>
   
   <div class="container" style="margin-bottom:30px;">
      <br><br><hr>
   </div>
   
   
    <c:set var="arr" value="${(len%3>0) ? len/3+1 : len/3}"/>   
    <c:set var="loops" value="false"/>        
    <c:if test="${len>0}">   
         <c:set var="counts" value="0"/>
       <c:forEach var="k" begin="0" end="${arr-1}">
          <c:set var="a" value="${(len%3!=0)?(k<=len/3-1) ? 3:(len%3==1)?1:2 : 3}"/>
          <c:if test="${not loops}">                       
             <div class="container" id="bphotos">      
                <c:forEach var="i" begin="${0}" end="${a-1}">                                            
                   <div class="child">
                     <c:forEach var="p"  begin="0" end="${firstphoto.size() - 1}">
                        <c:if test="${firstphoto.get(p).getBid() eq boardlist.get(i+k*3).getBid()}">                           
                           <img class=""style="width:300px; height:300px; margin-left:10px; margin-bottom:10px; "alt="..." 
                           src="../ImageFile/${firstphoto.get(p).getPhoto()}" 
                           onclick="location.href='../board/AcContent.jsp?m2id=<%=m2id %>&index=${i+k*3}'"/>                        
                        </c:if>
                     </c:forEach>   
                   </div>                               
                   <c:set var="counts" value="${counts+1}"/>                                                                  
                </c:forEach>                         
            </div>                  
            
         </c:if>
      </c:forEach>
   </c:if>      


</body>


</html>