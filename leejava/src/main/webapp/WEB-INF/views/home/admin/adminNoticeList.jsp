<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 관리 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style>
.mainSearchWrapper {
	margin-left: 300px;
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
			<br>

			<!--실질적인 공지사항 리스트들의 목록 -->
			<div class="noticeListWrapper">
				<h4>공지사항 리스트</h4>
				<span>(총 4건 중 4건)</span> <br>
				<div class="noticeListBtns">
					<button id="noticeFormBtn">공지사항 작성</button>
					<button>선택 삭제</button>
				</div>
				<div class="noticeList">
					<!--체크박스 공간,  글번호, 작성날짜, 카테고리, 제목, 상단 고정, 관리( 수정, 삭제, 고정or고정취소)  -->
					<table border="1">
						<tr>
							<th style="width: 50px;" class="listTh"><input type="checkbox"></th>
							<th style="width: 80px;" class="listTh">글번호</th>
							<th style="width: 100px;" class="listTh">작성일</th>
							<th style="width: 100px;" class="listTh">카테고리</th>
							<th style="width: 400px;" class="listTh">제목</th>
							<th style="width: 100px;" class="listTh">상단고정</th>
							<th style="width: 300px;" class="listTh">관리</th>
						</tr>
						<c:forEach items="${notices }" var="notice">
							<tr>
								<td>
									<input type="checkbox">
								</td>
								<td>
									${notice.n_no }
								</td>
								<td>
									${notice.n_wdate }
								</td>
								<td>
									${notice.n_category }
								</td>
								<td>
									${notice.n_title }
								</td>
								<td>
									${notice.n_fixed }
								</td>
								<td>
									<input type="button" value="수정">
									<input type="button" value="삭제">
									<input type="button" value="고정">
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
	$("#noticeFormBtn").on("click", function(){
		var check = confirm("공지사항을 등록하시겠어요?");
		if(check){ 
			location.href="noticeRegisterForm.do";
		} else {
			return false;
		}
	});
</script>
</html>