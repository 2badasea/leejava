package co.bada.leejava.practice;

import com.google.gson.Gson;

// Student 클래스를 Json 문자열로 변환
public class ObjectToJson {

	public static void main(String[] args) {
		
		// Student 객체 생성
		Student student = new Student(31, "bada");
		
		// Gson 객체 생성
		Gson gson = new Gson();
	
		// Student 객체 => Json문자열
		String studentJson = gson.toJson(student);
		
		// Json 문자열 출력
		System.out.println(studentJson);
	}
}
