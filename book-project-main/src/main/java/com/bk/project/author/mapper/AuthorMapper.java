package com.bk.project.author.mapper;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.author.vo.Author;

@Mapper
public interface AuthorMapper {
	void insertAuthor(Author author);
	
}
