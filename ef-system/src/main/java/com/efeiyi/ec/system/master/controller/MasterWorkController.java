package com.efeiyi.ec.system.master.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterWork;
import com.efeiyi.ec.master.model.MasterWorkPicture;
import com.efeiyi.ec.system.master.service.MasterWorkManager;
import com.efeiyi.ec.system.util.PinYi;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.p.service.AliOssUploadManager;
import net.sourceforge.pinyin4j.PinyinHelper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.filter.CharacterEncodingFilter;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/7/20.
 */
@Controller
public class MasterWorkController {


    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private MasterWorkManager masterWorkManager;



    @RequestMapping("/masterWork/uploadify.do")
    @ResponseBody
    public String uploadProductImg(HttpServletRequest request, HttpServletResponse response) throws Exception {
          String data = "";
        String flag = request.getParameter("flag");
          MasterWork  masterWork = (MasterWork) baseManager.getObject(MasterWork.class.getTypeName(), request.getParameter("masterWorkId"));
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        Map<String, MultipartFile> fileMap = multipartRequest.getFileMap();
        // String ctxPath = request.getSession().getServletContext().getRealPath("/")+ File.separator+"uploadFiles";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
        String identify = sdf.format(new Date());
        String url = "";
        Integer sort = 0;
        for (Map.Entry<String, MultipartFile> entry : fileMap.entrySet()) {
            MasterWorkPicture masterWorkPicture = new MasterWorkPicture();
            //上传文件
            MultipartFile mf = entry.getValue();
            String fileName = mf.getOriginalFilename();//获取原文件名
            Integer index = 0;
            String hz = fileName.substring(fileName.indexOf("."),fileName.length());
            String imgName = fileName.substring(0, fileName.indexOf(hz));
            url = "masterWork/" + fileName.substring(0, fileName.indexOf(hz)) + identify + hz;

                try {
                    aliOssUploadManager.uploadFile(mf, "ec-efeiyi", url);
                   if("img".equals(flag)) {
                       XQuery xQuery = new XQuery("listMasterWorkPicture_default", request);
                       xQuery.put("masterWork_id", masterWork.getId());
                       List<MasterWorkPicture> masterWorkPictureList = (List<MasterWorkPicture>) baseManager.listObject(xQuery);
                       if (masterWorkPictureList != null) {
                           if (masterWorkPictureList.size() != 0) {
                               sort = masterWorkPictureList.get(0).getSort() + 1;
                           }
                       }
                       masterWorkPicture.setPictureUrl(url);
                       masterWorkPicture.setStatus("1");
                       masterWorkPicture.setMasterWork(masterWork);
                       masterWorkPicture.setSort(sort);
                       baseManager.saveOrUpdate(MasterWorkPicture.class.getName(), masterWorkPicture);
                       data = masterWorkPicture.getId() + ":" + url + ":" + imgName + hz + ":" + sort;
                   }else if("audio".equals(flag)){
                       masterWork.setAudio(url);
                       baseManager.saveOrUpdate(MasterWork.class.getName(),masterWork);
                       data = url;
                   }
                } catch (Exception e) {
                    e.printStackTrace();
                }

        }
        System.out.print(url);
        return data;


    }

    @RequestMapping("/masterWork/changePictureSort.do")
    @ResponseBody
    public String changePictureSort(String sourceId,String sourceSort,String targetId,String targetSort ) throws Exception {
        masterWorkManager.changePictureSort(sourceId,sourceSort,targetId,targetSort);
        return "";

    }

    @RequestMapping("/masterWork/updatePicture.do")
    @ResponseBody
    public Boolean updatePicture(String id,String flag ) throws Exception {
        Boolean data = true;
        try {

            MasterWorkPicture masterWorkPicture = (MasterWorkPicture) baseManager.getObject(MasterWorkPicture.class.getName(),id);
            MasterWork masterWork = masterWorkPicture.getMasterWork();
            if("false".equals(flag)){
                masterWork.setPictureUrl(masterWorkPicture.getPictureUrl());
            }else {
                masterWork.setPictureUrl(null);
            }
            baseManager.saveOrUpdate(MasterWork.class.getName(),masterWork);
        }catch (Exception e){
            data = false;
            e.printStackTrace();
        }
        return data;

    }



    @RequestMapping("/masterWork/getPinyin.do")
    @ResponseBody
    public boolean getPinyin(HttpServletRequest request){
        boolean b = true;
        PinYi pinYi = new PinYi();
        try {
            XQuery xQuery =  new XQuery("listMaster3_default",request);
            List<Master> masterList = baseManager.listObject(xQuery);
            for(Master master :masterList){
                if((master.getName()==null||"".equals(master.getName()))){
                    String s = pinYi.getStringPinYin(master.getFullName());
                    master.setName(s);
                    baseManager.saveOrUpdate(Master.class.getName(),master);
                }
            }
        }catch (Exception e){
            b = false;
        }

        return b;
    }


}
