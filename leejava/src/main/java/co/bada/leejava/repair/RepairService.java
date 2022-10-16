package co.bada.leejava.repair;

import java.util.List;

import co.bada.leejava.Search;

public interface RepairService {
	// 유지보수 게시판의 페이징을 출력하기 위한 사전정보 (총 게시글의 갯수 구하기)
	int getRepairListCnt(Search svo);
	//	유지보수 리스트 등록
	int repairInsert(RepairVO rvo);
	// 페이징 정보가 반영된, 화면에 출력시킬 기본적인 유지보수 리스트
	List<RepairVO> repairSearchSelect(Search svo);
	// 유지보수 리스트 개별 데이터 조회
	RepairVO repairList(RepairVO rvo);
	// 유지보수 게시판 개별 수정
	int repairListUpdate(RepairVO rvo);
	// 유지보수 게시판 개별 삭제
	int repairListDelete(RepairVO rvo);
}
