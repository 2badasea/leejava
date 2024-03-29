package co.bada.leejava.member;

import java.util.List;

import co.bada.leejava.AttachImageVO;
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
	private String m_salt; 		// 암호화를 위해 생성한 salt값
	private String m_intro;
	
	// 가입약관 동의여부
	private String m_privacy; // 개인정보 유효기간
	private String m_promotion; // 프로모션 수신 여부
	
	/* 이미지 정보 	*/
	private List<AttachImageVO> imageList; 
}
