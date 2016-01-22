package com.efeiyi.ec.system.yale.question.controller;

import com.efeiyi.ec.yale.question.model.Question;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by Administrator on 2015/12/22.
 * 题目 Controller
 */
@Controller
@RequestMapping("/question")
public class QuestionController {

    @Autowired
    private AutoSerialManager autoSerialManager;
    @Autowired
    private BaseManager baseManager;
    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @RequestMapping("/saveOrUpdateQuestion.do")
    public ModelAndView saveProduct(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        Question question = new Question();

        String questionId = request.getParameter("id");
        String type = "new";
        if (!questionId.isEmpty() && !questionId.trim().equals("")) {
            type = "edit";
            question = (Question)baseManager.getObject(Question.class.getName(), questionId);
        }
        question = setBaseProperty(question, request, type);
        question = upLoadPicture(multipartRequest, question);

        baseManager.saveOrUpdate(Question.class.getName(), question);

        String resultPage = "redirect:/basic/xm.do?qm=plistQuestion_default";
        return new ModelAndView(resultPage);
    }

    private Question setBaseProperty(Question question, HttpServletRequest request, String type) throws Exception {
        String questionName = request.getParameter("questionName");
        String questionContent = request.getParameter("questionContent");
        String answerA = request.getParameter("answerA");
        String answerB = request.getParameter("answerB");
        String answerC = request.getParameter("answerC");
        String answerD = request.getParameter("answerD");
        String answerTrue = request.getParameter("answerTrue");
        String answerKnowledge = request.getParameter("answerKnowledge");

        question.setQuestionName(questionName);
        question.setQuestionContent(questionContent);
        question.setAnswerA(answerA);
        question.setAnswerB(answerB);
        question.setAnswerC(answerC);
        question.setAnswerD(answerD);
        question.setAnswerTrue(answerTrue);
        question.setAnswerKnowledge(answerKnowledge);

        if (type.equals("new")){
            String serial = autoSerialManager.nextSerial("question");
            question.setSerial(serial);
            question.setStatus("1");
            question.setCreateDatetime(new Date());
        }

        return question;
    }

    private Question upLoadPicture(MultipartRequest multipartRequest, Question question) throws Exception{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmSS");
        String identify = sdf.format(new Date());
        String url = "question/" + identify + ".jpg";
        String pictureUrl = "http://master3.efeiyi.com/"+url+"@!question-img-form";

        if (!multipartRequest.getFile("pictureUrl").getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartRequest.getFile("pictureUrl"), "315pal", url);
            question.setPictureUrl(pictureUrl);
        }

        return question;
    }
}
