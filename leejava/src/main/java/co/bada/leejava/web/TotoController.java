package co.bada.leejava.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import co.bada.leejava.member.MemberService;
import co.bada.leejava.notice.NoticeService;
import co.bada.leejava.totolist.TodoService;
import co.bada.leejava.totolist.TodoVO;

@Controller
public class TotoController {
	@Autowired
	MemberService memberDao;
	@Autowired
	TodoService todoDao;
	@Autowired
	NoticeService noticeDao;

	private static final Logger logger = LoggerFactory.getLogger(TotoController.class);

	// todolist ajaxInsert 요청 by sidebarTemplate.jsp
	// return으로 데이터 반환할 때, no값이랑 todo_content값 넘기기.
	@RequestMapping(value = "/ajaxInsert.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<TodoVO>> ajaxInsert(TodoVO tvo, @RequestParam("m_email") String m_email,
			@RequestParam("todo_content") String todo_content) {

		List<TodoVO> list = new ArrayList<>();
		logger.info("=========================  m_email확인: " + m_email);
		logger.info("========================= todo_content확인: " + todo_content);

		// vo객체에 담아서 우선 기존에 데이터가 존재하는지 체크후에 서로 다른 insert를 행한다.
		tvo.setM_email(m_email);
		boolean b = todoDao.todoInsert(tvo);
		logger.info("===============   BOOLEAN 타입으로 조회 => 기존에 데이터가 0(null)이라면 b값은 true, 존재했다면 falae =>  " + b);
		int todo_no;
		if (!b) {
			// 기존에 데이터가 존재하는 경우. todoInsertMin 호출 => min값으로 넣는다.
			// 다음으로 들어갈 todo_no값을 구하는쿼리를 이용하여 값을 구하고, 그 값을 list객체에 넣는다.
			// DB단에서 처리하는 것과 별개로, view단에 값을 넘기기 위해서 값을 받아온다. => 더 좋은 방법이 있을진 모르겠지만...
			todo_no = todoDao.nextTodo_no(tvo);
			tvo.setTodo_no(todo_no);
			tvo.setTodo_content(todo_content); //
			int n = todoDao.todoInsertMin(tvo);
			if (n != 0) {
				logger.info("=================== todoInserMin 성공");
				list.add(tvo);
				logger.info("반환할 list 조회: " + list);
				ResponseEntity<List<TodoVO>> result = new ResponseEntity<List<TodoVO>>(list, HttpStatus.OK);
				// 이때 return문은 json형태로 반환될 것이다.
				return result;
			} else {
				logger.info("=================== todoInserMin 실패");
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
			}

		} else { // tvo객체가 null인 경우 => 새로운 TodoVO 타입의 tvo객체를 생성해서 이번엔 todoInsertSeq작업.
			// 첫 데이터가 삽입되는 경우 => seq에 따라 들어간다.
			logger.info("============================= else 문에도 안 왔을 것이다. ");
			TodoVO tvo2 = new TodoVO();
			tvo2.setM_email(m_email);
			tvo2.setTodo_content(todo_content);
			todo_no = 1;
			tvo2.setTodo_no(todo_no);
			int m = todoDao.todoInsertSeq(tvo2);
			if (m != 0) {
				logger.info("=================== todoInserSeq 성공");
				list.add(tvo2);
				logger.info("반환할 list 조회: " + list);
				ResponseEntity<List<TodoVO>> result = new ResponseEntity<List<TodoVO>>(list, HttpStatus.OK);
				// 이때 return문은 json형태로 반환될 것이다.
				return result;
			} else {
				logger.info("=================== todoInserSeq 실패");
				return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
			}
		}
	}

// todoList버튼 클릭하자마자 해당 유저의 todolist들을 화면에 뿌려준다.
	// 이번에도 ResonseEntity타입으로 반환하고, json타입으로 반환하기 때문에, produces속성을 추가하였다.
	@RequestMapping(value = "/ajaxTodolist.do", produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<List<TodoVO>> ajaxTodolist(TodoVO tvo, HttpServletRequest request,
			@RequestParam("m_email") String m_email) {
		// list자료구조를 생성한다. 여기에 vo값들을 담아서 보낼 것이다.
		List<TodoVO> list = new ArrayList<>();

		logger.info("==================== ajax로 넘어온 이메일 값 확인: " + m_email);
		tvo.setM_email(m_email);
		list = todoDao.todoSelectList(tvo);
		logger.info("====================== list값 조회: " + list);

		// 그럼 list랑 httpstatus값을 반환하면 될 것 같다.
		ResponseEntity<List<TodoVO>> result = new ResponseEntity<List<TodoVO>>(list, HttpStatus.OK);
		logger.info("=========== result값 조회: " + result);
		return result;
	}

// todolist 삭제하가  ajax호출
	@ResponseBody
	@RequestMapping("/ajaxTodoDelete.do")
	public String ajaxTodoDelete(TodoVO tvo, HttpServletRequest request, @RequestParam("m_email") String m_email,
			@RequestParam("todo_no") int todo_no) {

		logger.info("===============  삭제하려고 날아온 이메일: " + m_email + " , todo_no값: " + todo_no);
		tvo.setM_email(m_email);
		tvo.setTodo_no(todo_no);
		String result = null;
		int n = todoDao.todoDelete(tvo);
		logger.info("=============  delete 결과 조회: " + n);
		if (n != 0) {
			result = "OK";
		} else {
			result = "NO";
		}
		return result;
	}

// todolist status값 업데이트 
	@ResponseBody
	@RequestMapping("/ajaxTodoUpdate.do")
	public String ajaxTodoUpdate(TodoVO tvo, HttpServletRequest request, @RequestParam("m_email") String m_email,
			@RequestParam("todo_no") int todo_no,
			@RequestParam(value = "todo_status", required = false) String todo_status,
			@RequestParam(value = "todo_content", required = false) String todo_content) {

		logger.info("========== 날라온 값 확인: " + m_email + ", todo_no: " + todo_no + ", todo_status: " + todo_status
				+ " , todo_content: " + todo_content);
		tvo.setM_email(m_email);
		tvo.setTodo_no(todo_no);
		tvo.setTodo_status(todo_status);
		tvo.setTodo_content(todo_content);

		String result = null;
		int n = todoDao.todoUpdate(tvo);
		logger.info("========== 업데이트 뒤 todo_status 값 조회: " + todo_status);
		if (n != 0) {
			if (todo_status != null) {
				if (todo_status.equals("active")) {
					result = "active";
				} else if (todo_status.equals("non-active")) {
					result = "non-active";
				}
			} else {
				result = "OK"; // 이때는 todo_content만 업데이트 되었던 경우.
			}
		}
		logger.info("========== result 값 조회 : " + result);
		return result;
	}

}
