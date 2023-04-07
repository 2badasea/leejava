// 아무 기능 없이 간단히 동작하는 코드만을 넣어서 확인하는 용도
// 게시물의 조회 페이지에서 사용하기 위해서 작성된 것 => views/
console.log("Reply Modeul............");

// 모듈 패턴(즉시 실행함수와 {}를 이용해서 객체를 구성)
var replyService = (function(){
	
	function Fn_replyInsert(reply, callback, error){
		console.log("insert reply............."); 
		
		
		/* ajax 생략
		$.ajax({   
			method: "POST",
			url: "boardReplyInsert.do", 
			data: JSON.stringify(reply),
			contentType : "application/json; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}  
			},
			error: function(xhr, status,er){
				if(error){
					error(er);
				}
			}
		}) */
		
	}
	
	// return 시키는 객체에 key,value 형식으로 함수를 등록한다. 외부에서 replyService.key 를 호출하면 함수가 호출된다.
	return {
	 	replyInsert : Fn_replyInsert
	 }; 
})();