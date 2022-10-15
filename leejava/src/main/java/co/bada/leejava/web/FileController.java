package co.bada.leejava.web;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import co.bada.leejava.uploadfile.UploadfileService;

/*
 * 공지사항과 배너이미지를 제외한 모든 파일 업로드와 다운로드 로직 구현 (공통)
 */
@Controller
public class FileController {
	@Autowired
	UploadfileService uploadfileDao;
}
