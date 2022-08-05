package co.bada.leejava.web;

import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
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
	
	// 유지보수 게시판 개별 데이터 조회 
	@GetMapping(value = "repairList.do", produces = MediaType.APPLICATION_JSON_VALUE )
	public ResponseEntity<RepairVO> repairList(@RequestParam int rno, RepairVO rvo){
		logger.info("view단에서 넘어온 rno의 값: " + rno);
		rvo.setRno(rno);
		return new ResponseEntity<RepairVO>( repairDao.repairList(rvo), HttpStatus.OK );
	}
	
	// 유지보수 게시판  선택 완료 구현 
	@PostMapping(value = "repairListcheckedAry.do", produces = "application/text; charset=utf-8")
	public  ResponseEntity<String> repairListcheckedAry(RepairVO rvo,
				@RequestParam("checkedAry[]") List<String> checkedAry,
				@RequestParam("rstatus") String rstatus){
		int rno;
		String message = "YES";
		for(String i : checkedAry) {
			rno = Integer.parseInt(i);
			rvo.setRno(rno);
			rvo.setRstatus(rstatus);
			int n = repairDao.repairListUpdate(rvo);
			if(n != 1) {	
				logger.info("에러 발생");
				message = "NO";
			}
		}
		return new ResponseEntity<String>(message, HttpStatus.OK);
	}
	
	// 유지보수 게시판 선택 삭제 구현
	@PostMapping(value = "repairListcheckedAryDelete.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> repairListcheckedAryDelete(RepairVO rvo,
			@RequestParam("checkedArray[]") List<String> checkedArray){
		logger.info("view단에서 넘어온 배열 확인: " + checkedArray);
		
		int rno = 0;
		String message = "성공적으로 삭제되었습니다.";
		for(String i : checkedArray) {
			rno = Integer.parseInt(i);
			rvo.setRno(rno);
			int n = repairDao.repairListDelete(rvo);
			if(n != 1) {
				logger.info("에러 발생");
				message = rno + "번 게시글 처리 중 에러가 발생했습니다.";
			}
		}
		return new ResponseEntity<String>(message, HttpStatus.OK);
	}
	
	// 유지보수 게시글 개별 업데이트
	@PutMapping(value = "repairListUpdate.do", produces = "application/text; charset=utf-8")
	public ResponseEntity<String> repairListUpdate(@RequestBody RepairVO rvo){
		logger.info("넘어온 값: " + rvo);
		int n = repairDao.repairListUpdate(rvo);
		String message = "업데이트 되었습니다.";
		if(n != 1) {
			message = "실패";
			return new ResponseEntity<String>(message, HttpStatus.NOT_MODIFIED);
		}
		return new ResponseEntity<String>(message, HttpStatus.OK);
		
	}
}
