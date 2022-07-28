<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
.mainSearchWrapper {
	margin-left: 15%;
	margin-top : 10%;
}
/*	공지사항 테이블 디자인 */
.noticeTable{
	margin-top: 2%;
	text-align: center;
	border-collapse: collapse;
	border: 1px solid #05AA6D; 
}
.noticeTableThTr{
	border-bottom: 1px solid #05AA6D;
}
.noticeTable th{
	font-size: 18px;
	height: 30px;
	border-left: 1px solid #05AA6D;
	padding: 5px;
	padding-left: 10px;
	padding-right: 10px;
	height: 30px;
	font-weight: 900;
}
.noticeTable td {
	border-bottom: 1px solid #05AA6D;
	height: 20px;
	border-left: 1px solid #05AA6D;
	padding: 5px;
}
.noticeTable a {
	color: #05AA6D;
	font-weight: bold;
}

/*	********************	*/
.noticeListTitleTd:hover{
	cursor: pointer;
}
.noticeListTr:hover {
	background-color: #F0FFF0;
}
.categorySearchSelect{
    display: none;
}
.noticeSearchWrapper{
	margin-top: 50px;
	display: flex;
	justify-content: center;
}
.searchInputBox{
	min-width: 200px;
	width: auto;
}
.noticeSearchBtn{
	min-width: 100px;
	height: auto;
	background-color: #05AA6D;
	color: white;
	padding: 5px;
	font-weight: 900;
}
.noticeSearchBtn:hover{
	cursor: pointer;
	background-color: whitesmoke;
	color: #05AA6D;
	transition: 1s;
}
.noticeSearchWrapper select{
	min-width: 100px;
}
.noticeSearchSelect,
.searchInputBox,
.categorySearchSelect,
.noticeSearchBtn {
	min-height: 30px;
}
/* 페이징 박스 디자인 */
.paginationUl > li{
	list-style-type: none;
	float: left;
	padding: 5px;
}

