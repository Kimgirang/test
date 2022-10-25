<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
   <jsp:include page="../CssLink/HomeCSS.jsp"></jsp:include>
   
   <style type="text/css">
    
   </style>
   
<meta charset="UTF-8">
<title>Home</title>
</head>   
<body style="background-color: #f5f5f5;">

<!--    <a id="toTop" href="#">맨위로</a>  -->
    
   <jsp:include page="../Nav/HomeNav.jsp"/>
   
   
   <!-- Home 페이지로 처음 오거나 다른 페이지에서 왔을때 게시물의 정보를 출력하기 위해 DB에 있는 게시물 정보를 가져옴 -->
   <c:if test="${listBoard == null }">
      <script>
         location.href="/sns/controller/selectBoard?pageRoute=selectBoard";
      </script>
   </c:if>
   
   
   <!-- 게시물 몇번째까지 출력할것인지 설정하는 변수 end -->
   <c:choose>
      <c:when test="${listBoard.size() <= 3 }">
         <c:set var="end" value="2"></c:set>
      </c:when>
      <c:otherwise>
         <c:set var="end" value="2"></c:set>
      </c:otherwise>
   </c:choose>
   
   <!-- 버튼을 눌렀으면(기능 실행했을때) -->
   <c:if test="${boardCount != null}">
