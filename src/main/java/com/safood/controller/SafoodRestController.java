package com.safood.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.mysql.cj.conf.ConnectionUrlParser.Pair;
import com.safood.service.BoardService;
import com.safood.service.FoodInfoService;
import com.safood.service.UserInfoService;
import com.safood.vo.Allergy;
import com.safood.vo.Answer;
import com.safood.vo.Food;
import com.safood.vo.Notice;
import com.safood.vo.Question;
import com.safood.vo.User;

@RestController
public class SafoodRestController {

	@Autowired
	BoardService service;
	@Autowired
	FoodInfoService fSvc;
	@Autowired
	UserInfoService uSvc;
	

	@RequestMapping(value = "api/lists", method = RequestMethod.GET)
	public List<Question> listAll() {
		return service.selectAll();
	}

	@RequestMapping(value = "api/lists/{qid}", method = RequestMethod.GET)
	public Question list(@PathVariable String qid) {
		return service.select(qid);
	}

	@RequestMapping(value = "api/lists", method = RequestMethod.POST, produces = { "application/json;charset=euc-kr" })
	public Map insertUser(@RequestBody Question q, HttpSession session) {
//		System.out.println("추가하기" + session.getAttribute("user"));
//		User user =  (User) session.getAttribute("user");
//		session.setAttribute("user", user.getId());
		service.insert(q);
		HashMap<String, String> map = new HashMap<>();
		map.put("result", "kiki");
		return map;
	}

	@RequestMapping(value = "api/lists", method = RequestMethod.PUT, produces = { "application/json;charset=euc-kr" })
//	@ResponseBody // ������ �������� �����ִ� JSON ������ �����͸� JAVA ��ü�� ��ȯ���� �޶�� �������̼�
	public Map updatecustomer(@RequestBody Question q) {// @RequestBody : Request�� ��ܼ� ������ ���۵Ǵ� ������{json}��
														// �ڹٰ�ü�� ��ȯ�� �� . json->java
		System.out.println("업데이트");
		System.out.println(q.getQid());
		System.out.println(q.getTitle());
		service.update(q);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("result", "update success");
		return map;
	}

	@RequestMapping(value = "api/lists/{qid}", method = RequestMethod.DELETE)
//	@ResponseBody // ������ �������� �����ִ� JSON ������ �����͸� JAVA ��ü�� ��ȯ���� �޶�� �������̼�
	public void deletecustomer(@PathVariable String qid) {
		System.out.println(qid);
		service.delete(qid);

	}

	@RequestMapping(value = "api/answers/{qid}", method = RequestMethod.GET)
	public List<Question> answerAll(@PathVariable String qid) {
		return service.answerAll(qid);
	}

	@RequestMapping(value = "api/answers", method = RequestMethod.POST, produces = {
			"application/json;charset=euc-kr" })
	public Map inserAnswer(@RequestBody Answer a, HttpSession session) {
//		System.out.println("추가하기" + session.getAttribute("user"));
//		User user =  (User) session.getAttribute("user");
//		session.setAttribute("user", user.getId());
		System.out.println(a.getQaid());
		service.insertAnswer(a);
		HashMap<String, String> map = new HashMap<>();
		map.put("result", "kiki");
		return map;
	}

	@RequestMapping(value = "api/answers/{aid}", method = RequestMethod.DELETE)
//	@ResponseBody // ������ �������� �����ִ� JSON ������ �����͸� JAVA ��ü�� ��ȯ���� �޶�� �������̼�
	public void deleteAnswer(@PathVariable String aid) {
		System.out.println(aid);
		service.deleteAnswer(aid);

	}

	@RequestMapping(value = "api/search/{type}/{data}", method = RequestMethod.GET)
	public List<Question> search(@PathVariable String type, @PathVariable String data) {
		if (type.equals("title")) {
			return service.selectFindByTitle("%" + data + "%");
		} else if (type.equals("user")) {
			return service.selectFindByUser("%" + data + "%");
		}

		return null;
	}

	@RequestMapping(value = "api/notice/lists", method = RequestMethod.GET)
	public List<Notice> noticeAll() {
		return service.noticeAll();
	}

	@RequestMapping(value = "api/notice/lists/{title}", method = RequestMethod.GET)
	public Notice noticeList(@PathVariable String title) {
		return service.noticeSelect(title);
	}

	@RequestMapping(value = "api/notice", method = RequestMethod.POST, produces = { "application/json;charset=euc-kr" })
	public Map insertNotice(@RequestBody Notice n, HttpSession session) {
//		System.out.println("추가하기" + session.getAttribute("user"));
//		User user =  (User) session.getAttribute("user");
//		session.setAttribute("user", user.getId());
		service.noticeInsert(n);
		HashMap<String, String> map = new HashMap<>();
		map.put("result", "kiki");
		return map;
	}

	@RequestMapping(value = "api/notice/count/{nid}", method = RequestMethod.PUT, produces = {
			"application/json;charset=euc-kr" })
//	@ResponseBody // ������ �������� �����ִ� JSON ������ �����͸� JAVA ��ü�� ��ȯ���� �޶�� �������̼�
	public Map updateCounter(@PathVariable String nid) {// @RequestBody : Request�� ��ܼ� ������ ���۵Ǵ� ������{json}��
														// �ڹٰ�ü�� ��ȯ�� �� . json->java
		System.out.println("카운트횟수 증가");
		service.updateCount(nid);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("result", "update success");
		return map;
	}

