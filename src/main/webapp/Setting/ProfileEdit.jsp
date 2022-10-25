<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix = "c"    uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>

<%
   String memberId=(String)session.getAttribute("memberId");  
%>

<script>
window.onpageshow = function(event) {
    if ( event.persisted || (window.performance && window.performance.navigation.type == 2)) {
    // Back Forward Cache로 브라우저가 로딩될 경우 혹은 브라우저 뒤로가기 했을 경우
    history.back();
    
  }
}
</script>
<style>
.buttons {border:0px; color:white; background:#81BEF7;}
.parent {display: flex; width: 100%; height: 200px; position:relative;}
p{height:30px; margin:16px;}

* { 
   font-family: 'Spoqa Han Sans Neo', 'sans-serif';
}

.container{
   margin-top:20px;
   color:#6667AB;
}
.custom-file-label::after {
   color:#6667AB;
}

.writeForm{
   background-color:white;
   border:1px solid #6667AB;
   border-radius:10px;
   height:200px;
   padding:30px;
   display:flex;
   padding-bottom:50px;
}
.texts{
   margin-right:30px;
   width:20%;
}
.texts .i2{
   height:48%;
}
.writeHere{
   width:80%;
}
.writeHere form{
   height:100%;
}

.writeHere input{
   width:100%;
   border: 1px;
   border-radius:7px;
}
.writeHere .i2{
   margin-top:0px;
   height:33px;
   width:100%;
   resize:none;
   border: solid #6667AB;
   border-radius:7px;
   margin-bottom: 10px;
}
.writeHere .i4{
   width:60px;
   border:1px solid #F8F8F8;
   text-align:rigth;
}

</style>
<link rel = "stylesheet" href = "http://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css">
<meta charset="UTF-8">
<title>ProfileEdit</title>
</head>   

<body style="background-color:#f5f5f5;">

      <script type="text/javascript">   function pedit(){formP.submit();}   </script>
<div class="container">
   <div class="writeForm">
      <div class="texts">
         <p>인트로
         <p>프로필 사진
      </div>
      <div class="writeHere">
         <form name="formP"  action = "/sns/controller/Pedit" method="post" enctype="multipart/form-data">
            <textarea class="i2" name="intro" maxlength='500' placeholder="자기소개를 써주세요!" style="color:#6667AB;"></textarea>
           
            <div class="custom-file mb-3" >
                <input type="file" class="custom-file-input" id="validatedCustomFile" name="profilephoto" required>
               <label class="custom-file-label" for="validatedCustomFile" style="color:#6667AB;">Choose file...</label>
               <div class="invalid-feedback" >Example invalid custom file feedback</div>
            </div>
      	</form>
      	
            	<div style="text-align: right;margin-bottom:30px;">
	               <input class="i4" type="submit" value="등록" style=" color:#6667AB;" onclick="pedit()"/>
	               <input class="i4" type="submit" value="취소" style=" color:#6667AB;" onclick="history.back()"/>
	               <input class="i4" type="submit" value="계정 편집" style=" color:#6667AB; width: 90px;" onclick="location.href='/sns/controller/AcEditPage'"/>
         		</div>
      </div>
   </div>
</div>
    
    
    
    
    
    
    
    
    
    
    
    
    
   
</body>
</html>