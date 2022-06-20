package co.bada.leejava.totolist;

public interface TodoService {
	// insert, delete, update, todoSelect 있어야 할 듯. 
	// todolist 추가
	int todoInsert(TodoVO tvo);
	// todolist 수정
	int todoUpdate(TodoVO tvo); 
	// todolist 삭제
	int todoDelete(TodoVO tvo);
	// 회원별 => todolist 조회 
	TodoVO todoSelect(TodoVO tvo);
}
