<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://tiles.apache.org/tags-tiles" prefix="tiles"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title><tiles:getAsString name="title" /></title>
<script src="http://code.jquery.com/jquery-latest.js"></script> 
<link rel="stylesheet" href="resources/css/common.css">
<style type="text/css">
</style>
</head>
<body>
	<div class="wrap">
		<div class="content">
				<tiles:insertAttribute name="left" />
			<div class="page_content">
				<tiles:insertAttribute name="body" />
				<tiles:insertAttribute name="foot" />
			</div>
		</div>
	</div>
</body>
</html>