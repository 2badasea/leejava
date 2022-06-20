package co.bada.leejava.totolist;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("todoDao")
public class TodoServiceImpl implements TodoService {
	@Autowired
	TodoMapper map;

	@Override
	public int todoInsert(TodoVO tvo) {
		// TODO Auto-generated method stub
		return map.todoInsert(tvo);
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
}
