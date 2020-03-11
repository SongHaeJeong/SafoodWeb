package com.safood.controller;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.safood.service.FoodInfoService;
import com.safood.service.UserInfoService;
import com.safood.vo.Food;
import com.safood.vo.User;

@Controller
public class SafoodViewController {

	@Autowired
	FoodInfoService fSvc;

	@Autowired
	UserInfoService uSvc;

//	@Autowired
//	BoardService bSvc;

	@ExceptionHandler(Exception.class)
	public String handleException() {
		return "error";
	}

	@RequestMapping(value = "/debug/{path}", method = RequestMethod.GET)
	public String debug(@PathVariable String path) {
		return path;
	}

	/* ***************************** FOOD ********************************* */
	@RequestMapping(value = "/main.safood", method = RequestMethod.GET)
	public String main(Model model, HttpSession session) {
		User u = (User) session.getAttribute("user");

		if (u != null) {
			String id = u.getId();
		}
		System.out.println("I got a request");
		return "main";
	}

	@RequestMapping(value = "/spa", method = RequestMethod.GET)
	public String spa(Model model, HttpSession session) {
		return "spa_root";
	}

	@RequestMapping(value = "/list.safood", method = RequestMethod.GET)
	public String listFood(Model model) {
		List<Food> list = fSvc.searchAllByPage(1, 20);
		model.addAttribute("foodList", list);
		return "foodpage";
	}

	@RequestMapping(value = "/search.safood", method = RequestMethod.POST)
	public String searchFoodByName(Model model, String keyword, HttpSession session, HttpServletRequest req) {
		ArrayList<Info> ln = new ArrayList<>();
		List<Food> list=  new ArrayList<Food>();
		User userName = (User)session.getAttribute("user");		
		System.out.println(keyword);
		String[] names = req.getParameterValues("en_name");
		if (names != null) {
			for (String str : names) {
				ln.add(new Info(req.getParameter(str+"_min"),req.getParameter(str+"_max"),str));
			}
		}
		
		String str1 ="";
		String str2 ="";
		String str3 ="";
		
		for (Info st : ln) {
			str1 += st.max+" ";
			str2 += st.min+" ";
			str3 += st.en_name + " ";
		}
		
		if(userName==null &&keyword !="") {
			fSvc.insertSearchLog(keyword, "" );
		}else if(keyword !="" && userName != null){
			System.out.println(userName.getId());
			fSvc.insertSearchLog(keyword, userName.getId());
		}
		
		System.out.println("checking");
		String check = req.getParameter("checkvalue");
		System.out.println(check);
		
		
		if(check.equals("true")) {
			list = fSvc.detailSearch(str1, str2, str3, "%"+keyword+"%");
		} else {
			System.out.println("그냥검색이요");
			System.out.println(keyword);
			list = fSvc.searchByName("%"+keyword+"%");
		}
		model.addAttribute("foodList", list);
		return "foodpage";
	}
	
	@RequestMapping(value = "/mainSearch.safood", method = RequestMethod.POST)
	public String mainPageSearch(Model model, String keyword, HttpSession session, String cal_number, HttpServletRequest req) {
		
		
		
		User userName = (User)session.getAttribute("user");		
		System.out.println(keyword);
		if(userName==null && keyword !="") {
			fSvc.insertSearchLog(keyword, "" );
		}else if(userName !=null && keyword !=""){
			System.out.println(userName.getId());
			fSvc.insertSearchLog(keyword, userName.getId());
		}
		//알러지 체크 했을때 검색해야됨.
		String[] allergyId = req.getParameterValues("allergies"); //체크되는 알러지 번호
		ArrayList<String> allwork = new ArrayList<>();
		if(allergyId != null) {
		for (int i = 0; i < allergyId.length; i++) {
			allwork.add(allergyId[i]);
		}
		HashMap hm = new HashMap<>();
		hm.put("allergyId", allwork);
		hm.put("cal_number", cal_number );
		hm.put("keyword", "%"+keyword+"%");
		List<Food> list = fSvc.mainPageSearch(hm);
		model.addAttribute("foodList", list);
		}else {
			List<Food> list = fSvc.searchLowCal("%"+keyword+"%", cal_number);
			model.addAttribute("foodList", list);
		}
		
		
			
		
	return "foodpage";
	}

