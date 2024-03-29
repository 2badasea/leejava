package co.bada.leejava.notice;

import java.util.List;

import co.bada.leejava.Search;

// 얘는 매퍼로서 notice-map.xml과 연동됨. 
public interface NoticeMapper {
	// CRUD

	List<NoticeVO> noticeSelectList(); // 공지사항 전체 불러오기

	NoticeVO noticeSelect(NoticeVO nvo); // 공지사항 개별 게시글 조회

	int noticeInsert(NoticeVO nvo); // 공지사항 작성

	int noticeUpdate(NoticeVO nvo); // 공지사항 수정

	int noticeDelete(NoticeVO nvo); // 공지사항 삭제

	int ajaxNoticeFileDelete(NoticeVO nvo); // 공지사항 수정 시 첨부파일 삭제

	int ajaxNoticeFixed(NoticeVO nvo); // 공지사항 개별 고정처리

	int noticeHitUpdate(NoticeVO nvo); // 공지사항 클릭 => 조회수 증가 업데이트

	List<NoticeVO> mainNoticeSelectList(); // 메인화면에 노출시킬 6가지.

	// 공지사항 게시글 갯수 구하는 것. Paging객체의 pageInfo()의 매개변수로 사용된다.
	int getNoticeListCnt(Search svo) throws Exception;

	// 페이징 처리를 한 것을 기준으로 리스트를 해당 view페이지에 출력한다.
	public List<NoticeVO> noticeSearchSelect(Search svo) throws Exception;
	
	// 사용자 공지사항에 출력시킬 게시글의 총 갯수 => 검색조건이 하나 더 있어서 별도로 정의
	int getUserNoticeListCnt(Search svo) throws Exception;
	
	// 사용자 공지사항에 출력시킬 게시글 리스트(위의 게시글이 총 갯수를 감안하여 페이징 처리된 결과 리스트 
	public List<NoticeVO> userNoticeSearchSelect(Search svo) throws Exception;

}