	@RequestMapping(value = "api/notice", method = RequestMethod.PUT, produces = { "application/json;charset=euc-kr" })
//	@ResponseBody // ������ �������� �����ִ� JSON ������ �����͸� JAVA ��ü�� ��ȯ���� �޶�� �������̼�
	public Map updateNotice(@RequestBody Notice n) {// @RequestBody : Request�� ��ܼ� ������ ���۵Ǵ� ������{json}��
													// �ڹٰ�ü�� ��ȯ�� �� . json->java
		System.out.println("업데이트");
		service.updateNotice(n);
		HashMap<String, String> map = new HashMap<String, String>();
		map.put("result", "update success");
		return map;
	}

	@RequestMapping(value = "api/notice/{nid}", method = RequestMethod.DELETE)
//	@ResponseBody // ������ �������� �����ִ� JSON ������ �����͸� JAVA ��ü�� ��ȯ���� �޶�� �������̼�
	public void deleteNotice(@PathVariable String nid) {
		System.out.println(nid);
		service.deleteNotice(nid);

	}

	@RequestMapping(value = "api/noticeSearch/{type}/{data}", method = RequestMethod.GET)
	public List<Notice> searchNotice(@PathVariable String type, @PathVariable String data) {
		System.out.println(type);
		System.out.println(data);
		if (type.equals("title")) {
			return service.noticeFindByTitle("%" + data + "%");
		} /*
			 * else if (type.equals("user")) { return service.noticeFindByUser("%"+data+
			 * "%"); }
			 */

		return null;
	}

	@RequestMapping(value = "api/eaten/{userid}", method = RequestMethod.POST, produces = {
			"application/json;charset=euc-kr" })
	public Map addEatenFood(@PathVariable String userid, HttpSession session, @RequestBody Food f) {
//		System.out.println("추가하기" + session.getAttribute("user"));
//		User user =  (User) session.getAttribute("user");
//		Food eatenFood = fSvc.selectOneByCode(foodCode);
//		session.setAttribute("user", user.getId());
//		if(userid.equals(session.getAttribute("user"))) {
		uSvc.addEatenFood(userid, f.getCode() + "");
//		}
		HashMap<String, String> map = new HashMap<>();
		map.put("result", "kiki");
		return map;
	}

	@RequestMapping(value = "api/wish/{userid}", method = RequestMethod.POST)
	public Map addwishFood(@PathVariable String userid, HttpSession session, @RequestBody Food f) {
//		System.out.println("추가하기" + session.getAttribute("user"));
//		User user =  (User) session.getAttribute("user");
//		Food eatenFood = fSvc.selectOneByCode(foodCode);
//		session.setAttribute("user", user.getId());
//		if(userid.equals(session.getAttribute("user"))) {
		uSvc.addWishFood(userid, f.getCode() + "");
//		}
		HashMap<String, String> map = new HashMap<>();
		map.put("result", "kiki");
		return map;
	}

	@RequestMapping(value = "api/wish/{userid}", method = RequestMethod.GET)
	public List<Food> wishList(@PathVariable String userid) {
		return uSvc.getWishFoodList(userid);
	}

	@RequestMapping(value = "api/eaten/{userid}", method = RequestMethod.GET)
	public List<Food> eantenList(@PathVariable String userid) {
		return uSvc.getEatenFoodList(userid);
	}

	@RequestMapping(value = "api/wish/{userId}/{wishFoodId}", method = RequestMethod.DELETE)
	public void deleteWishFood(@PathVariable String wishFoodId, @PathVariable String userId, HttpSession session) {
//		if(userId.equals(session.getAttribute("user"))) {

		uSvc.deleteWishFood(wishFoodId);
			System.out.println("삭제됨");
//		}

	}

	@RequestMapping(value = "api/eaten/{userId}/{foodLogId}", method = RequestMethod.DELETE)
	public void deleteEatenFood(@PathVariable String foodLogId, @PathVariable String userId, HttpSession session) {
//		if(userId.equals(session.getAttribute("user"))) {
		uSvc.deleteEatenFood(foodLogId);
			System.out.println("삭제됨");
//		}
	}
	
	//키워드 가지고 오기 (검색키워드)
	@RequestMapping(value = "api/searchLog", method = RequestMethod.GET)
	public List<String> keyWordList() {
		
		return fSvc.searchLog();
	}
	
	@RequestMapping(value = "api/best/{userid}", method = RequestMethod.GET)
	public List<Pair> bestEaten(@PathVariable String userid, HttpSession session) {
		User user = (User) session.getAttribute("user");
		if (user != null && user.getId().equals(userid))
			return uSvc.bestEaten(userid);
		else
			return uSvc.bestAllEaten();
	}
	
	
	@RequestMapping(value = "api/best", method = RequestMethod.GET)
	public List<Pair> bestEaten() {
		return uSvc.bestAllEaten();
	}
	
	@RequestMapping(value = "api/allergies", method = RequestMethod.GET)
	public List<Allergy> allergyList() {
		
		return fSvc.getWholeAllergies();
	}
	
	@RequestMapping(value = "api/userAllergies/{id}", method = RequestMethod.GET)
	public List<Allergy> userHasAllergies(@PathVariable String id) {
		
		return uSvc.getAllergyList(id);
	}
	
	@RequestMapping(value = "api/foodAllergies/{foodcode}", method = RequestMethod.GET)
	public List<Allergy> foodHasAllergies(@PathVariable String foodcode) {
		
		return fSvc.getAllergyList(foodcode);
	}
	

	
}
