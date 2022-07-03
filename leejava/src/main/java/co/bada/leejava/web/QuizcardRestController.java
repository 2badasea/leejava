package co.bada.leejava.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import co.bada.leejava.quizcard.QuizcardService;

// Quizcard와 관련된 RESTApi 관련 메서드들은 모두 여기로 정의.
@RestController
public class QuizcardRestController {
	@Autowired
	QuizcardService quizcardDao;
	
	private static final Logger logger = LoggerFactory.getLogger(QuizcardController.class);

	
	// 
}