	/* ***************************** USER ********************************* */
	@RequestMapping(value = "/register.safood", method = RequestMethod.POST)
	public String registerUser(HttpServletRequest req) {
		String id = req.getParameter("register_id");
		String pass = req.getParameter("register_password");
		String name = req.getParameter("register_name");
		String email = req.getParameter("register_email");
		String[] allergies = req.getParameterValues("allergies");
		for (String string : allergies) {
			System.out.println(string);
		}
		User u = new User(id, pass, name, email);
		System.out.println(u.toString());
		uSvc.registerUser(u);
		for (String al : allergies) {
			uSvc.addAllergy(id, al);
		}

		return "main";
	}

	@RequestMapping(value = "/modify.safood", method = RequestMethod.POST)
	public String updateUser(HttpSession session, HttpServletRequest req) {
		
		String pass = req.getParameter("modify_password");
		String name = req.getParameter("modify_name");
		String email = req.getParameter("modify_email");
		
		User u = (User) session.getAttribute("user");
		u.setEmail(email);
		u.setName(name);
		u.setPass(pass);
		String[] allergies = req.getParameterValues("allergies");
		for (String al : allergies) {
			uSvc.addAllergy(u.getId(), al);
		}
		uSvc.updateUser(u);

		return "redirect:/main.safood";
	}

	@RequestMapping(value = "/deleteUser.safood", method = RequestMethod.GET)
	public String deleteUser(String id, HttpSession session) {
		uSvc.deleteAllergy(id); // User_has_allergy table 에서 삭제
		uSvc.deleteUser(id); //User table 에서 회원정보 삭제
		System.out.println(id);
		session.removeAttribute("user");

		return "redirect:/main.safood";
	}

	@RequestMapping(value = "/login.safood", method = RequestMethod.POST)
	public String loginUser(HttpSession session, String id, String pass) {
		int cnt = uSvc.loginUser(id, pass);
		if (cnt != 0) {
			User u = uSvc.userConfirm(id);
			System.out.println("I'm not null" + id);
			session.setAttribute("user", u);
		}

		return "redirect:/main.safood";
	}

	@RequestMapping(value = "/logout.safood", method = RequestMethod.GET)
	public String logout(HttpSession session) {
		session.removeAttribute("user");

		return "redirect:/main.safood";
	}

	// 게시판====================================================================

	@RequestMapping(value = "/board/qna.safood", method = RequestMethod.GET)
	public String qna(Model model) {
		return "QnA";

	}

	@RequestMapping(value = "/board/notice.safood", method = RequestMethod.GET)
	public String notice(Model model, HttpSession session) {
		System.out.println("Notice 진입");
		return "notice";

	}

	/*
	 * @RequestMapping(value ="/board/detail.safood", method = RequestMethod.GET)
	 * public String detail(Model model) {
	 * 
	 * return "detail";
	 * 
	 * }
	 */

	/*
	 * @RequestMapping(value ="/board/regQuestion.safood", method =
	 * RequestMethod.GET) public String regQuestion(Model model) { return
	 * "regBoard";
	 * 
	 * }
	 */

	/* =================== STATS Page ======================== */
	@RequestMapping(value = "/stats.safood", method = RequestMethod.GET)
	public String statsPage(Model model) {
		System.out.println("stats requested");
		return "stats";
	}
	
	static class Info{
		String min;
		String max;
		String en_name;
		public Info(String min, String max, String en_name) {
			super();
			this.min = min;
			this.max = max;
			this.en_name = en_name;
		}
		
	}
}
