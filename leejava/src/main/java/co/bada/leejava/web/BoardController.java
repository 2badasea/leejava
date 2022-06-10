package co.bada.leejava.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import co.bada.leejava.Pagination;
import co.bada.leejava.board.BoardService;
import co.bada.leejava.board.BoardVO;

@Controller
public class BoardController {
	@Autowired
	BoardService boardDao;
	
	//  자유게시판으로 이동
	@RequestMapping("/boardList.do")
	public String boardList(Model model, BoardVO bvo
			// view에서 보내온 데이터 중에 'page'를 받는다는 뜻이다. 동시에 반드시 화면에서 넘어올 필요는 없고,
			// 데이터가 없을 경우 기본값을로 '1'을 세팅한다는 의미. 
			, @RequestParam(required = false, defaultValue = "1") int page			
			, @RequestParam(required = false, defaultValue = "1") int range
			) throws Exception { 
		
		
		// 전체 게시글 갯수
		int listCnt = boardDao.getBoardListCnt(); 
		
		// Pagination 객체 생성 및 페이징 정보 셋팅
		Pagination pagination = new Pagination();
		// @RequestParam으로 받은 page, range, 그리고 mapper로 받은 listCnt. 
		pagination.pageInfo(page, range, listCnt);
		
		model.addAttribute("pagination", pagination);
		model.addAttribute("boardList", boardDao.getBoardList(pagination));
		
		
		return "home/boardList";
	}
	

}
