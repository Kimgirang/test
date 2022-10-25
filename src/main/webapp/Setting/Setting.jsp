<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"	 uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>SettingPage</title>
<style>
	* { font-family: 'Spoqa Han Sans Neo', 'sans-serif'; }

	#editPage{
	background-color:white;
		display:flex;
		border:1px solid #6667AB;
		border-radius : 7px;
	}
	#editPage>.names{
		border-right:1px solid #6667AB;
		width:27%;
		text-align:center;
	}
	#editPage>.contents{
		border-radius : 7px;
		width:60%;
		padding-left:20%;
		color:#6667AB;
	}
	#editPage ul{
		list-style:none;
		padding-left:0px;
		padding-top:20px;
	}
	#editPage li{
		margin-bottom:25px;
	}
	#editPage .Logout{
		
	}
	#editPage .delAccount > a{
		color:red;
	}
</style>
</head>	
<!-- 회원삭제시 비밀번호끼리 틀리게 적거나, 데이터베이스에 있는 비밀번호와 입력된 비밀번호가 틀리다면 회원이 삭제되지 않게 -->
<script>
	
	function deleteSubmit(){
		var form = document.deleteAccountForm;
		var pw = document.deleteAccountForm.password.value;
		var cpw = document.deleteAccountForm.confirmPassword.value;
		var el = document.getElementsByClassName('deleteInputPw');
		if(pw!==cpw){	
			for(var i=0; i<el.length; i++){	el[i].value = '';}
			alert("입력한 두 비밀번호가 일치하지 않습니다.")
		}else{
			form.submit();
		}
	}
</script>

<jsp:include page="../Nav/HomeNav.jsp" flush="true" />
<body style="background-color:#f5f5f5;">
<div class="container">
	<div id="editPage">
			<div class="names">
				<ul>
					<li>아이디</li>
					<li>이름</li>
					<li>이메일</li>
					<li>전화번호</li>
					<li>생년월일</li>
					<li></li>
					<li></li>
					<li class="changePrivate"><a href="#" data-toggle="modal" data-target="#changePrivate">공개범위 변경</a></li>
					<li class="Logout"><a href="#" data-toggle="modal" data-target="#logout">로그아웃</a></li>
					<li class = "delAccount"><a href="#" data-toggle="modal" data-target="#delAcModal">회원탈퇴</a></li>
				</ul>
			</div>
			<div class="contents">
				<ul>
					<li>${memberId}</li>
					<li>${memberInfo.getName()}</li>
					<li>${memberInfo.getEmail() }</li>
					<li>${memberInfo.getPhone() }</li>
					<li>${memberInfo.getBirth() }</li>
					<li>${memberInfo.getIsprivate() }</li>
					<li></li>
					<li></li>
				</ul>
			</div>
	</div>
</div>

<!-- 모달창 -->



   <%-- 로그아웃 모달 코드 --%>
   <div class="modal fade" id="logout" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-scrollable">
         <div class="modal-content" id="modalContent">
            <div class="modal-header" id="modalHeader">
            	<h4 class="modal-title">로그아웃</h4>
               <h5 id="h5" class="modal-title" id="exampleModalLabel"></h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                  <span id="modalCloseSpan" aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body" id="modal-body">
            	<p>로그아웃 하시겠습니까?
            </div>
            <div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"onclick="location.href='/sns/controller/Logout'">로그아웃</button>
				</div>
         </div>
      </div>
   </div>
   <%-- 로그아웃 모달 코드 --%>
   
   <%-- 삭제 모달 코드 --%>
   <div class="modal fade" id="delAcModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-scrollable">
         <div class="modal-content" id="modalContent">
            <div class="modal-header" id="modalHeader">
            	<h4 class="modal-title">회원탈퇴</h4>
               <h5 id="h5" class="modal-title" id="exampleModalLabel"></h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                  <span id="modalCloseSpan" aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body" id="modal-body">
            	<p>회원탈퇴를 위해서 패스워드를 입력해 주십시오
					<form id="deleteAccountForm" name="deleteAccountForm" class="was-validated" action="/sns/controller/deleteAccount">
						<div>
							<input type="password" name="password" class="form-control deleteInputPw" required />
							<div class="valid-feedback"></div>
							<div class="invalid-feedback">비밀번호를 입력해 주세요</div>
						</div>
						<div>
							<input type="password" name="confirmPassword" class="form-control deleteInputPw" required />
							<div class="valid-feedback"></div>
							<div class="invalid-feedback">비밀번호를 입력해 주세요</div>
						</div>
						<div>
							<button type="button" class="btn btn-primary" data-dismiss="modal" style="margin-left:60%;">취소</button>
							<button type="button" class="btn btn-danger" data-dismiss="modal"onclick="deleteSubmit()">회원탈퇴</button>
						</div>
					</form>
            </div>
         </div>
      </div>
   </div>
   <%-- 삭제 모달 코드 --%>
   
   <%-- 비공개 모달 코드 --%>
   <div class="modal fade" id="changePrivate" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-dialog-scrollable">
         <div class="modal-content" id="modalContent">
            <div class="modal-header" id="modalHeader">
            	<h4 class="modal-title">계정 공개 설정</h4>
               <h5 id="h5" class="modal-title" id="exampleModalLabel"></h5>
               <button type="button" class="close" data-dismiss="modal" aria-label="닫기">
                  <span id="modalCloseSpan" aria-hidden="true">&times;</span>
               </button>
            </div>
            <div class="modal-body" id="modal-body">
            	<p>계정의 공개범위를 변경 하시겠습니까?
            </div>
            <div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">취소</button>
					<button type="button" class="btn btn-primary" data-dismiss="modal"onclick="location.href='/sns/controller/changePrivateStatus'">상태변경</button>
				</div>
         </div>
      </div>
   </div>
   <%-- 비공개 모달 코드 --%>

	

</body>
</html>