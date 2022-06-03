package co.bada.leejava.member;

import java.util.List;

public interface MemberService {
	List<MemberVO> memberSelectList();		// 회원 리스트 나열
	MemberVO memberSelect(MemberVO mvo);	// 로그인 || 닉네임중복 확인 ||  한 개인의 정보 조회
	int memberInsert(MemberVO mvo);			// 회원가입 추가
	int memberUpdate(MemberVO mvo);			// 회원정보 변경
	int memberDelete(MemberVO mvo);			// 회원탈퇴 
	boolean memberEmailCheck(MemberVO mvo);	// 회원가입 시 이메일 중복 확인
	boolean memberNicknameCheck(MemberVO mvo); // 닉네임 중복체크
	int memberJointerms(MemberVO mvo);  	// 가입약관 넣기
	String selectSalt(MemberVO mvo);		// 이메일 아이디를 통해서 salt값 조회
	List<MemberVO> v_memberSelectList(); 	// 뷰에 있는 회원정보 리스트 가져오기. 회원목록 페이지
}
