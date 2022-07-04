<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
  <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
	.wrapper {
	    border: 1px solid tomato;
	}
	
	.questionInfoWrapper {
	    width: 45%;
	    border: 0.5px solid;
	    margin-left: 28%;
	}
	
	.questionInfoHeader {
	    display: flex;
	}
	
	#quizcard_set_info {
	    resize: none;
	}
	
	h6 {
	    display: inline;
	}
	
	.questionInfoHeader {
	    display: flex;
	    justify-content: space-around;
	}
    .questionWrapper {
       width: 80%;
       margin-left: 10%;
    }

    .hint {
        /* 그리고  question과 answr의 공간을 안 잡도록 한다.*/
        z-index: 3;
        display: none;
        position: absolute;
        border: 0.5px solid teal;
        margin-top: 5%;
        margin-left: 20%;

    }

    .questionFormBody {
        display: flex;
    }

    .hintCreateBtn {
        width: 50px;
        height: 50px;
        margin-left: 20px;
        margin-right: 20px;
        margin-top: 60px;
        border-radius: 20px;
        border-style: none;
    }

    .hintCreateBtn:hover {
        cursor: pointer;
        background-color: teal;
        color: white;
        transition: 1s;
    }

    textarea {
        resize: none;
    }

    .quizcard_question_name,
    .quizcard_question_answer {
        width: 100%;
    }

    .question,
    .answer {
        width: 40%;
    }

    #quizcard_set_info {
        width: 70%;
    }

    .addQuestionBtnFirst,
    .addQuestionBtn {
        display: block;
        margin: auto;
        width: 150px;
        height: 50px;
        border-radius: 20px;
        border-style: none;
    }

    .addQuestionBtnFirst,
    .addQuestionBtn:hover {
        cursor: pointer;
        background-color: teal;
        color: white;
        transition: 1s;
    }

    .questionForm {
        border: 1px solid teal;
        padding-left: 10%;
    }
</style>
</head>
<body>
    <div class="wrapper">
        <div class="questionInfoWrapper">
            <div class="questionInfoHeader">
                <!--세트번호, 카테고리, 생성일, 마지막 업데이트일-->
                <h6>세트번호: ${qvo.quizcard_set_no }</h6>
                <h6>카테고리: ${qvo.quizcard_category }</h6>
                <h6>세트유형: ${qvo.quizcard_type }</h6>
                <h6>문제 수: ${questionCount} </h6>
                <div class="questionInfoDate" style="float: right;">
                    <h6>생성일: ${qvo.quizcard_set_cdate } </h6><br>
                    <h6>수정일: ${qvo.quizcard_set_udate }</h6>
                </div>
            </div>
            <div class="questionInfoBody">
                <!--세트이름, 세트설명-->
                <label for="quizcard_set_name">세트 이름</label>
                <input type="text" id="quizcard_set_name" name="quizcard_set_name" value="${qvo.quizcard_set_name}">
                <br>
                <label for="quizcard_set_info">세트 설명</label>
                <br>
                <textarea name="quizcard_set_info" cols="30" rows="5"
                    class="quizcard_set_intro">${qvo.quizcard_set_intro}</textarea>
            </div>
            <div class="questionInfoFooter">
                <!--접근권한 조정, 일단 현 상태에서 만들기(update)-->
                <span class="statusValue" data-statusvalue="${qvo.quizcard_set_status }">공개여부</span>
                <label for="statusPublic">전체공개</label>
                <input type="radio" id="statusPublic" name="quizcard_set_status" value="PUBLIC">
                <label for="statusPrivate">나만보기</label>
                <input type="radio" id="statusPrivate" name="quizcard_set_status" value="PRIVATE">
                <br>
            </div>
        </div>
        <br>
        <hr>
        <br>
	<!-- 여기 밑으로가 이제 문제들이 출력되어야 한다. c:forEach문 활용해서 반복적으로 출력해야 함. -->
	<!-- 잘 생각해보야함. 해당 폼 전체를 :forEach 메서드로 ㅗ돌리ㄹ는 게 가능한ㄱ. -->
	
	<!-- ------------------------------------------------------------------- -->
		<div class="questionWrapper">
            <!--밑에 questionForm이 반복되어야 한다. 일단 c:forEach문으로 반복시켜보자-->
            <c:forEach items="questionList" var="list">
	            <div class="questionForm">
	                <div class="questionFormHeader">
	                    <input class="questionNumber" id="questionNumber" value="${list.quizcard_question_no }">
	                </div>
	                <br>
	                <div class="questionFormBody">
	                    <div class="question">
	                        <input type="text" value="문제" readonly>
	                        <br>
	                        <textarea name="quizcard_question_name" class="quizcard_question_name" cols="30"
	                            rows="10">${list.quizcard_question_name }</textarea>
	                    </div>
	                    <button class="hintCreateBtn">힌트 추가</button>
	                    <div class="hint">
	                        <input type="text" value="힌트" readonly>
	                        <br>
	                        <textarea name="quizcard_question_hint" class="quizcard_question_hint" cols="30"
	                            rows="10">${list.quizcard_question_hint }</textarea>
	                        <button class="hintCloseBtn">닫기</button>
	                    </div>
	                    <div class="answer">
	                        <input type="text" value="답안" readonly><br>
	                        <textarea name="quizcard_question_answer" class="quizcard_question_answer" cols="30"
	                            rows="10">${list.quizcard_question_answer }</textarea>
	                    </div>
	                </div>
	                <br>
	                <div class="questionFormFooter">
	                    <button class="addQuestionBtn">퀴즈카드 추가</button>
	                </div>
	            </div>
            </c:forEach>
        </div>

	</div>  <!--  메인 Wrapper -->
</body>
<script>
	

	// 힌트 클릭.
	$(document).on("click", '.hintCreateBtn', function () {
	    console.log("힌트 클릭");
	    $(this).next().css("display", "block");
	})
	// 힌트 닫기
	$(document).on("click", '.hintCloseBtn', function () {
	    $(this).closest(".hint").css("display", "none");
	})
</script>
<script>
	$(function(){
		// DB에 저장된 quizcard_set_status값에 따라 미리 radio버튼에 체크를 준다.
			// 더 간결하게 코드를 짤 수 있는 방법이 생각이 나지 않았음.
		var status = $(".statusValue").data("statusvalue");
		console.log("status값: " + status);
		
		var public  = $("#statusPublic");
		var private = $("#statusPrivate");
		
		if (status === public.val()) {
            public.prop("checked", true);
        } else if (status === private.val()) {
            private.prop("checked", true);
        } else {
            return false;
        }
		
	})
	
</script>
</html>