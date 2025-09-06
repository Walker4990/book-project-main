package com.bk.project.book.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.book.dto.BookDTO;
import com.bk.project.book.dto.BookPagingDTO;
import com.bk.project.book.mapper.BookMapper;
import com.bk.project.book.vo.Book;

@Service
public class BookService {
	@Autowired
	private BookMapper mapper;
	
	// 수정 버튼 이동
	public Book selectUpdate(int bookNo) {
		return mapper.selectUpdate(bookNo);
	}
	
	//책 등록
	public int newBook(Book book)
	{
		return mapper.newBook(book);
	}
	//책 전체 출력
	public List<Book> allBook(BookPagingDTO paging) {
		return mapper.allBook(paging);
	}
	
	public int countBook(BookPagingDTO paging) {
		return mapper.countBook(paging);
	}


	//책 조회
	public List<Book> bookSearch(BookPagingDTO paging) {
		return mapper.searchBook(paging);
	}
	
	//책 수정
	public int updateBook(Book book) {
		return mapper.updateBook(book);
	}
	//책 삭제
	public int deleteBook(Book book)
	{
		return mapper.deleteBook(book);
	}
	
	public boolean confirmBook(String title) {
		return mapper.confirmBook(title)>0;
	}
	public int updateStatus(Book book) {
		return mapper.updateStatus(book);
	}
	public String selectTitle(int bookNo) {
		return mapper.selectTitle(bookNo);
	}
	public int total(String keyword) {
		return mapper.total(keyword);
	}
	
	public List<Book>allBooks(){
		return mapper.allBooks();
	}
	
	public List<Book>findBookByBookName(String bookTitle)
	{
		return mapper.findBookByBookName(bookTitle);
	}
	
	public Book findBookByNo(int bookNo) {
		return mapper.findBookByNo(bookNo);
	}
	
}
