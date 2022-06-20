package co.bada.leejava.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import co.bada.leejava.member.MemberService;
import co.bada.leejava.totolist.TodoService;

@Controller
public class TotoController {
	@Autowired
	MemberService memberDao;
	@Autowired
	TodoService todoDao;
	
	// todo리스트 호출, 클릭. 보통의 경우 ajax로 많이 처리해야 할 듯
	
	
}
