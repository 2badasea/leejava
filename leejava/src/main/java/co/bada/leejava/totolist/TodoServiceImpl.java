package co.bada.leejava.totolist;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("todoDao")
public class TodoServiceImpl implements TodoService {
	@Autowired
	TodoMapper map;

	@Override
	public int todoInsertSeq(TodoVO tvo) {
		// TODO Auto-generated method stub
		return map.todoInsertSeq(tvo);
	}

	@Override
	public int todoUpdate(TodoVO tvo) {
		// TODO Auto-generated method stub
		return map.todoUpdate(tvo);
	}

	@Override
	public int todoDelete(TodoVO tvo) {
		// TODO Auto-generated method stub
		return map.todoDelete(tvo);
	}

	@Override
	public TodoVO todoSelect(TodoVO tvo) {
		// TODO Auto-generated method stub
		return map.todoSelect(tvo);
	}

	@Override
	public int todoInsertMin(TodoVO tvo) {
		// TODO Auto-generated method stub
		return map.todoInsertMin(tvo);
	}

	@Override
	public List<TodoVO> todoSelectList(TodoVO tvo) {
		// TODO Auto-generated method stub
		return map.todoSelectList(tvo);
	}

	@Override
	public boolean todoInsert(TodoVO tvo) {
		// TODO Auto-generated method stub
		return map.todoInsert(tvo);
	}

	@Override
	public int nextTodo_no(TodoVO tvo) {
		// TODO Auto-generated method stub
		return map.nextTodo_no(tvo);
	}
}