.paginationLink {
	color: teal;
	font-size: 20px;
}
.paginationBox{
	margin-bottom: 20px;
	display: flex;
	justify-content: center;
}
.active a{
	font-weight: bolder;
	color: tomato;
	font-size: large;
} 
</style>
</head>
<body>
	<div class="memberNoticeList_wrapper">
		<div class="mainSearchWrapper">
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
					<option value="10" <c:if test="${pagination.getListSize() == 10 }">selected="selected"</c:if> >10건 보기</option>
					<option value="15" <c:if test="${pagination.getListSize() == 15 }">selected="selected"</c:if> >15건 보기</option>
					<option value="20" <c:if test="${pagination.getListSize() == 20 }">selected="selected"</c:if> >20건 보기</option>
				</select>
				
				<div class="noticeList">
					<!--체크박스 공간,  글번호, 작성날짜, 카테고리, 제목, 상단 고정, 관리( 수정, 삭제, 고정or고정취소)  -->
					<table class="noticeTable">
						<tr class="noticeTableThTr">
							<th style="width: auto;" class="listTh">글번호</th>
							<th style="width: 150px;" class="listTh">카테고리</th>
							<th style="width: 400px;" class="listTh">제목</th>
							<th style="width: 100px;" class="listTh">작성일</th>
							<th style="width: 100px;" class="listTh">작성자</th>
							<th style="width: auto;" class="listTh">조회수</th>
						</tr>
						<c:forEach items="${notice }" var="notice">
							<tr class="noticeListTr">
								<td>${notice.n_no }
									<input class="noticeFixedTd" type="hidden" value="${notice.n_fixed }">
								</td>
								<!-- 카테고리의 값에 따라서 알아서 한글로 번역하게 해준다. c:choose 사용. ${notice.n_category }  -->
								<td>
									<c:choose>
										<c:when test="${notice.n_category eq 'all'}">
											전체
										</c:when>
										<c:when test="${notice.n_category eq 'emergency'}">
											긴급
										</c:when>
										<c:when test="${notice.n_category eq 'event'}">
											이벤트
										</c:when>
										<c:otherwise>
											전체
										</c:otherwise>
									</c:choose>
								</td>
								<td class="noticeListTitleTd" onclick="memberNoticeRead(${notice.n_no}, ${notice.n_hit })">${notice.n_title }</td>
								<td>${notice.n_wdate }</td>
								<td>${notice.n_writer }</td>
								<td>${notice.n_hit }</td>
							</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			<!-- paging 박스가 들어갈 곳  -->
			<div id="paginationBox" class="paginationBox">
				<ul class="paginationUl">
					<c:if test="${pagination.prev }">
						<li class="paginationLi">
							<a class="paginationLink specialA" onclick="fn_prev('${pagination.page}', '${pagination.range }',
																		'${pagination.rangeSize }','${pagination.listSize }',
																		'${search.n_title }', '${search.n_category }',
																		'${search.n_content }', ${search.n_writer }')">이전</a>
						</li>
					</c:if>
					<c:forEach begin="${pagination.startPage }" end="${pagination.endPage }" var="noticeNo">
						<li class="paginationLi <c:out value="${pagination.page == noticeNo ? 'active' : '' }" />" >
							<a class="paginationLink specialA" onclick="fn_pagination('${noticeNo}', '${pagination.range }',
																			'${pagination.rangeSize }', '${pagination.listSize }',
																			'${search.n_title }', '${search.n_category }',
																			'${search.n_content }', '${search.n_writer }')">${noticeNo }</a>
						</li> 
					</c:forEach>
					<c:if test="${pagination.next }">
						<li class="paginationLi">
							<a class="paginationLink specialA" onclick="fn_next('${pagination.page}', '${pagination.range }',
																		'${pagination.rangeSize }', '${pagination.listSize }',
																		'${search.n_title }', '${search.n_category }',
																		'${search.n_content }', '${search.n_writer }')">다음</a>
						</li>
					</c:if>
				</ul>
			</div>
			<div class="noticeSearchWrapper" align="center">
				<select id="noticeSearchSelect" class="noticeSearchSelect" onchange="fn_selectBox()">
		            <option value="category">카테고리</option>
		            <option value="title">제목</option>
		            <option value="content">내용</option>
		            <option value="writer">작성자</option>
		            <option value="titleAndContent" selected>제목 + 내용</option>
		        </select>
       			<input type="text" class="searchInputBox">
		        <select class="categorySearchSelect" id="categorySearchSelect">
		            <option value="all" selected>전체</option>
		            <option value="emergency">긴급</option>
		            <option value="event">이벤트</option>
		        </select>
      			<button class="noticeSearchBtn">검색</button>
			</div>
			<br><br>
		</div>
	</div>
