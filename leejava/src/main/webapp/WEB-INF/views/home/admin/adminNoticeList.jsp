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
.noticeListBtns button { 
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
input[type="checkbox"]{
	width: 15px;
	height: 15px;
}			
/* 공지사항 검색 테이블 디자인 */
.noticeSearchTable{
	margin-top: 2%;
	text-align: center;
	border-collapse: collapse;
	border: 1px solid #05AA6D; 
}
.noticeSearchTable tr{
	border-bottom: 1px solid #05AA6D;
}
.noticeSearchTable th{
	font-size: 18px;
	height: 30px;
	border-left: 1px solid #05AA6D;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
	font-weight: 900;
}
.noticeSearchTable td{
	border-bottom: 1px solid #05AA6D;
	height: 20px;
	border-left: 1px solid #05AA6D;
	padding: 5px;
}
#n_category,
.noticeSearchTable input{
	width: 100%;
	height: 100%;
	font-size: 100%;	
	border-style: none;
	text-align: center;
}
#n_category,
.noticeSearchTable input{
	border-bottom: 0.5px dashed #05AA6D;
}	
/*	***********************  */ 
/* 공지사항 리스트 테이블 디자인*/
.noticeListTable{
	margin-top: 2%;
	text-align: center;
	border-collapse: collapse;
	border: 1px solid #05AA6D; 
}
.noticeListTableThTr{
	border-bottom: 1px solid #05AA6D;
}
.noticeListTable th{
	font-size: 18px;
	height: 30px;
	border-left: 1px solid #05AA6D;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
	font-weight: 900;
}
.noticeListTable td{
	border-bottom: 1px solid #05AA6D;
	height: 20px;
	border-left: 1px solid #05AA6D;
	padding: 5px;
}
.noticeListTable a{
	color: #05AA6D;
	font-weight: bold;
}
.active a{
	font-weight: bolder;
	color: tomato;
	font-size: large;
}

/*	***********************  */ 
.mainSearchWrapper button{
	border-radius: 20px;
	border-style: none;
	padding: 5px;
	width: auto;
	height: auto;
	color: 	#05AA6D;
	background-color: whitesmoke;
	font-weight: 900;
}
.mainSearchWrapper button:hover {
	cursor: pointer;
	background-color: #05AA6D;
	color: whitesmoke;
	transition: 0.5s;
}
.noticeSearchBtns{
	margin-top: 20px;
}
.noticeListBtns button,
.noticeSearch button{
	min-width: 100px;
	min-height: 40px;
}
</style>
<script>
	
</script>
</head>
<script>
	// 전체 HTML문서가 로드되자마자 항목들을 모두 초기화 시킨다. 
	$(document).ready(function(){
		// 검색창의 항목들 초기화 시킴
		$(".clearbtn").on("click", function() {
			 $("#n_title").val("");
			 $("#n_category").val("all"); // selecbox의 <option>태그의 value값 'all'로 세팅한다. 
			 $("#n_title").val("");
			 $("#n_content").val("");
		 });
	});
</script>
<body>
	<div class="adminNoticeList_wrapper">
		<div class="mainSearchWrapper">
			<h3>공지사항 관리</h3>
			<br>
			<!--검색 공간이 들어가야 하는 곳. ( 검색항목: 카테고리, 제목, 내용, 작성일자  )-->
				<div class="noticeSearch" align="center">
					<table class="noticeSearchTable">
						<tr>
							<th class="searchTh">제목</th>
							<td style="width: 200px">
								<input type="text" id="n_title" class="searchInput" placeholder="제목을 입력해주세요."></td>
							<th class="searchTh">내용</th>
							<td style="width: 400px">
								<input type="text" id="n_content" class="searchInput" placeholder="내용을 입력해주세요.">
							</td>
						</tr>
						<tr>
							<th class="searchTh">카테고리</th>
							<td>
								<select id="n_category" class="searchInput" >
									<option selected value="all">전체</option>
									<option value="emergency">긴급</option>
									<option value="event">이벤트</option>
								</select>
							</td>
							<th class="searchTh">작성자</th>
							<td>
								<input type="text" id="n_writer" class="searchInput" placeholder="작성자를 입력해주세요.">
							</td>
						</tr>
					</table>
					<div class="noticeSearchBtns">
						<!-- 참고로 type reset이 먹히려면 button태그도 form안에 있어야 한다. submit과 마찬가지 -->
						<button type="button" class="clearBtn">초기화</button>
						<button type="button" class="btnSearch">검색</button>
					</div>
				</div>
			<br>
			<br>
			<hr>
			<br>
			<!---------------실질적인 공지사항 리스트들의 목록 --------------------->
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
					<button type="button" class="noticeFormBtn">공지사항 작성</button>
					<button type="button" class="selectDeleteBtn">선택 삭제</button>
				</div>
				<div class="noticeList">
					<!--체크박스 공간,  글번호, 작성날짜, 카테고리, 제목, 상단 고정, 관리( 수정, 삭제, 고정or고정취소)  -->
					<table class="noticeListTable">
						<tr class="noticeListTableThTr">
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
								<td>${notice.n_no }</td>
								<td>
									${notice.n_wdate }
								</td>
								<td> <!--  ${notice.n_category }  value값이랑 별개로 jstl를 사용해서 각 value값에 대한 한글로 출력시키기 -->
									<c:choose>
										<c:when test="${notice.n_category eq 'all' }">
											전체
										</c:when>
										<c:when test="${notice.n_category eq 'emergency' }">
											긴급
										</c:when>
										<c:when test="${notice.n_category eq 'event' }">
											이벤트
										</c:when>
										<c:otherwise>
											전체
										</c:otherwise>
									</c:choose>
									
								</td>
								<td class="noticeListTitleTd">
									${notice.n_title }
								</td>
								<td>
									${notice.n_fixed }
								</td>
								<td>
									<button type="button" onclick="fn_noticeUpdate(${notice.n_no})">수정</button>
									<button type="button" onclick="noticeDeleteBtn(${notice.n_no})">삭제</button>
									<button type="button" onclick="noticeFixed(${notice.n_no},'${notice.n_fixed }')">고정</button>
								</td>
							</tr>
						</c:forEach>
					</table>
					<br><br>
					<!-- 페이징 박스가 들어갈 곳 -->
					<div id="paginationBox" class="pagination1">
						<ul class="pagination">
							<c:if test="${pagination.prev}">
								<li class="page-item"><a class="page-link specialA" href="#"
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
									<a class="page-link specialA" href="#"
									onClick="fn_pagination('${NoticeNo}', '${pagination.range}', '${pagination.rangeSize}', '${pagination.listSize}','${search.n_title}', '${search.n_category}', '${search.n_content}' , '${search.n_writer}')">
										${NoticeNo} </a>
								</li>
							</c:forEach>
							<c:if test="${pagination.next}">
								<li class="page-item"><a class="page-link specialA" href="#"
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
	$(document).on('click', '.btnSearch', function(e) {
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
	$(".selectDeleteBtn").on("click", function(){
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
			// ajax로 처리해야 한다. => 현재 상태가 F면 T를 날려보내고, T면 F늘 날려 보내서 업데이트 시키기 
			var message; 
			if( n_fixed === "F"){
				n_fixed = "T"; 
				message = "상단에 고정처리하시겠습니까?";
			} else {
				n_fixed ="F";
				message = "고정처리를 해제하시겠습니까?";
			}
			var check = confirm(message);
			if(check){
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
					}, 
					error: function(){
						alert("요청 처리 중 에러");
					}
				})
			} else {
				return false;
			}
	} // 상단고정 처리 이벤트 정의 끝. 
	
	// 공지사항 개별 수정 버튼 이벤트 정의
	function fn_noticeUpdate(n_no){
		var check = confirm("해당 게시글을 수정하시겠습니까?");
		if(check){
			location.href= "noticeFormUpdate.do?n_no=" + n_no;
		} else {
			return false;
		}
	}

	// 공지사항 개별 삭제 버튼 이벤트 정의
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

	$(".noticeFormBtn").on("click", function(){
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
		var	no = clickRow.find('td').eq(1).text();
		location.href='adminNoticeRead.do?n_no=' + no;
	});
	
	// 검색창 초기화 구현하기
	$(".clearBtn").on("click", function(){
		console.log("input창들에 대해 초기화를 시작하겠슴");
		 $("#n_title").val("");
		 $("#n_category").val("all"); // selecbox의 <option>태그의 value값 'all'로 세팅한다. 
		 $("#n_title").val("");
		 $("#n_content").val("");
	})
	
	// 검색 input창에 focus를 주면 border-bottom의 색깔을 변경시켜버리기  ( class="searchInput")  border-bottom: 1px solid #05AA6D;
	$(".searchInput").on({
		focus : function(e){
			$(e.target).css("outline-color", "tomato");
		}, 
		blur : function(e){
			$(e.target).css("outline-color", "whitesmoke")
		}
	})
</script>
<script>
	$(document).ready(function(){
		if ( $(".subCheckBtn").val() === "T" ) {
			$("input[value='T']").parent().parent().css("backgroundColor", "#F0FFF0");		
		}
	})
	// con
</script>
</html>