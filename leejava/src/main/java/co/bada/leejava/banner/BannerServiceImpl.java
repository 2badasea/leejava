package co.bada.leejava.banner;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("bannerDao")
public class BannerServiceImpl implements BannerService {
	@Autowired
	BannerMapper map;

	@Override
	public int bannerInsert(BannerVO bvo) {
		// TODO Auto-generated method stub
		return map.bannerInsert(bvo);
	}

	@Override
	public List<BannerVO> bannerimageSelect(BannerVO bvo) {
		// TODO Auto-generated method stub
		return map.bannerimageSelect(bvo);
	}
}
