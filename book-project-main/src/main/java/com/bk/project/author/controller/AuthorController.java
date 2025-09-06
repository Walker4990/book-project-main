package com.bk.project.author.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;

import com.bk.project.author.service.AuthorService;
import com.bk.project.author.vo.Author;
import com.bk.project.book.vo.Book;

@Controller
public class AuthorController {

	@Autowired
	private AuthorService service;
	

	}

