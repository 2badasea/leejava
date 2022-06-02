package co.bada.leejava.notice;

import java.util.List;

// 얘는 매퍼로서 notice-map.xml과 연동됨. 
public interface NoticeMapper {
	// CRUD
	List<NoticeVO> noticeSelectList(); // 공지사항 전체 불러오기

	NoticeVO noticeSelect(NoticeVO nvo); // 공지사항 개별 게시글 조회

	int noticeInsert(NoticeVO nvo); // 공지사항 작성

	int noticeUpdate(NoticeVO nvo); // 공지사항 수정

	int noticeDelete(NoticeVO nvo); // 공지사항 삭제
	
	int ajaxNoticeFileDelete(NoticeVO nvo); // 공지사항 수정 시 첨부파일 삭제
}
