package co.bada.leejava.web;

import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.google.gson.JsonObject;

import co.bada.leejava.Search;
import co.bada.leejava.board.BoardService;
import co.bada.leejava.board.BoardVO;
import co.bada.leejava.boardreply.BoardReplyService;
import co.bada.leejava.boardreply.BoardReplyVO;

@RestController
public class BoardReplyController {
	@Autowired
	BoardReplyService replyDao;
	@Autowired
	BoardService boardDao;
	
	// logger 객체  
	private static final Logger logger = LoggerFactory.getLogger(BoardReplyController.class);
	
	// 댓글 등록 요청(produce속성이나 consumes속성의 경우, MediaType으로 해도 무방
	@PostMapping(value = "boardReplyInsert.do", consumes = "application/json; charset=utf-8"
				, produces = "application/text; charset=utf-8")
	public ResponseEntity<String> boardReplyInsert(@RequestBody BoardReplyVO brvo, BoardVO bvo){
		
		logger.info("=========================== brvo 값 확인: " + brvo);
		
		// insert에 의해 리턴되는 값은 insert 성공여부가 아닌, 댓글번호값. 0만 아니면 성공.
		int insertedRno = replyDao.boardReplyInsert(brvo);
		
		// 위 insert문으로 생성된 row데이터의 댓글번호 rno값. 
		int resultCheck = brvo.getBoard_Reply_Rno();
		int parentNo = brvo.getBoard_Reply_Parent();
		logger.info("=========================== insertCount 확인: " + insertedRno);
		logger.info("============================ resultCheck값 확인:" + resultCheck);
		logger.info("============================= 참조하는 부모댓글 rno값 확인: "  + parentNo );
		
		// 부모댓글, 원글(board) 댓글수(replycnt) 항목도 업데이트
		if(insertedRno == 1) {
			bvo.setBoardNo(brvo.getBoard_Reply_Bno());
			bvo.setReplyCnt(1);
			int m =boardDao.boardReplyCntUpdate(bvo);
			if(m == 1) 
				logger.info("============================ 원글 replycnt 값도 수정 성공");
		}
		
		// view단에서 보여줄 데이터를 넘기도록
        Date now = new Date();
        SimpleDateFormat sdf = new SimpleDateFormat("yy-MM-dd HH:mm:ss");
        String formattedDate = sdf.format(now);
        
        // 날짜데이터와 생성된 댓글번호를 view단에 넘겨야 한다. 
        JsonObject jsonData = new JsonObject();
        jsonData.addProperty("rno", resultCheck);
        jsonData.addProperty("wdate", formattedDate);
        jsonData.addProperty("parentRno", parentNo);
        
		logger.info("=================================== json데이터 확인: "  + jsonData.toString());
		logger.info(jsonData.toString());
		// 삼항 연산자 처리  insertedRno의 값이 0 -> selectKey가 정상적으로 동작하지 않았고, insert문도 실행이 안 된 것
		return insertedRno != 0 ? new ResponseEntity<String>(jsonData.toString(), HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
//		return new ResponseEntity<String>(formattedDate, HttpStatus.OK);
	}
	
	
	
	// 특정 게시글의 댓글 조회 => 페이징 처리를 동반하여 리턴.
	@GetMapping(value = "boardReplyList.do/{boardNo}", produces = { MediaType.APPLICATION_JSON_VALUE,
																	MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<Map<String, Object>> boardReplyList(@PathVariable("boardNo") int boardNo
				,@RequestParam(required = false, defaultValue = "1") int page
				,@RequestParam(required = false, defaultValue = "1") int range
				,BoardReplyVO brvo
				,Search svo) {
		logger.info("================================= boardNo 값 확인: " + boardNo);
		
		// 댓글 한 페이지당 20개, rangeSize는 5 (1~5페이지 단위로 존재)
		svo.setListSize(30);
		svo.setRangeSize(5);
		svo.setBoard_Reply_Bno(boardNo);
		// 자유게시판 글번호 -> 해당 게시글 댓글 수 카운트
		int replyCnt = replyDao.getReplyCnt(svo);
		logger.info("============================ 해당 게시글의 총 댓글 수: " + replyCnt);
		svo.pageinfo(page, range, replyCnt);
		
		List<BoardReplyVO> list = new ArrayList<>();
		list = replyDao.boardReplyList(svo);
		logger.info("=========================== 반환된 list의 요소 개수: " + list.size());
			
		// jsonObject를 활용해서, 키값을 다르게 하여 데이터를 담는 방법
		Map<String, Object> map  = new HashMap<>();
		map.put("pagination", svo);
		map.put("list", list);
		logger.info("=========================== list: " + map.get("list"));
		
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}
	
	// 댓글 삭제 요청
	@DeleteMapping(value= "boardReplyDelete.do/{boardReplyRno}/{boardNo}", produces = {MediaType.TEXT_PLAIN_VALUE} )
	public ResponseEntity<String> boardReplyDelete(@PathVariable("boardReplyRno") int boardReplyRno
													, @PathVariable("boardNo") int boardNo
													,BoardReplyVO brvo, BoardVO bvo){
		
		logger.info("==================================== @PathVarialbe boardReplyRno 값 확인: " +boardReplyRno );
		logger.info("==================================== brvo값: " + brvo);
		
		brvo.setBoard_Reply_Rno(boardReplyRno);
		
		int removeCheck = replyDao.boardReplyDelete(brvo);
		if(removeCheck == 1) {
			bvo.setBoardNo(boardNo);
			bvo.setReplyCnt(-1);
			int m = boardDao.boardReplyCntUpdate(bvo);
			if( m == 1) {
				logger.info("===================================== 댓글삭제 -> 원글 replyCnt -1 업데이트 성공");
			}
		}
		logger.info("========================================= removeCheck 값 조회: " + removeCheck);
		return removeCheck == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
								: new ResponseEntity<String> ("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 부모 댓글 group값 수정
	@PutMapping(value = "boardReplyGroupUpdate.do/{boardReplyRno}/{updateValue}", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> boardReplyGroupUpdate(@PathVariable("boardReplyRno") int boardReplyRno
														, @PathVariable("updateValue") int updateValue
														, BoardReplyVO brvo){
		
		logger.info("======================== 부모댓글번호 조회: " +boardReplyRno );
		logger.info("======================== 업데이트값 조회: " + updateValue);
		
		brvo.setBoard_Reply_Rno(boardReplyRno);
		brvo.setBoard_Reply_Group(updateValue);
		
		
		return (replyDao.boardReplyGroupUpdate(brvo) == 1) ? new ResponseEntity<String>("success", HttpStatus.OK)
					: new ResponseEntity<String>("fail", HttpStatus.NOT_MODIFIED);
	}
	
	
	// 댓글 수정 => 수정할 내용이 json으로 넘어오고,  댓글번호가 파라미터로 넘어온다. 
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH},
					value = "boardReplyUpdate.do/{boardReplyRno}", 
					consumes = "application/json; charset=utf-8", 
					produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> boardReplyUpdate(@PathVariable("boardReplyRno") int boardReplyRno
												, @RequestBody BoardReplyVO brvo){
		
		logger.info("============================== 삭제할 댓글 번호: " + boardReplyRno);
		// brvo값에 댓글번호, 수정한 글 내역이 담겨서 오는지 확인
		logger.info("============================== 넘어온 brvo값: " + brvo);
		
		// 수정하는 경우 필요한 파라미터 (1. 댓글번호, 2. 수정시간, 3. 댓글내용-넘어온 brvo객체에 포함되어 있음)
		
		// 수정 시간 구하기(mapper 차원에서  to_char()를 활용하여 데이터를 넣는 방법도 존재)
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy-MM-dd HH:mm:ss");
        String formattedDate = now.format(formatter);
        brvo.setBoard_Reply_Udate(formattedDate); 		// 2. 수정 시간 
		
		int updateCheck = replyDao.boardReplyUpdate(brvo);
		
		return updateCheck == 1 ? new ResponseEntity<String>("update success", HttpStatus.OK)
								: new ResponseEntity<String>("update faile", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 1개 조회(테스트용) 
	@GetMapping(value = "boardReplySelectOne.do/{boardReplyBno}/{boardReplyRno}",
				produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<BoardReplyVO> boardReplySelect( BoardReplyVO brvo
													, @PathVariable("boardReplyBno") int boardReplyBno
													, @PathVariable("boardReplyRno") int boardReplyRno){
		
		logger.info("============================= 게시글 번호: " + boardReplyBno);
		logger.info("============================== 댓글 번호: " + boardReplyRno);
		
		brvo.setBoard_Reply_Bno(boardReplyBno);
		brvo.setBoard_Reply_Rno(boardReplyRno);
		
		return new ResponseEntity<BoardReplyVO>(replyDao.boardReplySelect(brvo), HttpStatus.OK);
	}
	
}
