<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
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
body {
}

.side {
	float: left;
	height:auto;
	width: 14rem!important;
	/* 	position: sticky;  */
/* 	position: -webkit-sticky; */

}

.wrapper {
	width: 100%;
}	
.content {
	width: 80rem!important;
}


</style>
</head>
<body>
	<div class="wrapper">
		<div class="side">
			<tiles:insertAttribute name="left" />
		</div>
		<div style="float: left;" class="content">
			<tiles:insertAttribute name="body" />
			<tiles:insertAttribute name="foot" />
		</div>
	</div>
</body>
</html>