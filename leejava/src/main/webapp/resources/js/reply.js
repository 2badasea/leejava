console.log("Reply Modeul............");

// 모듈 패턴(즉시 실행함수와 {}를 이용해서 객체를 구성)
var replyService = (function(){
	
	// 댓글 등록
	function Fn_replyInsert(replyData, callback, error){
		console.log("insert reply............."); 
		
		$.ajax({   
			method: "POST",
			url: "boardReplyInsert.do", 
			data: JSON.stringify(replyData),
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
		var boardNo = data.bno;
		console.log(boardNo);
		$.getJSON("boardReplyList.do/" + boardNo, function(response){
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
	
	
	// 댓글 삭제
	function Fn_replyDelete(deleteData, callback, error){
		var rno = deleteData.replyRno;
		var boardNo = deleteData.boardNo;
		
		$.ajax({
			method: "DELETE",
			url: "boardReplyDelete.do/" + rno + "/" + boardNo,
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
		console.log("번호 조회: " + data.board_Reply_Rno);
		console.log("내용 조회: " + data.board_Reply_Content);
		// 댓글번호는 url 파라미터로, 나머지는 data속성에 (ajax의 data에 담으면 HTTP body부분에 담겨서 전송됨. 이를 '페이로드')
		$.ajax({
			method: "PUT",
			url: "boardReplyUpdate.do/" + data.board_Reply_Rno,   // controller에서   /{다른 변수명} 형태로 받을 수 있음. 
			data: JSON.stringify(data),
			contentType: "application/json; charset=utf-8",
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
	
	
	// 댓글 조회(특정 1개)
	function Fn_replySelectOne(data, callback, error){
		var bno = data.boardNo;
		var rno = data.replyNo;
		
		$.get("boardReplySelectOne.do/" + bno + "/" + rno, function(result){
			if(callback){
				callback(result);
			}
		}).fail(function(xhr, status, err){
			if(error){
				error();
			}
		})
	}
	
	// 부모 댓글 group값 업데이트(insert, delete 시 변경)
	function Fn_replyGroupUpdate(data, callback, error){
		console.log("모듈에서 데이터 조회: " + data);
		console.log(data);
		var parentRno = data.parentRno;
		var updateValue = data.value;
		
		$.ajax({
			method : "PUT",
			url: "boardReplyGroupUpdate.do/" + parentRno + "/" + updateValue, 
			success: function(result){
				if(callback){
					callback(result);
				}
			},
			error: function(result){
				console.log("에러: " + result	);
			}
		})
	}
	
	// return 시키는 객체에 key,value 형식으로 함수를 등록한다. 외부에서 replyService.key 를 호출하면 함수가 호출된다.
	return {
	 	replyInsert : Fn_replyInsert,
	 	replySelectList : Fn_replyList,
	 	replyDelete : Fn_replyDelete,
	 	replyUpdate : Fn_replyUpdate,
	 	replySelectOne : Fn_replySelectOne,
	 	replyUpdateGroup : Fn_replyGroupUpdate
	 }; 
})();