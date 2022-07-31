package co.bada.leejava.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import co.bada.leejava.AttachImageVO;
import co.bada.leejava.Search;

@Repository("memberDao")
public class MemberServiceImpl implements MemberService {
	@Autowired
	MemberMapper map;
	
	@Override
	public List<MemberVO> memberSelectList() {
		// TODO Auto-generated method stub
		return map.memberSelectList();
	}

	@Override
	public MemberVO memberSelect(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.memberSelect(mvo);
	}

	@Override
	public int memberInsert(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.memberInsert(mvo);
	}

	@Override
	public int memberUpdate(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.memberUpdate(mvo);
	}

	@Override
	public int memberDelete(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.memberDelete(mvo);
	}

	@Override
	public boolean memberEmailCheck(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.memberEmailCheck(mvo);
	}

	@Override
	public boolean memberNicknameCheck(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.memberNicknameCheck(mvo);
	}

	@Override
	public int memberJointerms(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.memberJointerms(mvo);
	}

	@Override
	public String selectSalt(MemberVO mvo) {
		// String 타입의 m_salt값이 리턴되어야 함. 
		return map.selectSalt(mvo);  //
	}

	@Override
	public List<MemberVO> v_memberSelectList() {
		// TODO Auto-generated method stub
		return map.v_memberSelectList();
	}

	@Override
	public int ajaxNewPasswordUpdate(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.ajaxNewPasswordUpdate(mvo);
	}

	@Override
	public MemberVO memberMyInfoList(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.memberMyInfoList(mvo);
	}

	@Override
	public int ajaxNicknameUpdate(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.ajaxNicknameUpdate(mvo);
	}

	@Override
	public int ajaxImageEnroll(AttachImageVO ivo) {
		// TODO Auto-generated method stub
		return map.ajaxImageEnroll(ivo);
	}

	@Override
	public int profileInsert(AttachImageVO ivo) {
		// TODO Auto-generated method stub
		return map.profileInsert(ivo);
	}

	@Override
	public List<AttachImageVO> getAttachList(String m_email) {
		// TODO Auto-generated method stub
		return map.getAttachList(m_email);
	}

	@Override
	public boolean profileImageCheck(AttachImageVO ivo) {
		// TODO Auto-generated method stub
		return map.profileImageCheck(ivo);
	}

	@Override
	public int insertProfileImage(AttachImageVO ivo) {
		// TODO Auto-generated method stub
		return map.insertProfileImage(ivo);
	}

	@Override
	public int updateProfileImage(AttachImageVO ivo) {
		// TODO Auto-generated method stub
		return map.updateProfileImage(ivo);
	}

	@Override
	public int ajaxJoinTermsUpdate(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.ajaxJoinTermsUpdate(mvo);
	}

	@Override
	public MemberVO emailSelectByNickname(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.emailSelectByNickname(mvo);
	}

	@Override
	public MemberVO memberInfoSelect(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.memberInfoSelect(mvo);
	}

	@Override
	public MemberVO quizcardInfoSelect(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.quizcardInfoSelect(mvo);
	}

	@Override
	public boolean ajaxPwdCheck(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.ajaxPwdCheck(mvo);
	}

	@Override
	public int memberStatusUpdate(MemberVO mvo) {
		// TODO Auto-generated method stub
		return map.memberStatusUpdate(mvo);
	}

	@Override
	public int getMemberListCnt(Search svo) {
		// TODO Auto-generated method stub
		return map.getMemberListCnt(svo);
	}

	@Override
	public List<MemberVO> memberSearchSelect(Search svo) {
		// TODO Auto-generated method stub
		return map.memberSearchSelect(svo);
	}

}
