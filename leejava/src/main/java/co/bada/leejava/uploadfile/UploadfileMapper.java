package co.bada.leejava.uploadfile;

import java.util.List;

public interface UploadfileMapper {
	// 업로드 파일 DB에 insert
	int uploadfileInsert(UploadfileVO uvo);
	// 게시글 업로드 파일 조회
	List<UploadfileVO> uploadfileSelect(UploadfileVO uvo);
	// 개별 게시글의 첨부파일 전부 삭제
	int uploadfileDelete(UploadfileVO uvo);
	// 개별 게시글 첨부파일 한 개 삭제
	int uploadfileDeleteOne(UploadfileVO uvo);
}