</body>
<script>
	
	// 페이징 function  "이전" 구현.
	function fn_prev(page, range, rangeSize, listSize, n_title, n_category, n_content, n_writer){
		var page = ( (range - 2) * rangeSize) + 1;
		var range = range - 1;
		var url = "memberNoticeList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&listSize=" + listSize;
		url = url + "&n_title=" + n_title;
		url = url + "&n_category=" + n_category;
		url = url + "&n_content=" + n_content;
		url = url + "&n_writer=" + n_writer;
		location.href = url;
	}
	
	// 페이징 function 구현. 실질적인 페이지 넘버링
	function fn_pagination(page, range, rangeSize, listSize, n_title, n_category, n_content, n_writer){
		var url = "memberNoticeList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&listSize=" + listSize;
		url = url + "&n_title=" + n_title;
		url = url + "&n_category=" + n_category;
		url = url + "&n_content=" + n_content;
		url = url + "&n_writer=" + n_writer;
		location.href= url;
	}
	
	// 페이징 function구현. "다음" 버튼 클릭 이벤트 정의
	function fn_next(page, range, rangeSize, listSize, n_title, n_category, n_content, n_writer){
		var page = parseInt((range * rangeSize)) + 1;
		var range = parseInt(range) + 1;
		var url = "memberNoticeList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;
		url = url + "&listSize=" + listSize;
		url = url + "&n_title=" + n_title;
		url = url + "&n_category=" + n_category;
		url = url + "&n_content=" + n_content;
		url = url + "&n_writer=" + n_writer;
		location.href = url; 
	}

	// 게시글 출력 갯수 이벤트 정의
	function page(Paging){
		var startPage = Paging;
		var listSize =  $("#listSize option:selected").val();
		if(listSize == 10){
			var url = "memberNoticeList.do?startPage=" + startPage + "&listSize=" + listSize;
		} else if(listSize == 15){
			var url = "memberNoticeList.do?startPage=" + startPage + "&listSize=" + listSize;
		} else if(listSize == 20){
			var url = "memberNoticeList.do?startPage=" + startPage + "&listSize=" + listSize;
		}
		location.href = url;
	}

	// 글제목 클릭 시 공지사항 조회할 수 있도록 하기
	function memberNoticeRead(no, hit) {
		console.log("글번호 확인: " + no);
		console.log("조회수 확인: " + hit);
		location.href='memberNoticeRead.do?n_no=' + no + '&n_hit='+hit;
	}	
	
	
	 // selexbox에서 항목을 선택해서 변경이 있을 때마다 이벤트가 실행된다.
    function fn_selectBox(){
        console.log("이벤트 발생");
        var searchMenu = $(".noticeSearchSelect option:selected").val();
        // 고민해야 되는 점 =>  창을 비활성화 시킨다
        // 올 수 있는 값들 목록 => category, title, content, titleAndContent
        $(".searchInputBox").val('');
        if( searchMenu === "category"){ 
            console.log("카테고리 선택");
            $('.categorySearchSelect').css('display', 'block');
            $(".searchInputBox").css("display", "none");
        } else {
             $('.categorySearchSelect').css('display', 'none');
              $(".searchInputBox").css("display", "block");
        }

        if( searchMenu === "title"){
            $('.searchInputBox').attr("placeholder", "제목을 입력하세요.");
        }else if (searchMenu === "content" ){
            $(".searchInputBox").attr("placeholder","내용을 입력하세요");
        }else if (searchMenu === "titleAndContent"){
            $('.searchInputBox').attr("placeholder", "제목 또는 내용을 입력하세요");
        }else if ( searchMenu === "writer"){
         	$('.searchInputBox').attr("placeholder", "작성자의 닉네임을 입력하세요");
        }
    }
	 
	// 검색 버튼  ( 추후에 엔터키로도 검색이 작동하도록 수정하기 )
    $(".noticeSearchBtn").on("click", function(){
        console.log("검색 버튼 클릭 확인");
        // 각 파라미터의 값을 가져온다. 
        var category = ''; 
        var title = ''; 
        var content = ''; 
       	var writer = '';
        var select = $(".noticeSearchSelect option:selected").val();
        if(select == "category"){
            category = $('.categorySearchSelect option:selected').val();
        } else if(select == "title"){
            title = $(".searchInputBox").val();
        } else if (select == "content"){
            content = $(".searchInputBox").val();
        } else if (select == "writer"){
        	  content = $(".searchInputBox").val();
	    } else if (select == "titleAndContent"){
	          title = $(".searchInputBox").val();
	          content = $(".searchInputBox").val();
        } 
        var url = "memberNoticeList.do";
        url = url + "?n_category=" + category;
        url = url + "&n_title=" + title;
        url = url + "&n_content=" + content;
        url = url + "&n_writer=" + writer;
        location.href = url;  	
    })
    
    // enterkey로 검색버튼 작동시키기 => OK
	$('.searchInputBox, .categorySearchSelect, .noticeSearchSelect').on('keypress', function(e) {
		if (e.keyCode == '13') {
			$('.noticeSearchBtn').click();
		}
	});
	
</script>
<script>
	$(document).ready(function(){
		// 고정값이 T인 것은 문서가 로드되자마자 해당 tr행이 색깔을 다르게 표기한다.
		if( $('.noticeFixedTd').val() === "T"){
			$("input[value='T']").parent().parent().css('background',
			'#F0FFF0');
		}
		
		// 공지사항 리스트가 로드되자마자 해당 속성의 값이 생기도록
		if( $('.noticeSearchSelect option:selected').val() === "titleAndContent"){
             $(".searchInputBox").attr("placeholder", "제목 또는 내용을 입력하세요");
        }
		
		// 그리고 공지사항의 카테고리값도 영어가 아닌 한글로 출력할 수 있도록 할 것.
	})
</script>
</html>