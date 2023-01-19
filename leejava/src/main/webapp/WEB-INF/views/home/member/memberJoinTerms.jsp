<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입 약관 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
	.termsWrap {
        width: 50%;
        margin-left: 15%;
 	    margin-top: 7%;
        
    }
    .termsTitle {
        text-align: center;
    }
    .serviceTerms,
    .privacyTerms,
    .expireDateTerms,
    .promotionTerms {
        border: 0.5px solid whitesmoke;
    }
    input[type="checkbox"] {
        width: 20px;
        height: 20px;
    }
    textarea {
        width: 100%;
    }
    #nextBtn {
        width: 50%;
        height: 50px;
        background-color: #05AA6D;
        border-style: none;
        color: white;
        border-radius: 30px;
        margin: auto;
        display: block;
        font-size: medium;
    }
    #nextBtn:hover {
        transition: 0.5s;
        background-color: white;
        color: #05AA6D;
        cursor: pointer;
    }
</style>
</head>
<body>
	  <div class="termsWrap">
        <div class="termsTitle">
            <h3>자바이야기 약관 동의</h3>
            <hr>
        </div>
        <form action="memberJoinForm.do" id="frm">
        <div class="allCehckTerms">
            <input type="checkbox" class="allCheck" >
            <span>자바이야기 서비스 이용약관, 개인정보 수집 및 이용, 유효기간 3년(선택), 프로모션 정보 수신(선택)에 <b style="color: tomato;">모두 동의</b>합니다.
            </span>
        </div>
        <div class="serviceTerms">
            <div class="serviceCheck">
                <input type="checkbox" name="terms" class="subCheck required1">
                <span>(필수) 자바이야기 서비스 이용약관 동의</span>
            </div>
            <textarea name="" id="" cols="30" rows="10" readonly></textarea>
        </div>
        <div class="privacyTerms">
            <div class="privacyCheck">
                <input type="checkbox" name="terms" class="subCheck required2">
                <span>(필수) 개인정보 수집 및 이용 동의</span>
            </div>
            <textarea name="" id="" cols="30" rows="10" readonly></textarea>
        </div>
        <div class="expireDateTerms">
            <input type="checkbox" name="privateTerms" class="subCheck" id="privateTerms">
            <span>(선택) 개인정보 유효기간을 3년으로 선택합니다.</span>
            <br>
            <span>선택하지 않으시면 1년으로 설정됩니다.</span>
        </div>
        <div class="promotionTerms">
            <input type="checkbox" name="promotionTerms" class="subCheck" id="promotionTerms">
            <span>(선택) 프로모션 정보 수신 동의</span>
            <br>
            <span>자바이야기에서 제공하는 각종 이벤트, 안내 등의 정보를 수신합니다.</span>
        </div>
        </form>
        <br><br>
        <button type="button" id="nextBtn">가입 계속</button>
    </div>
</body>
<script>
	// jquery를 활용 checkbox 다중선택/해제
	$(".allCheck").on("click", function () {
	    if ($(".allCheck").is(":checked")) {
	        $(".subCheck").prop("checked", true);
	    } else {
	        $(".subCheck").prop("checked", false);
	    }
	});
	
	$(".subCheck").on("click", function () {
	    if ($(".allCheck").prop("checked", true)) {
	        $(".allCheck").prop("checked", false);
	    }
	})
	
	// 바닐라자바스크립트를 활용하여 checkbox 다중선택 / 해제 => 스프링에선 화살표함수가 적용 안 되는 듯? 
// 	function selectAll(selectAll) {
// 	    const checkboxes = document.querySelector('.subCheck');
		
// 	    checkboxes.forEach((checkbox) => {
// 	        checkbox.checked = selectAll.checked;
// 	    })
// 	}
	
	// '가입 계속' 버튼 클릭 시 => 필수항목 확인 후 다음 페이지 전환
	$("#nextBtn").on("click", function () {
	    if( $("#privateTerms").is(":checked") ){
	    	$("#privateTerms").val('YES');
	    }
	    if( $("#promotionTerms").is(":checked") ){
	    	$("#promotionTerms").val('YES');
	    }
	    
	    if ($(".required1").is(":checked") && $(".required2").is(":checked")) {
	    	alert("필수항목 확인 완료. \n회원가입 상세 화면으로 이동하겠습니다.");
	    	// <form>태그 submit()호출 => action속성에 명시한 url로 <form> 내의 name속성의 값들이 서버로 전달.
	    	frm.submit();
	    } else {
	        alert("필수항목은 반드시 체크해주셔야 합니다.");
	        return false;
	    }
	   
	})
</script>
</html>