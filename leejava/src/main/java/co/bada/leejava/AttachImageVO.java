package co.bada.leejava;

import lombok.Data;

@Data
public class AttachImageVO {
	// 프로필 이미지, 썸네일 이미지 등록을 위한 vo객체 생성 by 김밤파
	
	// 경로
	private String uploadPath;
	// uuid
	private String uuid;
	// 파일 이름
	private String fileName;
	// 이미지 정보가 누구의 이미지에 관한 정보인지 
	private String m_email;
}
