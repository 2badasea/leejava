<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>목적을 알 수 없는 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
</head>
<body>
<div class="wrapper">
	<div class="boardWrapper">
        <table border="1">
            <tr>
                <th>글번호</th>
                <th>카테고리</th>
                <th>제목</th>
                <th>내용</th>
                <th>작성일</th>
                <th>작성자</th>
                <th>조회수</th>
                <th>좋아요수</th>
            </tr>
            <c:forEach items="${boardList }" var="board">
            <tr>
            	<td>${board.b_no }</td>
            	<td>${board.b_category }</td>
            	<td>${board.b_title }</td>
            	<td>${board.b_content }</td>
            	<td>${board.b_wdate }</td>
            	<td>${board.b_writer }</td>
            	<td>${board.b_hit }</td>
            	<td>${board.b_like }</td>
            </tr>
            </c:forEach>
        </table>
    </div>

	<!-- pagination{s} -->
	<div id="paginationBox">
		<ul class="pagination">
			<c:if test="${pagination.prev}">
				<li class="page-item"><a class="page-link" href="#"
					onClick="fn_prev('${pagination.page}', '${pagination.range}', '${pagination.rangeSize}')">Previous</a></li>
			</c:if>
			<c:forEach begin="${pagination.startPage}"
				end="${pagination.endPage}" var="idx">
				<li
					class="page-item <c:out value="${pagination.page == idx ? 'active' : ''}"/> "><a
					class="page-link" href="#"
					onClick="fn_pagination('${idx}', '${pagination.range}', '${pagination.rangeSize}')">
						${idx} </a></li>
			</c:forEach>
			<c:if test="${pagination.next}">
				<li class="page-item">
					<a class="page-link" href="#" onClick="fn_next('${pagination.range}', '${pagination.range}', '${pagination.rangeSize}')" >
					Next
					</a>
				</li>
			</c:if>
		</ul>
	</div>
	<!-- pagination{e} -->

</div>
</body>
<script>
	// 이전 버튼 이벤트
	function fn_prev(page, range, rangeSize) {
		var page = ((range - 2) * rangeSize) + 1;
		var range = range - 1;

		var url = "boardList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;

		location.href = url;
	}

	// 페이지 번호 클릭
	function fn_pagination(page, range, rangeSize, searchType, keyword) {
		var url = "boardList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;

		location.href = url;
	}

	// 다음 버튼 이벤트
	function fn_next(page, range, rangeSize) {
		var page = parseInt((range * rangeSize)) + 1;
		var range = parseInt(range) + 1;

		var url = "boardList.do";
		url = url + "?page=" + page;
		url = url + "&range=" + range;

		location.href = url;
	}
</script>
</html>