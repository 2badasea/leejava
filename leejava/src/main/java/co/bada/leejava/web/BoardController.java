package co.bada.leejava.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.bada.leejava.Search;
import co.bada.leejava.board.BoardService;
import co.bada.leejava.board.BoardVO;

@Controller
public class BoardController {
	@Autowired
	BoardService boardDao;
	
	// logger 객체 
	private static final Logger logger = LoggerFactory.getLogger(BoardController.class);
	
	// 자유게시판 이동
	@RequestMapping(value = "boardList.do", method = { RequestMethod.GET, RequestMethod.POST} )
	public String boardList(Model model, BoardVO bvo
				, @RequestParam(required = false, defaultValue = "1") int page
				, @RequestParam(required = false, defaultValue = "1") int range
				, @RequestParam(required = false) String boardWriter
				, @RequestParam(required = false) String boardTitle
				, @RequestParam(required = false) String boardContents
				, Search svo) {
		
		// 검색요소 => view단에서 입력한 검색 항목이 svo객체에 담긴 것을 통해 처리하는 방식
		model.addAttribute("search", svo); 
		// 실질적인 페이징 처리 => 그전에 게시글의 총 갯수를 구한다. 
		svo.setBoardWriter(boardWriter);
		svo.setBoardTitle(boardTitle);
		svo.setBoardContents(boardContents); 
		int listCnt = boardDao.getBoardListCnt(svo);
		logger.info("자유게시판 페이징 처리 총 갯수 확인: " + listCnt);
		
		svo.pageinfo(page, range, listCnt);
		List<BoardVO> list = boardDao.boardSearchSelect(svo);
		model.addAttribute("pagination", svo);
		model.addAttribute("board", list);
		return "home/member/memberBoardList";
	}
	
	// 자유게시판 작성폼으로 이동
	@RequestMapping(value = "boardWritingForm.do" )
	public String boardWritingForm(Model model, HttpServletRequest request, HttpServletResponse response) {
		
		return "home/member/boardWritingForm";
	}
	
	// insert 데이터 테스트
	@ResponseBody
	@PostMapping(value ="/boardInsert.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> boardInsert(@RequestBody BoardVO bvo) {
		
		logger.info("ajax 넘어온 값 확인: " + bvo);
		logger.info("업로드 파일 숫자: " + bvo.getBfileCheck());
		int filesCount = bvo.getBfileCheck();
		int n = boardDao.boardInsert(bvo);
		String message;
		
		if(n == 1) {
			if(filesCount == 0) {	// 게시글 등록 성공 & 첨부파일 미존재
				message = "NOFILE";
				return new ResponseEntity<String>(message, HttpStatus.OK);
			} else {	
				// 게시글 등록 성공 & 첨부파일 존재 => 글번호를 리턴시킨다.
				message = String.valueOf(boardDao.getBno());
				return new ResponseEntity<String>(message, HttpStatus.OK);
			}
		} else {					// 게시글 등록 실패
			message = "NO";
			return new ResponseEntity<String>(message, HttpStatus.NOT_IMPLEMENTED);
		}
		
	}
	
}
