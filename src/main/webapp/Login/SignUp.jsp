<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"    uri="http://java.sun.com/jsp/jstl/core"%>
<!------- 회원가입 -------->
<!DOCTYPE html>
<html>
<head>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>?</title>
<style>
#menu {width: 30%;float: left;}
#menu p{margin-bottom: 22px; margin-top:30px;}
#form {width: 50%;float: left;}
#form p {margin-top:25px;margin-bottom:20px;}
.container{background-color: white; 
padding: 30px 50px;
border-radius:10px;
border:1px solid;    
border-color:#6667AB;
margin-top :100px;}
.from-group{}
</style>
</head>   
<body style="background-color: #f5f5f5;">
   
   <script type="text/javascript">   

      
      function CheckAddProduct(){
         var form = document.getElementById("signUpForm");
         
         // 아이디: 영문+숫자 20자리이하
         var idReg = /^[a-z]+[a-z0-9]{4,19}$/g;
         // 비밀번호 : 영문/숫자/특수문자 중 2가지 이상 10~20자리
         var pwExp = /^(?!((?:[A-Za-z]+)|(?:[~!@#$%^&*()_+=]+)|(?:[0-9]+))$)[A-Za-z\d~!@#$%^&*()_+=]{10,}$/;
         //이름 : 한글 이름 2~4자 이내로 입력하세요
         var nameExp = /^[가-힣]{2,4}$/;
         // 이메일 : @ 포함하여 이메일형식에 맞게 입력하세요
         var regExp = /^[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_.]?[0-9a-zA-Z])*.[a-zA-Z]{2,3}$/i;
         // 핸드폰번호 : 하이폰 넣어서 입력
         var numExp = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;
         //생년월일 : 94-06-12
         var birthExp = /^([0-9][0-9]|20\d{2})-(0[0-9]|1[0-2])-(0[1-9]|[1-2][0-9]|3[0-1])$/;
         

         if(!idExp.test(form.id.value)){
             alert("비밀번호는 영문,숫자,특수문자 중 2가지 이상 10~20자리까지");
             return false;  
         }
                  
         if(!pwExp.test(form.pw.value)){
             alert("비밀번호는 영문,숫자,특수문자 중 2가지 이상 10~20자리까지");
             return false;       
          }else if(!nameExp.test(form.name.value)){
             alert("이름 2~4자 이내");
             return false;
          }else if(!regExp.test(form.email.value)){
             alert("@ 포함하여 이메일형식에 맞게 입력");
             return false;
          }else if(!numExp.test(form.phone.value)){
             alert("'-'을 포함");
             return false;
          }else if(!birthExp.test(form.birth.value)){
             alert("94-06-12 형태로 입력");
             return false;
          } else{form.submit(); }
   
       }
      </script>


   <div class="container" style="background-color: white; padding: 30px 50px;">
      <form action="/sns/controller/signup" class="was-validated" name="member" id="signUpForm" method="post">
        
        <div class="form-group">
          <label for="mid">ID:</label>
          <input type="text" class="form-control" name="mid" id="mid" placeholder="Enter username"required>
          <div class="valid-feedback">Valid.</div>
          <div class="invalid-feedback">아이디를 입력해 주세요</div>
        </div>
                
        <div class="form-group">
          <label for="pw">Password:</label>
          <input type="text" class="form-control" name="pw" id="pw" placeholder="Enter password" required>
          <div class="valid-feedback">Valid.</div>
          <div class="invalid-feedback">비밀번호를 입력해 주세요</div>
        </div>        
        
        <div class="form-group">
          <label for="name">name:</label>
          <input type="text" class="form-control" name="name" id="name" placeholder="Enter password"  required>
          <div class="valid-feedback">Valid.</div>
          <div class="invalid-feedback">이름을 입력해 주세요</div>
        </div>
        
        <div class="form-group">
          <label for="email">email:</label>
          <input type="text" class="form-control" name="email" id="email" placeholder="Enter password" required>
          <div class="valid-feedback">Valid.</div>
          <div class="invalid-feedback">이메일을 입력해 주세요</div>
        </div>
        
        <div class="form-group">
          <label for="phone">phone:</label>
          <input type="text" class="form-control" name="phone" id="phone" placeholder="Enter password" required>
          <div class="valid-feedback">Valid.</div>
          <div class="invalid-feedback">전화번호를 입력해 주세요</div>
        </div>
        
        <div class="form-group">
          <label for="birth">birth:</label>
          <input type="date" class="form-control" name="birth" id="birth" placeholder="Enter password" required>
          <div class="valid-feedback">Valid.</div>
          <div class="invalid-feedback">생년월일을 선택해 주세요</div>
        </div>   
         
        <button type="button" class="btn btn-light" style="color:#6667AB; border-color:#6667AB;" >회원가입</button>
      </form>
   </div>
</body>
</html>