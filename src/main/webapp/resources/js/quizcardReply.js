 	// 세트번호 : thisSetNo
 	// 로그인 이메일: session_user
 	
 	/* summernote 구현 스크립트 */
	var toolbar = [
	    // 글꼴 설정
	    ['fontname', ['fontname']],
	    // 글자 크기 설정
	    ['fontsize', ['fontsize']],
	    // 굵기, 기울임꼴, 밑줄,취소 선, 서식지우기
	    ['style', ['bold', 'italic', 'underline','strikethrough', 'clear']],
	    // 글자색
	    ['color', ['forecolor','color']],
	    // 글머리 기호, 번호매기기, 문단정렬
	    ['para', ['ul', 'ol', 'paragraph']],
	    // 줄간격
	    ['height', ['height']],
	    // 그림첨부, 링크만들기, 동영상첨부
	// 	    ['insert',['picture','link']],
	    // 코드보기, 확대해서보기, 도움말
	    ['view', ['codeview','fullscreen', 'help']]
	  ];

 	// 객체형식으로 설정을 구성.
	var setting = {
 		   value : '',
           height : 150,
           minHeight : 100,
           maxHeight : 200,
           focus : true,
           placeholder : '무분별한 욕설과 비난은 자제해주세요',
           lang : 'ko-KR',
           toolbar : toolbar, // toolbar 설정은 위에서 해놓음. 
           callbacks : { 
           	// summernote에서 제공하는 콜백함수 중 하나. onImageUpload
           	onImageUpload : function(files, editor, welEditable) {
           			for (var i = files.length - 1; i >= 0; i--) {
           					uploadSummernoteImageFile(files[i], this);
           			}
           	}
           }
  	};
 	$('#summernote').summernote(setting);
 	
   // 이미지업로드 콜백함수 정의
 	function uploadSummernoteImageFile(file, el) {
		// 이때 파라미터로 되어있는 el의 값은 이미지 업로드가 발생한 <textarea>태그를 의미한다. 
		console.log(file);
	   	var data = new FormData();
		data.append("file", file);
		$.ajax({
			data : data,
			type : "POST",
			url : "ajaxUploadSummernoteImageFile.do",  // 컨트롤러에서 처리해야 함
			contentType : false, // multipart/form-data 형식으로 보낼 때는 contentType:을 false로. 
			enctype : 'multipart/form-data',
			processData : false,
			success : function(responseData) {
				console.log("responseData 확인: " + responseData);
				console.log("responseDate.url 확인: " + responseData.url);
				$(el).summernote('insertImage', responseData.url);
			}
		});
	} 
	/* End Summernote */

// 퀴즈카드 댓글 restAPI 	
var quizcardReplyService = (function(){
	
	// 퀴즈카드 댓글 전체 호출
	function quizcardReplyList(data, callback, error){
		var quizcardSetNo = data.qno;
		console.log("번호확인: " + quizcardSetNo );
		$.getJSON("quizcardReplyList/" + quizcardSetNo, function(response){
			if(callback){
				callback(response);
			}
		}).fail(function(xhr, status, err){
			alert("댓글 정보를 받아오는 데 실패했습니다.");
			if(error){
				error();
			}
		});
	}
	
	return{
		replyList : quizcardReplyList // 댓글 전체 호출
	};
	
})();

$(document).on("ready", function(){
	
	// 댓글이 출력되는 공간
	const replyBox = $(".quizcardReplyList");
	
	// 댓글 전체 출력 5월 29일까지 작업
	/*quizcardReplyService.replyList( { qno : thisSetNo }, function(replyList){
		console.log('list : ' +  replyList);
		console.log(replyList);
		console.log("로그인 유저 닉네임: " + session_user);
		
		$.each(replyList, function(index, item){
			var str = "";
			// depth(깊이)에 따라 class속성값 추가하여 스타일(배경, 위치) 차별화
		})
		
	})*/
})

