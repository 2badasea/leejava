package co.bada.leejava.repair;

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
	
}
