package kr.spring.book.service;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.spring.book.dao.BookMapper;
import kr.spring.book.vo.BookVO;

@Service
@Transactional
public class BookServiceImpl implements BookService{
	@Autowired
	private BookMapper bookMapper;

	@Override
	public List<BookVO> selectList(Map<String, Object> map) {
		return bookMapper.selectList(map);
	}

	@Override
	public int selectRowCount(Map<String, Object> map) {
		return bookMapper.selectRowCount(map);
	}

	@Override
	public void insertBook(BookVO book) {
		bookMapper.insertBook(book);
	}

	@Override
	public BookVO selectBook(int book_num) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public void updateBook(BookVO book) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteBook(int book_num) {
		// TODO Auto-generated method stub
		
	}

	@Override
	public void deleteFile(int book_num) {
		// TODO Auto-generated method stub
		
	}
}