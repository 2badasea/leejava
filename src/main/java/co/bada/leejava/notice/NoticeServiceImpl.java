package co.bada.leejava.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import co.bada.leejava.Search;

// noticeDao 라는 이름으로 IOC 컨테이너에 등록된다. 
// 컨트롤러에서 의존성 주입 가능. autowired하면 관련된 설정이 따라온다. 
@Repository("noticeDao")
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	NoticeMapper map;

	@Override
	public List<NoticeVO> noticeSelectList() {
		// TODO Auto-generated method stub
		return map.noticeSelectList();
	}

	@Override
	public NoticeVO noticeSelect(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return map.noticeSelect(nvo);
	}

	@Override
	public int noticeInsert(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return map.noticeInsert(nvo);
	}

	@Override
	public int noticeUpdate(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return map.noticeUpdate(nvo);
	}

	@Override
	public int noticeDelete(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return map.noticeDelete(nvo);
	}

	@Override
	public int ajaxNoticeFileDelete(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return map.ajaxNoticeFileDelete(nvo);
	}

	@Override
	public int ajaxNoticeFixed(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return map.ajaxNoticeFixed(nvo);
	}

	@Override
	public int noticeHitUpdate(NoticeVO nvo) {
		// TODO Auto-generated method stub
		return map.noticeHitUpdate(nvo);
	}

	@Override
	public List<NoticeVO> mainNoticeSelectList() {
		// TODO Auto-generated method stub
		return map.mainNoticeSelectList();
	}

	@Override
	public int getNoticeListCnt(Search svo) throws Exception {
		// TODO Auto-generated method stub
		return map.getNoticeListCnt(svo);
	}

	@Override
	public List<NoticeVO> noticeSearchSelect(Search svo) throws Exception {
		// TODO Auto-generated method stub
		return map.noticeSearchSelect(svo);
	}

	@Override
	public int getUserNoticeListCnt(Search svo) throws Exception {
		// TODO Auto-generated method stub
		return map.getUserNoticeListCnt(svo);
	}

	@Override
	public List<NoticeVO> userNoticeSearchSelect(Search svo) throws Exception {
		// TODO Auto-generated method stub
		return map.userNoticeSearchSelect(svo);
	}

}
