package co.bada.leejava.practice;

import com.google.gson.Gson;

// Json 문자열을 Student 클래스로 변환
public class JsonToObject {

	public static void main(String[] args) {

		// Json 문자열
		String jsonStr = "{\"id\":1,\"name\":\"bada\"}";
		
		// Gson 객체 생성
		Gson gson = new Gson();
		
		// Json 문자열 => Student 객체
		Student student = gson.fromJson(jsonStr, Student.class);
		
		// Student 객체 toString() 출력
		System.out.println(student);
	}

}
