package com.bk.project.author.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.author.mapper.AuthorMapper;
import com.bk.project.author.vo.Author;

@Service
public class AuthorService {

	@Autowired
	private AuthorMapper mapper;
	
	public void insertAuthor(Author author) {
		mapper.insertAuthor(author);
}
}