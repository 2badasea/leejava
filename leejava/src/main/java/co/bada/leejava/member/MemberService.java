package co.bada.leejava.member;

import java.util.List;

public interface MemberService {
	List<MemberVO> memberSelectList();		// 회원 리스트 나열
	MemberVO memberSelect(MemberVO mvo);	// 로그인 or 닉네임중복 확인 
	int memberInsert(MemberVO mvo);			// 회원가입 추가
	int memberUpdate(MemberVO mvo);			// 회원정보 변경
	int memberDelete(MemberVO mvo);			// 회원탈퇴 
	boolean memberEmailCheck(MemberVO mvo);	// 회원가입 시 이메일 중복 확인
}
