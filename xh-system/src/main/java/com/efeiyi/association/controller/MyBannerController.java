package com.efeiyi.association.controller;

import com.efeiyi.association.OrganizationConst;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.base.service.XdoManager;
import com.ming800.core.base.service.XdoSupportManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.DoQuery;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.service.DoManager;
import com.ming800.core.p.model.Banner;
import com.ming800.core.p.model.Document;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.p.service.BannerManager;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.ApplicationContextUtil;
import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by kayson_yang on 2015/7/13.
 */

@Controller
@RequestMapping("/myBanner")
public class MyBannerController {
    private static Logger logger = Logger.getLogger(MyBannerController.class);
    @Autowired
    private BaseManager baseManager;

    @Autowired
    private BannerManager bannerManager;
    @Autowired
    private XdoManager xdoManager;

    @Autowired
    private XdoSupportManager xdoSupportManager;

    @Autowired
    private DoManager doManager;

    @Autowired
    @Qualifier("aliOssUploadManagerImpl")
    private AliOssUploadManager aliOssUploadManager;

    @Autowired
    @Qualifier("autoSerialManager")
    private AutoSerialManager autoSerialManager;

    /**
     * 通过模块ID获取相关模块的轮播图（状态为可用）的所有对象
     */
    @SuppressWarnings("unchecked")
    @RequestMapping("/ba.do")
    public List<Banner> getBannerByGroupId(ModelMap modelMap, HttpServletRequest request) throws Exception {
        String qm = request.getParameter("qm");
        if (qm.split("_").length < 2) {
            throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
        }
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
        DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
//        modelMap.put("tempDo", tempDo);
//        modelMap.put("doQueryList", tempDo.getDoQueryList());
//        String resultPage = tempDo.getResult();

        PageEntity pageEntity = new PageEntity();
        String pageIndex = request.getParameter("pageEntity.index");
        String pageSize = request.getParameter("pageEntity.size");
        if (pageIndex != null) {
            pageEntity.setIndex(Integer.parseInt(pageIndex));
            pageEntity.setSize(Integer.parseInt(pageSize));
        }

        modelMap.put("tabTitle", tempDoQuery.getLabel());
//                resultPage = "/pc/choiceness";
        PageInfo pageInfo = xdoManager.listPage(tempDo, tempDoQuery, null, pageEntity);
        modelMap.put("pageInfo", pageInfo);
        modelMap.put("pageEntity", pageInfo.getPageEntity());

//                返回列表
//        Map map = request.getParameterMap();
//        xdoSupportManager.generateTempPageConditions(request.getRequestURI(), map, pageEntity.getIndex() + "", pageEntity.getSize() + "");
        // xdoSupportManager.generateTempPageConditions(request.getRequestURI(), map, 1 + "", 20 + "");


        if (tempDo.getExecute() != null && !tempDo.getExecute().equals("")) {
            modelMap = xdoSupportManager.execute(tempDo, modelMap, request);
        }
        modelMap.put("qm", qm);
        modelMap.put("group",tempDo.getLabel());
        return pageInfo.getList();
    }

    /**
     * 保存
     *
     * @param banner
     * @return
     */
    @RequestMapping(value = "/saveBanner.do", method = RequestMethod.POST)
    public ModelAndView saveBanner(@RequestParam(value = "image") MultipartFile multipartFile, HttpServletRequest request, Banner banner) throws Exception {

        String path = request.getParameter("qm");
        //新建内容
        if (banner.getId() == null || "".equals(banner.getId())) {
            banner.setStatus("1");
            banner.setId(null);
            banner.setImageUrl(null);
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "banner/" + identify + ".jpg";

        if (!multipartFile.getOriginalFilename().equals("")) {
            aliOssUploadManager.uploadFile(multipartFile, "association", url);
            url = OrganizationConst.imgBasePath + url;
            banner.setImageUrl(url);
        }
        bannerManager.saveBanner(banner);
        return new ModelAndView("redirect:" /*+ request.getContextPath() */+ path);
    }

    /**
     * 真删
     *
     * @param banner
     * @return
     */
    @RequestMapping("/deleteBanner.do")
    @ResponseBody
    public String deleteBanner(Banner banner) {

        try {

            bannerManager.deleteBanner(banner);

        } catch (Exception e) {
            e.printStackTrace();
        }

        return banner.getId();
    }

    /**
     * 假删
     *
     * @param banner
     * @return
     */
    @RequestMapping("/removeBanner.do")
    @ResponseBody
    public ModelAndView removeDocument(HttpServletRequest request, Banner banner) throws Exception {
        String path = request.getContextPath() + request.getParameter("resultPage");

        bannerManager.removeBanner(banner);

        return new ModelAndView("redirect:" /*+ request.getContextPath()*/ + path);
    }

    /**
     * 新建页面
     *
     * @param banner
     * @return
     */
    @RequestMapping("/newBanner.do")
    public ModelAndView direct2Jsp(ModelMap model, HttpServletRequest request, Banner banner) throws Exception {
        String qm = request.getParameter("qm");

        if (qm.split("_").length < 2) {
            throw new Exception("qm:" + qm + "的具体查询部分没有定义即'_'的后半部分没有定义");
        }
        //先找到配置文件里的entity
        Do tempDo = doManager.getDoByQueryModel(qm.split("_")[0]);
        //再从中找到query的信息
//            DoQuery tempDoQuery = tempDo.getDoQueryByName(qm.split("_")[1]);
        //设置保存后的返回页面
        model.addAttribute("qm", request.getParameter("resultPage"));
        if (banner.getId() != null && !"".equals(banner.getId())) {
            banner = (Banner) baseManager.getObject(banner.getClass().getName(), banner.getId());
            model.addAttribute("object", banner);
        }
        return new ModelAndView(/*request.getContextPath() +*/ tempDo.getResult());
    }


}
