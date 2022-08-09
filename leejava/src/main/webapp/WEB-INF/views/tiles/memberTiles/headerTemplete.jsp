<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자뷰 배너 페이지</title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
	.headerTemplete_wrapper{
		width: 100%;
		height: 100%;
	}
	.bannerWrapper{
		height: 90%;
	}
	.bannerMenu{
		height: 10%;
		border-top: 0.1px dotted lightgray;
	}
	.bannerApplySpan{
		text-decoration: none;
		color: gray;
		font-size: small;
	}
</style>
</head>
<body>
<div class="headerTemplete_wrapper">
	<div class="bannerWrapper">
		배너 이미지가 들어가는 공간
	</div>
	<div class="bannerMenu" align="right">
		<a href="bannerApply.do" class="bannerApplySpan">&lt;배너 문의&gt;</a>
	</div>
</div>
</body>
<script>
	
</script>
</html>