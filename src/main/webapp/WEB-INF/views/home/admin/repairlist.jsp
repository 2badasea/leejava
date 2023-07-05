<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이지 유지보수 리스트 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<style type="text/css">
/* ********** 공통 ***************/
.repairList_wrapper textarea{
	resize: vertical;
	border-radius: 20px;
	font-weight: 800;
	font-size: large;
	width: 95%;
	padding: 15px;
}
.repairList_wrapper label{
	font-weight: 900;
	margin-left: 15px;
}

.repairSearchWrapper{
}
.repairListDiv{
	width: 55%;
	margin-left: 10%;
}
.repairSearch{
	width: 55%;
}
.repairFormBtns button,
.repairSearchWrapper button{
	border-radius: 20px;
	border-style: none;
	padding: 10px;
	width: auto;
	height: auto;
	color: whitesmoke;
	background-color: #313348;
	font-weight: 900;
}
.repairFormBtns button:hover,
.repairSearchWrapper button:hover {
	cursor: pointer;
	background-color: whitesmoke;
	color: #313348;
	transition: 0.5s;
}

/* ***	검색차 영역 디자인	***	 */
.repairSearchTable{
	margin-top: 2%;
	text-align: center;
	border-collapse: collapse;
	border: 1px solid #313348;
}

.repairSearchTable tr{
	border-bottom: 1px solid #313348; 
}

.repairSearchTable th{
	font-size: 18px;
	height: 30px;
	border-left: 1px solid #313348;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
	font-weight: 900;
}

.repairSearchTable td{
	border-bottom: 1px solid #313348;
	height: 20px;
	border-left: 1px solid #313348;
	padding: 5px; 
}

.repairSearchTable input,
.repairSearchTable select{
	width: 100%;
	font-size: 100%;
	text-align: center;
	height: 100%;
	border-style: none;
	font-weight: 700;
	border-bottom: 0.5px solid #313348;
}

.repairSearchTable input:focus,
.repairSearchTable select:focus,
.repairSearchTable option:focus{
	outline-color: coral;
}

.repairSearchBtns{
	margin-top: 2%;
}
.repairSearchBtns button{
	min-width: 100px;
	min-height: 40px;
} 


/*	***	 유지보수 리스트 디자인 	***	*/
.repairListTable{
	margin-top: 2%;
	text-align: center;
	border-collapse: collapse;
	border: 1px solid #313348;
}

.repairListTr:hover{
	background-color: #B8D7FF;
	
}

.repairListTableThTr{
	border-bottom: 1px solid #313348;
}

.repairListTable th{
	font-size: 18px;
	height: 30px;
	border-left: 1px solid #313348;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
	font-weight: 900;
}

.repairListTable td{
	border-bottom: 1px solid #313348;
	height: 20px;
	border-left: 0.5px swolid whitesmoke;
	padding: 5px;
}
/*  유지보수 리스트 등록하는 폼 디자인 끝나면 다시 block으로 */ 

