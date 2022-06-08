<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
.mainSearchWrapper {
	margin-left: 10%;
	margin-top: 10%;
}

.searchTh {
	width: 100px;
	text-align: center;
}
.listTh {
	text-align: center;
}
tr > td {
	text-align: center;
}
.noticeListBtns { 
	display: flex;
	justify-content: flex-end;
	
}
.noticeListBtns > button { 
	margin-right: 10px;
	margin-bottom: 10px;
}
#noticeNumber {
	width: 50px;
	border: none;
	text-align: center;
	
}
.noticeListTitleTd:hover{
	cursor: pointer;
}
.noticeListTr:hover {
	background-color: #F0FFF0;
}
.noticeListTitleTd {
	text-overflow: ellipsis;
}
</style>
<script>
	
</script>
</head>
<body>
	<div class="wrapper">
		<div class="mainSearchWrapper">
			<h3>공지사항 관리</h3>
			<br>
			<!--검색 공간이 들어가야 하는 곳. ( 검색항목: 카테고리, 제목, 내용, 작성일자  )-->
			<div class="noticeSearchWrapper">
				<div class="noticeSearch">
					<table border="1">
						<tr>
							<th class="searchTh">제목</th>
							<td style="width: 200px"><input type="text" id="searchTitle"
								name="searchTitle"></td>
							<th class="searchTh">내용</th>
							<td style="width: 400px"><input type="text"
								id="searchContent" name="searchContent"></td>
						</tr>
						<tr>
							<th class="searchTh">카테고리</th>
							<td><select name="searchCategory" id="searchCategory">
									<option selected>전체</option>
									<option>긴급</option>
									<option>이벤트</option>
							</select></td>
							<th class="searchTh">작성일</th>
							<td><input type="month"> ~ <input type="month">
							</td>
						</tr>
					</table>
					<div class="noticeSearchBtns">
						<button>초기화</button>
						<button>검색</button>
					</div>
				</div>
			</div>
			<br>
			<br>
			<hr>
			<br>
			<!--실질적인 공지사항 리스트들의 목록 -->
			<div class="noticeListWrapper">
				<h4>공지사항 리스트</h4>
				<span>(총 4건 중 4건)</span> <br>
				<div class="noticeListBtns">
					<button id="noticeFormBtn">공지사항 작성</button>
					<button id="selectDeleteBtn">선택 삭제</button>
				</div>
				<div class="noticeList">
					<!--체크박스 공간,  글번호, 작성날짜, 카테고리, 제목, 상단 고정, 관리( 수정, 삭제, 고정or고정취소)  -->
					<table border="1">
						<tr>
							<th style="width: 50px;" class="listTh"><input type="checkbox" id="allCheckBtn"></th>
							<th style="width: 80px;" class="listTh">글번호</th>
							<th style="width: 100px;" class="listTh">작성일</th>
							<th style="width: 100px;" class="listTh">카테고리</th>
							<th style="width: 400px;" class="listTh">제목</th>
							<th style="width: 100px;" class="listTh">상단고정</th>
							<th style="width: 300px;" class="listTh">관리</th>
						</tr>
						<c:forEach items="${notices }" var="notice">
							<tr class="noticeListTr">
								<td>
									<input type="checkbox" class="subCheckBtn" data-value="${notice.n_no }" value="${notice.n_fixed }">
								</td>
								<td>
									<input name="n_no" id="noticeNumber" value='<c:out value="${notice.n_no }"/>' >
								</td>
								<td>
									${notice.n_wdate }
								</td>
								<td>
									${notice.n_category }
								</td>
								<td class="noticeListTitleTd">
									${notice.n_title }
								</td>
								<td>
									${notice.n_fixed }
								</td>
								<td>
									<input type="button" value="수정" onclick="location.href='noticeFormUpdate.do?n_no=${notice.n_no}'">
									<input type="button" value="삭제" onclick="noticeDeleteBtn(${notice.n_no})">
									<input type="button" value="고정" id="noticeFixedBtn" onclick="noticeFixed(${notice.n_no},'${notice.n_fixed }')">
								</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
<script>
	// 선택 삭제 구현
	$("#selectDeleteBtn").on("click", function(){
		var deleteCheck = confirm("정말 삭제하시겠습니까?");
		// 삭제할 대상들을 담을 배열 생성
		var checkedArray = [];
		if(deleteCheck){
			$(".subCheckBtn:checked").each(function(){
				// checked했던 것들을 모두 배열에 담아버린다.
				checkedArray.push($(this).attr("data-value")); 	
			})	
		}
		console.log("담은 것 개수체크: " + checkedArray.length);
		// ajax 처리를 한다.
		$.ajax({
			url: "ajaxNoticeSelectDelete.do",
			type: "POST",
			data: {
				checkedArray : checkedArray
			},
			success: function(message){
				if( message === "YES"){
					alert("Delete Success~!!");
					location.reload();
				}else {
					alert("요청사항 처리 중 에러 발생.");
				}
			}
		})
		
	})

	//****** 공지사항 개별 고정 처리( 글번호 값이랑 고정상태값을 가져온다. ) ******* 
	
 	//1차적으로 시도했던 방법인데, 고정값(F)을 매개변수로 받아오는 데 실패했다( F is not defined 어쩌구)	
