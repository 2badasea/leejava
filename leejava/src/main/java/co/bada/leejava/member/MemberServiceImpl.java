package co.bada.leejava.member;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

}
