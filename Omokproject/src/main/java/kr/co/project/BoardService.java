package kr.co.project;

import java.awt.Point;
import java.util.HashMap;
import java.util.Map;
import java.util.Stack;

import org.springframework.stereotype.Service;

@Service
public class BoardService {
	private Map<Integer, BoardVO> boardList = new HashMap<>();
	private Map<Integer, Integer> loserList = new HashMap<>();
	private int count = 1;
	
	public int addBoard(PlayerVO pno, String title) {
		boardList.put(count, new BoardVO(count, pno, title));
		return count++;
	}
	
	public Map<Integer, BoardVO> getBoardList() {
		return boardList;
	}
	
	public Map<Integer, Integer> getLoserList() {
		return loserList;
	}
	
	public BoardVO getBoard(int bno) {
		return boardList.get(bno);
	}
	
	public Integer getLoser(int bno) {
		return loserList.get(bno);
	}
	
	public void removeBoard(int bno) {
		boardList.remove(bno);
	}
	
	// 플레이어가 해당 게임에 접근 권한이 있는지 확인하는 메소드
	public boolean check(int bno, PlayerVO pno) {
		BoardVO board = boardList.get(bno);
		// board.getPlayer1().getPlayerPK()로 변환
		
		// 새로운 플레이어가 접속하면 player2자리에 등록 후 방장에게 턴 주기
		if (board.getPlayer1() == pno || board.getPlayer2() == pno) return true;
		if (board.getPlayer2() == null) {
			// 세션에서 playerVO 그대로 저장하게 변환
			
			board.setPlayer2(pno);
			board.setTurn(board.getPlayer1().getPlayerPK());
			return true;
		}
		return false;
	}
	
	// 돌을 게임판에 두는 메소드
	public boolean put(BoardVO board, PlayerVO pno, int row, int col) {
		// 현재 플레이어의 차례인지 확인
		if (board.getTurn() == 0) return false;
		if (board.getTurn() != pno.getPlayerPK()) return false;
		String[][] map = board.getMap();
		
		// 이미 돌이 있는지 확인
		if (!map[row][col].equals(".")) return false;
		
		// player1이면 st1, player2이면 st2 할당
		String stone;
		if (board.getPlayer1() == pno) stone = new String("st1");
		else stone = new String("st2");
		
		// 돌을 게임 판에 둠
		map[row][col] = stone;

		// 무르기를 위한 현재 좌표 저장
		board.getRecords().push(new Point(row, col));
		
		// 턴을 상대에게 넘겨 줌
		if (board.getTurn() == board.getPlayer1().getPlayerPK()) board.setTurn(board.getPlayer2().getPlayerPK());
		else board.setTurn(board.getPlayer1().getPlayerPK());
		return true;
	}
	
	// 무르기 메소드
	public void back(BoardVO board) {
		Stack<Point> records = board.getRecords();
		
		// 무를 수 있는 돌이 있으면 해당 게임 판의 돌을 "."로 되돌려 줌
		if (!records.empty()) {
			Point point  = records.pop();
			board.getMap()[(int) point.getX()][(int) point.getY()] = ".";
		}
		
		// 턴을 상대에게 넘겨 줌
		if (board.getTurn() == board.getPlayer1().getPlayerPK()) board.setTurn(board.getPlayer2().getPlayerPK());
		else board.setTurn(board.getPlayer1().getPlayerPK());
	}
	
    public boolean checkOmok(BoardVO board, PlayerVO pno, int y, int x) {
		// player1이면 st1, player2이면 st2 할당
		String stone;
		if (board.getPlayer1() == pno) stone = new String("st1");
		else stone = new String("st2");

    	int[] cnt = {0,0,0,0};
    	int[] x2 = {x, x-4, x-4 , x-4};
    	int[] y2 = {y-4, y, y-4, y+4};
    	int[] dx = {0,1,1,1};
    	int[] dy = {1,0,1,-1};

    	
    	for(int i=0;i<9;i++) {
    		for(int j=0;j<x2.length;j++) {
	    		int indexX = x2[j]+dx[j]*i;  
				int indexY = y2[j]+dy[j]*i;
				
				if(0<=indexX && indexX<=18 && 0<=indexY && indexY<=18) {
					if(stone.equals(board.map[indexY][indexX])) {
						if(++cnt[j] == 5) return true;
					}else {
							cnt[j] = 0;
					}
				}
    		}
    	}
    	return false;
    }
}

