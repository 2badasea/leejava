package co.bada.leejava.web;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import co.bada.leejava.repair.RepairService;
import co.bada.leejava.repair.RepairVO;

@RestController
public class RepairRestController {
	@Autowired
	RepairService repairDao;
	
	
	private static final Logger logger = LoggerFactory.getLogger(RepairRestController.class);
	
	@PostMapping(value = "repairList.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> repairList(@RequestBody RepairVO rvo){
		logger.info("view단에서 넘어온 rvo값 조회: " + rvo);
		int n = repairDao.repairInsert(rvo);
		String message = "";
		if(n != 1) {
			message = "NO";
			return new ResponseEntity<String>(message, HttpStatus.NOT_IMPLEMENTED);
		} else {
			message = "YES";
			return new ResponseEntity<String> (message , HttpStatus.OK);
		}
//		return ResponseEntity.ok().body(rvo); => 리턴타입만 바꾸면 이렇게도 리턴이 가능하다.
	}
	
}
