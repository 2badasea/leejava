<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title" /></title>
<!-- <link rel="stylesheet" href="resources/css/common.css"> -->
<style type="text/css">
*{
	margin: 0;
	padding: 0;
}
.wrap{
	width: 100%;
}
.sidebar {
	width: 15%;
	height: 100v;  /* 이 부분 정리하기. 화면 사이즈 높이 정하기*/
	float: left;   
}
</style>
</head>
<body>
	<div class="wrap">
		<div class="sidebar">
			<tiles:insertAttribute name="left" />
		</div>
		<div class="content">
			<tiles:insertAttribute name="body" />
			<tiles:insertAttribute name="foot" />
		</div>
	</div>
</body>
</html>