package co.bada.leejava.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

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
import co.bada.leejava.uploadfile.UploadfileService;
import co.bada.leejava.uploadfile.UploadfileVO;

@Controller
public class BoardController {
	@Autowired
	BoardService boardDao;
	@Autowired
	UploadfileService uploadfileDao;
	// 게시판 유형 1번
	static final int FILEBOARD = 1;
	
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
		
		model.addAttribute("search", svo); 
		// 페이징 처리에 사용되는 값 3개 => 검색 기능.
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
	@RequestMapping(value = "boardWritingForm.do", method = { RequestMethod.GET} )
	public String boardWritingForm() {
		
		return "home/member/boardWritingForm";
	}
	
	// insert 데이터 테스트
	@ResponseBody
	@PostMapping(value ="/boardInsert.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> boardInsert(@RequestBody BoardVO bvo) {
		
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
	
	/**
	 * 주석 나중에 다시 알아보기
	 * @param  
	 * @return 
	 */
	@RequestMapping(value = "boardRead.do", method = RequestMethod.GET)
	public String boardRead(Model model, BoardVO bvo, HttpSession session, UploadfileVO uvo
					, @RequestParam("boardNo") int boardNo 
					, @RequestParam("boardHit") int boardHit) throws Exception	{
		
		bvo.setBoardNo(boardNo);
		bvo.setBoardHit(boardHit + 1);
		// 로그인 상태(session 존재) => 조회수 업데이트
		if(session.getAttribute("session_user") != null) {
			boardDao.boardHitUpdate(bvo);
		} 
		// bvo.getBfileCheck()의 결과가 0이 아니라면, uploadfileDao를 통해 UploadFileVO uvo를 model에 담아야 한다. 
		bvo = boardDao.boardSelect(bvo);
		System.out.println("=================================bvo 값 조회: " + bvo);
		model.addAttribute("board", bvo);
		if(bvo.getBfileCheck() != 0) {
			List<UploadfileVO> list = new ArrayList<>();
			uvo.setFileBoard(FILEBOARD);
			uvo.setFileBno(boardNo);
			list = uploadfileDao.uploadfileSelect(uvo);
			model.addAttribute("fileList", list);
			System.out.println("===========================list 값 조회: " + list);
		}
		System.out.println("======================bvo 값 조회: " + bvo);
		// 본인이 작성한 게시글일 경우 => 수정하기 버튼도 view단에서 같이 구현한다. 
		return "home/member/boardRead";
	}
}
