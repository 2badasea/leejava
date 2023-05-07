<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<script>
	$(document).on("ready", function(){
		// 나중엔 간단히 modal창으로 결과를 알려주고 화면 이동시키기
		alert('전송을 완료 했습니다. 퀴즈카드 생성 폼으로 이동합니다');
		history.pushState(null, null, location.href);
		window.onpopstate = function(event) {
		    history.go(1);
		};
		// 일단은 이런 방식도 있다는 걸 알고, 페이지 이동시키자.
		location.href="quizcardQuestionForm.do";
	})
		
</script>
<body>
	뒤로가기 방지.
</body>
</html>