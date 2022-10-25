<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="java.sql.*" %>
<%@taglib prefix = "c"    uri="http://java.sun.com/jsp/jstl/core"%>
<%@page import="member.memberDAO"%>
<%@page import="member.memberDTO"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Write</title>
<jsp:include page="../Nav/HomeNav.jsp" flush="true" />
<style>
   * { font-family: 'Spoqa Han Sans Neo', 'sans-serif'; }
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
   height:550px;
   padding:30px;
   display:flex;
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
   margin-top:14px;
   height:50%;
   width:100%;
   resize:none;
   border: solid #6667AB;
   border-radius:7px;
}
.writeHere .i4{
   width:60px;
   border:1px solid #F8F8F8;
   text-align:rigth;
}
</style>

</head>   
<body style="background-color:#f5f5f5;">
<div class="container">
   <div class="writeForm">
      <div class="texts">
         <p>아이디
         <p class="i2" style="margin-top:30px;">내용
         <p>이미지
      </div>
      <div class="writeHere">
         <p>&nbsp;${memberId }
         <form name="writeForm" method="post" action="/sns/controller/uploadBoard" enctype="multipart/form-data">
            <textarea class="i2" name="content" maxlength='500' placeholder="내용을 입력해 주세요" style="color:#6667AB;"></textarea>
           
            <div class="custom-file mb-3" >
   		    <input type="file" class="custom-file-input" id="validatedCustomFile" name="ImageFile" required">
            <label class="custom-file-label" for="validatedCustomFile" style="color:#6667AB;">Choose file...</label>
            <div class="invalid-feedback" >Example invalid custom file feedback</div>
            </div>
            <div class="custom-file mb-3">
   		    <input type="file" class="custom-file-input" id="validatedCustomFile" name="ImageFile" >
            <label class="custom-file-label" for="validatedCustomFile" style="color:#6667AB;">Choose file...</label>
            <div class="invalid-feedback">Example invalid custom file feedback</div>
            </div>
            <div class="custom-file mb-3">
   		    <input type="file" class="custom-file-input" id="validatedCustomFile" name="ImageFile" >
            <label class="custom-file-label" for="validatedCustomFile" style="color:#6667AB;">Choose file...</label>
            <div class="invalid-feedback">Example invalid custom file feedback</div>
            </div>
      
            <p style="text-align:right;"><input class="i4" type="submit" value="등록" style=" color:#6667AB;"/>
         </form>
      </div>
   
   
   </div>
</div>
</body>
</html>