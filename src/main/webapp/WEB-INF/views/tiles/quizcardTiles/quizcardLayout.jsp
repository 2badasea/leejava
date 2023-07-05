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

.headerWrapper { 
	height: 30px;
	width: 100%;
	background-color: #FFF0F0;
	position: fixed;
	padding: 10px;
	background: teal;	
	font-weight: bold;
}

.bodyWrapper {
	min-height: 1000px;	
	padding-top: 50px;
}

.footerWrapper {
	background-color: whitesmoke;
	height: 100px;
	bottom: 0px;
	left: 0px;
	width: 100%;
	position: fixed;
}
.footerWrapper{
}
</style>
</head>
<body>
		<div class="headerWrapper">
			<tiles:insertAttribute name="qheader" />
		</div>
		<div class="bodyWrapper">
			<tiles:insertAttribute name="qbody" />
		</div>
		<div class="footerWrapper">
			<tiles:insertAttribute name="qfoot" />
		</div>
</body>
</html>