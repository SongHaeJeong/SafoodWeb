package com.safood.service;

import java.util.List;

import com.safood.vo.Answer;
import com.safood.vo.Notice;
import com.safood.vo.Question;

public interface BoardService {

	public List<Question> selectAll();


	public void insert(Question q);


	public Question select(String qid);


	public void update(Question q);


	public void delete(String num);


	public void insertAnswer(Answer a);


	public List<Question> answerAll(String qid);


	public void deleteAnswer(String aid);


	public List<Question> selectFindByTitle(String data);


	public List<Question> selectFindByUser(String data);


	public List<Notice> noticeAll();


	public Notice noticeSelect(String title);


	public void noticeInsert(Notice n);


	public void updateCount(String nid);


	public void updateNotice(Notice n);


	public void deleteNotice(String nid);


	public List<Notice> noticeFindByTitle(String string);


	public List<Notice> noticeFindByUser(String string);



}
