package co.bada.leejava.banner;

import java.util.List;

public interface BannerService {

	// 배너이미지 신청 insert
	int bannerInsert(BannerVO bvo);
	// 회원별로 배너신청 내역 조회
	List<BannerVO> bannerimageSelect(BannerVO bvo);
	// 관리자뷰 배너 현황 리스트 화면에 모두 출력시키기
	
}
