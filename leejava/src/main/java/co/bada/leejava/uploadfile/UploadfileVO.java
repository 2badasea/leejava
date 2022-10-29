package co.bada.leejava.uploadfile;

import lombok.Data;

@Data
public class UploadfileVO {
	private int fileBoard;			// 업로드 파일 게시판 종류
	private int fileBno; 			// 업로드 파일 게시글 번호
	private String fileUuid;		// 업로드 파일 UUID
	private String fileUploadpath;	// 업로드 파일 경로 
	private String fileOriginname;	// 업로드 파일 원본명 
	private boolean fileType; 		// 업로드 파일 유형(확장자) => 이미지일 경우, true. => mapper에서 true, 즉 이미지는 1로 저장시키기
}
