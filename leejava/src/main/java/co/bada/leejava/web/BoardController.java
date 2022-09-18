package co.bada.leejava.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import co.bada.leejava.Search;
import co.bada.leejava.board.BoardService;
import co.bada.leejava.board.BoardVO;

@Controller
public class BoardController {
	@Autowired
	BoardService boardDao;
	
	// 자유게시판 이동
	@RequestMapping(value = "boardList.do", method = { RequestMethod.GET, RequestMethod.POST} )
	public String boardList(Model model, BoardVO bvo, Search svo) {
		
		return "home/member/boardList";
	}
	
}
