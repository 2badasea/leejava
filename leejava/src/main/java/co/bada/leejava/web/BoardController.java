//package co.bada.leejava.web;
//
//import javax.servlet.http.HttpServletRequest;
//
//import org.springframework.beans.factory.annotation.Autowired;
//import org.springframework.stereotype.Controller;
//import org.springframework.ui.Model;
//import org.springframework.web.bind.annotation.RequestMapping;
//import org.springframework.web.bind.annotation.RequestMethod;
//import org.springframework.web.bind.annotation.RequestParam;
//
//import co.bada.leejava.Pagination;
//import co.bada.leejava.board.BoardService;
//import co.bada.leejava.board.BoardVO;
//
//@Controller
//public class BoardController {
//	@Autowired
//	BoardService boardDao;
//
//	BoardVO bvo = new BoardVO();
//
//@RequestMapping("/boardTestInsert.do")
//public String boardTestInsert(HttpServletRequest request, BoardVO bvo) { 
//	
//	// 카테고리, 제목, 내용, 작성자, 조회수, 좋아요수 
//	
//	
//	for(int i = 1; i<1233; i++) { 
//		bvo.setB_title(i + " 번째 게시물입니다.");
//		bvo.setB_content(i + " 번째 게시물입니다.");
//		bvo.setB_category("1");
//		bvo.setB_writer("1");
//		bvo.setB_hit(0);
//		bvo.setB_like(0);
//		
//		int n = boardDao.insertBoard(bvo);
//		if( n != 1) { 
//			System.out.println("오류 발생");
//		}
//		
//	}
//	return "redirect:home.do";
//}
//
//
////
//@RequestMapping(value = "getBoardList.do", method = RequestMethod.GET)
//public String getBoardList(Model model
//		, @RequestParam(required = false, defaultValue = "1") int page			
//		, @RequestParam(required = false, defaultValue = "1") int range		
//		) throws Exception {
//		
//	// 전체 게시글 개수
//	int listCnt = boardDao.getBoardListCnt();
//	
//	// Pagination 객체 생성
//	Pagination pagination = new Pagination();
//	pagination.pageInfo(page, range, listCnt);
//	
//	model.addAttribute("pagination", pagination);
//	model.addAttribute("boardList", boardDao.boardSelectList(pagination));
//	
//
//}
