// 아무 기능 없이 간단히 동작하는 코드만을 넣어서 확인하는 용도
// 게시물의 조회 페이지에서 사용하기 위해서 작성된 것 => views/
console.log("Reply Modeul............");

// 모듈 패턴(즉시 실행함수와 {}를 이용해서 객체를 구성)
var replyService = (function(){
	
	// 외부에서 replyService.replyInsert(객체, 콜백)으로 호출 => Fn_replyInsert(객체, 콜백)으로 실행된다.
	function Fn_replyInsert(reply, callback, error){
		console.log("insert reply............."); 
		
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
		}) 
	} // end -- insert 
	
	// 댓글 전체 목록 호출
	function Fn_replyList(data, callback, error){
		console.log(data);
		var boardNo = data.bno;
		console.log("아래가 boardNo 값"); 
		console.log(boardNo);
		$.getJSON("boardReplyList.do/" + boardNo, function(response){
			if(callback){
				callback(response);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		});
	}
	
	// 댓글 삭제
	function Fn_replyDelete(rno, callback, error){
		$.ajax({
			method: "DELETE",
			url: "boardReplyDelete.do/" + rno,
			success: function(deleteResult, status, xhr){
				if(callback){
					callback(deleteResult);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		})
	} // End of delete 
	
	// 댓글 수정 => json형식으로 서버에 전송. (insert와 유사)
	function Fn_replyUpdate(data, callback, error){
		console.log("번호 조회: " + data.rno);
		
		// 댓글번호는 url 파라미터로, 나머지는 data속성에 (ajax의 data에 담으면 HTTP body부분에 담겨서 전송됨. 이를 '페이로드')
		$.ajax({
			method: "PUT",
			url: "boardReplyUpdate.do/" + data.rno,   // controller에서   /{다른 변수명} 형태로 받을 수 있음. 
			data: JSON.stringify(data),
			contentType: "application/text; charset=utf-8",
			success: function(result, status, xhr){
				if(callback){
					callback(result);
				}
			},
			error: function(xhr, status, er){
				if(error){
					error(er);
				}
			}
		}) // End of ajax
	} // End of Update
	
	
	// 댓글 조회(특정)
	function Fn_replySelect(data, callback, error){
		var bno = data.boardNo;
		var rno = data.replyNo;
		
		$.get("boardReplySelect.do/" + bno + "/" + rno  + ".json", function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		})
	}
	
	
	
	// return 시키는 객체에 key,value 형식으로 함수를 등록한다. 외부에서 replyService.key 를 호출하면 함수가 호출된다.
	return {
	 	replyInsert : Fn_replyInsert,
	 	replySelect : Fn_replyList,
	 	replyDelete : Fn_replyDelete,
	 	replyUpdate : Fn_replyUpdate,
	 	replySelect : Fn_replySelect
	 }; 
})();