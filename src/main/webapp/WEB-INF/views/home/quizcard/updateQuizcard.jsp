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
 	} 
	
	.questionInfoWrapper {
	    width: 50%;
	    padding: 15px;
	    border: 0.5px solid;
	    margin-left: 25%;
	    margin-top: 3%;
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
        z-index: 3;
        display: none;
        position: absolute;
        border: 0.5px solid teal;
        margin-left: 20%;
        width: 35%;
        background-color: lightgray;
    }
    .hint textarea {
    	background-color: whitesmoke;
    	border-style: none;
    }

    .questionFormBody {
        display: flex;
    }

    .hintCreateBtn {
        width: auto;
        height: 50px;
        margin-left: 45px;
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
        width: 150px;
        height: 50px;
        border-radius: 20px;
        border-style: none;
    }
	.questionWrapper textarea{
		border-radius: 20px;
	    padding: 15px;
	    color: teal;
	    font-size: large;
	    font-weight: bold; 
	    width: 100%;
	}
	
	.hint {
		padding: 20px; 
	}
	
	.hint textarea{
		width: 95%;
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
        margin-top: 50px;
        padding-left: 8%;
    }
    .updateEndBtn{
    	display: block;
    	margin: auto;
   	   	width: 150px;
        height: 50px;
        border-radius: 20px;
        border-style: none;
    }
    .updateEndBtn:hover{
    	cursor: pointer;
        background-color: teal;
        color: white;
        transition: 1s;
    }
    .questionNumber{
    	margin-top: 5px;
    	border-style: none;
    	height: 20px;
    	font-size: 20px;
    }
    #setName{
    	border-style: none;
    	font-size: large;
    	font-weight: bolder;
    }
    .questionForm button {
    	border-radius: 20px;
	    width: auto;
	    height: auto;
	    font-weight: 900;
	    color: teal;
	    background-color:  whitesmoke;
	    border-style: none;
	    padding: 10px;
    }
    .questionForm button:hover {
    	cursor: pointer;
	    background-color: teal;
	    color: whitesmoke;
	    transition: 1s;
	}
	.questionFormFooter {
		padding-top: 20px;
		padding-bottom: 20px;
		padding-right: 150px;
	}
	.hintCloseBtn{
		display: block;
		margin: auto;
		min-width: 100px;
		height: 40px;
		margin-top:20px;
	}
	.intoTitle{
		color: teal;
	}
	.quizcard_set_intro{
		border: 1px solid #2E3856;
		padding: 10px;
		border-radius: 20px; 
		font-weight: bolder;
		border-style: none;
		font-size: larger;
	}
