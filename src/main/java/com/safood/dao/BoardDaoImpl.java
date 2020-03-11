package com.safood.dao;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.safood.mapper.BoardMapper;
import com.safood.vo.Answer;
import com.safood.vo.Notice;
import com.safood.vo.Question;
@Controller
public class BoardDaoImpl implements BoardDao{

	@Autowired
	BoardMapper mapper;
	@Override
	public List<Question> selectAll() {
		// TODO Auto-generated method stub
		return mapper.selectAll();
	}
	@Override
	public void insert(Question q) {
		mapper.insert(q);
	}
	@Override
	public Question select(String qid) {
		// TODO Auto-generated method stub
		return mapper.select(qid);
	}
	@Override
	public void update(Question q) {
		mapper.update(q);
	}
	@Override
	public void delete(String num) {
		// TODO Auto-generated method stub
		mapper.delete(num);
	}
	@Override
	public void insertAnswer(Answer a) {
		mapper.insertAnswer(a);
	}
	@Override
	public List<Question> answerAll(String qid) {
		return mapper.answerAll(qid);
	}
	@Override
	public void deleteAnswer(String aid) {
		mapper.deleteAnswer(aid);
	}
	@Override
	public List<Question> selectFindByTitle(String data) {
		return mapper.selectFindByTitle(data);
		}
	@Override
	public List<Question> selectFindByUser(String data) {
		return mapper.selectFindByUser(data);
	}
	@Override
	public List<Notice> noticeAll() {
		return mapper.noticeAll();
	}
	@Override
	public Notice noticeSelect(String title) {
		return mapper.noticeSelect(title);
	}
	@Override
	public void noticeInsert(Notice n) {
		mapper.noticeInsert(n);
	}
	@Override
	public void updateCount(String nid) {
		// TODO Auto-generated method stub
		mapper.updateCount(nid);
		
	}
	@Override
	public void updateNotice(Notice n) {
		mapper.updateNotice(n);
	}
	@Override
	public void deleteNotice(String nid) {
		mapper.deleteNotice(nid);
	}
	@Override
	public List<Notice> noticeFindByTitle(String string) {
		return mapper.noticeFindByTitle(string);
	}
	@Override
	public List<Notice> noticeFindByUser(String string) {
		return mapper.noticeFindByUser(string);
	}
	
	
	
	
	

}
