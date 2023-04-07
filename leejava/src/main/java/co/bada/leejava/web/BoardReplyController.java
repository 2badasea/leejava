package co.bada.leejava.web;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.http.protocol.HTTP;
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
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import co.bada.leejava.Search;
import co.bada.leejava.boardreply.BoardReplyService;
import co.bada.leejava.boardreply.BoardReplyVO;



@RestController
public class BoardReplyController {
	@Autowired
	BoardReplyService replyDao;
	
	// logger 객체 
	private static final Logger logger = LoggerFactory.getLogger(BoardReplyController.class);
	
	// 댓글 등록 요청(produce속성이나 consumes속성의 경우, MediaType으로 해도 무방
	@PostMapping(value = "boardReplyInsert.do", consumes = "application/json; charset=utf-8"
				, produces = "application/text; charset=utf-8")
	public ResponseEntity<String> boardReplyInsert(@RequestBody BoardReplyVO brvo){
		
		logger.info("=========================== brvo 값 확인: " + brvo);
		
		int insertCount = replyDao.boardReplyInsert(brvo);
		logger.info("=========================== insertCount 확인: " + insertCount);
		
		// 삼항 연산자 처리
		return insertCount == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
				: new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 특정 게시글의 댓글 조회 => 페이징 처리를 동반하여 리턴.
	@GetMapping(value = "boardReplyList.do/{boardNo}", produces = { MediaType.APPLICATION_JSON_VALUE,
																	MediaType.APPLICATION_XML_VALUE
	})
	public ResponseEntity<Map<String, Object>> boardReplyList(@PathVariable("boardNo") int boardNo
				,@RequestParam(required = false, defaultValue = "1") int page
				,@RequestParam(required = false, defaultValue = "1") int range
				,Search svo) {
		
		// svo에는 boardNo 정보가 들어가 있다. 
		logger.info("============================== svo : " + svo);
		
		// 댓글 한 페이지당 20개, rangeSize는 5 (1~5페이지 단위로 존재)
		svo.setListSize(20);
		svo.setRangeSize(5);
		svo.setBoardNo(boardNo);
		// 자유게시판 글번호 -> 해당 게시글 댓글 수 카운트
		int replyCnt = replyDao.getReplyCnt(svo);
		logger.info("============================ 해당 게시글의 총 댓글 수: " + replyCnt);
		svo.pageinfo(page, range, replyCnt);
		List<BoardReplyVO> list = replyDao.boardReplyList(svo);
		
		// jsonObject를 활용해서, 키값을 다르게 하여 데이터를 담는 방법
		Map<String, Object> map  = new HashMap<>();
		map.put("pagination", svo);
		map.put("list", list);
		logger.info("=========================== pagination: " + map.get("pagination"));
		logger.info("=========================== list: " + map.get("list"));
		
		return new ResponseEntity<Map<String,Object>>(map, HttpStatus.OK);
	}
	
	// 댓글 삭제 요청
	@DeleteMapping(value= "boardReplyDelete.do/{boardReplyRno}", produces = {MediaType.TEXT_PLAIN_VALUE} )
	public ResponseEntity<String> boardReplyDelete(@PathVariable("boardReplyRno") int boardReplyRno,
													@RequestBody BoardReplyVO brvo){
		
		logger.info("==================================== @PathVarialbe boardReplyRno 값 확인: " +boardReplyRno );
		logger.info("==================================== brvo값: " + brvo);
		
		brvo.setBoardReplyRno(boardReplyRno);
		
		int removeCheck = replyDao.boardReplyDelete(brvo);
		
		return removeCheck == 1 ? new ResponseEntity<String>("success", HttpStatus.OK)
								: new ResponseEntity<String> ("fail", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 수정
	// 댓글 수정 => 수정할 내용이 json으로 넘어오고,  댓글번호가 파라미터로 넘어온다. 
	@RequestMapping(method = { RequestMethod.PUT, RequestMethod.PATCH},
					value = "boardReplyUpdate.do/{boardReplyRno}", 
					consumes = "application/json; charset=utf-8", 
					produces = { MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String> boardReplyUpdate(@PathVariable("boardReplyRno") int boardReplyRno
												, @RequestBody BoardReplyVO brvo){
		
		logger.info("============================== 삭제할 댓글 번호: " + boardReplyRno);
		logger.info("============================== 넘어온 brvo값: " + brvo);
		
		// 수정하는 경우 필요한 파라미터 (1. 댓글번호, 2. 수정시간, 3. 댓글내용-넘어온 brvo객체에 포함되어 있음)
		brvo.setBoardReplyRno(boardReplyRno); 			// 1. 댓글번호
		
		// 수정 시간 구하기(mapper 차원에서  to_char()를 활용하여 데이터를 넣는 방법도 존재)
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yy-MM-dd HH:mm:ss");
        String formattedDate = now.format(formatter);
        brvo.setBoardReplyUdate(formattedDate); 		// 2. 수정 시간 
		
		int updateCheck = replyDao.boardReplyUpdate(brvo);
		
		return updateCheck == 1 ? new ResponseEntity<String>("update success", HttpStatus.OK)
								: new ResponseEntity<String>("update faile", HttpStatus.INTERNAL_SERVER_ERROR);
	}
	
	// 댓글 1개 조회(테스트용) 
	@GetMapping(value = "boardReplySelect.do/{boardReplyBno}/{boardReplyRno}",
				produces = { MediaType.APPLICATION_XML_VALUE, MediaType.APPLICATION_JSON_VALUE})
	public ResponseEntity<BoardReplyVO> boardReplySelect( BoardReplyVO brvo
													, @PathVariable("boardReplyBno") int boardReplyBno
													, @PathVariable("boardReplyRno") int boardReplyRno){
		
		logger.info("============================= 게시글 번호: " + boardReplyBno);
		logger.info("============================== 댓글 번호: " + boardReplyRno);
		
		brvo.setBoardReplyBno(boardReplyBno);
		brvo.setBoardReplyRno(boardReplyRno);
		
		return new ResponseEntity<BoardReplyVO>(replyDao.boardReplySelect(brvo), HttpStatus.OK);
		
	}
	
}
