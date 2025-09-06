package com.bk.project.evaluation.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.bk.project.evaluation.dto.EvaluationDTO;
import com.bk.project.evaluation.service.EvaluationService;
import com.bk.project.evaluation.vo.Evaluation;
import com.bk.project.member.vo.Member;

@Controller
public class EvaluationController {

	@Autowired
	private EvaluationService service;
	
		// 인사평가
		@GetMapping("/newEvaluation")
		public String newEvaluation(Model model) {
			List<Member> member = service.selectAllMembers();
			List<Member> evaluator = service.evalMem();
			
			model.addAttribute("evaluator", evaluator);
			model.addAttribute("memberList", member);
			model.addAttribute("page", "evaluationPage/newEvaluation.jsp");
			
			return "common/layout";
			
		}
		
		@ResponseBody
		@PostMapping("/newEvaluation")
		public String newEvaluation(Evaluation eval) {
			   System.out.println("eval : " + eval);
			   System.out.println(">>> evaluatorNo=" + eval.getEvaluatorNo());
			   System.out.println(">>> memberNo=" + eval.getMemberNo());
			service.newEvaluation(eval);
			return "success";
			
		}
		
		@GetMapping("/promoCandi")
		public String promoCandi(Model model) {
			List<EvaluationDTO> promoCandi = service.promoCandi();
			 for (EvaluationDTO dto : promoCandi) {
			        System.out.println(dto);  // 모든 필드 출력되는지 확인
			    }
			model.addAttribute("promoCandi", promoCandi);
			model.addAttribute("page", "/evaluationPage/promoCandi.jsp");
			return "common/layout";
			//return "page/evaluationPage/promoCandi";
		}
}
