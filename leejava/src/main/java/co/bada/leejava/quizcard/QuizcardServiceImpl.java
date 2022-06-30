package co.bada.leejava.quizcard;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("quizcardDao")
public class QuizcardServiceImpl implements QuizcardService {
	@Autowired
	QuizcardMapper map;

	@Override
	public int quizcardSetCreate(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.quizcardSetCreate(qvo);
	}

	@Override
	public int quizcardSetNoGet() {
		// TODO Auto-generated method stub
		return map.quizcardSetNoGet();
	}

	@Override
	public int quizcardCategory(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.quizcardCategory(qvo);
	}

	@Override
	public QuizcardVO quizcardSelect(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.quizcardSelect(qvo);
	}

	@Override
	public int firstQuestionInsert(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.firstQuestionInsert(qvo);
	}
}
