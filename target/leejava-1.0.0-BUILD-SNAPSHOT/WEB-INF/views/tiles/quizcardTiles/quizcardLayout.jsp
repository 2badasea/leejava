<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:insertAttribute name="qtitle" /></title>
<script src="http://code.jquery.com/jquery-latest.js"></script>
<style type="text/css">
* {
	margin: 0px;
	padding: 0px;
}
body{
	width: 100%;
	height: 100%;
}
	
/* .wrapper { */
/* 	width: 100%; */
/* 	height: 100%; */
/* 	padding-top: 20px; */
/* } */

.headerWrapper { /* 얘가 사실상 부모요소의 div역할을 한다  */
	height: 30px;
	width: 100%;
	background-color: #FFF0F0;
	position: fixed;
	padding: 10px;
	background: teal;	
	font-weight: bold;
}

.bodyWrapper {
	min-height: 800px;	
	padding-top: 50px;
}

.footerWrapper {
	background-color: #FFF0F0;
	height: 70px;
}
.footerWrapper{
	margin-top: 200px;
}
</style>
</head>
<body>
<!-- 	<div class="wrapper"> -->
		<div class="headerWrapper">
			<tiles:insertAttribute name="qheader" />
		</div>
		<div class="bodyWrapper">
			<tiles:insertAttribute name="qbody" />
		</div>
		<div class="footerWrapper">
			<tiles:insertAttribute name="qfoot" />
		</div>
<!-- 	</div> -->
</body>
</html>