package co.bada.leejava.repair;

import co.bada.leejava.Search;

public interface RepairMapper {
	// 유지보수 게시판의 페이징을 출력하기 위한 사전정보 (총 게시글의 갯수 구하기)
	int getRepairListCnt(Search svo);
	//	유지보수 리스트 등록
	int repairInsert(RepairVO rvo);
}

