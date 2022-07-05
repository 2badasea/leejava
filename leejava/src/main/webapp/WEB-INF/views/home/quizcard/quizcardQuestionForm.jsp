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
                <h6 class="quizcardSetNo" data-quizcardsetno="${qvo.quizcard_set_no }">세트번호: ${qvo.quizcard_set_no }</h6>
                <h6>카테고리: ${qvo.quizcard_category }</h6>
                <h6>세트유형: ${qvo.quizcard_type }</h6>
                <h6 class="questionCount" data-questioncount="${questionCount}">문제 수: ${questionCount} </h6>
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
            <c:forEach items="${questionList }" var="list">
	            <div class="questionForm">
	                <div class="questionFormHeader">
	                    <input class="questionNumber" id="questionNumber" value="${list.quizcard_question_no } 번 문제">
	                </div>
	                <br>
	                <div class="questionFormBody" data-no="${list.quizcard_question_no }">
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
	                    <button class="deleteQuestionBtn" data-no="${list.quizcard_question_no }">퀴즈카드 삭제</button>
	                </div>
	            </div>
            </c:forEach>
        </div>

	</div>  <!--  메인 Wrapper -->
</body>
<script>
	// 해당 세트번호 전역변수로 선언
	const quizcard_set_no = $(".quizcardSetNo").data("quizcardsetno");

	// 문제명, 힌트, 답란 blur 이벤트 체크 우선 "업데이트"부터 해보자
	 $(document).on("blur", ".quizcard_question_name, .quizcard_question_hint, .quizcard_question_answer", function (e) {
        console.log("blur이벤트 발생");
        // 세트번호
        console.log("세트번호 조회: " + quizcard_set_no);
        // 문제번호. 
        var quizcard_question_no = $(e.target).closest(".questionFormBody").data("no");
        console.log("문제번호 조회: " + quizcard_question_no);  
        // 문제명
        var quizcard_question_name = $(e.target).closest(".questionFormBody").find(".quizcard_question_name").val();
        // 힌트
        var quizcard_question_hint = $(e.target).closest(".questionFormBody").find(".quizcard_question_hint").val();
        // 답
        var quizcard_question_answer = $(e.target).closest(".questionFormBody").find(".quizcard_question_answer").val();
        
        // ajax 호출.  넘길 데이터(  "quizcard_set_no", "quizcard_question_no", "quizcard_question_name[hint, answer]")
        $.ajax({
        	url: "ajaxQuestionUpdate.do",
        	method: "post",
        	data: {
        		quizcard_set_no : quizcard_set_no,
        		quizcard_question_no : quizcard_question_no,
        		quizcard_question_name : quizcard_question_name,
        		quizcard_question_hint : quizcard_question_hint,
        		quizcard_question_answer : quizcard_question_answer
        	},
        	success: function(result){
        		console.log(result);
        		// 업데이트 성공하고 나서, 문제명, 힌트, 답안은 업데이트한 걸로 value값 세팅하기. => 해줄 필요 없음.
//         		$(e.target).closest(".questionFormBody").find(".quizcard_question_name").val(quizcard_question_name);
//         		$(e.target).closest(".questionFormBody").find(".quizcard_question_hint").val(quizcard_question_hint);
//         		$(e.target).closest(".questionFormBody").find(".quizcard_question_answer").val(quizcard_question_answer);
        	}
        	
        })
        
    })

	// 카드 추가 이벤트
	$(document).on("click", ".addQuestionBtn", function(){
		
		var str = "";
        str += "<div class='questionForm'><div class='questionFormHeader'>";
        str += " <input class='questionNumber' id='questionNumber'>";
        str +=
            "</div><br><div class='questionFormBody'data-no=''><div class='question'><input type='test' value='문제' readonly>";
        str += "<br><textarea name='quizcard_question_name' class='quizcard_question_name' cols='30' rows='10'>문제를 입력하세요</textarea></div>";
        str += "<button class='hintCreateBtn'>힌트추가</button>";
        str += "<div class='hint'><input type='text' value='힌트' readonly><br>";
        str +=
            "<textarea name='quizcard_question_hint' class='quizcard_question_hint' cols='30' rows='10'>힌트를 입력하세요</textarea>";
        str += "<button class='hintCloseBtn'>닫기</button></div>";
        str += "<div class='answer'><input type='text' value='답안' readonly><br>";
        str +=
            "<textarea name='quizcard_question_answer' class='quizcard_question_answer' cols='30' rows='10'>답안을 입력하세요</textarea></div></div><br>";
        str +=
            "<div class='questionFormFooter'><button class='addQuestionBtn'>퀴즈카드 추가</button>";
        str += "<button class='deleteQuestionBtn' data-no=''>퀴즈카드 삭제</button>";
        str += "</div></div>";

        $(".questionWrapper").append(str);
        
        var boxCount = $(".questionForm").length;
        console.log("현재 남아있는 박스 총 갯수: " + boxCount);
        
        //카드를 추가하거나 삭제할 때마다 카운팅을 해서 번호를 매긴다. 그리고 data속성으로 문제번호도 남겨놓는다. crud를 위해서
        var $questionForms = $(".questionForm");
        $.each($questionForms, function (index, item) {
            console.log("index값: " + index);
            $(item).find('.questionNumber').val(index + 1 + " 번 문제");
            $(item).find('.questionFormBody').data("no", (index + 1));
            $(item).find('.deleteQuestionBtn').data("no", (index+1));
        })
        
        // 카드추가 이벤트... 여기서 내가 따로 스크립트로 작성하나.. 그냥 db에 직접적으로 insert하나 똑같은 것 아닌가... 
        	// 어차피 기본값이기 때문. 새로 생긴 것에 대해선 별도로 update도 가능함. 일단 실험ㄱㄱ. 필요한 건, 문제번호와 set번호
        	// 그리고 인조키의 경우, 스크립트 단에서 생성해서 넘기는 게 나을 것 같다. 
        // 박스 전체 갯수나 새로 생성되는 퀴즈카드의 문제번호나 똑같다는 것을 활용. 
        var newQuestionNo = boxCount;
        console.log("새로 생성된 문제번호: " + newQuestionNo);
        console.log("세트번호: " +  quizcard_set_no);
        // 문제넘버링(인조키) 생성
        var qno = newQuestionNo <10 ? '0'+newQuestionNo : ''+newQuestionNo;
        var quizcard_no = quizcard_set_no + qno;
        
        $.ajax({
        	url: "ajaxQuestionNew.do",
        	type: "POST",
        	data: {
        		quizcard_question_no : newQuestionNo,
        		quizcard_set_no : quizcard_set_no,
        		quizcard_no : quizcard_no
        	},
        	success: function(data){
        		console.log(data);
        	},
        	error: function(data){
        		console.log(data);
        	}
        })
		        
	})
	
	
	/************** 카드 삭제 이벤트. **************/
	$(document).on("click", ".deleteQuestionBtn", function(e){
		// 화면상에서 요소를 지운다.
		$(this).closest('.questionForm').remove();
		// 지워진 요소에
		var qno = $(e.target).data("no");
		console.log("qno의 값: " + qno);
		console.log("quizcard_set_no의 값: " + quizcard_set_no);
		// ajax 호출 => quizcard_set_no값,  qno(quizcard_question_no)값을 날려서 지운다. 
		$.ajax({
			url: "ajaxQuestionDel.do"
			data: {
				quizcard_question_no : qno,
				quizcard_set_no : quizcard_set_no
			},
			success: function(data){
				console.log(data);
			},
			error: function(data){
				console.log(data);
			}
		})
		
		// ajax로 삭제 후 index넘버링을 다시 해주어야 한다. 중간의 값이 사라지는 경우도 있으니
			// 화면 상에 노출되는 것분 아니라, DB상에서도  quizcard_no, quizcard_question_no
		
		
		
        // 박스 갯수 조회
        // 동적으로 추가된 다음에 카드박스에 대한 count을 시작하고, 그 갯수만큼 반복문을 돌려 각각의 box에다가 index에 해당하는 value값을 부여한다. => class = "questionForm" 이 값을 기준.
        var boxCount = $(".questionForm").length;
        console.log("현재 남아있는 박스 총 갯수: " + boxCount);

        //카드를 추가하거나 삭제할 때마다 카운팅을 해서 번호를 매긴다. 
        	// => 여기서 ajax로 날리면 안 되나. for문 반복으로.
        var $questionForms = $(".questionForm");
        $.each($questionForms, function (index, item) {
            $(item).find('.questionNumber').val(index + 1 + " 번째 문제");
            $(item).find('.questionFormBody').data("no", (index + 1));
        })
        

	})
	
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
		// 컨트롤러에서 넘긴 questionCount(문제수) 값이 2 이상이면 첫 번째 카드의 삭제와 추가버튼 비활시키도록
		var questionCount = $(".questionCount").data("questioncount");
		console.log("문제수: " + questionCount);
		if(questionCount >1){
			$(".deleteQuestionBtn:first").css("display", "none");
			$(".addQuestionBtn:first").css("display", "none");
			$(".addQuestionBtn").not(".addQuestionBtn:last").css("display", "none");
		}
		
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