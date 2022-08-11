package co.bada.leejava.banner;

import java.util.List;

import co.bada.leejava.Search;

public interface BannerMapper {

	// 배너이미지 신청 insert
	int bannerInsert(BannerVO bvo);
	// 회원별로 배너신청 내역 조회
	List<BannerVO> bannerimageSelect(BannerVO bvo);
	// 사용자뷰 배너 신청 현황 조회
	BannerVO bannerApplySelect(BannerVO bvo);
	// 페이징 처리를 위한 데이터 rowdate 갯수 확인
	int getListCnt();
	// 실제 페이징 처리 이후에 화면에 뿌려줄 데이터 리스트 조회 
	List<BannerVO> bannerApplyList(Search svo);
	// 배너 상태값 변경 이벤트 
	int bannerUpdate(BannerVO bvo);
}
