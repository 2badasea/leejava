<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
	<input type="hidden" id="questionInfo" data-setno="${setNo }" data-studytype="${studyType }" data-count="${questionCount }">
	
</body>
<script>
	$(document).on("ready", function(){
		var setNo = $("#questionInfo").data("setno");
		var studyType = $("#questionInfo").data("studytype");
		var questionCount = $("#questionInfo").data("count");
		console.log("컨트롤러에서 넘어온 세트번호: " + setNo);
		console.log("컨트롤러에서 넘어온 스터디타입: " + studyType);
		console.log("컨트롤러에서 넘어온 문제 갯수: " + questionCount);
		
		// 문제번호 순서 리스트 생성
       	const questionList = [];
        if (studyType === "random") {
            // 선택한 것이 랜덤 배열인 경우.
            while (true) {
                var num = Math.floor(Math.random() * questionCount) + 1;
                if (questionList.indexOf(num) === -1) {
                    questionList.push(num);
                }
                if (questionList.length === questionCount) {
                    break;
                }
            }
        } else if(studyType === "order"){
            for (var i = 1; i <= questionCount; i++) {
                questionList.push(i);
            }
        }
        console.log("생성된 배열 조회: " +questionList);
		var quizcard_question_no = questionList[0];
        // ajax로 setNo와 문제번호 리스트의 첫 번째 값을 넘겨서 해당 데이터를 호출한다.
        
		$.ajax({
			url: "ajaxStudyStart.do",
			data: {
				quizcard_set_no : setNo,
				quizcard_question_no : quizcard_question_no
			},
			dataType: "JSON",
			method: "GET",
			contentType: "application/json; charset=utf-8",
			success: function(data){
				console.log("ajax 통신 성공");
				// json타입으로 데이터가 넘어옴.
				console.log(data);
			}, 
			error: function(data){
				console.log("통신 실패");
				console.log(data);
			}
		})
		 
	})
</script>
</html>