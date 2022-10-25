<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>

   <style type="text/css">

	/* 프로필사진 */
	.box {width: 60px; height: 60px; border-radius: 70%; overflow: hidden; background: #BDBDBD;}
	.profile {width: 100%; height: 100%; object-fit: cover; display:flex;}
	
	/* 무한 스크롤 */
	html, body{ margin: 0; }      
	h1 {position: fixed; top: 0; width: 100%; height: 60px; text-align: center; background: white; margin: 0; line-height: 60px; }
	section .box {height: 500px; background: red;}
	section .box p {margin: 0; color: white; padding: 80px 20px;}
	section .box:nth-child(2n) {background: blue;}
	
	/* 게시글 사진 */
	img {width: 500px; height: 500px; }
	
	/* 게시글 내부 요소들 왼쪽 여백 */
	.sort {padding-left: 10px;}
	     
	/*삭제메뉴 */
	.material-symbols-outlined {font-variation-settings:'FILL' 0,'wght' 400,'GRAD' 0,'opsz' 48;}

   </style>
   
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>AcContent</title>
</head>   
<body style="background-color:#f5f5f5;">
   
   
   <jsp:include page="../Nav/HomeNav.jsp"/>
   

   <!-- Home 페이지로 처음 오거나 다른 페이지에서 왔을때 게시물의 정보를 출력하기 위해 DB에 있는 게시물 정보를 가져옴 -->
   <c:if test="${listBoard == null }">
      <script>
      	location.href="/sns/controller/selectBoard?pageRoute=selectBoard&m2id=${param.m2id}&index=${param.index}";
      </script>    
   </c:if>   
   
   <!-- 게시물 몇번째까지 출력할것인지 설정하는 변수 end -->   
   <c:choose>
      <%-- 버튼 안눌렀을때(기능 실행 안했을때) --%>
      <c:when test="${boardCount == null}">
			<c:if test="${len<=5&&len>0}">
				<c:set var="begin" value="0"/>
				<c:set var="end" value="${len-1}"/>
			</c:if>			
			<!-- 게시글 여섯개 이상 -->
			<c:if test="${len>5}">			
				<!--세번째 게시글까지 0부터 아래로 두개 더 출력 후 아래로 무한스크롤 -->
				<c:if test="${param.index<3}"><c:set var="begin" value="0"/><c:set var="end" value="${param.index+2}"/></c:if>
				<!--네번째 게시글부터 위아래 2개 출력후 위아래로 무한스크롤 -->
				<c:if test="${param.index>=3}"><c:set var="begin" value="0"/><c:set var="end" value="${param.index+2}"/></c:if>		
				<!--끝에서 두번째 게시글부터 위로 2개 아래로 len-1만큼 출력후 위로 무한스크롤 -->
				<c:if test="${param.index>len-3}"><c:set var="begin" value="0"/><c:set var="end" value="${len-1}"/></c:if>					
			</c:if>	
      </c:when>
      
      <%-- 버튼 눌렀을때(기능 실행 했을때) --%>
      <c:otherwise>
      <c:if test="${boardCount+2>0 && len-1>0 }">
          <!-- 끝에서 두번째 게시글부터는 무한스크롤 없이 전부 포문으로 출력 -->
	      <c:if test="${boardCount>len-3}"><c:set var="begin" value="0"/><c:set var="end" value="${len-1}"/></c:if>		
	      <!-- 끝에서 두번째전까지는 버튼눌린 게시글+2 만큼 출력 -->
	      <c:if test="${boardCount<=len-3}"><c:set var="begin" value="0"/><c:set var="end" value="${boardCount + 2}"/></c:if>		
       </c:if>
      </c:otherwise>
   </c:choose>
   
   <!-- ─────────────────────────────────────────────────────────────────────────── -->
   <!-- 전체 게시물 출력 시작 -->
   

      <br><br>
      <div class="container">
         <section>
            <c:forEach var="i"  begin="${begin}" end="${end}">
               <%-- 게시글 번호(나중엔 삭제 예정) --%>
               <div id="bphoto${i}" style="width: 502px; border: 1px solid #6667AB; border-radius: 20px;">
               	<div style="display:flex;">
               		<div style="width:50%;">	              
                   	 	<%-- 게시글 작성자 프사(작성자 페이지 링크), 아이디(작성자 페이지 링크) --%>	
	                    <div style="display:flex; margin-left:20px;margin-top:30px;">
		                    <p class="box" style="width: 60px; height: 60px; border-radius: 70%; overflow: hidden; background: #BDBDBD;"><img class="profile" onclick="location.href='/sns/controller/AcHomePage?m2id=${listBoard.get(i).getId()}'" 
		                    src="../profilephoto/${listBoard.get(i).getPfp()}"/>
		                   	<p style="margin-left:10px; margin-top:18px;">아이디 <a href="/sns/controller/AcHomePage?m2id=${listBoard.get(i).getId()}">
		                   	${listBoard.get(i).getId()}</a></p>
	                    </div>                 
                   </div>
                   <div style="width:50%;" >
					<!-- 삭제 -->

					<c:if test="${memberId == m2id }">
                   		<button class="btn btn-secondary" style="background-color:#6667AB; margin-left:70%; margin-top:20px; 
                   		font-color:#BEC3C9;" onclick="scrollStop('delete', ${listBoard.get(i).getBid()}, ${i})">del</button>
                   </c:if>                   		
                   </div>
                </div>   
                  <c:if test="${photo.size() - 1 >= 0}">
                     <div id="demo${i}" class="carousel slide" data-ride="carousel" style="width: 500px;" data-interval="false">
                        <div class="carousel-inner">
                           <div class="carousel-inner" role="listbox">
                               <c:set var="pCount" value="0"></c:set>
                               
                               <%-- 사진 뿌리기 시작 --%>
                                 <c:forEach var="p"  begin="0" end="${photo.size() - 1}">
                                  <c:if test="${photo.get(p).getBid() eq listBoard.get(i).getBid()}">
                                    <c:choose>
                                       <c:when test="${pCount == 0}">
                                       
                                          <div class="carousel-item active">
                                             <img class="" src="../ImageFile/${photo.get(p).getPhoto()}" alt="...">
                                             </div>
                                             <c:set var="pCount" value="${pCount + 1}"></c:set>
                                       </c:when>
                                       
                                       <c:otherwise>
                                          <div class="carousel-item">
                                             <img class="" src="../ImageFile/${photo.get(p).getPhoto()}" alt="...">
                                             </div>
                                             <c:set var="pCount" value="${pCount + 1}"></c:set>
                                       </c:otherwise>
                                       
                                    </c:choose>
                                  </c:if>
                               </c:forEach>
                               <%-- 사진 뿌리기 종료 --%>
                           </div>
                           
                            <%-- 화살표 버튼 시작 --%>
                            <a class="carousel-control-prev" href="#demo${i}" data-slide="prev" style="height: 500px;">
                                 <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                              </a>
                            <a class="carousel-control-next" href="#demo${i}" data-slide="next" style="height: 500px;">
                                 <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            </a>
                            <%-- 화살표 버튼 종료 --%>
                         
                              <%-- 인디케이터 시작 --%>
                            <ul class="carousel-indicators" style="height: 40px;">
                                 <li data-target="#demo" data-slide-to="0" class="active"></li>
                                 <li data-target="#demo" data-slide-to="1"></li>
                                 <li data-target="#demo" data-slide-to="2"></li>
                            </ul>
                            <%-- 인디케이터 종료 --%>
                          </div>
                     </div>         
                   </c:if>
                   <br>
                   
                   <%-- 좋아요(모달), 댓글(모달), 공유(모달), 게시물 저장 버튼(좋아요만 됨) --%>
                  <p class="sort" style="margin-top: -15px;">
					<i class="bi-heart" onclick="location.href='/sns/controller/likeWho?pageRoute=likeWho&bid=${listBoard.get(i).getBid()}&boardCount=${i}&index=${param.index}&m2id=${param.m2id }'"></i>
<%--                            <i class="bi-heart-fill" style="font-size: 33px; color: #6667AB; cursor: pointer; margin-right: 20px;" onclick="scrollStop('likeWho', ${listBoard.get(i).getBid()}, ${i})"></i> --%>
                     <i class="bi bi-chat-dots" style="font-size: 25px; -webkit-text-stroke: 1px; color: #6667AB; cursor: pointer; margin-right: 17px;" onclick="scrollStop()"></i>
                     <i class="bi bi-share" style="font-size: 25px; -webkit-text-stroke: 1px; color: #6667AB; cursor: pointer; margin-right: 20px;"></i>
                     <i class="bi bi-bookmark-plus" style="font-size: 25px; -webkit-text-stroke: 1px; color: #6667AB; cursor: pointer; float: right; padding-right: 10px;"></i>
                     
                  <%-- 좋아요 1개 이상일때만 보여주기 --%>
                  <c:if test="${listBoard.get(i).getLikeCount() != 0}">
                     <p class="sort" style="margin-top: -5px;"><a style="color: #6667AB;" href="#" data-toggle="modal" data-target="#logout" data-bid="${listBoard.get(i).getBid()}">좋아요 ${listBoard.get(i).getLikeCount()}개</a>
                  </c:if>
                  
                  <%-- 게시글 내용 --%>
                  <p class="sort" style="font-weight: 400;">게시글 내용 ${listBoard.get(i).getContent()}
                  
                  <%-- 댓글 1개 이상일때만 보여주기 --%>
                  <c:if test="${listBoard.get(i).getCommentCount() != 0}">
                     <p class="sort"><a style="color: #6667AB;" href="/sns/controller/selectBoardDetail?pageRoute=selectBoardDetail&bid=${listBoard.get(i).getBid()}">댓글 ${listBoard.get(i).getCommentCount()}개 보기</a>
                  </c:if>
                  
                  <%-- 게시글 작성 날짜 --%>
                  <p class="sort" style="font-size: 13px; font-weight: 350;">${listBoard.get(i).getBirth()}
                  <hr style="border: 0; height: 1px; background-color: #6667AB;">
                  
                  <%-- 댓글 --%>
                  <p style="margin-top: -10px;">
                     <form name="form${listBoard.get(i).getBid()}" method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=${listBoard.get(i).getBid()}&commentDetail=Home&boardCount=${i}">
                        <input type="text" class="form-control" name="comment" placeholder="댓글을 달아보세요!" style="background-color: transparent; width: 440px; float: left; border: none;">
                        <button class="btn btn-secondary" style="color: #6667AB; background-color: #f5f5f5; border: none;">등록</button>
                     </form>
                  <div style="margin-top: 10px;"></div>
               </div>
               <br><br>
            </c:forEach>
         </section>
         
      </div>
      <br><br><br>
   
   <!-- 전체 게시물 출력 종료 -->
   <!-- ─────────────────────────────────────────────────────────────────────────── -->
   
   
   <!-- 무한 스크롤은 페이지를 처음 띄우거나 다른 페이지에서 왔을때의 경우와 버튼을 눌렀을때의 경우로 나뉨 -->
   <c:if test="${boardCount == null }">
      <c:set var="boardCount" value="-1"></c:set>
   </c:if>
   
   
   <!-- ─────────────────────────────────────────────────────────────────────────── -->
   <!-- 자바스크립트 코드 시작 -->
   
   <script>
      
   // 스크롤 할때마다 현재 Y축 좌표를 sessionStorage.Y에 담는다. sessionStorage는 자바의 session과 비슷하다 
   window.addEventListener('scroll', () => { 
      sessionStorage.HomeY = window.scrollY;
      console.log(sessionStorage.HomeY);
      
   });
   
   
   // Java → JSTL(EL) → JavaScript 순으로 정보를 옮겨담음 
   // listBoard 가져오기
   var listBoard = new Array();
   <c:forEach items="${listBoard}" var="listBoard">         
      listBoard.push({
         bid            : "${listBoard.getBid()}",
         id            : "${listBoard.getId()}",
         content         : "${listBoard.getContent()}" ,
         birth         : "${listBoard.getBirth()}" ,
         likeCount      : "${listBoard.getLikeCount()}" ,
         pfp            : "${listBoard.getPfp()}" ,
         photo         : "${listBoard.getPhoto()}" ,
         commentCount   : "${listBoard.getCommentCount()}" 
      }); 
    </c:forEach> 
   
    
   // photo 가져오기
   var listPhoto = new Array();
   <c:forEach items="${photo}" var="photo">         
      listPhoto.push({
         bid            : "${photo.getBid()}",
         photo         : "${photo.getPhoto()}",
         photo2         : "${photo.getPhoto2()}"
      }); 
    </c:forEach>  
   
    
   // 버튼(좋아요, 댓글 등)을 눌렀을때 몇번째 게시물인지 알수 있는 함수 
   var boardCount = <c:out value="${boardCount}"></c:out>
        
   
   <!-- ─────────────────────────────────────────────────────────────────────────── -->
   <!-- 무한 스크롤 시작 -->
   
   // 버튼(좋아요, 댓글 등)을 눌렀을때 boardCount에 담긴 게시물 index값의 +2번째부터 무한 스크롤 적용
   // 2번째 게시물의 버튼을 눌렀으면 5번째 게시물부터 무한 스크롤 적용(4번째 게시물까지는 미리 만들어놓기 때문)
   if (boardCount != -1) {
      var index = boardCount + 3;
      var index2 = index;

   }
   
   else {
		  var index = '${param.index+3}';
	      var index2 = '${param.index+3}';

   }
   

   if(${len}>5){   
   window.onscroll = function(e) {
      if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) { 
    	  
    	  if(${param.index}<${len-3} && ${boardCount}<${len-3}){
         var addContent = document.createElement("div");

         // 좋아요 if
         if (listBoard[index].likeCount > 0) {
            var like = '<p class="sort" style="margin-top: -5px;"><a style="color: #6667AB;" href="#" data-toggle="modal" data-target="#logout" data-bid="' + listBoard[index].bid + '">좋아요 ' + listBoard[index].likeCount + '개</a>';
         }
         else {
            var like = '';
         }
         
         // 댓글 if
         if (listBoard[index].commentCount > 0) {
            var comment = '<p class="sort"><a style="color: #6667AB;" href="/sns/controller/selectBoardDetail?pageRoute=selectBoardDetail&bid=' + listBoard[index].bid + '">댓글' + listBoard[index].commentCount + '개 보기</a>';
         }
         
         else {
            var comment = '';
         }
         
         // 사진 뿌리기
         var pCount = 0;
         
         if (listPhoto.length -1 >= 0) {
            var photoDivStart = '<div id="demo' + index2 + '" class="carousel slide" data-ride="carousel" style="width: 500px;" data-interval="false">' +
                                '<div class="carousel-inner">' +
                                   '<div class="carousel-inner" role="listbox">';
            for (var p = 0; p < listPhoto.length - 1; p++) {
               if (listPhoto[p].bid == listBoard[index2].bid) {
                  if (pCount == 0) {
                     photoDivStart += '<div class="carousel-item active">';
                  }
                  else {
                     photoDivStart += '<div class="carousel-item">';
                  }
                  photoDivStart +=    '<img class="" src="../ImageFile/' + listPhoto[p].photo2 + '" alt="...">' +
                               '</div>';
                  pCount += 1;
               }
            }
            var photoDivEnd =    '' +
                                  '</div>' +
            
                                  '<a class="carousel-control-prev" href="#demo' + index2 + '" data-slide="prev" style="height: 500px;">' + 
                                       '<span class="carousel-control-prev-icon" aria-hidden="true"></span>' + 
                                    '</a>' + 
                                  '<a class="carousel-control-next" href="#demo' + index2 + '" data-slide="next" style="height: 500px;">' + 
                                       '<span class="carousel-control-next-icon" aria-hidden="true"></span>' + 
                                  '</a>' + 
                            
                                  '<ul class="carousel-indicators" style="height: 40px;">' + 
                                       '<li data-target="#demo" data-slide-to="0" class="active"></li>' + 
                                       '<li data-target="#demo" data-slide-to="1"></li>' +
                                       '<li data-target="#demo" data-slide-to="2"></li>' +
                                  '</ul>' +
                              '</div>' +
                           '</div>' + 
                           '<br>';
         }
         
         addContent.innerHTML =  '' +
                           '<div style="width: 502px; border: 1px solid #6667AB; border-radius: 20px;">' +
                              '<p><h3 class="sort">' + listBoard[index].bid + '번 게시글</h3>' +
                              '<p class="sort">' + 
                                 '작성자 프사 ' + '<a href="/sns/controller/AcHomePage?m2id=' + listBoard[index].id + '">' + listBoard[index].pfp + '</a> ' +
                                 '아이디 ' + '<a href="/sns/controller/AcHomePage?m2id=' + listBoard[index].id + '">' + listBoard[index].id + '</a> ' + 
                              photoDivStart + 
                              photoDivEnd + 
                              '<p class="sort" style="margin-top: -15px;">' + 
                                 '<i class="bi-heart" style="font-size: 23px; -webkit-text-stroke: 1px; color: #6667AB; cursor: pointer; margin-right: 20px;" onclick="scrollStop(\'likeWho\', ' + listBoard[index].bid + ', ' + index + ')"></i>' +
                                 '<i class="bi bi-chat-dots" style="font-size: 25px; -webkit-text-stroke: 1px; color: #6667AB; cursor: pointer; margin-right: 17px;" onclick="scrollStop(' + listBoard[index].bid + ')"></i>' + 
                                 '<i class="bi bi-share" style="font-size: 25px; -webkit-text-stroke: 1px; color: #6667AB; cursor: pointer; margin-right: 20px;"></i>' +
                                 '<i class="bi bi-bookmark-plus" style="font-size: 25px; -webkit-text-stroke: 1px; color: #6667AB; cursor: pointer; float: right; padding-right: 10px;"></i>' +
                              like +
                              '<p class="sort" style="font-weight: 400;">게시글 내용 ' + listBoard[index].content +
                              comment + 
                              '<p class="sort" style="font-size: 13px; font-weight: 350;">' + listBoard[index].birth +
                              '<hr style="border: 0; height: 1px; background-color: #6667AB;">' +
                              '<p style="margin-top: -10px;">' + 
                                  '<form name="form' + listBoard[index].bid + '" method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=' + listBoard[index].bid + '&commentDetail=Home&boardCount=' + index + '">' + 
                                     '<input type="text" class="form-control" name="comment" placeholder="댓글을 달아보세요!" style="background-color: transparent; width: 440px; float: left; border: none;">' + 
                                     '<button class="btn btn-secondary" style="color: #6667AB; background-color: #f5f5f5; border: none;">등록</button>' +
                                  '</form>' + 
                               '<div style="margin-top: 10px;"></div>' + 
                               '</div>' + 
                               '<br><br>';
         document.querySelector('section').appendChild(addContent);
         index ++;
         index2 ++;
      }
      }

   }
   }
      
   <!-- 무한 스크롤 종료 -->
   <!-- ─────────────────────────────────────────────────────────────────────────── -->
   
   
   // 버튼 눌렀을때 오는 함수
   function scrollStop(pageRoute, bid, boardCount) { 
      
      // 좋아요 눌렀을때
      if (pageRoute == 'likeWho') {
         location.href="/sns/controller/likeWho?pageRoute=likeWho&bid=" + bid + "&boardCount=" + boardCount+"&index=${param.index}&m2id=${param.m2id}";
      }
       
          // 댓글 눌렀을때
          else if (pageRoute == 'insertComment') {
             location.href="/sns/controller/insertComment?pageRoute=insertComment&bid=" + bid + "&commentDetail=Home&boardCount=" + boardCount;
      }
      	  // 삭제 눌렀을때
          else if (pageRoute == 'delete') {        	  
              	location.href="/sns/controller/delete?pageRoute=delete&bid=" + bid + "&boardCount=" + boardCount+"&index=${param.index}&m2id=${param.m2id}";        	  
       }
      
      
      
   }
   
	// 버튼이 눌렸을때
	if(boardCount!=-1){
	 //버튼 눌렸던 위치로 
	 window.scrollTo(0, sessionStorage.HomeY); 
	 } 
	 //버튼 눌리지 않고 achome, selfhome에서 왔을때
	 else{	
		// 선택한 게시글 위치로
 		var selectedboard = document.querySelector("#bphoto${param.index}").offsetTop;//선택한 게시글 위치	
 		window.scrollTo({top:selectedboard-115, behavior:'auto'});//해당위치로 스크롤 이동 
	 }
	 
   </script>
    
    <!-- 자바스크립트 코드 종료 -->
    <!-- ─────────────────────────────────────────────────────────────────────────── -->
   
</body>
</html>