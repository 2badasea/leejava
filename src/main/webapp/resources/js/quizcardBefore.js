	const thisSetNo = $("#quizcardBeforeSetNo").val();
	const session_user = $("#session_user").val(); 
	
	// 사용자 정보 조회하는 모달창 관련 스크립트 부분(공통영역)  ------------------------- 작업 끝나고 밑으로 내려보내기
	$(".setCreaterClickA").on("click", function(e){
		console.log("유저 닉네임 클릭");
		let email;
		console.log( $(e.target).text()); 
		$("body").css("overflow", "hidden");	// 모달창 호출 => body영역 스크롤 방지
		$(".userInfo_modal_container").css("display", "block");
		var sendNickname = $(e.target).text();
		// 첫 번째 ajax로 프로필 정보(닉네임, 이메일, 가입날짜, intro + 프로필이미지 정보)		
		$.ajax({
			url: "ajaxUserInfo.do?m_nickname=" +  sendNickname,
			method: "GET",
			dataType: "json",
			async: false, 
			success: function(data){
				email = data.m_email; // 해당 유저가 작성한 퀴즈카드 목록을 조회하기 위한 변수
				$("#m_nickname").val(data.m_nickname);
				$("#m_joindate").val(data.m_joindate);
				$("#userIntroForm").val(data.m_intro);
				$("#userInfoTitle").html(data.m_nickname + " 님의 사용자 정보");
				$("#userIntroLabel").text(data.m_nickname + " 님의 Intro");
			},
			error: function(responseText){
				console.log("호출 실패");
				console.log(responseText);
			}
		})
		// 두 번째 ajax => 작성한 퀴즈카드 정보 넣기. 
		var tb = $("<table class='userInfo_quizcardTb' />");
		$.ajax({
			url: "ajaxMyQuizcard.do",
			method: "GET",
			dataType: "json",
			data: {
				m_email: email
			},
			contentType: "application/json; charset=utf-8",
			success: function(data){
				console.log("호출 성공");
				console.log(data);
				// json 배열의 타입을 출력시켜야 한다   class="userInfo_quizcard" 여기 공간에 append 시킨다. 
				$.each(data, function(index, item){
					if(item.quizcard_set_status != 'PRIVATE'){
						var tr = $("<tr clas=s'userInfo_quizcardTr' />").append(
								$("<td />").text(item.quizcard_set_no),
								$("<td />").text(item.quizcard_set_name),
								$("<td />").text(item.quizcard_set_cdate),
								$("<td />").text(item.quizcard_category));
						tb.append(tr);
					}
				})
				$(".userInfo_quizcard").append(tb);
			},
			error: function(responseText){
				console.log("호출 실패");
				console.log(responseText);
			}
		})
		
		// email값을 이용하여 get.JSON url을 호출하여 db에 있는 프로필 이미지 정보를 가져와서 화면에 뿌려준다.
			var uploadResult = $(".userInfo_image");
			$.getJSON("getAttachList.do", { m_email : email}, function(arr){
				if(arr.length != 1){ // 프로필 이미지 정보가 없는 경우.
					let str = "";
					str += "<div id='basic_result_card'>";
					str += "<img src='resources/image/userimage.jpg'>"; // 내부 이미지 호출
					str += "</div>";
					uploadResult.html(str);
					return;
				}
				let obj = arr[0];
				let str = "";
				let fileCallPath = encodeURIComponent( obj.uploadPath + "/s_" + obj.uuid + "_" + obj.fileName);
				str += "<div id='basic_result_card'";
				str += " data-path='" +  obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" +  obj.fileName + "'";
				str += ">";
				str += "<img src='display.do?fileName=" + fileCallPath + "'>";
				str += "</div>";
				uploadResult.html(str);
			}) // get.JSON 메서드 영역 끝  ( get.JSON으로 회원의 이미지 정보를 출력하여 display.do로 화면에 출력시킨다.)
	})
	
	// 모달창 닫기버튼(X) 
	$(".userInfoModalCloseBtn").on('click', function(){
		console.log("사용자 정보 창 닫기");
		$(".userInfo_quizcard").empty();  // div안의 영역을 초기화 
		$("body").css("overflow", "unset"); // 모달창 호출 => 스크롤 방지 해제
		$(".userInfo_modal_container").css('display', 'none');
	})
	
	// 외부영역 클릭 모달창 닫기
	$(document).on("click", function(e){
		if( $(e.target).closest('.userInfo_modal_content').length == 0 && !$(e.target).hasClass('setCreaterClickA') ){
			$(".userInfo_quizcard").empty(); 
			$("body").css("overflow", "unset");
			$(".userInfo_modal_container").css('display', 'none');
		}	
	})
	
	// 퀴즈카드 작성자 정보 모달창을 통해 작성자가 생성한 퀴즈카드 set이동 
	$(document).on("click", ".userInfo_quizcardTr", function(e){
		var check = confirm("해당 퀴즈카드로 이동하시겠습니까?");
		if(check){
			var set_no = $(e.target).parent().find('td').eq(0).text();
			location.href='quizcardBefore.do?set_no=' + set_no;
		} else {
			return false;
		}
	})
	
	/**
		===== 페이지 렌더링 이후 실행시킬 스크립트문 ====
	 */
	$(function(){
		console.log("세트번호(thisSetNo): " + thisSetNo );
		// ajax로 호출 => 모든 문제를 배열에 담고 => 인덱스 생성 => prev, next 화살표 정의하기 
		$.ajax({
			url: "questionNameList.do",
			method: "GET",
			dataType: "JSON",
			contentType: "application/json; charset=utf-8",
			data: {
				quizcard_set_no : thisSetNo
			},
			success: function(data){
				console.log("호출 성공");
				questionNames(data);
			},
			error: function(responseText){
				console.log("호출 실패");
				console.log(responseText);
			}
		})
		// 문제 이름을 담을 배열 선언
		let questionNameList = [];
		var count = 0;
		
		function questionNames(data){
			$.each(data, function(index, item){
				questionNameList.push(item.quizcard_question_name); // 배열은 push() 메서드를 통해 추가
			})
			console.log("배열조회: " + questionNameList);
			$(".questionNo").text(count + 1);
			$(".questionName").text( questionNameList[count] );
		}
		
		// 이전문제버튼, 다음문제 버튼  prevQuestion  nextQuestion
		$(".prevQuestion").on("click", function(){
			var number = $(".questionNo").text();
			console.log("현재 문제 번호: " + number);
			if(count === 0){
				return false;
			} else {
				count--;
				console.log("count값: " + count);
				$(".questionNo").text(count + 1);
				$(".questionName").text( questionNameList[count] );
			}
		})
		
		// 다음문제버튼 
		$(".nextQuestion").on("click", function(){
			console.log("문제 총 갯수: " + questionNameList.length);
			if( count === (questionNameList.length-1) ){
				return false;
			} else {
				count++;
				$(".questionNo").text(count+1);
				$(".questionName").text( questionNameList[count] );
			}
		})
		
		// 즐겨찾기 상태여부에 따른 별표 활성화 ajax로 조회. 
		$.ajax({
			url: "ajaxBookmarkStatus.do",
			method: "GET",
			dataType: "text",
			data: {
				quizcard_set_no : thisSetNo,
				m_email : session_user
			},
			success: function(responseText){
				if(responseText === "NO"){
					$("#emptyStar").css("display", "block");
					$("#addStar").css("display", "none");
				} else if(responseText === "YES"){
					$("#emptyStar").css("display", "none");
					$("#addStar").css("display", "block");
				}
			},
			error: function(responseText){
				console.log("통신에러")
				console.log(responseText);
			}
		})
	})
	// 이전 퀴즈카드 메인페이지로 돌아가는 이벤트 버튼
	$(".quizcardMainGoBtn").on('click', function(){
		location.href = "quizcard.do";
	})

	// 학습모드 선택 모달창 활성화
	$("#quizcardStartBtn").on("click", function(){
		$(".studyType_modal_container").css("display", "block");
	})
	
	// 학습시작 버튼
	$("#studyStartBtn").on('click', function(){
		// 세트번호와 학습방식의 값을 날린다. 
		var setNo = $("#modalHeader").data("setno");
		var studyType = $("input[name='studyType']:checked").val();
		// 세트이름, 카테고리, 세트번호는 quizcard_history 테이블에 insert된다.
		var setName = $("#quizcardBeforeSetNo").data("setname");
		var setCategory = $("#quizcardBeforeSetNo").data("category");
		var memail = $("#session_user").val();
		var data = {
				quizcard_set_no : setNo,
				quizcard_set_name : setName,
				quizcard_category : setCategory,
				m_email : memail
		};
		
		$.ajax({
			url: "ajaxHistory.do",
			method : "POST",
			dataType: "text",
			contentType: "application/json; charset=utf-8",
			data: JSON.stringify(data),
			success: function(responseText){
				console.log("호출 성공");
				if(responseText === "UPDATE" || responseText === "INSERT"){
					// 두 값을 컨트롤러를 통해 페이지에 넘긴다. 그리고 해당 페이지에서 restController를 통해 작업!
					location.href="studyStart.do?setNo=" + setNo + "&studyType=" + studyType;
				} else {
					console.log(responseText);
					// 비회원이 접근하려고 할 때. 
					location.href="studyStart.do?setNo=" + setNo + "&studyType=" + studyType;
				}
			},
			error: function(responseText){
				console.log("호출 실패");
				console.log(responseText);
				location.href="studyStart.do?setNo=" + setNo + "&studyType=" + studyType;
			}
		})
	})
	
	
	// 학습모드 선택 창닫기
	$("#studyTypeCloseBtn").on("click", function(){
		$(".studyType_modal_container").css("display", "none");
	})
	
	// 모달창 외부영역 클릭 => 모달창 비활성화
	$(document).on("click", ".studyType_modal_layer", function(e){
		if( !$(e.target).hasClass("studyType_modal_content") ) {
			$(".studyType_modal_container").css("display", "none");
		}
	})
	
	// 퀴즈카드 수정페이지 이동 ( by 생성자)
	$("#updateQuizcardBtn").on("click", function(){
		// quizcard_set_no값과 해당 세트번호의 문제갯수를 날린다.
		// 문제갯수의 경우 컨트롤러에서 또 쿼리문을 조회하긴 번거롭기 때문. 
		var setNo = $("#dataInput").data("setno");
		console.log("세트번호: " + setNo);
		var questionCount = $("#dataInput").data("questioncount");
		console.log("해당 세트의 문제 갯수: " + questionCount);
		
		var check = confirm("해당 퀴즈카드를 수정하시겠어요?");
		if(check){
			location.href="updateQuizcard.do?set_no="+setNo + "&questionCount=" + questionCount;
		} else {
			return false;
		}
	})
	
	// 즐겨찾기 추가/취소.
	$("#starClick").on("click",function(e){
		var userEmail = $("#session_user").val();
		if(userEmail === ""){
			alert("회원들만 이용할 수 있는 서비스입니다.");
			return false;
		}
		var thisSetNo = $("#quizcardBeforeSetNo").val();
		// 클릭했을 때 별표의 class값에 따라 취소인지 아닌지 여부 판단 empty면 insert 아니면 delete // ajax두 번 호출? 
		var b = $(e.target).hasClass("empty");
		if(b){
			// trun인 경우, 즉 비어있는 경우 => insert시킨다. 
			$.ajax({
				url: "ajaxBookmarkAdd.do",
				type: "POST",
				data: {
					m_email : userEmail,
					quizcard_set_no : thisSetNo
				},
				success: function(responseText){
					console.log("호출 성공");
					alert("즐겨찾기에 추가되었습니다.");
					console.log(responseText);
					if(responseText === "OK"){
						$("#emptyStar").css("display", "none");
						$("#addStar").css("display", "block");
					}
				},
				error: function(responseText){
					console.log("호출 실패");
					console.log(responseText);
				}
			})
		} else {
			// empty속성이 없는 경우 => 이미 즐겨찾기 추가된 상태 => delete시키기.
			$.ajax({
				url: "ajaxBookmarkDelete.do",
				type: "POST",
				data : {
					m_email : userEmail,
					quizcard_set_no : thisSetNo
				},
				success: function(responseText){
					console.log("호출 성공");
					console.log(responseText);
					alert("즐겨찾기가 취소되었습니다.");
					if(responseText === "OK"){
						$("#emptyStar").css("display", "block");
						$("#addStar").css("display", "none");
					}
				},
				error: function(responseText){
					console.log("호출 실패");
					consoel.log(responseText);
				}
			})
		}	
	})