/*	유지보수 작성 폼 디자인 */
.repairForm{
	border: 0.5px solid #313348;
	border-radius: 20px;
	width: 40%;
	height: auto;
	padding: 10px;
 	display: display;   
}
.repairSearch{
	display: none;
}
.repairFormOpenBtn{
	display: none;
}
.repairSearchOpenBtn{
	display: block;
}
.repairForm input{
	border-style: none;
}
.repairForm span{
		
}
textarea:focus, 
.repairForm input:focus {
	outline-color: #6482B9;	
}
.rcontentLabel:hover{
	cursor: pointer;
}
.rcontentInput{
	display: none;
	margin-bottom: 10px;
}
.minusicon{
	display: none;
}
.show{
	display: block;
} 
.hidden{
	display: none;
}
.repairFormSearchBtns {
	margin-top:1%;
}
.repairListTable td{
	border-left: 1px solid #313348;
}
.repairFormHeader,
.repairFormTitle{
	border-bottom: 0.1px dotted lightgray;
	padding-top: 5px;
	padding-bottom: 5px;
}
.repairSearchWrapperTop{
	margin-top: 5%;
	margin-left: 20%; 
}
.rtitleInput{
	width: 80%;
	font-weight: 700;
	font-size: medium;
	padding: 5px;
	margin-left: 10px;
}
.repairListTitleTd:hover{
	cursor: pointer;
}
.repairListTitleTd{
	font-weight: 700;
	color: teal;
}
.repairFormHeader {
	display: flex;
	justify-content: space-around;
}
/* **********	유지보수 게시글 rowdatㅁ 조회 모달창 디자인 ******* */
   .repair_modal_container {
        position: fixed;
        top: 0px;
        bottom: 0px;
        width: 100%;
        height: 100vh;
        display: none;
        z-index: 1;
    }

    .repair_modal_content {
        position: absolute;
        top: 30%;
        left: 20%;
        width: 35%;
        height: auto;
        z-index: 3;
        background-color: white;
        border: 0.5px solid #313348;
        border-radius: 30px;
        padding: 20px;
    }

    .repair_modal_layer {
        position: relative;
        width: 100%;
        height: 100%;
        z-index: 2;
        background-color: gray;
        opacity: 0.5;
        transition: 2s;
    }
    .model_rtitleInput{
    width: 80%;
    font-weight: 700;
    font-size: medium;
    padding: 5px;
    margin-left: 10px;
    color: teal;
    }

    .model_repairForm{
    border: 0.5px solid #313348;
    border-radius: 20px;
    width: 97%;
    height: auto;
    padding: 10px;
    display: display;   
    }
    .model_repairForm label{
        font-weight: 900;
    }
    .model_repairForm input{
        border-style: none;
    }
    textarea:focus, 
    .model_repairForm input:focus {
        outline-color: #6482B9;	
    }
    .model_rcontentInput{
        margin-bottom: 10px;
        color: teal;
    }
    .model_repairForm textarea{
        resize: vertical;
        border-radius: 20px;
        font-weight: 800;
        font-size: large;
        width: 95%;   
        padding: 15px;
    }
    .repairModelCloseBtn {
    	margin-left: 15px;
    	min-width: 80px;
    	width: auto;
    }
    .repairUpdateBtn{
    	min-width: 100px;
    	width: auto;
    }
    .model_m_emailInput, 
    .rnoInput{
    	text-align: center;
    	font-weight: 600;
    	font-size: medium;
    	width: 100px;
    	color: teal;
    }
    
    .repairListDiv input[type='checkbox']{
    	width: 20px;
    	height: 20px;
    }
    .repairListSpan{
    	color: #313348;
    	font-weight: 800;
    }
    .paginationBox {
		margin-bottom: 20px;
		display: flex;
		justify-content: center;
	}
	.paginationUl > li{
		list-style-type: none;
		float: left;
		padding: 5px;
	}
	.paginationLink{
		color: #313348;
		font-size: 20px;
	}
	.active a {
		font-weight: bolder;
		font-size: large;
		color: tomato;
	}	
	.repairListOptions{
		display: flex; 
		justify-content: space-around;
	}
</style>
</head>
<body>
<!-- 유지보수 게시판 개별 데이터 조회 모달창  -->
    <!--유지보수 개별 데이터 조회하는 모달창-->
     <div class="repair_modal_container">
        <div class="repair_modal_content">
                <!-- 여기가 대입한 공간 -->
        <div class="model_repairForm">
   			<form id="frm">
	            <div class="model_repairFormHeader">
	                <!--들어가는 요소 글번호, 중요도, 카테고리, 우선순위   -->
	                <label for="repairNo">No</label>
	                <input type="text" id="repairNo" class="rnoInput" value="" readonly="readonly">
	                <div style="display: inline; margin-left: 50px;">
	                    <label for="rwdate" style="font-size: small;">작성일</label>   
	                    <label for="rfdate" style="font-size: small;">/ 완료일 :</label>   
	                    <span id="rwdate" class="model_rwdate" style="font-size: small;"></span>
	                    <span id="rfdate" class="model_rfdate" style="font-size: small; color: tomato;"></span>
	                </div>
	                <br>
	                <label for="model_rcategory">카테고리</label>
	                <select id="model_rcategory" class="model_rcategoryInput">
	                    <option value="ALL" selected>선택</option>
	                    <option value="ADMIN" >관리자</option>
	                    <option value="QUiZCARD">퀴즈카드</option>
	                    <option value="USER">사용자</option>
	                </select>
	                <label for="model_rgrade">중요도</label>
	                <select id="model_rgrade" class="model_rgradeInput">
	                    <option value="ALL" selected>분류</option>
	                    <option value="A">상</option>
	                    <option value="B">중</option>
	                    <option value="C">하</option>
	                </select>
	                <label id="model_rstatus">진행상황</label>
	                <select id="model_rstatus" class="model_rstatusInput">
	                    <option value="ALL" selected>시작전</option>
	                    <option value="FIXING">진행중</option>
	                    <option value="FIXED">완료</option>
	                </select>
	                <label for="model_m_email">작성자</label>
	                <input type="text" id="model_m_email" class="model_m_emailInput" value="" readonly="readonly">
	            </div>
	            <div class="model_repairFormTitle" >
	                <label for="model_rtitle">제목</label>
	                <input type="text" id="model_rtitle" class="model_rtitleInput" readonly="readonly" placeholder="제목을 입력해주세요(최대 25자)" maxlength="40" style="min-width: 150px;">
	            </div>
	            <div class="model_repairFormContent">
	                <label for="model_repairContent" class="model_rcontentLabel">
	                	상세 내용
	                </label>
	                <br>
	                <textarea name="" id="model_repairContent" class="model_rcontentInput" readonly="readonly" cols="30" rows="4"></textarea>
	            </div>
   			</form>
		    <div class="repairFormBtns" style="display: flex; justify-content: flex-end; border: 3%; margin-right: 5%;">
              <button type="button" class="repairModelCloseBtn">수정&닫기</button>
	        </div>
   		</div>
        </div> <!-- repair_model_content 영역 끝. -->
        <div class="repair_modal_layer"></div>
    </div> 
