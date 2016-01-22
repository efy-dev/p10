package com.efeiyi.ec.system.yale.question.dao;

import com.ming800.core.p.model.WxCalledRecord;
import com.ming800.core.taglib.PageEntity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2016/1/18.
 * 排行榜 dao interface
 */
public interface ScoreboardDao {

    /**
     * 获取微信记录List.size
     * @return list.size
     */
    Integer getSize(Date selStartDate, Date selEndDate);

    /**
     * 获取微信记录List
     * @return 微信记录List
     * @param pageEntity
     * @param selStartDate
     * @param selEndDate
     */
    List<WxCalledRecord> getWxCalledRecordList(PageEntity pageEntity, Date selStartDate, Date selEndDate);

    /**
     * 获取consumer的答题次数和开始结束时间
     * @param wxCalledRecord 微信账号（一个openid）
     * @param selStartDate 开始日期
     * @param selEndDate 结束日期
     * @return 答题次数和开始结束时间
     */
    Object[] getAnswerCountAndDate(WxCalledRecord wxCalledRecord, Date selStartDate, Date selEndDate);

    /**
     * 获取consumer的累计奖励
     * @param wxCalledRecord 微信账号（一个openid）
     * @param selStartDate 开始日期
     * @param selEndDate 结束日期
     * @return 累计奖励
     */
    BigDecimal getRewardTotal(WxCalledRecord wxCalledRecord, Date selStartDate, Date selEndDate);

    /**
     * 获取consumer的分享次数(有效的分享次数)
     * @param wxCalledRecord 微信账号（一个openid）
     * @param selStartDate 开始日期
     * @param selEndDate 结束日期
     * @return 累计奖励
     */
    Integer getShareCount(WxCalledRecord wxCalledRecord, Date selStartDate, Date selEndDate);
}
