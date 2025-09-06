package com.bk.project.evaluation.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.bk.project.evaluation.dto.EvaluationDTO;
import com.bk.project.evaluation.mapper.EvaluationMapper;
import com.bk.project.evaluation.vo.Evaluation;
import com.bk.project.member.vo.Member;

@Service
public class EvaluationService {

	@Autowired
	private EvaluationMapper mapper;
	
	public void newEvaluation(Evaluation eval) {
		mapper.newEvaluation(eval);
	}
	
	public List<Member> selectAllMembers() {
		return mapper.selectAllMembers();
	}
	public List<Member> evalMem() {
		return mapper.evalMem();
	}
	public List<EvaluationDTO> promoCandi(){
		return mapper.promoCandi();
	}

}