// 	function noticeFixed(n_no, n_fixed){
// 		console.log("고정처리 할 글 번호: " + n_no);
// 		//var n_fixed = $(this).closest("tr").children("td").eq(5).html();
// 		console.log("고정처리 할 글의 고정상태: " + n_fixed);
// 	}
	// 2차적인 방법으로, 그냥 버튼을 클릭하면 이벤트를 발생시켜서 => 개별 요소들의 값을 일일이 가져와봄
// 	$("#noticeFixedBtn").on("click", function(){ 
// 		var tr = $(this).closest("tr");
// 		var td = tr.children();
// 		var n_no = td.eq(1).text();
// 		var n_fixed = td.eq(5).text();
// 		console.log("글번호 확인: " + n_no);
// 		console.log("고정상태 확인: " + n_fixed);
// 	})
	// 3차적으로 시도했던 방법. => 다시 한번 고정값 가져와보기( 못 가져오는 이유는 문자열의 경우 ""따옴표 처리되어야 함.)
	// 따옴표 처리가 없으면 식별자로 인식하기 때문에 그렇다 => 매개변수 상에서 ''따옴표로 묶어봄
	function noticeFixed(n_no, n_fixed){ 
		// 매개변수로 받는 값을 따옴표 처리 해서 받으니깐 문자열로 넘어왔다.
		console.log("글번호 확인: " + n_no + "고정상태 확인: " + n_fixed);
		// ajax로 처리해야 한다. => 현재 상태가 F면 T를 날려보내고, T면 F늘 날려 보내서 업데이트 시키기 
		if( n_fixed === "F"){
			n_fixed = "T"; 
		} else {
			n_fixed ="F";
		}
		console.log("바꾸려는 고정값 확인: " + n_fixed);
		// ajax로 처리한다(글번호, 고정상태값)
		$.ajax({
			url : "ajaxNoticeFixed.do",
			type: "POST",
			data: {
				n_no : n_no,
				n_fixed : n_fixed
			},
			success: function(message){
				if(message === "YES"){
					alert("처리되었습니다.");
					location.reload(); 
				}else {
					alert("요청 처리 중 에러");
				}
			}
		})
	}
	

	// 공지사항 개별 삭제 버튼 함수
	function noticeDeleteBtn(n_no){ 
		console.log("글번호 확인: " + n_no);
		var deleteCheck = confirm("게시글을 삭제하시겠습니까?");
		if(deleteCheck ){ 
			// ajax 방식으로 개별 게시글 삭제 
			$.ajax({
				type: "POST",
				url: "noticeDelete.do",
				data: {
					n_no : n_no
				},
				success: function(message){
					if( message === "YES"){ 
						alert("Delete Success");
						location.reload();
					} else {
						alert("Delete Fail");
					}
				}
			})
		} else {
			return false;
		}
	}
	
	// 전체선택 & 부분선택 구현하기. ( id = allCheckBtn , class = subCheckBtn )
	$("#allCheckBtn").on("click", function(){ 
		console.log("전체 버튼 클릭 확인");
		if( $("#allCheckBtn").is(":checked") ){ 
			$(".subCheckBtn").prop("checked", true);
		} else {
			$(".subCheckBtn").prop("checked", false);
		}
	})
	// 부분 체크 해제 시 전체 체크도 해제
	$(".subCheckBtn").on("click", function(){
		console.log("서브 버튼 클릭");
		// 서브 버튼 클릭 => 클릭했을 때, checked상태가 false라면 allcehck또 false로. 
		// 문제 해결=> .subCheckBtn이 한 개가 아니므로 this를 통해 이벤트를 호출시킨 객체를 지정했어야 한다.
		if( !$(this).is(":checked") ){
			$("#allCheckBtn").prop("checked", false);
		}
	})
	
	

	$("#noticeFormBtn").on("click", function(){
		var check = confirm("공지사항을 등록하시겠어요?");
		if(check){ 
			location.href="noticeRegisterForm.do";
		} else {
			return false;
		}
	});
	
	// tr값 글 조회하기
	$(".noticeListTitleTd").on("click", function(){ 
		var clickRow = $(this).closest('tr');
		var	no = clickRow.find('td:eq(1)').find('input').val();
		alert('내가 클릭한 행이 가리키는 글번호의 값: ' + no);
		// 처음으로 get방식으로 넘겨보자. ajax타지말고, 
		location.href='adminNoticeRead.do?n_no=' + no;
	});
</script>
<script>
	// data-fixed 
	$(document).ready(function(){
// 		alert( $(".subCheckBtn").attr("data-fixed") );
		
		if ( $(".subCheckBtn").val() === "T" ) {
			$("input[value='T']").parent().parent().css("backgroundColor", "#FFF0F5");		
		}
	})
	
</script>
</html>