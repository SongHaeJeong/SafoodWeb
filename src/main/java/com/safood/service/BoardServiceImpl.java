package com.safood.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.safood.dao.BoardDao;
import com.safood.vo.Answer;
import com.safood.vo.Notice;
import com.safood.vo.Question;

@Controller
public class BoardServiceImpl implements BoardService{

	@Autowired
	BoardDao dao;
	
	@Override
	public List<Question> selectAll() {
		// TODO Auto-generated method stub
		return dao.selectAll();
	}

	@Override
	public void insert(Question q) {
		dao.insert(q);
	}

	@Override
	public Question select(String qid) {
		// TODO Auto-generated method stub
		return dao.select(qid);
	}

	@Override
	public void update(Question q) {
		dao.update(q);
	}

	@Override
	public void delete(String num) {
		dao.delete(num);
	}

	@Override
	public void insertAnswer(Answer a) {
		dao.insertAnswer(a);
	}

	@Override
	public List<Question> answerAll(String qid) {
		return dao.answerAll(qid);
	}

	@Override
	public void deleteAnswer(String aid) {
		dao.deleteAnswer(aid);
	}

	@Override
	public List<Question> selectFindByTitle(String data) {
		return dao.selectFindByTitle(data);
	}

	@Override
	public List<Question> selectFindByUser(String data) {
		return dao.selectFindByUser(data);
	}

	@Override
	public List<Notice> noticeAll() {
		return dao.noticeAll();
	}

	@Override
	public Notice noticeSelect(String title) {
		return dao.noticeSelect(title); 
	}

	@Override
	public void noticeInsert(Notice n) {
		dao.noticeInsert(n);
	}

	@Override
	public void updateCount(String nid) {
		dao.updateCount(nid);
	}

	@Override
	public void updateNotice(Notice n) {
		dao.updateNotice(n);
	}

	@Override
	public void deleteNotice(String nid) {
		dao.deleteNotice(nid);
	}

	@Override
	public List<Notice> noticeFindByTitle(String string) {
		return dao.noticeFindByTitle(string);
	}

	@Override
	public List<Notice> noticeFindByUser(String string) {
		return dao.noticeFindByUser(string);
	}

}
