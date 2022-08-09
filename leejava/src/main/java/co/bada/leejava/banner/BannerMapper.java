package co.bada.leejava.banner;

import java.util.List;

public interface BannerMapper {

	// 배너이미지 신청 insert
	int bannerInsert(BannerVO bvo);
	// 회원별로 배너신청 내역 조회
	List<BannerVO> bannerimageSelect(BannerVO bvo);
}
