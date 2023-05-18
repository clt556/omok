package kr.co.project;

import lombok.Data;

@Data	
public class PlayerVO {
	private int playerPK;
	private String id;
	private String password;
	private String nickname;
	private int victory;
	private int total;
	private int num;
	private int rnum;

}
