<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
	.testResultBox{
		border: 1px solid black;
	}
</style>
</head>
<body>
<div align="center">
	<button id="testBtn">테스트 시작</button>
	<div class="testResultBox"></div>
</div>
</body>
<script>
	$("#testBtn").on("click", function(){
		const quizcard_set_no = 101;
		var ary = [];
		for(var i = 0; i<10; i++){
			var obj = {};
			obj["question_no"] = i;
			obj["whereQno"] = i+1;
			obj["quizcard_set_no"] = 101;
			var preNo = (i+1)<10 ? '0'+(i+1) : ''+(i+1);
			var afterNo = quizcard_set_no + preNo;
			obj["quizcard_no"] = afterNo;
			ary.push(obj);
		}
		console.log("배열객체 형태");
		console.log(ary);
		console.log(JSON.stringify(ary));
		
		$.ajax({
			url: "updateTest.do",
			data: JSON.stringify(ary),
			type: "POST",
			contentType: 'application/json; charset=utf-8',
			success: function(data){
				console.log("수신성공");
				console.log(data);
			},
			error: function(data){
				console.log("수신실패");
				console.log(data);
			}
		})
	})
</script>
</html>