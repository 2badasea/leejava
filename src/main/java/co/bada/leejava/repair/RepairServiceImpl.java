package co.bada.leejava.repair;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import co.bada.leejava.Search;

@Repository("repairDao")
public class RepairServiceImpl implements RepairService {
	@Autowired
	private RepairMapper map;
	
	@Override
	public int getRepairListCnt(Search svo) {
		// TODO Auto-generated method stub
		return map.getRepairListCnt(svo);
	}

	@Override
	public int repairInsert(RepairVO rvo) {
		// TODO Auto-generated method stub
		return map.repairInsert(rvo);
	}

	@Override
	public List<RepairVO> repairSearchSelect(Search svo) {
		// TODO Auto-generated method stub
		return map.repairSearchSelect(svo);
	}

	@Override
	public RepairVO repairList(RepairVO rvo) {
		// TODO Auto-generated method stub
		return map.repairList(rvo);
	}

	@Override
	public int repairListUpdate(RepairVO rvo) {
		// TODO Auto-generated method stub
		return map.repairListUpdate(rvo);
	}

	@Override
	public int repairListDelete(RepairVO rvo) {
		// TODO Auto-generated method stub
		return map.repairListDelete(rvo);
	}
	
}
