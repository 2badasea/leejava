package co.bada.leejava.repair;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("repairDao")
public class RepairServiceImpl implements RepairService {
	@Autowired
	private RepairMapper map;
	
	@Override
	public List<RepairVO> repairSelectList() {
		// TODO Auto-generated method stub
		return map.repairSelectList();
	}

	@Override
	public RepairVO repairSelect(RepairVO rvo) {
		// TODO Auto-generated method stub
		return map.repairSelect(rvo);
	}

	@Override
	public int repairInsert(RepairVO rvo) {
		// TODO Auto-generated method stub
		return map.repairInsert(rvo);
	}

	@Override
	public int repairUpdate(RepairVO rvo) {
		// TODO Auto-generated method stub
		return map.repairUpdate(rvo);
	}

	@Override
	public int repairDelete(RepairVO rvo) {
		// TODO Auto-generated method stub
		return map.repairDelete(rvo);
	}
	
	
	
}
