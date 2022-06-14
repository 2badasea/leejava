package co.bada.leejava.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class QuizletController {
	
	
	// 퀴즐렛 학습 페이지 이동
	@RequestMapping("/quizlet.do")
	public String quizlet(HttpServletRequest request, Model model) {
		
		// 아마도 tiles 오류 때문에 페이지를 못 찾는 것 같다. 
		// 현재 home에서 갈려나오는 각각의 페이지에 대해 타일즈 설정을 해주어야 한다. 
		return "home/quizlet/quizletHome";
	}
}
