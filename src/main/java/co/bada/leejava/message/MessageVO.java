package co.bada.leejava.message;

import lombok.Data;

@Data
public class MessageVO {
	
	private int msgno;   			// 인덱스 번호.
	private String msgdate;			// 메시지 작성날짜
	private String fromnick;		// 보내는 사람 닉네임
	private String tonick;			// 받는 사람 닉네임
	private String msgtitle;		// 메시지 제목
	private String msgcontent;		// 메시지 내용
	private int msgcheck;			// 메시지 읽음여부 확인 '0' or '1'
}
