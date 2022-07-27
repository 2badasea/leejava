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
.pagination1{
	margin-bottom: 20px;
	display: flex;
	justify-content: center;	
}
.pagination > li{
	list-style-type: none;
	float: left;
	padding: 5px;
}
</style>
<script>
	
</script>
</head>
<script>
	// 전체 HTML문서가 로드되자마자 항목들을 모두 초기화 시킨다. 
	$(document).ready(function(){
		// 검색창의 항목들 초기화 시킴
		$("#clearbtn").on("click", function() {
			 $("#n_title").val("");
			 $("#n_category").val("all"); // selecbox의 <option>태그의 value값 'all'로 세팅한다. 
			 $("#n_title").val("");
			 $("#n_content").val("");
		 });
	});
</script>
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
							<td style="width: 200px">
								<input type="text" id="n_title" name="searchTitle"></td>
							<th class="searchTh">내용</th>
							<td style="width: 400px">
								<input type="text" id="n_content" name="searchContent">
							</td>
						</tr>
						<tr>
							<th class="searchTh">카테고리</th>
							<td>
								<select id="n_category" name="searchCategory" >
									<option selected value="all">전체</option>
									<option value="emergency">긴급</option>
									<option value="event">이벤트</option>
								</select>
							</td>
							<th class="searchTh">작성자</th>
							<td>
								<input type="text" id="n_writer" name="searchWriter">
							</td>
						</tr>
					</table>
					<div class="noticeSearchBtns">
						<!-- 참고로 type reset이 먹히려면 button태그도 form안에 있어야 한다. submit과 마찬가지 -->
						<button type="reset" id="clearBtn">초기화</button>
						<button type="button" id="btnSearch">검색</button>
					</div>
				</div>
			</div>
			<br>
			<br>
			<hr>
			<br>
			<!--실질적인 공지사항 리스트들의 목록 -->
			<div class="noticeListWrapper">
				<h3>공지사항 리스트</h3>
				<c:choose>
					<c:when test="${pagination.listCnt lt pagination.end }">
						<span>(총 ${pagination.listCnt }건 중 ${pagination.start } ~ ${pagination.listCnt }건)</span>
					</c:when>
					<c:otherwise>
						<span>(총 ${pagination.listCnt }건 중 ${pagination.start } ~ ${pagination.end }건)</span>
					</c:otherwise>
				</c:choose>
				&nbsp;&nbsp;&nbsp;
				<select class="paging" name="searchType" id="listSize" onchange="page(1)">
					<option value="10" <c:if test="${pagination.getListSize() == 10 }">selected="selected"</c:if>>10건 보기</option>
					<option value="15" <c:if test="${pagination.getListSize() == 15 }">selected="selected"</c:if>>15건 보기</option>
					<option value="20" <c:if test="${pagination.getListSize() == 20 }">selected="selected"</c:if>>20건 보기</option>
				</select>
				
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
						<c:forEach items="${notice }" var="notice">
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
					<br><br>
					<!-- 페이징 박스가 들어갈 곳 -->
					<div id="paginationBox" class="pagination1">
						<ul class="pagination">
							<c:if test="${pagination.prev}">
								<li class="page-item"><a class="page-link" href="#"
									onClick="fn_prev('${pagination.page}', '${pagination.range}'
													, '${pagination.rangeSize}', '${pagination.listSize}'
													, '${search.n_title}', '${search.n_category}'
													, '${search.n_content}' , '${search.n_writer}')">
													이전</a>
								</li>
							</c:if>
							<c:forEach begin="${pagination.startPage}"
								end="${pagination.endPage}" var="NoticeNo">
								<li
									class="page-item <c:out value="${pagination.page == NoticeNo ? 'active' : ''}"/> ">
									<a class="page-link" href="#"
									onClick="fn_pagination('${NoticeNo}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.listSize}','${search.n_title}', '${search.n_category}', '${search.n_content}' , '${search.n_writer}')">
										${NoticeNo} </a>
								</li>
							</c:forEach>
							<c:if test="${pagination.next}">
								<li class="page-item"><a class="page-link" href="#"
									onClick="fn_next('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.listSize}' ,'${search.n_title}', '${search.n_category}', '${search.content}' , '${search.n_writer}')">다음</a></li>
							</c:if>
						</ul>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
<script> 
	// 페이징 function 구현. 난 기존의 3개에다가, 검색항목인 제목, 내용, 카테고리, 작성자르르 더 넣양 함. 
	function fn_prev(page, range, rangeSize, listSize, n_title, n_category, n_content, n_writer) {
			var page = ((range - 2) * rangeSize) + 1;
			var range = range - 1;
			var url = "adminNoticeList.do";
			url = url + "?page=" + page;
			url = url + "&range=" + range;
			url = url + "&listSize=" + listSize;
			url = url + "&n_title=" + n_title;
			url = url + "&n_category=" + n_category;
			url = url + "&n_content=" + n_content;
			url = url + "&n_writer=" + n_writer;
			location.href = url;
	}
	
	function fn_pagination(page, range, rangeSize, listSize, n_title, n_category, n_content, n_writer) {
		var url = "adminNoticeList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&listSize=" + listSize;
		url = url + "&n_title=" + n_title;
		url = url + "&n_category=" + n_category;
		url = url + "&n_content=" + n_content;
		url = url + "&n_writer=" + n_writer;
		location.href = url;
	}
	
	function fn_next(page, range, rangeSize, listSize, n_title, n_category, n_content, n_writer) {
		var page = parseInt((range * rangeSize)) + 1;
		var range = parseInt(range) + 1;
		var url = "adminNoticeList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&listSize=" + listSize;
		url = url + "&n_title=" + n_title;
		url = url + "&n_category=" + n_category;
		url = url + "&n_content=" + n_content;
		url = url + "&n_writer=" + n_writer;
		location.href = url;
	}
	
	function page(Paging) {
		var startPage = Paging;
		var listSize = $("#listSize option:selected").val();
		if (listSize == 10) {
			var url = "adminNoticeList.do?startPage=" + startPage
					+ "&listSize=" + listSize
		} else if (listSize == 15) {
			var url = "adminNoticeList.do?startPage=" + startPage
					+ "&listSize=" + listSize
		} else if (listSize == 20) {
			var url = "adminNoticeList.do?startPage=" + startPage
					+ "&listSize=" + listSize
		}
		location.href = url;
	}
	
	// 해당 구문은 동적으로 element가 생겼을 때 function을 사용할 수 있도록 해주는 구문이다. 
	$(document).on('click', '#btnSearch', function(e) {
		e.preventDefault();  
		var url = "adminNoticeList.do";
		url = url + "?n_title=" + $('#n_title').val();
		url = url + "&n_category=" + $('#n_category').val();
		url = url + "&n_content=" + $('#n_content').val();
		url = url + "&n_writer=" + $('#n_writer').val();
		alert("테스트 alert. 정상적으로 넘겨지는 url 값: " +  url);
		console.log("전달되는 값들 목록: " + $('#n_title').val() + ", " + $('#n_category').val() +  ", " + $('#n_content').val() + ", " + $('#n_writer').val());
		location.href = url;
	});
		
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
	$(document).ready(function(){
		if ( $(".subCheckBtn").val() === "T" ) {
			$("input[value='T']").parent().parent().css("backgroundColor", "#FFF0F5");		
		}
	})
	
</script>
</html>