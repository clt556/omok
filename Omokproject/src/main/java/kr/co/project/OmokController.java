package kr.co.project;

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
			return "redirect:/lobby.do";
		}
	}
	@GetMapping("/register.do")
	public String register() {
		return "register";
	}
	@GetMapping("/lobby.do")
	public String lobby() {
		return "lobby";
	}
}
