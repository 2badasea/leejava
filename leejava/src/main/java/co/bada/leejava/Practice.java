package co.bada.leejava;

import java.util.HashMap;
import java.util.Map;

import com.google.gson.Gson;
import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class Practice {

	public static void main(String[] args) {
		// 이번에는 map 객체를 json 문자열로.
		Map<String, String> map = new HashMap<>();
		map.put("name", "leebada");
		map.put("age", "31");
		map.put("address", "daegu");
		
		System.out.println("현재 map 구조: " + map);
		
		Gson gson = new Gson();
		
		String jsonObj = gson.toJson(map);
		System.out.println(jsonObj);
		
		// toJson 자체가 객체형태로 만드는 것이 아니라, json문자열로 변환하는 것. 
		
		// json배열 생성 => 배열객체의 형태. 
		JsonArray jsonAry = new JsonArray();
		JsonObject jsonObject = new JsonObject();
		jsonObject.addProperty("name", "leeseulbi");
		jsonObject.addProperty("address", "Seoul");
		
		jsonAry.add(jsonObject);
		System.out.println("현재 배열 모습: " + jsonAry);
		String jsonAryStr = gson.toJson(jsonAry);
		System.out.println(jsonAryStr);
	}

}