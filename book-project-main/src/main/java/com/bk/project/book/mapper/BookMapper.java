package com.bk.project.book.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.book.dto.BookDTO;
import com.bk.project.book.dto.BookPagingDTO;
import com.bk.project.book.vo.Book;

@Mapper
public interface BookMapper {

	
	
	int newBook(Book book);
	int updateBook(Book book);
	int deleteBook(Book book);
	Book selectUpdate(int bookNo);
	int confirmBook(String title);
	int updateStatus(Book book);
	String selectTitle(int bookNo);
	Integer findAuthorNoByBookNo(int bookNo);
	int findBookNoByContract(int contractNo);
	Book findBookByNo(int bookNo);
	int total(String keyword);
	List<Book> allBooks();
	
	List<Book> findBookByBookName(String bookTitle);
	
	List<Book> searchBook(BookPagingDTO paging);
	
	List<Book> allBook(BookPagingDTO paging);
	
	int countBook(BookPagingDTO paging);
	int findPriceByBookNo(int bookNo);
}
