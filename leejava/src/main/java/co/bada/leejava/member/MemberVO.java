package co.bada.leejava.member;

import lombok.Data;

@Data
public class MemberVO {
	private String m_email;		// 가입 이메일
	private String m_nickname;	// 닉네임
	private String m_password;	// 비밀번호
	private String m_joindate;	// 가입 날짜
	private String m_joinpath;  // 가입 경로(유형)
	private String m_phone;		// 연락처 
	private String m_address;	// 주소
	private String m_status; 	// 권한
	private String m_birthdate; // 생년월일
}
