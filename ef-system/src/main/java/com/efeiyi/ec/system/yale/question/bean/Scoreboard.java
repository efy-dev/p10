package com.efeiyi.ec.system.yale.question.bean;

import java.math.BigDecimal;
import java.util.Date;

/**
 * Created by Administrator on 2016/1/18.
 * 排行榜 bean
 */
public class Scoreboard {

    private String nickname;//微信昵称
    private String username;//e飞蚁用户名
    private Integer answerCount;//答题次数
    private BigDecimal rewardTotal;//累计奖励
    private Integer shareCount;//好友帮助次数（有效的分享次数）
    private Date startDate;//开始日期
    private Date endDate;//结束日期

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public Integer getAnswerCount() {
        return answerCount;
    }

    public void setAnswerCount(Integer answerCount) {
        this.answerCount = answerCount;
    }

    public BigDecimal getRewardTotal() {
        return rewardTotal;
    }

    public void setRewardTotal(BigDecimal rewardTotal) {
        this.rewardTotal = rewardTotal;
    }

    public Integer getShareCount() {
        return shareCount;
    }

    public void setShareCount(Integer shareCount) {
        this.shareCount = shareCount;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }
}
