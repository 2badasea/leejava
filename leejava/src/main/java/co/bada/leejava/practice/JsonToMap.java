package co.bada.leejava.practice;

import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

// Json 문자열 => Map 변환하기
public class JsonToMap {

	public static void main(String[] args) {

		// Json 문자열
		String jsonStr = "{\"id\":\"1\",\"name\":\"bada\"}";
		
		// Gson 객체 생성
		Gson gson = new Gson();
		
		// Json 문자열 => Map 
		Map<String, Object> map = gson.fromJson(jsonStr, Map.class);
		
		// Map 출력
		for(Map.Entry<String, Object> entry : map.entrySet()) {
			System.out.println(entry.getKey() + "=" + entry.getValue());
		}
		
	}

}
