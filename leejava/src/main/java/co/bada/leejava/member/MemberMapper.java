package co.bada.leejava.member;

import java.util.List;

import co.bada.leejava.AttachImageVO;

public interface MemberMapper {
	List<MemberVO> memberSelectList();		// 회원 리스트 나열
	MemberVO memberSelect(MemberVO mvo);	// 로그인 or 닉네임중복 확인 
	int memberInsert(MemberVO mvo);			// 회원가입 추가
	int memberUpdate(MemberVO mvo);			// 회원정보 변경
	int memberDelete(MemberVO mvo);			// 회원탈퇴 
	boolean memberEmailCheck(MemberVO mvo);	// 회원가입 시 이메일 중복 확인
	boolean memberNicknameCheck(MemberVO mvo); // 닉네임 중복체크
	int memberJointerms(MemberVO mvo);  	// 가입약관 넣기
	String selectSalt(MemberVO mvo);		// 이메일 아이디를 통해서 salt값 조회
	List<MemberVO> v_memberSelectList(); 	// 뷰에 있는 회원정보 리스트 가져오기. 회원목록 페이지
	int ajaxNewPasswordUpdate(MemberVO mvo);  // 새로운 비밀번호 변경 => salt값, 다이제스트암호값 업데이트
	MemberVO memberMyInfoList(MemberVO mvo); // 단순 개인정보랑 약관동의 여부 모두 체크. 
	int ajaxNicknameUpdate(MemberVO mvo); // 개인정보 페이지 => 닉네임 변경 신청
	/* 이미지 정보 등록 */ 
	// 파라미터로는 이미지 정보가 담긴 AttachImageVO 클래스를 지정. 
	int profileInsert(AttachImageVO ivo);
	int ajaxImageEnroll(AttachImageVO ivo);
	/* 이미지 데이터 반환*/
	List<AttachImageVO> getAttachList(String m_email);
	// 프로필 이미지 정보 존재하는지 체크
	boolean profileImageCheck(AttachImageVO ivo);
	// 프로필 이미지 정보 신규 추가 
	int insertProfileImage(AttachImageVO ivo);
	// 프로필 이미지 정보 업데이트
	int updateProfileImage(AttachImageVO ivo); 
	
}
