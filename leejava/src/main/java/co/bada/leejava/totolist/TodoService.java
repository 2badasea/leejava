package co.bada.leejava.totolist;

import java.util.List;

public interface TodoService {
	// insert, delete, update, todoSelect 있어야 할 듯. 
	// todolist 추가
	int todoInsertSeq(TodoVO tvo);
	// todolist 추가 => 기존에 데이터가 있는 경우, 최솟값을 찾아서 해당하는 no값을 삽입한다.
	int todoInsertMin(TodoVO tvo);
	// todolist 수정
	int todoUpdate(TodoVO tvo); 
	// todolist 삭제
	int todoDelete(TodoVO tvo);
	// 회원별 => todolist 조회  => 얘는 todolist버튼을 클릭했을 때, 회원별 todolist정보 전체를 뿌려주기 위함. => 그럼 List타입으로 해야함. ㅇ
	TodoVO todoSelect(TodoVO tvo);
	// 기존에 존재하는지 체크.
	
	// 그리고 DB에 저장되어 있는 회원별 전체 todolist정보도 가져오도록 한다. 최소0개~최대5개.  
	List<TodoVO> todoSelectList(TodoVO tvo);
	// 그리고 boolean타입으로 데이터가 데이터 insert가 처음인지 아닌지 판단
	boolean todoInsert(TodoVO tvo);
}
