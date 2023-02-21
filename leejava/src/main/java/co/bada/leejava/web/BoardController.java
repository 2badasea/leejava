package co.bada.leejava.web;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.google.gson.JsonObject;

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
	@Resource(name = "fileUploadPath")
	private String fileUploadPath;
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
		
		return "home/member/memberBoardWritingForm";
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
	 * 자유게시판 개별 글 조회
	 */
	@RequestMapping(value = "boardRead.do", method = RequestMethod.GET)
	public String boardRead(Model model, BoardVO bvo, HttpSession session, UploadfileVO uvo
					, @RequestParam("boardNo") int boardNo 
					, @RequestParam("boardHit") int boardHit) throws Exception	{
		
		bvo.setBoardNo(boardNo);
		// 로그인 상태(session 존재) => 조회수 업데이트
		if(session.getAttribute("session_user") != null) {
			bvo.setBoardHit(boardHit + 1);
			boardDao.boardHitUpdate(bvo);
		} 
		// bvo.getBfileCheck()의 결과가 0이 아니라면, uploadfileDao를 통해 UploadFileVO uvo를 model에 담아야 한다. 
		bvo = boardDao.boardSelect(bvo);
		model.addAttribute("board", bvo);
		if(bvo.getBfileCheck() != 0) {
			List<UploadfileVO> list = new ArrayList<>();
			uvo.setFileBoard(FILEBOARD);
			uvo.setFileBno(boardNo);
			list = uploadfileDao.uploadfileSelect(uvo);
			model.addAttribute("fileList", list);
		}
		// 본인이 작성한 게시글일 경우 => 수정하기 버튼도 view단에서 같이 구현한다. 
		return "home/member/memberBoardRead";
	}
	
	// 자유게시판 개별 게시글 첨부파일 모두 삭제
	@ResponseBody
	@RequestMapping(value = "uploadfileDelete.do", method = RequestMethod.GET, produces = "application/text; charset=utf-8")
	public String uploadfileDelete(UploadfileVO uvo, @RequestParam int boardNo) {
		logger.info("======================삭제할 글번호: " + boardNo);
		
		uvo.setFileBoard(FILEBOARD);
		uvo.setFileBno(boardNo);
		
		int n = uploadfileDao.uploadfileDelete(uvo);
		
		return (n==1) ? "success" : "fail";
	}
	
	// 자유게시판 개별 게시글 삭제
	@ResponseBody
	@PostMapping(value = "boardDelete.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> boardDelete(@RequestBody BoardVO bvo){
		
		int n = boardDao.boardDelete(bvo);
		String message = (n==1) ? "success" : "fail";
		if(n == 1) {
			return new ResponseEntity<String>(message, HttpStatus.OK);
		}else {
			return new ResponseEntity<String>(message, HttpStatus.NOT_IMPLEMENTED);
		}
	}
	
	// 자유게시판 첨부파일 썸네일 이미지 호출
	@GetMapping("thumbnailDisplay.do")
	public ResponseEntity<byte[]> thumbnailDisplay(String thumbfilecallpath) {
		logger.info("================================ 썸네일 파일 이름 확인: " + thumbfilecallpath);
		
		File file = new File(fileUploadPath, thumbfilecallpath);
		logger.info("======================== File 객체 값: " + file);
		ResponseEntity<byte[]> result = null;
		
		try {
			HttpHeaders header = new HttpHeaders();
			
			header.add("Content-type", Files.probeContentType(file.toPath()));
			result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);
		} catch (IOException e) {
			logger.info("================= 예외 발생");
			e.printStackTrace();
		}
		return result;
	}
	
	// 자유게시판 추천 클릭여부 확인
	@ResponseBody
	@GetMapping(value ="boardLikeitCheck.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> boardLikeCheck(BoardVO bvo, @RequestParam String boardLikeNick, @RequestParam int boardNo) {
		logger.info("================================================ boardLikeNick : " + boardLikeNick);
		logger.info("================================================ boardNo : " + boardNo);
		// 닉네임과 게시글 번호를 담아서, 존재여부 확인한다. 해당하는 값이 존재하면 css효과를 준다. 
		
		bvo.setBoardLikeNick(boardLikeNick);
		bvo.setBoardNo(boardNo);
		
		System.out.println("================== 조회 결과: " + boardDao.boardLikeCheck(bvo));
		String result = String.valueOf(boardDao.boardLikeCheck(bvo));
		System.out.println("================== string으로 변환한 조회 결과: " + result);
		
		
		if(result.equals("null")) {
			logger.info("============ 데이터 없음" );
			result = "0";
			return new ResponseEntity<String>(result, HttpStatus.OK);
		} else {
			logger.info("================================= 찾은 값 : " +  result);
			return new ResponseEntity<String>(result,HttpStatus.OK);
		}
	}
	
	// 자유게시판 추천 업데이트
	@ResponseBody
	@RequestMapping(value = "boardLikeitUpdate.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> boardLikeitUpdate(BoardVO bvo 
										,@RequestParam("nickname") String nickname
										,@RequestParam("boardNo") int boardNo
										,@RequestParam("clickValue") int clickValue
										,@RequestParam("checkHiddenLike") int checkHiddenLike){
		JsonObject json = new JsonObject();
		
		
		logger.info("============================== clickValue " + clickValue);
		logger.info("============================== checkHiddenLike " + checkHiddenLike);
		
		// 경우의 수 1) hidden이 0인 경우 => insert(board_likeit) => update(board)
		// 경우의 수 2) hidden과 click값이 같은 경우 => delete(board_likeit) => update(board);
		bvo.setBoardNo(boardNo);
		// update전 게시글 추천수 조회
		int likeCount = boardDao.boardSelect(bvo).getBoardLikeit();
		logger.info("============================== DML 작업 이전 기존 테이블의 좋아요 값: " + likeCount);
		bvo.setBoardLikeNick(nickname);
		bvo.setBoardLikeValue(clickValue);
		if( checkHiddenLike == 0) {  // 추천테이블 insert, 게시판테이블 update
			// 추천 테이블에 row데이터 추가
			int n = boardDao.boardLikeitInsert(bvo);
			logger.info("=========================== n값: " + n);
			if(n == 1) {
				// board 테이블의 추천수값 업데이트
				if( clickValue == 1) {
					likeCount = likeCount + 1;
				}else {
					likeCount = likeCount -1;
				}
				logger.info("============================== insert 후 수정할 count값 : " + likeCount);
				bvo.setBoardLikeit(likeCount);
				int m = boardDao.boardLikeitUpdate(bvo);
				logger.info("=========================== m값: " + m);
				if(m == 1 ) {
					json.addProperty("method", "insert");
					json.addProperty("likeCount", likeCount);
					json.addProperty("newHiddenValue", clickValue);
					return new ResponseEntity<String>(json.toString(), HttpStatus.OK);
				}
			} 
		} else {  // hiddenClick != 0 인 경우, 즉 hiddenClick과 clickValue의 같이 같다 => delete(추천), update(게시판)
			int n = boardDao.boardLikeitDelete(bvo);
			logger.info("=========================== n값: " + n);
			if( n == 1) {
				logger.info("============================== delete 전 count값 : " + likeCount);
				if( clickValue == 1) {
					likeCount--;
				}else {
					likeCount++;
				}
				logger.info("============================== delete 후 count값 : " + likeCount);
				bvo.setBoardLikeit(likeCount);
				int m = boardDao.boardLikeitUpdate(bvo);
				logger.info("=========================== m값: " + m);
				if(m == 1) {
					json.addProperty("method", "delete");
					json.addProperty("likeCount", likeCount);
					json.addProperty("newHiddenValue", 0);
					return new ResponseEntity<String>(json.toString(), HttpStatus.OK);
				}
			}
		}
		
		return new ResponseEntity<String>("fail", HttpStatus.ACCEPTED);
		
	}
	
	
	
}