<script>
	/* 모달창의 제목과 내용부분의 경우 기본값 readonly => 더블클릭이 일어나면 readonly가 해제되고, blur이벤트가 발생하면 알아서 업데이트 되도록 한다. */
	// 1. 더블클릭(dblclick) 이벤트 정의
	$(".model_rtitleInput, .model_rcontentInput").on("dblclick", function(){
		$(this).prop("readonly", false);
	})
	// 2. blur업데이트 처리
	$(".model_rtitleInput, .model_rcontentInput").on("blur", function(e){
		// blur가 발생한 것들에 대해서만 readonly속성이 false인 경우에만 blur에 의한 업데이트가 일어나도록 정의
		if ($(this).attr('readonly') !=  'readonly'){
			var data;
			var rtitle;
			var rcontent;
			var rno = $('.rnoInput').val();
			if( $(this).hasClass('model_rtitleInput') ){
				rtitle = $(this).val();
				data = { rtitle : rtitle, rno: rno };
			} else if ($(this).hasClass('model_rcontentInput')){
				rcontent = $(this).val();
				data = { rcontent : rcontent, rno: rno };
			}
			$.ajax({
				url: "repairListUpdate.do",
				method : "PUT",
				contentType: "application/json; charset=utf-8",
				dataType: "text",
				data : JSON.stringify(data),
				success: function(message){
					console.log("호출 성공");
					if(message !== "실패"){
						$(".repairModelCloseBtn").val('new');
					}
				},
				error: function(){
					console.log("호출 실패");
				}
			}) // ajax 끝
		} // if문 끝 
	})	// blue업데이트 이벤트 정의 끝.
	

	// 카테고리 업데이트
	$(".model_rcategoryInput").on("change", function(){
		console.log("선택한 값: " + $(this).val());
		console.log("글번호 값: " + $('.rnoInput').val());
		var rcategory = $(this).val();
		var rno = $('.rnoInput').val();
		// rest api 방식으로 업데이트 가능. 
		var data = {
				rcategory : rcategory,
				rno : rno
		};
		$.ajax({
			url: "repairListUpdate.do",
			data: JSON.stringify(data),
			type: "PUT",
			dataType: "text",
			contentType: "application/json; charset=utf-8",
			success: function(message){
				console.log("호출 성공");
				if(message !== "실패"){
					$(".repairModelCloseBtn").val('new');
				}
			},
			error: function(){
				console.log("호출 실패");
			}
		})
	})
	
	// 중요도 업데이트
	$(".model_rgradeInput").on("change", function(){
		console.log("선택한 값: " + $(this).val());
		console.log("글번호 값: " + $('.rnoInput').val());
		var rgrade = $(this).val();
		var rno = $('.rnoInput').val();
		// rest api 방식으로 업데이트 가능. 
		var data = {
				rgrade : rgrade,
				rno : rno
		};
		$.ajax({
			url: "repairListUpdate.do",
			data: JSON.stringify(data),
			type: "PUT",
			dataType: "text",
			contentType: "application/json; charset=utf-8",
			success: function(message){
				console.log("호출 성공");
				if(message !== "실패"){
					$(".repairModelCloseBtn").val('new');
				}
			},
			error: function(){
				console.log("호출 실패");
			}
		})
	})
	
	// 진행상황 업데이트
	$(".model_rstatusInput").on("change", function(){
		console.log("선택한 값: " + $(this).val());
		console.log("글번호 값: " + $('.rnoInput').val());
		var rstatus = $(this).val();
		var rno = $('.rnoInput').val();
		// rest api 방식으로 업데이트 가능. 
		var data = {
				rstatus : rstatus,
				rno : rno
		};
		$.ajax({
			url: "repairListUpdate.do",
			data: JSON.stringify(data),
			type: "PUT",
			dataType: "text",
			contentType: "application/json; charset=utf-8",
			success: function(message){
				console.log("호출 성공");
				if(message !== "실패"){
					$(".repairModelCloseBtn").val('new');
				}
				if(rstatus !== 'FIXED'){
					$('.model_rfdate').text('');
				}
			},
			error: function(){
				console.log("호출 실패");
			}
		})
	})
	
	// 모달창 닫기 이벤트
	$(".repairModelCloseBtn").on("click", function(){
		if( $(".repairModelCloseBtn").val() == 'new'){
			$(".repair_modal_container").css("display", "none");
			$('body').css("overflow", "unset");
			location.reload();
		} else {
			$(".repair_modal_container").css("display", "none");
			$('body').css("overflow", "unset");
		}
	})
	
	// 외부영역 클릭으로 모달창 닫기
	$(document).on("click", function(e){
		if( $(e.target).closest(".repair_modal_content").length === 0 &&  
			$(e.target).closest(".repairListTr").length === 0 ) {
			if( $(".repairModelCloseBtn").val() == 'new'){
				$(".repair_modal_container").css("display", "none");
				$('body').css("overflow", "unset");
				location.reload();
			} else {
				$(".repair_modal_container").css("display", "none");
				$('body').css("overflow", "unset");
			}
		}
	})
	
