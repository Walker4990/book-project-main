package com.bk.project.evaluation.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import com.bk.project.evaluation.dto.EvaluationDTO;
import com.bk.project.evaluation.vo.Evaluation;
import com.bk.project.member.vo.Member;

@Mapper
public interface EvaluationMapper {

	void newEvaluation(Evaluation eval);
	List<Member> selectAllMembers();
	List<Member> evalMem();
	
	List<EvaluationDTO> promoCandi();
}
