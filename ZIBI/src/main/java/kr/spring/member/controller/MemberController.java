package kr.spring.member.controller;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.spring.member.service.MemberService;
import kr.spring.member.vo.MemberVO;
import kr.spring.util.PasswordCheckException;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class MemberController {
	
	//의존 관계 주입
	@Autowired
	private MemberService memberService;
	
	//VO 초기화
	@ModelAttribute
	public MemberVO initCommand() {
		return new MemberVO();
	}
	
	//회원가입 폼 호출
	@GetMapping("/member/register")
	public String memberRegister() {
		return "registerForm"; //타일즈
	}
	
	@PostMapping("/member/register")
	public String registerSubmit(@Valid MemberVO memberVO, BindingResult result) {
		//유효성 체크
		if(result.hasFieldErrors("mem_email") || result.hasFieldErrors("mem_password")) {
			return memberRegister();
		}
		//회원가입
		memberService.registerMember(memberVO);
		
		return "home"; //타일즈
	}
	
	//로그인 폼 호출
	@GetMapping("/member/login")
	public String loginForm() {
		return "login"; //타일즈
	}
	
	//로그인 폼 submit
	@PostMapping("/member/login")
	public String loginSubmit(@Valid MemberVO memberVO, BindingResult result, HttpSession session) {
		
		log.debug("<<로그인>>" + memberVO);
		
		//로그인 체크
		MemberVO db_member = null;
		
		try {
			db_member = memberService.selectMember(memberVO.getMem_email());
			boolean check = false;
			
			log.debug("<<로그인 check>>" + db_member);
			
			if( db_member != null ) //아이디 존재할 경우
				check = db_member.checkPassword(memberVO.getMem_password()); //비밀번호 일치여부 확인
			
			if(check) { //비밀번호 일치할 경우
				
				/*자동 로그인 처리 필요*/
				
				session.setAttribute("user",db_member); //로그인 처리
				return "redirect:/main/home";
			}
			
			throw new PasswordCheckException(); //비밀번호 미일치할 경우 예외 던지기
			
		} catch (PasswordCheckException e) {
			result.reject("invalidIdOrPassword");
			return loginForm();
		}
	}
	
	//로그아웃 처리
	@RequestMapping("/member/logout")
	public String logout(HttpSession session) {
		
		session.invalidate();
		
	return "redirect:/main/home";
	}
	
	
	
	
	
}