<%--       <c:set var="end" value="${boardCount + 2}"></c:set> --%>
      <c:if test="${boardCount+2>0 && len-1>0 }">
          <!-- 끝에서 두번째 게시글부터는 무한스크롤 없이 전부 포문으로 출력 -->
	      <c:if test="${boardCount>len-3}"><c:set var="begin" value="0"/><c:set var="end" value="${len-1}"/></c:if>		
	      <!-- 끝에서 두번째전까지는 버튼눌린 게시글+2 만큼 출력 -->
	      <c:if test="${boardCount<=len-3}"><c:set var="begin" value="0"/><c:set var="end" value="${boardCount + 2}"/></c:if>		
       </c:if>
   </c:if>
   
   
   <!-- ─────────────────────────────────────────────────────────────────────────── -->
   <!-- 전체 게시물 출력 시작 -->
   
      <br><br>
      <div class="container">
         <section>
            <c:forEach var="i"  begin="0" end="${end}">
            
               <%-- 게시글 번호(나중엔 삭제 예정) --%>
               <div class="sectionDiv">
                    <p><h3 class="sort">${listBoard.get(i).getBid()}번 게시글</h3>
                    
                    <%-- 게시글 작성자 프사(작성자 페이지 링크), 아이디(작성자 페이지 링크) --%>
                    <div style="display:flex; margin-left:20px;">
                       <p class="box"><img class="profile" onclick="location.href='/sns/controller/AcHomePage?m2id=${listBoard.get(i).getId()}'" 
                       src="../profilephoto/${listBoard.get(i).getPfp()}"/>
                         <p style="margin-left:10px; margin-top:18px;">아이디 <a href="/sns/controller/AcHomePage?m2id=${listBoard.get(i).getId()}">
                         ${listBoard.get(i).getId()}</a></p>
                    </div>
                  <%-- 사진 뿌리기 시작 --%>
                  <c:if test="${photo.size() - 1 >= 0}">
                     <div id="demo${i}" class="carousel slide" data-ride="carousel" style="width: 500px;" data-interval="false">
                        <div class="carousel-inner">
                           <div class="carousel-inner" role="listbox">
                               <c:set var="pCount" value="0"></c:set>
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
                           </div>
                           
                            <%-- 화살표 버튼 시작 --%>
                            <a class="carousel-control-prev" href="#demo${i}" data-slide="prev">
                               <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                            </a>
                            <a class="carousel-control-next" href="#demo${i}" data-slide="next">
                               <span class="carousel-control-next-icon" aria-hidden="true"></span>
                            </a>
                            <%-- 화살표 버튼 종료 --%>
                         
                            <%-- 인디케이터 시작 --%>
                            <ul class="carousel-indicators">
                               <li data-target="#demo" data-slide-to="0" class="active"></li>
                               <li data-target="#demo" data-slide-to="1"></li>
                               <li data-target="#demo" data-slide-to="2"></li>
                            </ul>
                            <%-- 인디케이터 종료 --%>
                          </div>
                     </div>         
                   </c:if>
                   <br>
                   <%-- 사진 뿌리기 종료 --%>
                   
                   <%-- 좋아요(모달), 댓글(모달), 공유(모달), 게시물 저장 버튼(좋아요만 됨) --%>
                   <p class="sort" id="button4">
                                  
                         <c:choose>
                            <c:when test="${listBoard.get(i).getLikeCondition() eq 'Y'}">
                               <i class="bi bi-heart-fill" onclick="location.href='/sns/controller/likeWho?pageRoute=likeWho&bid=${listBoard.get(i).getBid()}&boardCount=${i}'"></i>
                            </c:when>
                            <c:otherwise>
                               <i class="bi bi-heart" onclick="location.href='/sns/controller/likeWho?pageRoute=likeWho&bid=${listBoard.get(i).getBid()}&boardCount=${i}'"></i>
                            </c:otherwise>
                         </c:choose>
                      
                      <a class="bi bi-chat-dots" href="#exampleModal" role="button" data-toggle="modal" data-name="comment"   data-count="${i}"></a>
                      <i class="bi bi-share"></i>
                      <i class="bi bi-bookmark-plus"></i>
                     
                  <!-- 좋아요 1개 이상일때만 보여주기 -->
                  <c:if test="${listBoard.get(i).getLikeCount() != 0}">
                     <p class="sort"><a class="modalButton" href="#exampleModal" role="button" data-toggle="modal" data-name="like"      data-count="${i}">좋아요 ${listBoard.get(i).getLikeCount()}개</a>
                  </c:if>
                  
                  <%-- 게시글 내용 --%>
                  <p class="sort" id="boardContent">${listBoard.get(i).getContent()}
                  
                  <%-- 댓글 1개 이상일때만 보여주기 --%>
                  <c:if test="${listBoard.get(i).getCommentCount() != 0}">
                     <p class="sort"><a class="modalButton" href="#exampleModal" role="button" data-toggle="modal" data-name="comment"   data-count="${i}">댓글 ${listBoard.get(i).getCommentCount()}개 보기</a>
                  </c:if>
                  
                  <%-- 게시글 작성 날짜 --%>
                  <p class="sort boardBirth">${listBoard.get(i).getBirth()}
                  <hr class="boardBirthHR">
                  
                  <%-- 댓글 --%>
                  <p class="boardComment">
                     <form name="form${listBoard.get(i).getBid()}" method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=${listBoard.get(i).getBid()}&commentDetail=Home&boardCount=${i}">
                        <input id="boardCommentInput" type="text" class="form-control" name="comment" placeholder="댓글을 달아보세요!">
                        <button class="btn btn-secondary" id="boardCommentButton">등록</button>
                     </form>
                  <div id="boardCommentBlank"></div>
               </div>
               <br><br>
            </c:forEach>
         </section>
      </div>
      <br><br><br>
   
   <!-- 전체 게시물 출력 종료 -->
   <!-- ─────────────────────────────────────────────────────────────────────────── -->


   <%-- 모달 코드 --%>
   <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-scrollable">
         <div class="modal-content" id="modalContent">
            <div class="modal-header" id="modalHeader">
               <h5 class="modal-title" id="exampleModalLabel"></h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                  <span id="modalCloseSpan" aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body" id="modal-body">
            </div>
         </div>
      </div>
   </div>
   <%-- 모달 코드 --%>



   
   <!-- 무한 스크롤은 페이지를 처음 띄우거나 다른 페이지에서 왔을때의 경우와 버튼을 눌렀을때의 경우로 나뉨 -->
   <c:if test="${boardCount == null }">
      <c:set var="boardCount" value="-1"></c:set>
   </c:if>
   
   
   <!-- ─────────────────────────────────────────────────────────────────────────── -->
   <!-- 자바스크립트 코드 시작 -->
   
   <script>
   
   var memberId = '${memberId}';
   
   // 모달(좋아요, 댓글) 관련
   $('#exampleModal').on('show.bs.modal', function(e) {
       
       // 좋아요 누른건지 댓글 누른건지 알수 있는 변수
      var name = $(e.relatedTarget).data('name');
      // 몇번째 게시물 누른건지 알수 있는 변수
       var count = $(e.relatedTarget).data('count');
       
       // modal-body 안에 기존에 생성했던 요소들 전부 삭제
       var modalBody = document.getElementById('modal-body');
       modalBody.innerHTML = '';
       
       // h5(모달 헤더 내용) 태그에 좋아요, 모달 제목 넣으려고 만듬
       var exampleModalLabel = document.getElementById('exampleModalLabel');
       
       // 좋아요 눌렀으면
       if (name == 'like') {
          
          exampleModalLabel.innerHTML = '누가누가 좋아요';
          
          for (var i = 0; i < likeWhoId.length; i++) {
            if (listBoard[count].bid == likeWhoId[i].bid) {
               var p = document.createElement("p");
                p.innerHTML = likeWhoId[i].likeId;
                
                p.innerHTML += '<hr style="border: 0; height: 1px; background-color: #6667AB;">';
                $(".modal-body").append(p);
            }
         }
      }
       
       // 댓글 눌렀으면
       else if (name == 'comment') {
          
          exampleModalLabel.innerHTML = '누가누가 댓글';
          var div = document.createElement("div");
         div.className = 'comment'
         $(".modal-body").append(div);
         
          for (var i = 0; i < listComment.length; i++) {
            if (listBoard[count].bid == listComment[i].id) {
               var p = document.createElement("p");
                p.innerHTML = listComment[i].pfp + ' : ' + listComment[i].cid + ' : ' + listComment[i].content;
            if (listComment[i].cid == memberId) {
               p.innerHTML += '<i class="bi bi-x-lg modalCommentDelete" onclick="location.href=\'/sns/controller/deleteComment?pageRoute=deleteComment&bid=' + listBoard[count].bid + '&cid=' + listComment[i].commentId + '\'"></i>';
            }
                p.innerHTML += '<hr style="border: 0; height: 1px; background-color: #6667AB;">';
                $(".comment").append(p);
            }
         }
      }
   })
   
   
   // 스크롤 할때마다 현재 Y축 좌표를 sessionStorage.Y에 담는다. sessionStorage는 자바의 session과 비슷하다 
   window.addEventListener('scroll', () => { 
      sessionStorage.HomeY = window.scrollY;
   });
   
   
   //// ArrayList는 Java → JSTL(EL) → JavaScript 순으로 정보를 옮겨담음 
   
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
         likeCondition  : "${listBoard.getLikeCondition()}" ,
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
   
   // likeWhoId 가져오기
   var likeWhoId = new Array();
   <c:forEach items="${likeWhoId}" var="likeWhoId">         
      likeWhoId.push({
         bid            : "${likeWhoId.getBid()}",
         likeId         : "${likeWhoId.getLikeId()}"
      }); 
    </c:forEach>  
       
   // listComment 가져오기
   var listComment = new Array();
   <c:forEach items="${listComment}" var="listComment">         
      listComment.push({
         id            : "${listComment.getId()}",
         cid            : "${listComment.getCid()}",
         pfp            : "${listComment.getPfp()}",
         likeCount      : "${listComment.getLikeCount()}",
         content         : "${listComment.getContent()}",
         commentId     : "${listComment.getCommentId()}",
         birth         : "${listComment.getBirth()}"
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
      var index = <c:out value="${end + 1}"></c:out>
      var index2 = <c:out value="${end + 1}"></c:out>
   }
      
   window.onscroll = function(e) {
      if((window.innerHeight + window.scrollY) >= document.body.offsetHeight) { 

         // 좋아요 if
         if (listBoard[index].likeCount > 0) {
            var like = '<p class="sort"><a class="modalButton" href="#exampleModal" role="button" data-toggle="modal" data-name="like"      data-count="' + index + '">좋아요 ' + listBoard[index].likeCount + '개</a>'
         }
         else {
            var like = '';
         }
         
         // 댓글 if
         if (listBoard[index].commentCount > 0) {
            var comment = '<p class="sort"><a class="modalButton" href="#exampleModal" role="button" data-toggle="modal" data-name="comment"   data-count="' + index + '">댓글 ' + listBoard[index].commentCount + '개 보기</a>';
         }
         
         else {
            var comment = '';
         }
         
         // 좋아요 색상
         if (listBoard[index].likeCondition == 'Y') {
            var likeCondition = '<i class="bi-heart-fill" onclick="location.href=\'/sns/controller/likeWho?pageRoute=likeWho&bid=' + listBoard[index].bid + '&boardCount=' + index + '\'"></i>';
         }
         
         else {
            var likeCondition = '<i class="bi-heart" onclick="location.href=\'/sns/controller/likeWho?pageRoute=likeWho&bid=' + listBoard[index].bid + '&boardCount=' + index + '\'"></i>';
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
            
                                  '<a class="carousel-control-prev" href="#demo' + index2 + '" data-slide="prev">' + 
                                       '<span class="carousel-control-prev-icon" aria-hidden="true"></span>' + 
                                    '</a>' + 
                                  '<a class="carousel-control-next" href="#demo' + index2 + '" data-slide="next">' + 
                                       '<span class="carousel-control-next-icon" aria-hidden="true"></span>' + 
                                  '</a>' + 
                            
                                  '<ul class="carousel-indicators">' + 
                                       '<li data-target="#demo" data-slide-to="0" class="active"></li>' + 
                                       '<li data-target="#demo" data-slide-to="1"></li>' +
                                       '<li data-target="#demo" data-slide-to="2"></li>' +
                                  '</ul>' +
                              '</div>' +
                           '</div>' + 
                           '<br>';
         }
         
         var addContent = document.createElement("div");
         addContent.innerHTML =  '' +
                           '<div class="sectionDiv">' +
                              '<p><h3 class="sort">' + listBoard[index].bid + '번 게시글</h3>' +
                              '<p class="sort">' + 
                                 '작성자 프사 ' + '<a href="/sns/controller/AcHomePage?m2id=' + listBoard[index].id + '">' + listBoard[index].pfp + '</a> ' +
                                 '아이디 ' + '<a href="/sns/controller/AcHomePage?m2id=' + listBoard[index].id + '">' + listBoard[index].id + '</a> ' + 
                              photoDivStart + 
                              photoDivEnd + 
                              '<p class="sort" style="margin-top: -15px;">' + 
                                  likeCondition +
                                 '<a class="bi bi-chat-dots" href="#exampleModal" role="button" data-toggle="modal" data-name="comment"   data-count="' + index + '"></a>' + 
                                 '<i class="bi bi-share"></i>' +
                                 '<i class="bi bi-bookmark-plus""></i>' +
                              like +
                              '<p class="sort" style="font-weight: 400;">게시글 내용 ' + listBoard[index].content +
                              comment + 
                              '<p class="sort boardBirth">' + listBoard[index].birth +
                              '<hr class="boardBirthHR">' +
                              '<p class="boardComment">' + 
                                  '<form name="form' + listBoard[index].bid + '" method="post" action="/sns/controller/insertComment?pageRoute=insertComment&bid=' + listBoard[index].bid + '&commentDetail=Home&boardCount=' + index + '">' + 
                                     '<input id="boardCommentInput" type="text" class="form-control" name="comment" placeholder="댓글을 달아보세요!">' + 
                                     '<button class="btn btn-secondary" id="boardCommentButton">등록</button>' +
                                  '</form>' + 
                               '<div id="boardCommentBlank"></div>' + 
                               '</div>' + 
                               '<br><br>';
         document.querySelector('section').appendChild(addContent);
         index ++;
         index2 ++;
      }
   }
      
   <!-- 무한 스크롤 종료 -->
   <!-- ─────────────────────────────────────────────────────────────────────────── -->
   
   
   
   // 버튼을 눌렀을때 다시 그 위치까지 가게 해줌
    window.scrollTo(0, sessionStorage.HomeY);
    
   
   </script>
    
    <!-- 자바스크립트 코드 종료 -->
    <!-- ─────────────────────────────────────────────────────────────────────────── -->
   
</body>
</html>