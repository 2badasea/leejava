package co.bada.leejava.practice;

//Student클래스 생성. Object => Json변환하는 실습용.
public class Student {
	private int id;
	private String name;

	// 매개변수 2개를 받는 생성자 선언.
	public Student(int id, String name) {
		this.id = id;
		this.name = name;

	}

	// toString() 메소드 재정의
	@Override
	public String toString() {
		return "Student [id=" + id + ", name=" + name + "]";
	}
}
