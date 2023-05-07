package co.bada.leejava.practice;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonObject;

public class CreateGson {

	public static void main(String[] args) {
		// new
		Gson gson1 = new Gson();
		// GsonBuilder
		Gson gson2 = new GsonBuilder().create();
		Gson gson3 = new GsonBuilder().setPrettyPrinting().create();

		// Json 생성하기
		Gson gson = new Gson();
		// json key, value 추가.
		// JsonObject도 gson에서 제공하는 클래스. 객체생성용
		JsonObject jsonObject = new JsonObject();
		jsonObject.addProperty("name", "bada");
		jsonObject.addProperty("age", 31);
		System.out.println("생성한 jsonObject 확인: " + jsonObject);

		// JsonObject를 Json문자열로 변환
		// gson에서는 문자열로 변환할 때 toJson()을 사용
		// json.simple에선 toJSONString() 사용했었음.
		String jsonStr = gson.toJson(jsonObject);

		// 생성된 json 문자열 출력
		System.out.println(jsonStr);

		// json.simple에선 put()메서드를 통해 key, value 프로퍼티 추가 */
	}

}
