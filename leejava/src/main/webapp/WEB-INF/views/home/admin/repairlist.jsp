<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>페이지 유지보수 리스트 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
/* ********** 공통 ***************/
.repairList_wrapper textarea{
	resize: vertical;
	border-radius: 20px;
	padding: 15px;
	font-weight: 800;
	font-size: large;
	width: 95%;
}
.repairList_wrapper label{
	font-weight: 900;
	margin-left: 15px;
}

.repairSearchWrapper{
	margin-top: 3%;
}
.repairListDiv,
.repairSearch{
	padding-right: 15%;
}
.repairSearchWrapper button{
	border-radius: 20px;
	border-style: none;
	padding: 5px;
	width: auto;
	height: auto;
	color: whitesmoke;
	background-color: #313348;
	font-weight: 900;
}
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
	margin-top: 20px;
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
	background-color: lightgray;
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
.repairSearch{
	margin-left: 20%;
}
/*	유지보수 작성 폼 디자인 */
.repairForm{
	margin-left: 20%;
	border: 0.5px solid #313348;
	border-radius: 20px;
	width: 40%;
	min-height: 200px;
	height: auto;
	padding: 10px;
 	display: none;   
}
.repairSearchOpenBtn{
	display: none;
}
.repairForm input{
	border-style: none;
}
.repairForm span{
		
}
.repairForm input:focus {
	outline-color: #313348;	
}
</style>
</head>
<body>
<div class="repairList_wrapper">
    <!-- 검색요소 중에 입력해야 할 요소가 있나>? 카테고리(selectbox), 제목 내용, 진행상태, 기간? -->
   <div class="repairSearchWrapper">	
   		<div class="repairForm&SearchBtns">
	   		<button class="repairFormOpenBtn">유지보수 사항 추가</button>
	   		<button class="repairSearchOpenBtn">유지보수 리스트 검색</button>
   		</div>
   		<!-- 유지보수 입력창을 호출하는 폼을 호출한다. --> 
   		<form id="frm">
   		<div class="repairForm">
	            <div class="repairFormHeader">
	                <!--들어가는 요소 글번호, 중요도, 카테고리, 우선순위   -->
	                <label for="repairNo">No</label>
	                <input type="text" id="repairNo" class="rnoInput" value="">
	                <br>
	                <label for="rCategory">분류</label>
	                <select id="rCategory" class="rCategoryInput">
	                    <option value="ALL" selected>선택</option>
	                    <option value="ADMIN" >관리자</option>
	                    <option value="QUiZCARD">퀴즈카드</option>
	                    <option value="USER">사용자</option>
	                </select>
	                <label for="rGrade">중요도</label>
	                <select id="rGrade" class="rGradeInput">
	                    <option value="ALL" selected>분류</option>
	                    <option value="A">상</option>
	                    <option value="B">중</option>
	                    <option value="C">하</option>
	                </select>
	                <label id="rStatus">진행상황</label>
	                <select id="rStatus" class="rStatusInput">
	                    <option value="ALL" selected>시작전</option>
	                    <option value="FIXING">진행중</option>
	                    <option value="FIXED">완료</option>
	                </select>
	                <label for="m_email">작성자</label>
	                <input type="text" id="m_email" class="m_emailInput" value="" readonly="readonly">
	            </div>
	            <div class="repairFormTitle" >
	                <label for="rTitle">제목</label>
	                <input type="text" id="rTitle" class="rTitleInput" placeholder="제목을 입력해주세요" maxlength="20" style="min-width: 150px;">
	                <div class="addInfo" style="display: inline;">
	                    <label for="repairDate">작성일/완료일</label>   
	                    <span class="rWdate" ></span>
	                    <span class="rFdate">/ - </span>
	                </div>
	            </div>
	            <div class="repairFormContent">
	                <label for="repairContent">상세 내용</label>
	                <br>
	                <textarea name="" id="repairContent" class="rContentInput" cols="30" rows="4"></textarea>
	            </div>
	        <div class="repairFormBtns">
	            <button type="button" class="repairFormBtn">Enroll</button>
	            <button type="button" class="repairFormCloseBtn">Close</button>
	        </div>
   		</div>
   		</form>
   		<script>
   			// 유지보수 사항을 등록하는 이벤트. (이때 등록자는 세션값의 이메일이다 )
   			$(".repairFormBtn").on("click", function(){
   				console.log("등록 버튼 클릭");
   				var m_email = $(".adminPageHiddenInput").data('user');
   				var rCategory = $(".rCategoryInput").val();
   				var rTitle = $(".rTitleInput").val();
   				var rContent = $(".rContentInput").val();
   				var rStatus = $(".rStatusInput").val();
   				var rGrade = $('.rGradeInput').val();
   				if(rTitle === "" || rContent === ""){
   					alert("제목 또는 내용은 반드시 입력하셔야 합니다.");
   					return false;
   				}
   				var data = {
   						m_email : m_email,
   						rcategory : rCategory,
   						rtitle : rTitle,
   						rcontent : rContent,
   						rstatus : rStatus, 
   						rgrade : rGrade 
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
   						console.log(message);
   					},
   					erorr: function(){
   						console.log("호출 실패");
   					}
   				})
   			})
   		</script>
   		
   		
   
   		<div class="repairSearch">
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
	       <div class="repairSearchBtns">
	           <button type="button" class="clearBtn">초기화</button>
	           <button type="button" class="repairSearchBtn">검색</button>
	       </div>
       </div>
		<br>
		<br>
		<hr>
		<br>
  		<!-- 유지보수 리스트 -->
	   <div class="repairListDiv" align="center">
	    <!--한 페이지에 몇 개의 rowdate를 출력시킬지에 대한 구성요소-->
	    
	    <!--버튼이 들어가는  공간-->
	        <table class="repairListTable">
	            <tr class="repairListTableThTr">
	                <th class="listTh">
	                    <input type="checkbox" class="allCheckBtn">
	                </th>
	                <th class="listTh">No.</th>
	                <th class="listTh">중요도</th>
	                <th class="listTh">카테고리</th>
	                <th class="listTh">제목</th>
	                <th class="listTh">진행상황</th>
	                <th class="listTh">작성일/완료일</th>
	            </tr> 
<%-- 	            <c:forEach items="" var=""> --%>
	            	<tr class="repairListTr">
		                <td><input type="checkbox" class="subCheckBtn" data-value="${repair.rno}"></td>
		                <td>${repair.rno}</td>
		                <td>${repair.rGrade}</td>
		                <td>${repair.rCategory}</td>
		                <td>${repair.rTitle}</td>
		                <td>${repair.rStatus}</td>
		                <td>${repair.rWdate} // ${repair.rFdate}</td>
		            </tr>
<%-- 		        </c:forEach> --%>
	        </table>
		
		</div>
   </div>
</div>
</body>
<script>
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
</script>
<script>
	$(document).on("ready", function(){
		// 유지보수 등록하는 폼에 현재 시각 추가  ( 보여지는 것과 실제 DB에 저장되는 데이터는 다름. )
		const now = new Date().toISOString().substring(0,10);
		$(".rWdate").text(now);
		
	})
</script>
</html>