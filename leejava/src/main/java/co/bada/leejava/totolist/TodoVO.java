package co.bada.leejava.totolist;

import lombok.Data;

@Data
public class TodoVO {
	// m_email, todo_no(int), todo_content, todo_status 	
	private String m_email;
	private int todo_no;
	private String todo_content;
	private String todo_status;
}
