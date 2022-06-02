package co.bada.leejava.notice;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

}
