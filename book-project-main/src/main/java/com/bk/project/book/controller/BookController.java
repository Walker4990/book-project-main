package com.bk.project.book.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.BookProjectApplication;
import com.bk.project.book.dto.BookDTO;
import com.bk.project.book.dto.BookPagingDTO;
import com.bk.project.book.service.BookService;
import com.bk.project.book.vo.Book;
import com.bk.project.vacation.service.VacationService;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpSession;

@Controller
public class BookController {

    private final VacationService vacationService;

    private final BookProjectApplication bookProjectApplication;

	@Autowired
	private BookService service;

    BookController(BookProjectApplication bookProjectApplication, VacationService vacationService) {
        this.bookProjectApplication = bookProjectApplication;
        this.vacationService = vacationService;
    }
	
	//수정 버튼 이동
	@GetMapping("/updateBook")
	public String selectUpdate(int bookNo, Model model) {
		//model.addAttribute("page", "/bookPage/updateBook.jsp");
		Book bookVO = service.selectUpdate(bookNo);
		model.addAttribute("selectBook", bookVO);
		//return "common/layout";
		return "/page/bookPage/updateBook";
	}
	
	
	@GetMapping("/allBook")
	public String allBook(Model model,BookPagingDTO paging){
		List<Book> list = service.bookSearch(paging);
		int total = service.countBook(paging);
		
		model.addAttribute("bookList", list);
		model.addAttribute("paging", new BookPagingDTO(paging.getPage(), total));
		model.addAttribute("page", "/bookPage/allBook.jsp");
		model.addAttribute("param", paging);
		
		return "common/layout";
		
	}
/*
	//책 조회
	@GetMapping("/allBook")
	public String allBook(Model model,BookPagingDTO paging)
	{
		model.addAttribute("page", "/bookPage/allBook.jsp");
		model.addAttribute("bookList",service.allBook(paging));
		
		return "common/layout";
		//return "/page/bookPage/allBook";
		
	}
	

	
	//책 조회
	@PostMapping("/searchBook")
	public String keyword(BookDTO dto, Model model, BookPagingDTO paging)
	{	
		String keyword = dto.getKeyword();
		if(keyword == null || keyword.trim().isEmpty()) {
			
			model.addAttribute("bookList",service.allBook(paging));
			
		} else {
			model.addAttribute("bookList", service.bookSearch(dto));
		}
		model.addAttribute("page", "bookPage/allBook.jsp");
		return "common/layout";
	}
*/
	//책 정보 변경
	@ResponseBody
	@PostMapping("/updateBook")
	public String updateBook(Book book) {
		System.out.println("book 정보 확인 : " + book.getBookNo());
		int result = service.updateBook(book);
		System.out.println(result);
		if(result > 0)return "success";
		else
			return "fail";
	}
	
	
	//책 정보 삭제(Script 코드)
	@PostMapping("/deleteBook")
	public String deleteBook(Book book)
	{
		service.deleteBook(book);
		return "success";
	}
	@ResponseBody
	@PostMapping("/updateStatus")
	public String updateStatus(Book book) {
		service.updateStatus(book);
		return "success";
	}
}
