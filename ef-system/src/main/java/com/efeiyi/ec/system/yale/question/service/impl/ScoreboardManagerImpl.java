package com.efeiyi.ec.system.yale.question.service.impl;

import com.efeiyi.ec.system.yale.question.dao.ScoreboardDao;
import com.efeiyi.ec.system.yale.question.service.ScoreboardManager;
import com.ming800.core.p.model.WxCalledRecord;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2016/1/18.
 * 排行榜service
 */
@Service
public class ScoreboardManagerImpl implements ScoreboardManager {

    @Autowired
    @Qualifier("scoreboardDaoHibernate")
    private ScoreboardDao scoreboardDao;

    @Override
    public Integer getSize(Date selStartDate, Date selEndDate) {
        return scoreboardDao.getSize(selStartDate, selEndDate);
    }

    @Override
    public List<WxCalledRecord> getWxCalledRecordList(PageEntity pageEntity, Date selStartDate, Date selEndDate) {
        return scoreboardDao.getWxCalledRecordList(pageEntity, selStartDate, selEndDate);
    }

    @Override
    public Object[] getAnswerCountAndDate(WxCalledRecord wxCalledRecord, Date selStartDate, Date selEndDate) {
        return scoreboardDao.getAnswerCountAndDate(wxCalledRecord, selStartDate, selEndDate) ;
    }

    @Override
    public BigDecimal getRewardTotal(WxCalledRecord wxCalledRecord, Date selStartDate, Date selEndDate) {
        return scoreboardDao.getRewardTotal(wxCalledRecord, selStartDate, selEndDate);
    }

    @Override
    public Integer getShareCount(WxCalledRecord wxCalledRecord, Date selStartDate, Date selEndDate) {
        return scoreboardDao.getShareCount(wxCalledRecord, selStartDate, selEndDate);
    }
}
