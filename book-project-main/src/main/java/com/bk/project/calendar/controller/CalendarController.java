package com.bk.project.calendar.controller;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.author.service.AuthorService;
import com.bk.project.author.vo.Author;
import com.bk.project.book.service.BookService;
import com.bk.project.book.vo.Book;
import com.bk.project.contract.service.ContractService;
import com.bk.project.contract.vo.Contract;
import com.bk.project.vacation.dto.VacationDTO;
import com.bk.project.vacation.service.VacationService;
import com.bk.project.vacation.vo.Vacation;

@Controller
public class CalendarController {
	
	@Autowired
	private ContractService contractService;

	@Autowired
	private VacationService vacationService;
	@Autowired
	private BookService bookService;
	@Autowired
	private AuthorService authorService;
	
	@ResponseBody
	@GetMapping("/calendar")
	public List<Map<String, Object>> getCalendarEvents() {
	    List<Map<String, Object>> events = new ArrayList<>();
	    List<Contract> list = contractService.selectContractDate();

	    for (Contract c : list) {
	        if (c.getStartDate() == null) continue;

	        Map<String, Object> event = new HashMap<>();
	        event.put("title", "[계약] " + c.getBookTitle());
	        event.put("start", c.getStartDate().toString());

	        // FullCalendar는 end가 exclusive → 종료일 +1
	        if (c.getEndDate() != null) {
	            event.put("end", c.getEndDate().plusDays(1).toString());
	        }

	        event.put("allDay", true);
	        event.put("id", "CONTRACT-" + c.getContractNo());

	        // ⭐ extendedProps 안에 genre 넣기
	        Map<String, Object> ext = new HashMap<>();
	        ext.put("genre", c.getGenre());
	        event.put("extendedProps", ext);

	        events.add(event);
	    }

	    return events;
	}
	@ResponseBody
	@PostMapping(value = "/calendar", consumes = "application/json")
	@Transactional
	public Map<String, Object> insertContractCalendar(@RequestBody Map<String, Object> param) {
	    // === 1. 필수값 검증 ===
	    String authorName   = (String) param.get("authorName");
	    String bookTitle    = (String) param.get("bookTitle");
	    String startDateStr = (String) param.get("startDate");
	    String genre        = (String) param.get("genre");

	    if (authorName == null || authorName.isBlank()) 
	        throw new IllegalArgumentException("authorName required");
	    if (bookTitle == null || bookTitle.isBlank())   
	        throw new IllegalArgumentException("bookTitle required");
	    if (startDateStr == null || startDateStr.length() < 10) 
	        throw new IllegalArgumentException("Invalid start date");

	    // === 2. 날짜 변환 ===
	    LocalDate startDate     = LocalDate.parse(startDateStr.substring(0, 10));
	    LocalDate endDate       = parseDate((String) param.get("endDate"));
	    LocalDate manuscriptDue = parseDate((String) param.get("manuscriptDue"));
	    LocalDate printDate     = parseDate((String) param.get("printDate"));
	    LocalDate publishDate   = parseDate((String) param.get("publishDate"));

	    // === 3. 날짜 무결성 검증 ===
	    if (startDate != null && endDate != null && startDate.isAfter(endDate))
	        throw new IllegalArgumentException("startDate must be <= endDate");
	    if (manuscriptDue != null && endDate != null && manuscriptDue.isAfter(endDate))
	        throw new IllegalArgumentException("manuscriptDue must be <= endDate");
	    if (manuscriptDue != null && printDate != null && manuscriptDue.isAfter(printDate))
	        throw new IllegalArgumentException("manuscriptDue must be <= printDate");
	    if (printDate != null && publishDate != null && publishDate.isBefore(printDate))
	        throw new IllegalArgumentException("publishDate must be >= printDate");

	    // === 4. 계약 저장 ===
	    Map<String, Object> map = new HashMap<>(param);
	    map.put("startDate", startDate);
	    map.put("endDate", endDate);

	    contractService.insertContractCalendar(map);
	    int contractNo = ((Number) map.get("contractNo")).intValue();

	    // === 5. 작가 등록 ===
	    Author author = new Author();
	    author.setAuthorName(authorName);
	    author.setNationality((String) param.get("nationality"));
	    author.setGender((String) param.get("gender"));
	    author.setBirthDate(parseDate((String) param.get("birthDate")));
	    author.setContractNo(contractNo);
	    authorService.insertAuthor(author);

	    // === 6. 도서 등록 ===
	    Book book = new Book();
	    book.setTitle(bookTitle);
	    book.setAuthor(authorName);
	    book.setPublishDate(publishDate);
	    book.setPrice(param.get("price") != null ? Integer.parseInt(param.get("price").toString()) : 0);
	    book.setGenre(genre);
	    book.setContractNo(contractNo);
	    bookService.newBook(book);

	    // === 7. FullCalendar 반환 데이터 ===
	    Map<String,Object> res = new LinkedHashMap<>();
	    res.put("id", "CONTRACT-" + contractNo);
	    res.put("title", "[계약] " + bookTitle);
	    res.put("start", startDate.toString());
	    if (endDate != null) {
	        res.put("end", endDate.plusDays(1).toString());
	    }
	    res.put("allDay", true);
	    Map<String, Object> ext = new HashMap<>();
	    ext.put("genre", genre);
	    res.put("extendedProps", ext);

	    return res;
	}

   /** 문자열 → LocalDate 변환 유틸 */
   private LocalDate parseDate(String str) {
       return (str == null || str.isBlank()) ? null : LocalDate.parse(str.substring(0, 10));
   }
   @ResponseBody
   @GetMapping("/detail/{contractNo}")
   public Contract getContractDetail(@PathVariable("contractNo") int contractNo) {
       // DB에서 해당 계약 조회 @PathVariable -> 변수를 받아옴
       return contractService.selectContractDetail(contractNo);
   }
	
	
}



