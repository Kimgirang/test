<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>

<jsp:include page="../CssLink/CssLink.jsp" flush="true" />
<!-- style here -->
<style>
	* { font-family: 'Spoqa Han Sans Neo', 'sans-serif'; }
#homeNav {
  background-color:white;
  background-clip:border-box;
  padding-top:15px;
  padding-bottom:30px;
  margin-bottom:70px;
  
  width: 100%;
  position: relative;
  text-align: center;

}
#homeNav>a {
  display: block;
  font-size: 25px;
  font-weight: 900;
  position: absolute;
  left: 10%;
}

#homeNav *{
	color: #6667AB;
}

#homeNav>form {
	display:inline-block;
	top:50%;
}
#homeNav>form>input{
	width:240px;
	height:35px;
	border:1px solid #6667AB;
	border-radius: 7px;
	background-color:#EFEFEF;
}

/* width 가 1100이상일 때 */
@media(min-width :1000px){
	#homeNav>ul {
	  padding: 0 20px;
	  height: 30px;
	  color: #fff;
	  position: absolute;
	  transform: translateY(-20px);
	  right: 30px;
	  
	  display: inline-block;
	  list-style:none;
	  padding-left:0px;
	}
	#homeNav>ul li {
	  float: left;
	  line-height: 80px;
	  padding: 0 15px;
	}
	#homeNav .sideBar{
	display:none;
	}
}

/* width 가 1100이하로 내려가면 아이콘들 숨기게 하기 */
@media(max-width :1000px){
	#homeNav>ul>.n-sideBar{
		display:none;
	}
	#homeNav>ul>.sideBar {
	  padding: 0 20px;
	  height: 30px;
	  color: #fff;
	  position: absolute;
	  
	  right: 10%;
	  top:10px;
	  display: inline-block;
	  list-style:none;
	  padding-left:0px;
	}
	#homeNav>ul{
	margin-bottom:0px;
	}
}

</style>


<!-- html here -->
<nav id="homeNav">
    <a href="/sns/controller/HomePage">StarGram</a>
    
    <form method="post" name="searchForm" action="/sns/controller/getSearch">
    	<input type="text" name="searchText" />
    </form>

    <ul >
<!--알림 -->
      <li class="n-sideBar"><a href="/sns/controller/checkNoti">
      	<c:choose>
			<c:when test="${notiCount > 0 }"><i class="fa-solid fa-heart"></i></c:when>
			<c:when test="${empty notiCount || notiCount==0 }"><i class="fa-regular fa-heart"></i></c:when>
		</c:choose>
      </a></li>
<!--DM-->
      <li class="n-sideBar"><a href="/sns/controller/goDmPage"><i class="fa-solid fa-paper-plane"></i></a></li>
<!--글쓰기-->
      <li class="n-sideBar"><a href="/sns/controller/WritePage"><i class="fa-solid fa-pen"></i></a></li>
<!--내페이지-->      
      <li class="n-sideBar"><a href="/sns/controller/goMyPage"><i class="fa-solid fa-circle-user"></i></a></li>
<!-- 로그아웃 -->
	  <li class="n-sideBar"><a href="#" data-toggle="modal" data-target="#logout"><i class="fa-solid fa-arrow-right-from-bracket"></i></a></li>
<!--햄버거-->      
      <li class="sideBar">
      	<div class="dropdown">
  			<a class="btn btn-light dropdown-toggle" href="#" role="button" data-toggle="dropdown" aria-expanded="false">
   			 	<i class="fa-solid fa-bars"></i>
  			</a>
		  <div class="dropdown-menu">
		    <a class="dropdown-item" href="/sns/controller/WritePage"><i class="fa-solid fa-pen"></i>&nbsp; Write</a>
		    <a class="dropdown-item" href="#"><i class="fa-solid fa-paper-plane"></i>&nbsp; DM</a>
		    <a class="dropdown-item" href="/sns/controller/goMyPage"><i class="fa-solid fa-circle-user"></i>&nbsp; MyPage</a>
		    <a class="dropdown-item" href="#" data-toggle="modal" data-target="#logout"><i class="fa-solid fa-arrow-right-from-bracket"></i>&nbsp;LogOut</a>
		  </div>
		</div>
		</li>
    
    
    </ul>
    
       <%-- 로그아웃 모달 코드 --%>
   <div class="modal fade" id="logout" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-scrollable">
         <div class="modal-content" id="modalContent">
            <div class="modal-header" id="modalHeader">
            	<h4 class="modal-title">로그아웃</h4>
               <h5 id="h5" class="modal-title"></h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                  <span id="modalCloseSpan" aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body">
            	<p>로그아웃 하시겠습니까?
            </div>
            <div class="modal-footer">
					<button type="button" class="btn btn-light" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-light" data-dismiss="modal"onclick="location.href='/sns/controller/Logout'">로그아웃</button>
				</div>
         </div>
      </div>
   </div>
   <%-- 로그아웃 모달 코드 --%>

  </nav>
