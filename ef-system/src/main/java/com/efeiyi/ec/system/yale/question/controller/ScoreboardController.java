package com.efeiyi.ec.system.yale.question.controller;

import com.efeiyi.ec.organization.model.Consumer;
import com.efeiyi.ec.system.yale.question.bean.Scoreboard;
import com.efeiyi.ec.system.yale.question.service.ScoreboardManager;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.model.WxCalledRecord;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2016/1/18.
 * 排行榜Controller
 */
@Controller
@RequestMapping("/scoreboard")
public class ScoreboardController {

    @Autowired
    private BaseManager baseManager;
    @Autowired
    @Qualifier("scoreboardManagerImpl")
    private ScoreboardManager scoreboardManager;

    @RequestMapping("/scoreboardPList.do")
    public ModelAndView scoreboardPList(ModelMap modelMap, HttpServletRequest request) throws Exception {
        List<Scoreboard> scoreboardList = new ArrayList<>();
        //排行榜列表分页信息
        PageEntity pageEntity = new PageEntity();
        String pageIndex = request.getParameter("pageEntity.index");
        String pageSize = request.getParameter("pageEntity.size");
        if (pageIndex != null) {
            pageEntity.setIndex(Integer.parseInt(pageIndex));
            pageEntity.setSize(Integer.parseInt(pageSize));
        }
        modelMap.put("pageEntity", pageEntity);
        //获取开始结束时间段
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd" );
        String start = request.getParameter("selStartDate");
        String end = request.getParameter("selEndDate");
        Date selStartDate = (start==null||start.trim().equals(""))?null:sdf.parse(start);
        Date selEndDate = (end==null||end.trim().equals(""))?null:sdf.parse(end);
        modelMap.put("selStartDate", selStartDate);
        modelMap.put("selEndDate", selEndDate);

        //获取微信记录List,已分页
        List<WxCalledRecord> wxcrList = scoreboardManager.getWxCalledRecordList(pageEntity, selStartDate, selEndDate);

        scoreboardList = getScoreboardList(wxcrList, scoreboardList, modelMap);
        pageEntity.setCount(scoreboardManager.getSize(selStartDate, selEndDate));

        modelMap.put("scoreboardList", scoreboardList);
        return new ModelAndView("/yale/scoreboard/scoreboardPList", modelMap);
    }

    private List<Scoreboard> getScoreboardList(List<WxCalledRecord> list, List<Scoreboard> scoreboardList, ModelMap modelMap){
        Date selStartDate = (Date) modelMap.get("selStartDate");
        Date selEndDate = (Date) modelMap.get("selEndDate");
        for (WxCalledRecord wxRecord: list){
            Scoreboard scoreboard = new Scoreboard();
            scoreboard.setNickname(wxRecord.getRequestSource());//微信昵称
            //电商用户
            Consumer consumer = (Consumer) baseManager.getObject(Consumer.class.getName(), wxRecord.getConsumerId());
            scoreboard.setUsername(consumer.getUsername());//e飞蚁用户名
            //consumer答题次数[0]/开始时间[1]/结束时间[2]
            Object[] objects = scoreboardManager.getAnswerCountAndDate(wxRecord, selStartDate, selEndDate);
            Integer answerCount = objects == null ? 0 : Integer.valueOf((objects[0] == null ? 0 : objects[0]).toString());
            scoreboard.setAnswerCount(answerCount);
            //开始时间[1]
            Date startDate = objects == null ? null : (Date) objects[1];
            scoreboard.setStartDate(startDate);
            //结束时间[2]
            Date endDate = objects == null ? null : (Date) objects[2];
            scoreboard.setEndDate(endDate);
            //consumer累计奖励
            BigDecimal rewardTotal = scoreboardManager.getRewardTotal(wxRecord, selStartDate, selEndDate);
            scoreboard.setRewardTotal(rewardTotal);
            //好友帮助次数（有效的分享次数）
            Integer shareCount = scoreboardManager.getShareCount(wxRecord, selStartDate, selEndDate);
            scoreboard.setShareCount(shareCount);

            scoreboardList.add(scoreboard);
        }

        return scoreboardList;
    }

}