</style>
</head>
<body>
    <div class="wrapper">
        <div class="questionInfoWrapper">
            <div class="questionInfoHeader">
                <!--세트번호, 카테고리, 생성일, 마지막 업데이트일-->
                <h3 class="quizcardSetNo intoTitle" data-quizcardsetno="${qvo.quizcard_set_no }">세트번호: ${qvo.quizcard_set_no }</h3>
                <h3 class="intoTitle">카테고리: ${qvo.quizcard_category }</h3>
                <h3 class="intoTitle">세트유형: ${qvo.quizcard_type }</h3>
                <h3 class="questionCount intoTitle" data-questioncount="${questionCount}">문제 수: ${questionCount} </h3>
                <div class="questionInfoDate" style="float: right;">
                    <h4 class="intoTitle">생성일: ${qvo.quizcard_set_cdate } </h4><br>
                    <h4 class="intoTitle">수정일: ${qvo.quizcard_set_udate }</h4>
                </div>
            </div>
            <div class="questionInfoBody">
                <!--세트이름, 세트설명-->
                <h3 class="intoTitle"><label for="setName">세트 이름</label></h3>&nbsp;&nbsp;
                <input type="text" id="setName" name="setName" value="${qvo.quizcard_set_name}">
                <br>
                <h3 class="intoTitle"><label for="quizcard_set_info">세트 설명</label></h3>
                <textarea name="quizcard_set_info" cols="50" rows="8"
                    class="quizcard_set_intro">${qvo.quizcard_set_intro}</textarea>
            </div>
            <div class="questionInfoFooter">
                <!--접근권한 조정, 일단 현 상태에서 만들기(update)-->
                <span class="statusValue" data-statusvalue="${qvo.quizcard_set_status }"><b>공개여부</b></span>
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
	<!-- 잘 생각해보야함. 해당 폼 전체를 :forEach 메서드로 돌리는 게 가능한가. -->
	
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
	                    	<h3>문제</h3>
	                        <br>
	                        <textarea name="quizcard_question_name" class="quizcard_question_name" cols="50"
	                            rows="12">${list.quizcard_question_name }</textarea>
	                    </div>
	                    <button class="hintCreateBtn" style="height: 45px;">힌트 입력</button>
	                    <div class="hint">
	                        <h3>힌트</h3>
	                        <br>
	                        <textarea name="quizcard_question_hint" class="quizcard_question_hint" cols="50"
	                            rows="12">${list.quizcard_question_hint }</textarea>
	                        <button class="hintCloseBtn">닫기</button>
	                    </div>
	                    <div class="answer">
	                        <h3>답안</h3>
	                        <br>
	                        <textarea name="quizcard_question_answer" class="quizcard_question_answer" cols="50"
	                            rows="12">${list.quizcard_question_answer }</textarea>
	                    </div>
	                </div>
	                <br>
	                <div class="questionFormFooter" align="center">
	                    <button class="addQuestionBtn">퀴즈카드 추가</button>
	                    <button class="deleteQuestionBtn" data-no="${list.quizcard_question_no }">퀴즈카드 삭제</button>
	                </div>
	            </div>
            </c:forEach>
            <br><br>
	        <button class="updateEndBtn">수정완료</button>
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
        	}
        })
        
    })

	// 카드 추가 이벤트
	$(document).on("click", ".addQuestionBtn", function(){
		
		var str = "";
        str += "<div class='questionForm'><div class='questionFormHeader'>";
        str += " <input class='questionNumber' id='questionNumber'>";
        str +=
            "</div><br><div class='questionFormBody'data-no=''><div class='question'><h3>문제</h3>";
        str += "<br><textarea name='quizcard_question_name' class='quizcard_question_name' cols='50' rows='12'>문제를 입력하세요</textarea></div>";
        str += "<button class='hintCreateBtn'>힌트추가</button>";
        str += "<div class='hint'><h3>힌트</h3><br>";
        str +=
            "<textarea name='quizcard_question_hint' class='quizcard_question_hint' cols='50' rows='12'>힌트를 입력하세요</textarea>";
        str += "<button class='hintCloseBtn'>닫기</button></div>";
        str += "<div class='answer'><h3>답안</h3><br>";
        str +=
            "<textarea name='quizcard_question_answer' class='quizcard_question_answer' cols='50' rows='12'>답안을 입력하세요</textarea></div></div><br>";
        str +=
            "<div class='questionFormFooter' align='center'><button class='addQuestionBtn'>퀴즈카드 추가</button>";
        str += "<button class='deleteQuestionBtn' data-no=''>퀴즈카드 삭제</button>";
        str += "</div></div>";

        $(".questionWrapper").append(str);
        
        var boxCount = $(".questionForm").length;
        console.log("현재 남아있는 박스 총 갯수: " + boxCount);
        
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
        
        //카드를 추가하거나 삭제할 때마다 카운팅을 해서 번호를 매긴다. 그리고 data속성으로 문제번호도 남겨놓는다. crud를 위해서
        var $questionForms = $(".questionForm");
        $.each($questionForms, function (index, item) {
            console.log("index값: " + index);
            $(item).find('.questionNumber').val(index + 1 + " 번 문제");
            $(item).find('.questionFormBody').data("no", (index + 1));
            $(item).find('.deleteQuestionBtn').data("no", (index+1));
        })
        location.reload();
	})
	
	/************** 카드 삭제 이벤트. **************/
	$(document).on("click", ".deleteQuestionBtn", function(e){
		
		var boxCount = $(".questionForm").length;
        console.log("삭제되기 전 박스갯수(= 문제갯수): " + boxCount);
		// 화면상에서 요소를 지운다.
		$(this).closest('.questionForm').remove();
		
        // 삭제할 문제 번호.
		var qno = $(e.target).data("no");
		console.log("삭제할 qno의 값: " + qno);
		console.log("quizcard_set_no의 값: " + quizcard_set_no);
		// ajax 호출 => quizcard_set_no값,  qno(quizcard_question_no)값을 날려서 지운다. 
		$.ajax({
			url: "ajaxQuestionDel.do",
			type: "POST",
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
		
        // 삭제한 문제번호가 박스갯수와 같았다면, 즉, 마지막 행이었다면 불필요하게 반복문으로 다시 순번값을 정렬할 필요가 없다.
        if(qno !== boxCount) {
	        var $questionForms = $(".questionForm");
	        $.each($questionForms, function (index, item) {
	            $(item).find('.questionNumber').val(index + 1 + " 번째 문제");
	            $(item).find('.questionFormBody').data("no", (index + 1));
	            $(item).find('.deleteQuestionBtn').data("no", (index + 1));
        	})
        	questionUpdateFnc(qno, boxCount);
        }  
		// 삭제 이후, 마지막 카드 박스에는 "카드추가" 버튼이 활성화 되어야 함
        $(".addQuestionBtn:last").css("display", "block");
		if( boxCount === 1){
			$(".addQuestionBtn:first").css("display", "block");
		}
		location.reload();
	})
       
	function questionUpdateFnc( qno, count ){
		// 삭제된 대상 +1이 업데이트 대상 문제번호, count는 업데이트 대상 숫자
			// 반복문으로 객체에 담아서 컨트롤러에 넘긴다. 
		var updateAry = [];
		for(var i = qno; i<count; i++){
			var updateObj = {};
			updateObj["setQno"] = i;
			updateObj.setNo = quizcard_set_no;
			var preQno = i < 10 ? '0'+i : ''+ i;
			var afterQno = quizcard_set_no + preQno;
			updateObj.setQuizcardNo = afterQno;
			updateAry.push(updateObj);
		}
		console.log("업데이트 목록 생성된 객체 확인:");
		console.log(updateAry);
		$.ajax({
			type: "PUT",
			url: "ajaxUpdateQuestionNo.do",
			contentType: 'application/json; charset=utf-8',
			data: JSON.stringify(updateAry),
			async : false,
			success: function(data){
				console.log("통신성공");
			},
			error: function(data){
				console.log("통신실패");
			}
		})
	}
	
	// 힌트 클릭.
	$(document).on("click", '.hintCreateBtn', function () {
	    console.log("힌트 클릭");
	    $(this).next().css("display", "block");
	})
	// 힌트 닫기
	$(document).on("click", '.hintCloseBtn', function () {
	    $(this).closest(".hint").css("display", "none");
	})
	
	// 수정완료버튼 (이전 페이지로 돌아가기)
	$(".updateEndBtn").on("click", function(){
		console.log("수정완료 클릭");
		// 수정완료하고 바로 반영된 데이터를 보려면 => 세트번호와 이메일을 같이 url에 매핑해서 날려야 한다. 
		location.href = "quizcardBefore.do?set_no=" + quizcard_set_no;
	})
	
	// 세트이름 수정 =>
	$(document).on("blur", "#setName, .quizcard_set_intro, input[name='quizcard_set_status']" ,function(){
		if ( $(this) === $("input[name='quizcard_set_status']")){
			console.log("공개여부 blue이벤트 발생");
		}
		var setName = $("#setName").val();
		var	setIntro = $(".quizcard_set_intro").val();
		console.log("세트 이름: " + setName);
		console.log("세트 소개: " + setIntro);
		console.log("const 전역변수 세트 번호: " + quizcard_set_no);
		var setStatus = $("input[name='quizcard_set_status']:checked").val();
		console.log("상태값: " + setStatus);
		// 세트이름은  null이 되면 안 되도록 체크하기
		if(setName == null){
			alert("세트이름을 입력해주세요");
			$("#setName").focus();
		} else {
			console.log("업데이트 ajax 호출");
			$.ajax({
				url: "ajaxQuizInfoUpdate.do",
				method: "post",
				data:{
					quizcard_set_no : quizcard_set_no,
					quizcard_set_name :  setName,
					quizcard_set_intro : setIntro,
					quizcard_set_status: setStatus
				},
				success: function(responseText){
					console.log("ajax호출 성공");
					console.log(responseText);
				},
				error: function(responseText){
					console.log("ajax호출 실패");
					console.log(responseText);
				}
				
			})
		}
	})
	
</script>
<script>
	$(function(){
		// 컨트롤러에서 넘긴 questionCount(문제수) 값이 2 이상이면 첫 번째 카드의 삭제와 추가버튼 비활시키도록
		var questionCount = $(".questionForm").length;
		console.log("문제수: " + questionCount);
		if(questionCount >1){
			$(".deleteQuestionBtn:first").css("display", "none");
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