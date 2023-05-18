package kr.co.project;

import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

@Controller
public class OmokController {
	@Autowired
	OmokService oService;
	
	//시권
	@GetMapping("/login.do")	//로그인 폼
	public String login(Model model) {
		PlayerVO pVO = new PlayerVO();
		pVO.setNum(1);
		List<PlayerVO> list = oService.addList(pVO);
		model.addAttribute("list",list);
		return "login";
	}
	
	@PostMapping("/login.do")	//로그인 요청
	public String login2(HttpSession sess, Model model,
							@RequestParam String id, @RequestParam String password ) {
		PlayerVO vo = oService.login(id, password);
		if(vo==null) {//로그인 X
			model.addAttribute("miss","틀렸다");
			return "login";
		}else { //로그인 O
			sess.setAttribute("loginSess", vo);
			return "redirect:/lobby";
		}
	}
	@GetMapping("/logout.do")	//로그 아웃 요청
	public String logout(HttpSession sess) {
		sess.invalidate();
		return "redirect:/login.do";
	}

	@GetMapping("/updateInfo.do") // 회원 수정 폼
	public String updateInfo() {
		return "updateInfo";
	}
	@PostMapping("/update.do")	//회원 수정 요청
	public String update(HttpSession sess,Model model, PlayerVO vo) {
		if(oService.updateInfo(vo)>0) {
			model.addAttribute("msg", "정보가 업데이트 되었습니다!");
			model.addAttribute("url","lobby");
			PlayerVO  pVO = (PlayerVO)sess.getAttribute("loginSess");
			pVO.setPassword(vo.getPassword());
			pVO.setNickname(vo.getNickname());
		}else {
			model.addAttribute("msg","수정 실패");
		}
		return "include/alert";
	}
	
	// 창준
	@Autowired
	BoardService bService;
	
	@GetMapping("/lobbyRankLeftside")
	public String left() {
		return "lobbyRankLeftside";
	}
	
	@GetMapping("/lobby")
	public String lobby(@RequestParam(value="page", defaultValue = "1") int page, Model model) {
		
		Map<Integer, BoardVO> boards = bService.getBoardList();
		if (page < 1) page = 1;
		if (page > boards.size() / 5 + 1) page = boards.size() / 5 + 1;
		
		model.addAttribute("boards", bService.getBoardList());
		model.addAttribute("page", page);
		
		return "lobby";
	}
	
	@PostMapping("/create")
	public String create(HttpServletRequest req, Model model, HttpSession sess) throws UnsupportedEncodingException {
		req.setCharacterEncoding("utf-8");
		String title = req.getParameter("title");
		PlayerVO pno = (PlayerVO) sess.getAttribute("loginSess");	// 원래는 세션에서 사용자 회원 번호 조회
		int roomNo = bService.addBoard(pno, title);
		model.addAttribute("roomNo", roomNo);
		return "redirect:game";
	}
	
	@GetMapping("/game")
	public String game(int roomNo, Model model, HttpSession sess) {
		// 게임이 끝난 건지 검증, 끝났으면 finish2로 이동
		Map<Integer, Integer> loserList = bService.getLoserList();
		if (loserList.get(roomNo) != null) {
			model.addAttribute("roomNo", roomNo);
			return "redirect:finish2";
		}
		PlayerVO pno = (PlayerVO) sess.getAttribute("loginSess");	// 원래는 세션에서 사용자 회원 번호 조회
		
		// 현재 플레이어가 해당 방에 입장할 수 있는지 체크, 못들어가는 방이면 로비로 이동
		if (!bService.check(roomNo, pno)) return "redirect:lobby";
		model.addAttribute("board", bService.getBoard(roomNo));
		return "game";
	}
	
	@GetMapping("/put")
	public String put(int roomNo, int row, int col, Model model, HttpSession sess) {
		BoardVO board = bService.getBoard(roomNo);
		PlayerVO pno = (PlayerVO) sess.getAttribute("loginSess"); // 세션에서 사용자 정보 받아와야 함 BoardService put도 수정
		
		// 돌을 놓는 메소드
		bService.put(board, pno, row, col);
		model.addAttribute("roomNo", roomNo);
		
		// 오목이 완성되면 finish로 이동
		if (bService.checkOmok(board, pno, row, col)) return "redirect:finish";
		
		return "redirect:game";
	}
	