</script> 

<!-- -------  모달창 끝  ------------------->

<div class="repairList_wrapper">
    <!-- 검색요소 중에 입력해야 할 요소가 있나>? 카테고리(selectbox), 제목 내용, 진행상태, 기간? -->
  <div class="repairSearchWrapper">	
   		<!-- 유지보수 입력창을 호출하는 폼을 호출한다. --> 
	<div class="repairSearchWrapperTop">
		<h1>유지보수 현황 조회</h1>
		<br>
   		<div class="repairForm">
   			<form id="frm">
	            <div class="repairFormHeader">
					<div>
		                <label for="rcategory">카테고리</label>
		                <select id="rcategory" class="rcategoryInput">
		                    <option value="ALL" selected>선택</option>
		                    <option value="ADMIN" >관리자</option>
		                    <option value="QUiZCARD">퀴즈카드</option>
		                    <option value="USER">사용자</option>
		                </select>
	                </div>
	                <div>
	              		<label for="rgrade">중요도</label>
	       	     	    <select id="rgrade" class="rgradeInput">
		                    <option value="ALL" selected>분류</option>
		                    <option value="A">상</option>
		                    <option value="B">중</option>
		                    <option value="C">하</option>
		                </select>
	                </div>
	                <div>
		                <label id="rstatus">진행상황</label>
		                <select id="rstatus" class="rstatusInput">
		                    <option value="ALL" selected>시작전</option>
		                    <option value="FIXING">진행중</option>
		                    <option value="FIXED">완료</option>
		                </select>
	                </div>
	            </div>
	            <div class="repairFormTitle" >
	                <label for="rtitle">제목</label>
	                <input type="text" id="rtitle" class="rtitleInput" placeholder="제목을 입력해주세요(최대 20자)" maxlength="45" style="min-width: 150px;">
	            </div>
	            <div class="repairFormContent">
	                <label for="repairContent" class="rcontentLabel">
	                	상세 내용 입력
	                	 <i class="fa-solid fa-circle-plus plusicon" ></i>
		                <i class="fa-solid fa-circle-minus minusicon"></i>
	                </label>
	                <br>
	                <textarea name="" id="repairContent" class="rcontentInput" cols="30" rows="4"></textarea>
	            </div>
   			</form>
		    <div class="repairFormBtns" style="display: flex; justify-content: flex-end; border: 3%; margin-right: 5%;">
		      <button type="button" class="repairFormBtn">등록하기</button>
	        </div>
   		</div>
   		
	<!-- repairForm, repairSearch 이렇게 두 개 존재  -->   
   		<div class="repairSearch">
   		  <form id="searchForm">
	       <table class="repairSearchTable">
	           <tr>
	               <th>제목</th>
	               <td style="width: 300px;">
	                   <input type="text" id="rTitle" class="searchInput rTitle" placeholder="제목을 입력해주세요." > 
	               </td>
	               <th>내용</th>
	               <td style="width: 300px;">
	                   <input type="text" id="rContent" class="searchInput rContent" placeholder="내용을 입력해주세요.">
	               </td>
	           </tr>
	           <tr>
	               <th>카테고리</th>
	               <td>
	                   <select id="rCategory" class="searchInput rCategory">
	                       <option value="ALL" selected="selected">전체</option>
	                       <option value="USER">사용자</option>
	                       <option value="QUIZCARD">퀴즈카드</option>
	                       <option value="ADMIN">관리자</option>
	                   </select>
	               </td>
	               <th>작성자</th>
	               <td>
	                   <input type="text" id="m_email" class="searchInput m_email" placeholder="작성자의 닉네임을 입력해주세요.">
	               </td>
	           </tr>
	       </table>
	       </form>
	       <div class="repairSearchBtns">
	           <button type="button" class="clearBtn">초기화</button>
	           <button type="button" class="repairSearchBtn">검색</button>
	       </div>
       </div>
   	</div>  <!-- repairSearchWrapperTop 부분 끝 -->
    <div class="repairFormSearchBtns" align="center">
  		<button type="button" class="repairFormOpenBtn">유지보수 추가 전환</button>
  		<button type="button" class="repairSearchOpenBtn">유지보수 검색 전환</button>
	</div>
   	<script>
   		/*	검색창 이벤트 정리 */
   		// 1. 검색창 입력요소 초기화
   		$(".clearBtn").on("click", function(){
   			console.log("초기화 버튼 클릭");
   			$("#searchForm")[0].reset();
   		})
   		
   		// 2. 검색버튼 구현 
   		$(".repairSearchBtn").on("click", function(){
   			var url = "adminRepair.do";
   			var rcategory = $(".rCategory").val();
   			var rtitle = $(".rTitle").val();
   			var rcontent = $(".rContent").val();
   			var m_email = $(".m_email").val();
   			url = url + "?rcategory=" + rcategory;
   			url = url + "&rtitle=" + rtitle;
   			url = url + "&rcontent" + rcontent;
   			url = url + "&m_email" + m_email;
   			location.href = url;
   		})
   	</script>
   	
		<br>
		<br>
		<hr>
		<br>
  		<!----- 유지보수 리스트 ------>
	   <div class="repairListDiv" align="center">
	    	<div class="repairListOptions">
	    			    <!--한 페이지에 몇 개의 rowdate를 출력시킬지에 대한 구성요소-->
		    	<div class="repairListCntBox">
			    	<c:choose>
			    		<c:when test="${pagination.listCnt lt pagination.end }">
			    			<span class="repairListSpan">(총 ${pagination.listCnt}건 중 ${pagination.start } ~ ${pagination.listCnt }건)</span>
			    		</c:when>
			    		<c:otherwise>
			    			<span class="repairListSpan">(총 ${pagination.listCnt}건 중 ${pagination.start } ~ ${pagination.end }건)</span>
			    		</c:otherwise>
			    	</c:choose>
			    	<br>
			    	<select class="paging" name="searchType" id="listSize" onchange="page(1)">
			    		<option value="10" <c:if test="${pagination.getListSize() == 10 }">selected="selected"</c:if>>10건씩 보기</option>
			    		<option value="15" <c:if test="${pagination.getListSize() == 15 }">selected="selected"</c:if>>15건씩 보기</option>
			    		<option value="20" <c:if test="${pagination.getListSize() == 20 }">selected="selected"</c:if>>20건씩 보기</option>
			    	</select>
		    	</div>
		    	<div class="repairListBtns">
		    		<button type="button" class="selectDeleteBtn">선택 삭제</button>
		    		<button type="button" class="selectFinishBtn">선택 완료</button>
		    		<br>
		    		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
			    	<select name="rtimeorder" id="rtimeorder" class="rtimeorder" onchange="fn_rtimeorder()">
			    		<option value="DESC" <c:if test="${pagination.getRtimeorder() == 'DESC' }">selected="selected"</c:if>>최신 순</option>
			    		<option value="ASC" <c:if test="${pagination.getRtimeorder() == 'ASC' }">selected="selected"</c:if>>작성 순</option>
			    		<option value="RGRADEORDER" <c:if test="${pagination.getRtimeorder() == 'RGRADEORDER' }">selected="selected"</c:if>>중요도 순</option>
			    		<option value="RSTATUSORDER" <c:if test="${pagination.getRtimeorder() == 'RSTATUSORDER' }">selected="selected"</c:if> >진행상황 순</option>
		    		</select>
		    		<input type="hidden" class="hiddenInputTest" id="hiddenInputTest" data-rtimeorder="${search.getRtimeorder() }" 
		    								data-timeorder="${pagination.getRtimeorder() }">
				</div>
	    	</div>
	    	<script>
	    		// onchange 이벤틀 정의함으로써 변경되어 선택하 값을 가져온다. 
	    		function fn_rtimeorder(){
	    			var rtimeorder = $(".rtimeorder").val();
	    			// rtimeorder의 값이 여러가지. 
	    			var url = "adminRepair.do";
	    			// rtimeorder 값으로 가질 수 있는 것(DESC, ASC, RGRADEORDER, RSTATUSORDER)
	    			url = url += "?rtimeorder=" + rtimeorder;
	    			location.href = url;
	    		}
	    	
	    	</script>
	        <table class="repairListTable">
	            <tr class="repairListTableThTr">
	                <th class="listTh" style="width: 30px;">
	                    <input type="checkbox" class="allCheckBtn">
	                </th>
	                <th class="listTh">No.</th>
	                <th class="listTh">중요도</th>
	                <th class="listTh">카테고리</th>
	                <th class="listTh" style="width: 350px">제목</th>
	                <th class="listTh">진행상황</th>
	                <th class="listTh">작성일/완료일</th>
	            </tr> 
	            <c:forEach items="${repair }" var="repair">
	            	<tr class="repairListTr">
		                <td>  
		                	<input type="checkbox" class="subCheckBtn" data-value="${repair.rno}" 
		                		data-status="${repair.rstatus }" value="${repair.rno}" data-rgrade="${repair.rgrade }">
		                </td>
		                <td>${repair.rno}</td>
		                <td>
		                	<c:choose>
		                		<c:when test="${repair.rgrade == 'A' }">상</c:when>
		                		<c:when test="${repair.rgrade == 'B'}">중</c:when>
		                		<c:when test="${repair.rgrade == 'C' }">하</c:when>
		                		<c:otherwise>하</c:otherwise>
		                	</c:choose>
		                </td>
		                <td>
		                	<c:choose>
		                		<c:when test="${repair.rcategory == 'ALL' }">전체</c:when>
		                		<c:when test="${repair.rcategory == 'ADMIN'}">관리자</c:when>
		                		<c:when test="${repair.rcategory == 'QUIZCARD' }">퀴즈카드</c:when>
		                		<c:when test="${repair.rcategory == 'USER' }">사용자</c:when>
		                		<c:otherwise>전체</c:otherwise>
		                	</c:choose>
		                </td>
		                <td class="repairListTitleTd">
		                	${repair.rtitle}
		                </td>
		                <td class="repairListStatusTd">
		           	   	 	<c:choose>
		                		<c:when test="${repair.rstatus == 'ALL' }">시작전</c:when>
		                		<c:when test="${repair.rstatus == 'FIXING'}">진행중</c:when>
		                		<c:when test="${repair.rstatus == 'FIXED' }">완료</c:when>
		                		<c:otherwise>시작전</c:otherwise>
		                	</c:choose>
		                </td>
		                <td>
		                	<span style="font-size: small;">${repair.rwdate}</span>  
		                	<br>
		                	<c:if test="${repair.rfdate != null }">
		                		<span style="font-size: small; color: coral;">/ ${repair.rfdate}</span>
		                	</c:if>
		                </td>
		            </tr>
		        </c:forEach>
	        </table>
	       	<br><br>
	       	<!-- 페이징 박스가 들어갈 곳 -->
	        <div id="paginationBox" class="paginationBox">
	        	<ul class="paginationUl">
	        	<!-- 기본적인 페이지 호출 파라미터 갯수에 rangeSize와 listSize가 추가된다. 해당 paging정보가 반영되는 게 우선순위ㄱ이기 때문.  -->
	        		<c:if test="${pagination.prev }">
	        			<li class="paginationLi">
	        				<a class="paginationLink specialA" onclick="fn_prev('${pagination.page}','${pagination.range}', '${pagination.rangeSize }','${pagination.listSize }',
	        																	'${search.rcategory }','${search.rtitle }','${search.rcontent }','${search.m_email }',
	        																	'${search.rgrade }', '${search.rstatus }','${search.rtimeorder }')">
	        				이전</a>
	        			</li>
	        		</c:if>
	        		<c:forEach begin="${pagination.startPage }" end="${pagination.endPage }" var="repairNo">
	        			<!-- 화면에 출력되는 페이지 넘버링과 실제 현재 출력되고 있는 페이징 넘버값이 같다면 class속성에 'active' 속성값 추가 -->
	        			<li class="paginationLi <c:out value="${pagination.page == repairNo ? 'active' : '' }" />" >
	        				<a class="paginationLink specialA" onclick="fn_pagination('${repairNo}', '${pagination.range}', '${pagination.rangeSize }','${pagination.listSize }',
	        																	'${search.rcategory }','${search.rtitle }','${search.rcontent }','${search.m_email }',
	        																	'${search.rgrade }', '${search.rstatus }','${search.rtimeorder }')">
	        				
	        				${repairNo }</a>
	        			</li>
	        		</c:forEach>
	        		<c:if test="${pagination.next }">
	        			<li class="paginationLi">
	        				<a class="paginationLink specialA" onclick="fn_next('${pagination.page}','${pagination.range}', '${pagination.rangeSize }','${pagination.listSize }',
																				'${search.rcategory }','${search.rtitle }','${search.rcontent }','${search.m_email }',
																				'${search.rgrade }', '${search.rstatus }','${search.rtimeorder }')">
	        				다음</a>
	        			</li>
	        		</c:if>
	        	</ul>
	        </div>
		</div>
  </div>	<!--  repairSearchWrapper 부분 끝 -->
