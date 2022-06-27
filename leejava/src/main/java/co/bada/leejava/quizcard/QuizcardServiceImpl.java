package co.bada.leejava.quizcard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("quizcardDao")
public class QuizcardServiceImpl implements QuizcardService {
	@Autowired
	QuizcardMapper map;
}
