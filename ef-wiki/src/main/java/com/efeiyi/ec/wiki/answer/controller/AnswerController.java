package com.efeiyi.ec.wiki.answer.controller;

import com.efeiyi.ec.yale.question.model.Question;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2016/5/13.
 */
@Controller
public class AnswerController {
    @Autowired
    BaseManager baseManager;

    @RequestMapping({"/questionList.do"})
    public String getQuestionList(HttpServletRequest request, Model model) throws Exception {
        XQuery xQuery = new XQuery("plistQuestion_default", request);
        xQuery.addRequestParamToModel(model, request);
        PageInfo pageInfo = baseManager.listPageInfo(xQuery);

        model.addAttribute("questions", pageInfo.getList());
        return "/wiki/questionList";
    }

    @RequestMapping({"/question/{questionId}.html"})
    public String questinDetails(HttpServletRequest request, Model model, @PathVariable String questionId) {
        Question question = (Question) baseManager.getObject(Question.class.getName(), questionId);
        model.addAttribute("question", question);
        return "/wiki/detail";
    }


}
