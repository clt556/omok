package kr.co.project;
import lombok.Data;

import java.util.*;
import java.awt.Point;

@Data
public class BoardVO {
    public int board_pk;
    public String title;
    PlayerVO player1;  // PlayerVO로 변환
    PlayerVO player2;
    int size = 19;
    int turn;
    String[][] map;
    Stack<Point> records;
    
    
    BoardVO(int bno, PlayerVO pno, String title) {
    	records = new Stack<>();
    	this.board_pk = bno;
    	this.player1 = pno;		// pno로 playerVO 찾아서 반환하게 변환
    	this.title = title;
        map = new String[size][size];
        for (int row = 0; row < size; row++) {
            for (int col = 0; col < size; col++) {
                map[row][col] = ".";
            }
        }
    }
}
