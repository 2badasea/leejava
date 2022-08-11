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
	body{
		background-color: whitesmoke;
	}
	.mainForm{
	}
	.declineForm{
		width: 98%;
		border-collapse: collapse;
		border: 1px solid #313348;
	}
	.declineForm td{
		border-bottom: 1px solid lightgray;
	}
	label{
		font-weight: 700;
	}
	.declineForm input{
		background-color: whitesmoke;
		border-style: none;
		text-align: center;
		font-size: medium;
		border-bottom: 1px dotted lightgray;
	}
	.declineForm input:focus{
		outline: none;
	}
	textarea {
		background-color: whitesmoke;
		resize: none;	
		width: 95%;
		height: 75%;
		border-style: none;
		padding: 5px;
		font-size: medium;
		font-weight: 500;
	}
	#toUser{
		margin-left: 15px;
	}
</style>
</head>
<body>
	<!-- 서버에 넘겨야 할 값들  보내는 사람, 받는 사람, 제목, 내용,  -->
	<div class="mainForm" align="center">
		<table class="declineForm">
			<tr>
				<td style="height: 30px;">
					<label for="fromUser">보내는 사람</label>
					<input type="text" id="fromUser" value="${fromUser }" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td style="height: 30px;">
					<label for="toUser">받는 사람</label>
					<input type="text" id="toUser" value="${toUser }" readonly="readonly">
				</td>
			</tr>
			<tr>
				<td style="height: 120px;">
					<label for="toTitle">제목</label>
					<textarea rows="2" id="toTitle"></textarea>
				<td>
			</tr>
			<tr>
				<td style="height: 200px;">
					<label for="toContent">내용</label>
					<textarea rows="5" id="toContent"></textarea>	
				</td>			
			</tr>
		</table>
		<br>
		<button type="button" class="messageSendBtn">전송하기</button>
		<button type="button" class="PopCloseBtn">닫기</button>
	</div>
</body>
<script>
	$(".messageSendBtn").on("click", function(){
		console.log("메시지 전송 버튼 클릭");
	})
	
</script>
</html>