	@GetMapping("/finish")
	public String finish(int roomNo, HttpSession sess, Model model) throws InterruptedException {
		BoardVO board = bService.getBoard(roomNo);
		PlayerVO pno = (PlayerVO) sess.getAttribute("loginSess");
		PlayerVO pno2;
		if (pno == board.getPlayer1()) pno2 = board.getPlayer2();
		else pno2 = board.getPlayer1();
		
		Map<Integer, Integer> loserList = bService.getLoserList();
		
		// 진 사람을 loserList에 담아 줌
		loserList.put(roomNo, board.getTurn());
		
		if (board.getTurn() == pno.getPlayerPK()) {
			model.addAttribute("msg", "패배");
			pno2.setVictory(pno2.getVictory() + 1);
			oService.updateVictory(pno2);
		} else {
			model.addAttribute("msg", "승리");
			pno.setVictory(pno.getVictory() + 1);
		}
		
		// 결과 db 반영
		pno.setTotal(pno.getTotal() + 1);
		pno2.setTotal(pno2.getTotal() + 1);
		
		oService.updateVictory(pno);
		oService.updateVictory(pno2);
				
		model.addAttribute("url", "/project/lobby");
		return "include/alert";
	}
	
	@GetMapping("/finish2")
	public String finish2(int roomNo, HttpSession sess, Model model) {
		// 방 삭제 되었는데 리프레쉬 된 경우를 위해 만든 클래스, 설명 안해도됨
		BoardVO board = bService.getBoard(roomNo);
		PlayerVO pno = (PlayerVO) sess.getAttribute("loginSess");

		if (board.getTurn() == pno.getPlayerPK()) {
			model.addAttribute("msg", "패배");
		} else {
			model.addAttribute("msg", "승리");
		}

		bService.removeBoard(roomNo);
		model.addAttribute("url", "/project/lobby");
		return "include/alert";
	}
	
	
	@GetMapping("/surrender")
	public String surrender(int roomNo, Model model, HttpSession sess) {
		BoardVO vo = bService.getBoard(roomNo);
		if (vo.turn == 0) {
			bService.removeBoard(roomNo);
			return "redirect:lobby";
		}
		PlayerVO pno = (PlayerVO) sess.getAttribute("loginSess");
		vo.setTurn(pno.getPlayerPK());
		model.addAttribute("roomNo", roomNo);
		
		return "redirect:finish";
	}
	
	@GetMapping("/back")
	public String back(int roomNo, Model model) {
		BoardVO vo = bService.getBoard(roomNo);
		bService.back(vo);
		model.addAttribute("roomNo", roomNo);
		return "redirect:game";
	}
	
	///서영
	@GetMapping("/join.do")	//회원가입 폼 이동
	public String join() {
		
		return "join";
	}
	
	@GetMapping("/dupCheck.do")
	@ResponseBody
	public String dupCheck(@RequestParam String id) {
		return oService.dupCheck(id) == 0 ? "usable" : "notusable";
	}
	
	@PostMapping("/regist.do")
	public String regist(Model model, PlayerVO vo) {
		int r = oService.insert(vo);
		if (r == 0) {
			model.addAttribute("msg", "가입 실패"); //실패하고 전페이지로 가면되잖아 join.do
			
		} else {
			
			model.addAttribute("msg", "정상적으로 가입되었습니다.");
			model.addAttribute("url","/project/login.do");
			
		}
		return "include/alert";
	}
	//지원
	@GetMapping("/rank.do") // i , dir= left, right
	public String index(Model model,
						PlayerVO vo,
						@RequestParam(value="num", defaultValue = "1") int num
						
			) {
//		System.out.println(num);
		vo.setNum(num);
		model.addAttribute("total",oService.count(vo));
		if(num ==1) {
			model.addAttribute("list",oService.addList(vo));
			model.addAttribute("num",1);
		}else {
			model.addAttribute("list",oService.addList(vo));
			model.addAttribute("num",num);
		}
		
		return "/rank";
	}
}
