<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c"    uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<%
   String memberId=(String)session.getAttribute("memberId");
   if(memberId!=null){
      if (request.getAttribute("memberlist") == null) {
         response.sendRedirect("/sns/controller/selectAc?pageRoute=selectAc&ae=1");
      } 
   } else { %>  <%} 
   
%>
<style>
.buttons {border:0px; color:white; background:#81BEF7;}
.parent {display: flex; width: 100%; height: 200px; position:relative; margin-top:50px;}
p{height:30px; margin:16px;}

#menu {width: 30%;float: left;}
#menu p{margin-bottom: 22px; margin-top:30px;}
#form {width: 50%;float: left;}
#form p {margin-top:25px;margin-bottom:20px;}
</style>

<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>AcEdit</title>
</head>   


<body style="background-color: #f5f5f5 ;">

   
   
   <br><br>
   <div class="container" style="border:1px solid #6667AB; border-radius: 10px; background-color: white; padding: 30px;">
      <form action="/sns/controller/Aedit" class="was-validated" name="member" id="signUpForm" method="post">
        
        <div class="form-group">
          <label for="mid">ID:</label>
          <input type="text" class="form-control" name="mid" id="mid" name="uname" required disabled="disabled" value="${memberlist.getMid()}">
          <div class="valid-feedback">Valid.</div>
          <div class="invalid-feedback">아이디를 입력해 주세요</div>
        </div>
        
        <div class="form-group">
          <label for="pw">Password:</label>
          <input type="password" class="form-control" name="pw" id="pw" placeholder="Enter password" name="pswd" required>
          <div class="valid-feedback">Valid.</div>
          <div class="invalid-feedback">비밀번호를 입력해 주세요</div>
        </div>
        
        <div class="form-group">
          <label for="name">name:</label>
          <input type="text" class="form-control" name="name" id="name" name="pswd" required placeholder="${memberlist.getName() }">
          <div class="valid-feedback">Valid.</div>
          <div class="invalid-feedback">이름을 입력해 주세요</div>
        </div>
        
        <div class="form-group">
          <label for="email">email:</label>
          <input type="text" class="form-control" name="email" id="email" name="pswd" required placeholder="${memberlist.getEmail() }">
          <div class="valid-feedback">Valid.</div>
          <div class="invalid-feedback">이메일을 입력해 주세요</div>
        </div>
        
        <div class="form-group">
          <label for="phone">phone:</label>
          <input type="text" class="form-control" name="phone" id="phone" name="pswd" required placeholder="${memberlist.getPhone() }">
          <div class="valid-feedback">Valid.</div>
          <div class="invalid-feedback">전화번호를 입력해 주세요</div>
        </div>
        
        <div class="form-group">
          <label for="birth">birth:</label>
          <input type="date" class="form-control" name="birth" id="birth" name="pswd" required placeholder="${memberlist.getBirth()}">
          <div class="valid-feedback">Valid.</div>
          <div class="invalid-feedback">생년월일을 선택해 주세요</div>
        </div>   
         
        <button type="submit" class="btn btn-light" onclick="Aedit()" style="color:#6667AB; border:0.5px solid #6667AB;">수정</button>
        <button type="submit" class="btn btn-light" onclick="history.back()" style="color:#6667AB; border:0.5px solid #6667AB;">취소</button>
      </form>
   </div>
   
   
   <script type="text/javascript">
   
      function Aedit() {
         formA.submit();   
      }
      
   </script>
   
   
   
   
   
   
   
   
   
   
   
</body>
</html>