</div>
</body>
<script>
	function page(Paging){
		var startPage = Paging;
		var listSize = $("#listSize option:selected").val();
		// 기본적인 값에다가 startPage와 listSize만 추가돈 페이징 정보가 화면에 출력된다. 
		var url = "adminRepair.do?startPage=" + startPage + "&listSize=" + listSize;
		location.href = url;
	}
	
	// 현재 listSize의 기본값은 10, rangeSize의 기본값은 5로 설정된 상태. 
	function fn_prev(page, range, rangeSize, listSize, rcategory, rtitle, 
			rcontent, m_email, rgrade, rstatus, rtimeorder){
		var page = ( (range - 2) * rangeSize ) + 1;
		var range = range - 1; 
		var url = "adminRepair.do";
		url = url += "?page=" + page;
		url = url += "&range=" + range;
		url = url += "&listSize=" + listSize;
		url = url += "&rcategory=" + rcategory;
		url = url += "&rtitle=" + rtitle;
		url = url += "&rcontent=" + rcontent;
		url = url += "&m_email=" + m_email;
		url = url += "&rgrade=" + rgrade;
		url = url += "&rstatus=" + rstatus;
		url = url += "&rtimeorder=" + rtimeorder;
		location.href = url;
	}
	
	function fn_pagination(page, range, rangeSize, listSize, rcategory, rtitle,
			rcontent, m_email, rgrade, rstatus, rtimeorder) {
		var url = "adminRepair.do";
		url = url += "?page=" + page;
		url = url += "&range=" + range;
		url = url += "&listSize=" + listSize;
		url = url += "&rcategory=" + rcategory;
		url = url += "&rtitle=" + rtitle;
		url = url += "&rcontent=" + rcontent;
		url = url += "&m_email=" + m_email;
		url = url += "&rgrade=" + rgrade;
		url = url += "&rstatus=" + rstatus;
		url = url += "&rtimeorder=" + rtimeorder;
		location.href= url;
	}
	
	function fn_next(page, range, rangeSize, listSize, rcategory, rtitle,
			rcontent, m_email, rgrade, rstatus, rtimeorder){
		var page =  parseInt( (range * rangeSize) ) + 1;
		var range = parseInt(range) + 1; 
		var url = "adminRepair.do";
		url = url += "?page=" + page;
		url = url += "&range=" + range;
		url = url += "&listSize=" + listSize;
		url = url += "&rcategory=" + rcategory;
		url = url += "&rtitle=" + rtitle;
		url = url += "&rcontent=" + rcontent;
		url = url += "&m_email=" + m_email;
		url = url += "&rgrade=" + rgrade;
		url = url += "&rstatus=" + rstatus;
		url = url += "&rtimeorder=" + rtimeorder;
		location.href = url;
		
	}

	// 선택 삭제 구현 
	$(".selectDeleteBtn").on("click", function(){
			var checkedLength = $(".subCheckBtn:checked").length;
			if(checkedLength === 0){
				alert("선택한 게 없습니다.");
				return false;
			}
			var checkedArray = [];
			var deleteCheck= confirm("정말 삭제하시겠습니까?");
			if(!deleteCheck){
				alert("취소되었습니다.");
				return false;
			} else {
				$(".subCheckBtn:checked").each(function(){
					checkedArray.push($(this).data('value'));
				})
				console.log("배열 확인: " + checkedArray);	
				$.ajax({
					url: "repairListcheckedAryDelete.do",
					dataType : "TEXT",
					data: {
						checkedArray : checkedArray
					},
					contentType: "application/x-www-form-urlencoded",
					type: "POST",
					success: function(text){
						console.log("호출 성공");
						alert(text);
						location.reload();
					},
					error: function(){
						console.log("호출 실패");
					}
				})
				
			}
	})


	// 선택 완료 업데이트 시킥 => 그전에 우선 체크박스를 통해 체크시킨 게 있는지 체크를 해야 함. 
	$(".selectFinishBtn").on("click", function(){
			var checkedLength = $(".subCheckBtn:checked").length;
			if(checkedLength === 0){
				alert("선택한 게 없습니다.");
				return false;
			}
			var finishCheck = confirm("확인없이 일괄적으로 완료처리 하시겠습니까?");
			var checkedAry = [];
			var rstatus = "FIXED";
			if(!finishCheck){
				return false;
			} else {
				$(".subCheckBtn:checked").each(function(){
					checkedAry.push( $(this).data('value') );
				})
			}
			console.log("확인: " + checkedAry);
			var data = {
					checkedAry : checkedAry,
					rstatus : rstatus
			};
			// ajax로 처리한다. 
			$.ajax({
				url: "repairListcheckedAry.do",
				type: "POST",
				dataType: "text",
				data: data,
				success: function(message){
					console.log("호출 성공");
					console.log(message);
					var check = confirm("새로고침?");
					if(check){
						location.reload();
					} else {
						return false;
					}
				},
				erorr: function(){
					console.log("호출 실패");
				}
			})
	})

	// 리스트르 클릭하면 해당 글의 내용 조회
	$(".repairListTitleTd").on("click", function(e){
		console.log("게시글 확인 이벤트 발생");
		// 우선적으로 모달창부터 활성화 시킨다. 
		$(".repair_modal_container").css("display", "block");
		$('body').css("overflow", "hidden");
		// 글번호르 던져서 해당 값을 가져온다 ajax를 통해
		var no = $(e.target).closest('tr').children().eq(1).text();
		console.log("이 라인의 글 번호 확인: " + no);
		// ajax를 호출한다 (json으로 데이터를 받아서 받아온 데이터를 화면에 노출시킨다. )
		$.ajax({  	
			url: "repairList.do",
			method: "GET",
			dataType: "JSON",
			contentType: "application/text; charset=utf-8",
			data : {
				rno : no
			},
			success: function(data){
				console.log("호출 성공");
				console.log(data);
				$(".rnoInput").val(data.rno);
				$(".model_rwdate").text(data.rwdate);
				// 완료일에 대한 데이터가 없는 경우 => 화면에 데이터 뿌리지 않기
				if( data.rfdate !== null ){  
					$(".model_rfdate").text(" / " + data.rfdate);
				};
				$('.model_m_emailInput').val(data.m_email);
				$('.model_rtitleInput').val(data.rtitle);
				$(".model_rcontentInput").val(data.rcontent);
				$(".model_rcategoryInput").val(data.rcategory);
				$(".model_rgradeInput").val(data.rgrade);
				$(".model_rstatusInput").val(data.rstatus);
			},
			error: function(){
				console.log("호출 실패");
			}
		})
	})
	
	
	//임시 스크림트 영역. 검색창이랑 등록하는 창 작업 끝나면 => 스크립트 하단으로 내리기
	$(".repairFormOpenBtn").on("click", function(){
		console.log("등록하는 폼 호출");
		$(".repairForm").css("display","block");
		$(".repairSearchOpenBtn").css("display", "block");
		$(".repairFormOpenBtn").css("display", "none");
		$('.repairSearch').css("display", "none")
	})
	
	// 다시 검색하는 폼 활성화 시키고, 등록하는 폼 숨기기
	$(".repairSearchOpenBtn").on("click", function(){
		console.log("검색하는 폼 호출");
		$(".repairForm").css("display","none");
		$(".repairSearchOpenBtn").css("display", "none");
		$(".repairFormOpenBtn").css("display", "block");
		$('.repairSearch').css("display", "block");
		$("#frm")[0].reset();
	})
	
	// 유지보수 사항을 등록하는 이벤트. (이때 등록자는 세션값의 이메일이다 )
	$(".repairFormBtn").on("click", function(){
		console.log("등록 버튼 클릭");
		var m_email = $(".adminPageHiddenInput").data('user');
		var rcategory = $(".rcategoryInput").val();
		var rtitle = $(".rtitleInput").val();
		var rcontent = $(".rcontentInput").val();
		var rstatus = $(".rstatusInput").val();
		var rgrade = $('.rgradeInput').val();
		if(rtitle === "" ){
			alert("제목은 필수입력 항목입니다.");
			return false;
		}
		var data = {
				m_email : m_email,
				rcategory : rcategory,
				rtitle : rtitle,
				rcontent : rcontent,
				rstatus : rstatus, 
				rgrade : rgrade 
		};
		console.log("데이터 조회!"); // view단에서 보내는 데이터는 6개. 나머지느 DB상에서 처리를 한다. 
		console.log(data);
		console.log(JSON.stringify(data));
			$.ajax({ 
			url: "repairList.do",
			type: "POST",
			dataType: "text",
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(data),
			success: function(message){
				console.log("호출 성공");
				alert(message);
				location.reload();
			},
			erorr: function(){
				console.log("호출 실패");
			}
		})
	})
	
	$(".rcontentLabel").on("click", function(){
		if($('.rcontentInput').is(":visible")){
			$(".rcontentInput").css("display", "none");
			$(".plusicon").css("display", "inline");
			$('.minusicon').css("display", "none");
		} else {
			$(".rcontentInput").css("display", "block");
			$(".plusicon").css("display", "none");
			$('.minusicon').css("display", "inline");
		}
	})
	
	// 체크박스 전체 선택
	$(".allCheckBtn").on("click", function(){
		if( $(".allCheckBtn").is(":checked")){
			$(".subCheckBtn").prop("checked", true);
		} else {
			$(".subCheckBtn").prop("checked", false);
		}
	})
	
	// 체크박스 부분 선택
	$(".subCheckBtn").on("click", function(){
		if( $(".allCheckBtn").is(":checked")){
			$(".allCheckBtn").prop("checked", false);
		}
	})
</script>
<script>
	$(document).on("ready", function(){
		// 유지보수 등록하는 폼에 현재 시각 추가  ( 보여지는 것과 실제 DB에 저장되는 데이터는 다름. )
		const now = new Date().toISOString().substring(0,10);
		$(".rWdate").text(now);
		
		// status값이 fixed(완료)인 경우 => 해당 게시글의 제목의 스타일을 바꾼다. 
		$(".subCheckBtn").each(function(){
			if( $(this).data('status') === 'FIXED'){
				var thisTr = $(this).closest('tr');
				thisTr.css("backgroundColor", "#FFE6E6");
				$(this).closest('tr').find('td').eq(4).css("color", "lightgray").css("text-decoration", "line-through");
			}
			if( $(this).data('rgrade') === 'A'){
				$(this).closest('tr').find('td').eq(2).css('font-size', 'large').css("color", "tomato").css('font-weight', '700');
			}
		})
		
		var firstTest = $("#hiddenInputTest").data('rtimeorder');
		var secondTest = $("#hiddenInputTest").data('timeorder');
		console.log("firstTest: " + firstTest + ",   secondTest: " + secondTest);
	})
</script>
</html>