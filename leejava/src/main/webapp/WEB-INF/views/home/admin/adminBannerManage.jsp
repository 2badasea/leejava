<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>관리자 배너 관리 페이지.</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="https://kit.fontawesome.com/fe7e33d80b.js" crossorigin="anonymous"></script>
<style>
.adminBannerManage_wrapper{
	margin-left: 3%;
	border: 0.1px dotted gray;
	width: 75%;
}
</style>
</head>
<body>
<div class="adminBannerManage_wrapper">
	<!-- 크게 두 섹션으로 구성 => 실제 배너이미지 조정하는 부분과 배너신청 현황을 조회하는 곳 -->
	<div class="bannerManageForm">
		
	</div>
	<div class="bannerApplyListForm">
		<!-- 검색창은 구현하지 않고, 페이징 처리만 해놓을 것. -->
		<table class="bannerApplyListTable" border="1">
			<tr>
				
			</tr>
		</table>
	</div>
</div>

</body>
<script>

</script>
<script>
	$(document).on("ready", function(){
		console.log("배너 신청 관리페이지 호출");
	})
</script>
</html>