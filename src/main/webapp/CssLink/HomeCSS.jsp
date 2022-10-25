<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<style type="text/css">
   
   /* 무한 스크롤 */
   html, body{
      margin: 0;
   }
   
   h1 {
     position: fixed; 
     top: 0; 
     width: 100%; 
     height: 60px; 
     text-align: center; 
     background: white; 
     margin: 0; 
     line-height: 60px;
   }
   
   /* 게시글 사진 */
   img {
      width: 500px;
      height: 500px;
   }
   
   /* 게시글 내부 요소들 왼쪽 여백 */
   .sort {
      padding-left: 10px;
   }
   
   /* 맨위로 버튼 */
   #toTop{
      background:none; 
      position:fixed; 
      bottom:50px; right:800px; 
      cursor:pointer; 
      text-decoration:none; 
      border-radius:20px; 
      -moz-border-radius:20px; 
      -webkit-border-radius:5px;
   } 
    
   /* 모달 좋아요 */
   .modal-body::-webkit-scrollbar {
      width: 15px;
   }
   
   .modal-body::-webkit-scrollbar-thumb {
      background-color: #6667AB;
      border-radius: 10px;
      background-clip: padding-box;
      border: 2px solid transparent;
   }
   
   .modal-body::-webkit-scrollbar-track {
      background-color: #c1c1f7; 
      background-color: white;
      border-radius: 10px;
      box-shadow: inset 0px 0px 5px white;
   }
 
    /* 섹션 다음 div*/
    .sectionDiv {
       width: 502px; 
       border: 1px solid #6667AB; 
       border-radius: 20px;
    }

   /* 캐러셀 이전, 다음 버튼 */
    .carousel-control-next, .carousel-control-prev {
       height: 500px;
    }
    
    /* 캐러셀 사진 하단 가로 막대기 */
    .carousel-indicators {
       height: 40px;
    }
    
    #button4 {
       margin-top: -15px;
    }
    
    /* 좋아요(모달), 댓글(모달), 공유(모달), 게시물 저장 버튼 */
    .bi-heart, .bi-heart-fill, .bi-chat-dots, .bi-share, .bi-bookmark-plus {
       font-size: 25px;
       color: #6667AB;
       cursor: pointer;
       margin-right: 20px;
       -webkit-text-stroke: 1px;
    }
    
    /* 게시물 저장 버튼 */
    .bi-bookmark-plus {
       float: right; 
       padding-right: 10px;
    }
    
    /* 좋아요, 댓글 모달 버튼 */
    .modalButton {
       margin-top: -5px; 
       color: #6667AB;
    }
    
    /* 게시글 내용 */
    #boardContent {
       font-weight: 400;
    }
    
    
    /* 게시글 작성 날짜 */
    .boardBirth {
       font-size: 13px;
       font-weight: 350;
    }
    
    /* 게시글 작성 날짜 밑에 hr 태그 */
    .boardBirthHR{
       border: 0; 
       height: 1px; 
       background-color: #6667AB;
    }
    
    /* 댓글 form 위에 p 태그 */
    .boardComment {
       margin-top: -10px;
    }
    
    /* 댓글 등록 버튼 */
    #boardCommentButton {
       color: #6667AB; 
       background-color: #f5f5f5; 
       border: none;
    }
    
    /* 댓글 input 태그 */
    #boardCommentInput {
       background-color: transparent; 
       width: 440px; 
       float: left; 
       border: none;
    }
    
    /* 댓글 form 밑에 공백 div */
    #boardCommentBlank {
       margin-top: 10px;
    }
    
    /* 모달 */
    #exampleModal {
       height: 540px;
       margin-top: 200px;
    }
    
    #modalContent {
       border-radius: 20px;
    }
    
    #modalHeader {
       text-align: center;
    }
    
    #exampleModalLabel {
       padding-left: 170px;
       color: #6667AB;
    }
    
    #modalCloseSpan {
       color: #6667AB;
    }
    
    /* 모달 댓글 삭제 */
      .modalCommentDelete {
      float: right;
      font-size: 15px;
      color: #6667AB;
      cursor: pointer;
      margin-right: 20px;
      -webkit-text-stroke: 1px;
   }
   
   .box {
      width: 60px; height: 60px; 
      border-radius: 70%; 
      overflow: hidden; 
      background: #BDBDBD;
   }
   
   /* 프로필사진 */
   .profile {
      width: 100%; 
      height: 100%; 
      object-fit: cover; 
      display:flex;
   }
    
</style>