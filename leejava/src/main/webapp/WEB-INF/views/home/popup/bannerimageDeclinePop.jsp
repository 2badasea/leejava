<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<style>

* {
	margin:0;
	padding:0;
	box-sizing:border-box;
	-webkit-box-sizing:border-box;
	-moz-box-sizing:border-box;
	-webkit-font-smoothing:antialiased;
	-moz-font-smoothing:antialiased;
	-o-font-smoothing:antialiased;
	font-smoothing:antialiased;
	text-rendering:optimizeLegibility;
}

body {
	font-family:"Open Sans", Helvetica, Arial, sans-serif;
	font-weight:500;
	font-size: 15px;
	line-height:30px;
	color:#777;
	background: #05AA6D;
}

.container {
	max-width:400px;
	width:100%;
	margin:0 auto;
	position:relative;
}

#contact {
	background:#F9F9F9;
	padding:25px;
	margin:50px 0;
}

#contact h3 {
	color: #F96;
	display: block;
	font-size: 30px;
	font-weight: 400;
}

#contact h4 {
	margin:5px 0 15px;
	display:block;
	font-size:13px;
}

fieldset {
	border: medium none !important;
	margin: 0 0 10px;
	min-width: 100%;
	padding: 0;
	width: 100%;
}

#contact input[type="text"], #contact input[type="email"], #contact input[type="tel"], #contact input[type="url"], #contact textarea {
	width:100%;
	border:1px solid #CCC;
	background:#FFF;
	margin:0 0 5px;
	padding:10px;
}

#contact input[type="text"]:hover, #contact input[type="email"]:hover, #contact input[type="tel"]:hover, #contact input[type="url"]:hover, #contact textarea:hover {
	-webkit-transition:border-color 0.3s ease-in-out;
	-moz-transition:border-color 0.3s ease-in-out;
	transition:border-color 0.3s ease-in-out;
	border:1px solid #AAA;
}

#contact textarea {
	height:150px;
	max-width:100%;
  	resize:none;
}

#contact button[type="submit"] {
	cursor:pointer;
	width:100%;
	border:none;
	background: #05AA6D;
	color: whitesmoke;
	margin:0 0 5px;
	padding:10px;
	font-size:15px;
}

#contact button[type="submit"]:hover {
	background:coral;
	color: white;
	-webkit-transition:background 0.3s ease-in-out;
	-moz-transition:background 0.3s ease-in-out;
	transition:background-color 0.3s ease-in-out;
}

#contact button[type="submit"]:active { box-shadow:inset 0 1px 3px rgba(0, 0, 0, 0.5); }

#contact input:focus, #contact textarea:focus {
	outline:0;
	border:1px solid #999;
}
::-webkit-input-placeholder {
 color:#888;
}
:-moz-placeholder {
 color:#888;
}
::-moz-placeholder {
 color:#888;
}
:-ms-input-placeholder {
 color:#888;
}

</style>
</head>
<body>
	<input type="hidden" id="hiddenInputData" data-touser="${toUser }" data-fromuser="${fromUser }">
	<!-- 테스트를 위한  -->
	<div class="container">  
  <form id="contact"	>
    <h3>메시지 작성</h3>
    <h4></h4>
    <fieldset>
      <input type="text" tabindex="1" class="fromnick" value="보내는 사람: ${fromUser }" readonly="readonly">
    </fieldset>
    <fieldset>
      <input type="text" tabindex="2" class="tonick" value="받는 사람: ${toUser }" readonly="readonly">
    </fieldset>
        <fieldset>
      <input type="text" placeholder="제목을 작성해주세요. (최대 25자)" class="msgtitle" tabindex="3" maxlength="25">
    </fieldset>
    <fieldset>
      <textarea placeholder="메시지 내용을 입력하세요." class="msgcontent" tabindex="4" required></textarea>
    </fieldset>
    <fieldset>
      <button name="submit" type="submit" id="sendBtn" data-submit="...Sending">전송하기</button>
    </fieldset>
  </form>
 
  
</div>
</body>
<script>
	$("#sendBtn").on("click", function(e){
		e.preventDefault();
		console.log("전송버튼 클릭!");
		// 데이터값 확인
		var fromnick = $(".fromnick").val();
		var tonick = $(".tonick").val();
		var msgtitle = $(".msgtitle").val();
		var msgcontent = $(".msgcontent").val();
		// 유효성 체크
		if( msgtitle == '' || msgcontent == ''){
			alert("제목과 내용은 반드시 입력해주셔야 합니다.");
			return false;
		}
		console.log(fromnick);
		console.log(tonick);
		console.log(msgtitle);
		console.log(msgcontent);
	})
	
</script>
</html>