package co.bada.leejava.repair;

import java.util.List;

public interface RepairService {
	// 전체 조회 
	List<RepairVO> repairSelectList();
	// 개별조회
	RepairVO repairSelect(RepairVO rvo);
	// 유지보수 목록 추가
	int repairInsert(RepairVO rvo);
	// 유지보수 목록 업데이트
	int repairUpdate(RepairVO rvo);
	// 유지보수 목록 삭제
	int repairDelete(RepairVO rvo);
}
