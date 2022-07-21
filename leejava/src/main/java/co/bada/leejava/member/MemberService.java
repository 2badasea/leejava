package co.bada.leejava.member;

import java.util.List;

import co.bada.leejava.AttachImageVO;

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
	int ajaxNewPasswordUpdate(MemberVO mvo);  // 새로운 비밀번호 변경 => salt값, 다이제스트암호값 업데이트
	MemberVO memberMyInfoList(MemberVO mvo); // 단순 개인정보랑 약관동의 여부 모두 체크. 
	int ajaxNicknameUpdate(MemberVO mvo); // 개인정보 페이지 => 닉네임 변경 신청
	int profileInsert(AttachImageVO ivo);
	int ajaxImageEnroll(AttachImageVO ivo); // 프로필 이미지 등록
	/* 이미지 데이터 반환*/
	List<AttachImageVO> getAttachList(String m_email);
	// 프로필 이미지 정보 존재하는지 체크
	boolean profileImageCheck(AttachImageVO ivo);
	// 프로필 이미지 정보 신규 추가 
	int insertProfileImage(AttachImageVO ivo);
	// 프로필 이미지 정보 업데이트
	int updateProfileImage(AttachImageVO ivo); 
	// 개인정보동의, 프로모션 동의여부 업데이트 
	int ajaxJoinTermsUpdate(MemberVO mvo);
	// 닉네임으로 이메일 조회
	MemberVO emailSelectByNickname(MemberVO mvo);
	// 사용자 정보 조회(이메일, 닉네임, 가입날짜, 소개글, 프로필이미지 정보) 
	MemberVO memberInfoSelect(MemberVO mvo);
	// 퀴즈카드 정보 가져오기
	MemberVO quizcardInfoSelect(MemberVO mvo);
	// 이메일과 다이제스트 암호로 정보 체크 
	boolean ajaxPwdCheck(MemberVO mvo);
}
