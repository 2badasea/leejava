<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title" /></title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
}

.wrapper {
	width: 100%;
	height: 100%;
	display: flex;
}
.sideWrapper {
	width: 12%;
}
.mainWrapper {
	width: 85%;
}
.headerWrapper {
	height: 5%;
	background-color: #FFF0F0	;
}
.bodyWrapper{
	min-height: 700px; 
}
.footerWrapper{
	background-color: #FFF0F0;
	height: 70px;
}
</style>
</head>
<body>
	<div class="wrapper">
		<div class="sideWrapper">
			<tiles:insertAttribute name="left" />
		</div>
		<div class="mainWrapper">
			<div class="headerWrapper">
				<tiles:insertAttribute name="header" />
			</div>
			<div class="bodyWrapper">
				<tiles:insertAttribute name="body" />
			</div>
			<div class="footerWrapper">
				<tiles:insertAttribute name="foot" />
			</div>
		</div>
	</div>
</body>
</html>