package co.bada.leejava.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import co.bada.leejava.repair.RepairService;

@RestController
public class RepairRestController {
	@Autowired
	RepairService repairDao;
	
	
	private static final Logger logger = LoggerFactory.getLogger(RepairRestController.class);
	
	
	
}
