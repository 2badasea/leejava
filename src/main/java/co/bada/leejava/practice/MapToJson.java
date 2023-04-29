package co.bada.leejava.practice;

import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;

// Map => Json 문자열 변환하기
public class MapToJson {

	public static void main(String[] args) {
		// Map
		Map<String, String> map = new HashMap<>();
		map.put("id", "1");
		map.put("name", "bada");
		System.out.println("json문자열로 변하기 전: " + map);
		
		// Map => Json문자열
		Gson gson = new Gson();
		String jsonStr = gson.toJson(map);
		
		// json 문자열 출력
		System.out.println(jsonStr);
	}

}
