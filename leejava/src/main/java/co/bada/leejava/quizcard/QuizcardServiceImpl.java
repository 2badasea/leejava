package co.bada.leejava.quizcard;

import java.util.List;

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

	@Override
	public List<QuizcardVO> quizcardList() {
		// TODO Auto-generated method stub
		return map.quizcardList();
	}

	@Override
	public List<QuizcardVO> ajaxMyQuizcard(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxMyQuizcard(qvo);
	}

	@Override
	public int quizcardQuestionCount(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.quizcardQuestionCount(qvo);
	}

	@Override
	public int quizcardReplyCount(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.quizcardReplyCount(qvo);
	}

	@Override
	public QuizcardVO quizcardBeforeInfo(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.quizcardBeforeInfo(qvo);
	}

	@Override
	public List<QuizcardVO> quizcardQuestionList(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.quizcardQuestionList(qvo);
	}

	@Override
	public int ajaxQuestionUpdate(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxQuestionUpdate(qvo);
	}

	@Override
	public int ajaxQuestionNew(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxQuestionNew(qvo);
	}

	@Override
	public int ajaxQuestionDel(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxQuestionDel(qvo);
	}

	@Override
	public int ajaxUpdateQuestionNo(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxUpdateQuestionNo(qvo);
	}

	@Override
	public int quizcardUdateChange(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.quizcardUdateChange(qvo);
	}

	@Override
	public int quizcardHitUpdate(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.quizcardHitUpdate(qvo);
	}

	@Override
	public QuizcardVO ajaxStudyStart(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxStudyStart(qvo);
	}

	@Override
	public int ajaxQuizInfoUpdate(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxQuizInfoUpdate(qvo);
	}

	@Override
	public QuizcardVO ajaxWrongQuestion(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxWrongQuestion(qvo);
	}

	@Override
	public boolean ajaxScrapSelect(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxScrapSelect(qvo);
	}

	@Override
	public int ajaxScrapAdd(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxScrapAdd(qvo);
	}

	@Override
	public List<QuizcardVO> questionNameList(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.questionNameList(qvo);
	}

	@Override
	public int ajaxBookmarkAdd(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxBookmarkAdd(qvo);
	}

	@Override
	public int ajaxBookmarkDelete(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxBookmarkDelete(qvo);
	}

	@Override
	public boolean ajaxBookmarkStatus(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxBookmarkStatus(qvo);
	}

	@Override
	public boolean ajaxLikeitCheck(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxLikeitCheck(qvo);
	}

	@Override
	public int ajaxLikeitAdd(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxLikeitAdd(qvo);
	}

	@Override
	public int quizcardLikeitUpdate(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.quizcardLikeitUpdate(qvo);
	}

	@Override
	public List<QuizcardVO> ajaxBookmark(QuizcardVO qvo) {
		// TODO Auto-generated method stub
		return map.ajaxBookmark(qvo);
	}



}
