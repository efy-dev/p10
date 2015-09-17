package com.efeiyi.ec.wiki.base.controller;

import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.ObjectRecommendedManager;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by Administrator on 2015/8/4.
 *
 */
public class WikibaseController extends BaseController {
    private static Logger logger = Logger.getLogger(WikibaseController.class);
    @Autowired
    BaseManager baseManager;
    @Autowired
    ObjectRecommendedManager objectRecommendedManager;


    /**
     * 非遗项目
     * @param  request is HttpServletRequest
     * @return projectList
     * @throws Exception
     */
    public List getFeiyiProjectList(HttpServletRequest request)throws Exception{
        XQuery xQuery = new XQuery("listWikiProject_default",request);
        return  baseManager.listObject(xQuery);
    }

    /**
     * 精彩非遗项目
     * @return wondenfulProjectList
     * @throws Exception
     */
    public  List getWondenfulProjectList()throws Exception{
        return objectRecommendedManager.getRecommendedList("WondenfulProject");
    }

    /**
     * 推荐项目
     * @return recommendProjectList
     * @throws Exception
     */
    public  List getRecommendProjectList()throws Exception{
        return objectRecommendedManager.getRecommendedList("ProjectRecommended");
    }

    /**
     * 传承人推荐
     * @return recommendTenantList
     * @throws Exception
     */
    public  List getRecommendTenantList()throws Exception{
        return objectRecommendedManager.getRecommendedList("masterRecommended");
    }

    /**
     * 精彩视频
     * @return wondenfulVideosList
     * @throws Exception
     */
    public  List getWondenfulVideosList()throws Exception{
        return objectRecommendedManager.getRecommendedList("WondenfulVideo");
    }



}
