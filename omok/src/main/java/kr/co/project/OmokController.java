package kr.co.project;

import java.io.UnsupportedEncodingException;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class OmokController {
	@Autowired
	OmokService oService;
	
	@GetMapping("/login.do")
	public String login() {
		return "login";
	}
	
	@PostMapping("/login.do")
	public String login2(HttpSession sess,
							@RequestParam String id, @RequestParam String password ) {
		PlayerVO vo = oService.login(id, password);
		if(vo==null) {//로그인 X
			return "/login";
		}else { //로그인 O
			sess.setAttribute("loginSess", vo);
			return "redirect:/lobby";
		}
	}
	@GetMapping("/register.do")
	public String register() {
		return "register";
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
		PlayerVO pno = (PlayerVO) sess.getAttribute("loginSess");	// 원래는 세션에서 사용자 회원 번호 조회
		if (!bService.check(roomNo, pno)) return "redirect:lobby";
		model.addAttribute("board", bService.getBoard(roomNo));
		return "game";
	}
	
	@GetMapping("/put")
	public String put(int roomNo, int row, int col, Model model, HttpSession sess) {
		BoardVO board = bService.getBoard(roomNo);
		PlayerVO pno = (PlayerVO) sess.getAttribute("loginSess"); // 세션에서 사용자 정보 받아와야 함 BoardService put도 수정
		bService.put(board, pno, row, col);
		model.addAttribute("roomNo", roomNo);
		
		return "redirect:game";
	}
	
	@GetMapping("/surrender")
	public String surrender(int roomNo, Model model, HttpSession sess) {
		BoardVO vo = bService.getBoard(roomNo);
		// 원래는 세션에서 사용자 회원 번호 조회, 승자 승 + 1 게임 수 + 1, 패자 게임 수 + 1 -> memberService에서 메소드로 만드는 게 좋을듯
		bService.removeBoard(roomNo);
		return "redirect:lobby";
	}
	
	@GetMapping("/back")
	public String back(int roomNo, Model model) {
		BoardVO vo = bService.getBoard(roomNo);
		bService.back(vo);
		model.addAttribute("roomNo", roomNo);
		return "redirect:game";
	}
	
	///
	
}
