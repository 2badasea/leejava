<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>사용자뷰 배너 페이지</title>
<style type="text/css">
	.headerTemplete_wrapper{
		width: 100%;
		height: 100%;
	}
	.bannerSlide_Container{
		height: 90%;
		width: 100%;
		position: relative;
	}	
	.bannerApplySpan{
		text-decoration: none;
		color: gray;
		font-size: small;
	}
	
	.fade{
		-webkit-animation-name: fade;
		-webkit-animation-duration: 1.5s;
		animation-name: fade;
		animation-duration: 1.5s;
	}
	
	@-webkit-keyframes fade {
	  from {opacity: .4} 
	  to {opacity: 1}
	}

	@keyframes fade {
	  from {opacity: .4} 
	  to {opacity: 1}
	}
	
	.prev, .next{
		cursor: pointer;
		position: absolute;
		top: 50%;
		width: auto;
		padding: 16px;
		margin-top: -22px;
		color: coral;	 
		font-weight: bold;
		font-size: 18px;
		transition: 0.6s ease;
		border-radius: 0 3px 3px 0;
	}
	
	.next{
		right: 6px;
		border-radius: 3px 0 0 3px;
	}
	.prev:hover, .next:hover {
		background-color: rgba(0, 0, 0, 0.8);
	}
	.bannerSlideBox{
		max-width: 1172px;
		height: 300px;
	}
	.bannerSlideBox img{
		min-width:  1000px;
		max-width: 1172px;
		max-height: 300px;
	}
</style>
</head>
<body>
<div class="headerTemplete_wrapper">
	<div class="bannerSlide_Container">
		<!-- 여기 공간에 스크립트를 통한 배너이미지가 동적으로 출력된다.  -->
	</div>
	<div class="bannerMenu" align="right">
		<a href="bannerApply.do" class="bannerApplySpan">&lt;배너 문의&gt;</a>
	</div>
</div>
</body>
<script>
	$(function(){
		// 배너이미지를 출력시키는 함수를 호출.
		console.log("배너 이미지 호출 이벤트 시작");
		var banpoststatus = 'PUBLICING';
		$.ajax({
			url : "publicingBannerList.do",
			data: {
				banpoststatus : banpoststatus
			},
			async: false, // ajax로 화면을 모두 출력한 다음 슬라이드 이벤트가 일어나도록 하기 위함.
			method : "GET",
			dataType: "JSON",
			contentType: "application/x-www-form-urlencoded; charset=utf-8",
			success: function(data){
				console.log("호출 성공");
				Fnc_bannerImageShow(data);
			},
			error: function(err){
				console.log("호출 실패");
				console.log(err);
			}
		})
		
		// 화면 로딩이 끝나면, 첫 번째 div를 제외한 나머지를 숨긴다.
		$(".bannerSlideBox").not(".active").hide();
		
		// 4초마다 다음 슬라이드로 넘어가는 이벤트
		setInterval(nextSlide, 3000);
	})
</script>
<script>
	// 배너이미지 화면에 출력시키는 함수 ajax의 success 콜백함수. 
	function Fnc_bannerImageShow(data){
		var bannerContainer = $(".bannerSlide_Container");
		// bannerSlide_Container 여기 안에 모두 들어가야 한다. 
		console.log("데이터 조회: "	);
		console.log(data); // 가져올 데이터는  data.banpfile
		$.each(data, function(index, item){
			/*	동적으로 태그를 구성한다. */  
			var banpfile = item.banpfile;
			var banpfileName = encodeURIComponent(banpfile);	
			var str = "";
			if( index === 0){
				str = "<div class='bannerSlideBox fade active'>";
			} else {
				str = "<div class='bannerSlideBox fade'>";
			}
			str += "<img src='bannerDisplay.do?banpfileName=" +  banpfileName + "' >";
			str += "</div>";
			bannerContainer.append(str);
		})
		// 방향 icon도 추가.
		bannerContainer.append("<a class='prev' onclick='prevSlide()'>&#10094;</a>");
		bannerContainer.append("<a class='next' onclick='nextSlide()'>&#10095;</a>");
	}
	
	// 이전 슬라이드 호출 이벤트
	function prevSlide(){
		// 우선 모든 div를 숨긴다. 
		$('.bannerSlideBox').hide();
		// 모든 슬라이드 div객체를 변수에 저장
		var allSlide = $(".bannerSlideBox");
		// 현재 화면에 출력된 슬라이드의 인덱스 변수
		var currentIndex = 0; 
		
		// 반복문으로 현재 active클래스를 가진 div를 찾아서 index에 저장. 
		$(".bannerSlideBox").each(function(index, item){
			if( $(this).hasClass('active')){
				currentIndex = index;
			}
		});
		
		// 새롭게 나타낼 div의 index
		var newIndex = 0;
		if(currentIndex <= 0){
			// 현재 슬라이드의 index가 0인 경우 => 마지막 슬라이드로 보냄(무한반복)
			nexIndex = allSlide.length - 1;
		} else {
			nexIndex = currentIndex - 1;
		}
		
		// 모든 div에서 active클래스 제거
		$(".bannerSlideBox").removeClass('active');
		// 새롭게 저정한 index번째 슬라이드에 active 클래스 부여 후 show();
		$(".bannerSlideBox").eq(newIndex).addClass('show');
		$('.bannerSlideBox').eq(newIndex).show();
	}
	
	 // 다음 슬라이드 호출 이벤트
	function nextSlide() {
		 $(".bannerSlideBox").hide();
		 var allSlide = $(".bannerSlideBox");
		 var currentIndex = 0;
		 
		 $(".bannerSlideBox").each(function(index, item){
			 if( $(this).hasClass('active')){
				 currentIndex = index;
			 }
		 })
		 
		 var newIndex = 0;
		 if(currentIndex >= allSlide.length - 1 ){
			 newIndex = 0;
		 } else{
			 newIndex = currentIndex + 1;
		 }
		 
		 $('.bannerSlideBox').removeClass('active');
		 $('.bannerSlideBox').eq(newIndex).addClass('active');
		 $('.bannerSlideBox').eq(newIndex).show();
	 }
	
</script>
</html>