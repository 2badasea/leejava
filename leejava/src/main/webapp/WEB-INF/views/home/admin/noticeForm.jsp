<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>공지사항 작성 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>

<!-- summernote 사용 -->
<!-- include libraries(jQuery, bootstrap) -->
<script src="https://code.jquery.com/jquery-3.5.1.min.js"></script>
<link href="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" rel="stylesheet">
<script src="https://stackpath.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
<!-- include summernote css/js -->
<link href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote.min.js"></script>
<style>
tr > th {
	text-align: center;
}
.mainFormWrapper{
	margin-left: 400px;
	margin-top: 100px;
}
input {
	width: 100%;
}
select {
	width: 100%;
}
</style>
</head>

<body>
	<div class="wrapper">
		<div class="mainFormWrapper">
			<h3>공지사항 등록</h3>
			<!-- 공지사항 항목 구성( 카테고리, 제목, 내용, 첨부파일 -->
			<table border="1">
				<tr>
					<th style="width: 150px;">제목</th>
					<td style="width: 500px;">
						<input type="text" name="n_title">
					</td>
					<th style="width: 200px;">카테고리</th>
					<td style="width: 200px">
						<select name="n_category">
							<option selected="selected">전체</option>
							<option>긴급</option>
							<option>이벤트</option>
						</select>
					</td>
				</tr>
				<tr>
					<th>내용</th>
					<td colspan="3">
						<textarea rows="" cols="" name="n_content" id="summernote"></textarea>
					</td>
				</tr>
				<tr>
					<th>첨부파일</th>
					<td colspan="3">
						<input type="file" name="n_file" id="n_file">
					</td>
				</tr>
			</table>
			<div class="noticeRegisterBtns">
				<button id="noticeRegisterBtn">공지사항 등록</button>
				<button id="goBackBtn">돌아가기</button>
			</div>
		</div>
	</div>	
</body>
<script>
	// 문서가 로드되면 서머노트 적용시키도록 
	$(document).ready(function() {
	  	$('#summernote').summernote({
	  		placeholder: 'content',
	        minHeight: 370,
	        maxHeight: null,
	        focus: true, 
	        lang : 'ko-KR'
	  	});
	});
	
	
</script>
</html>