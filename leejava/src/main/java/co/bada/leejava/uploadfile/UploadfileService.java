package co.bada.leejava.uploadfile;

import java.util.List;

public interface UploadfileService {
	// 업로드 파일 DB에 insert
	int uploadfileInsert(UploadfileVO uvo);
	// 게시글 업로드 파일 조회
	List<UploadfileVO> uploadfileSelect(UploadfileVO uvo);
}
