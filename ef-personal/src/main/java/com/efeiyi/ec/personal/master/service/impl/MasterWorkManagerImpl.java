package com.efeiyi.ec.personal.master.service.impl;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterWork;
import com.efeiyi.ec.master.model.MasterWorkPicture;
import com.efeiyi.ec.personal.master.service.MasterWorkManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午11:04
 * To change this template use File | Settings | File Templates.
 */
@Service
public class MasterWorkManagerImpl implements MasterWorkManager {

    @Autowired
    private XdoDao xdoDao;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Override
    public void changePictureSort(String sourceId, String sourceSort, String targetId, String targetSort) {
        MasterWorkPicture source = (MasterWorkPicture) xdoDao.getObject(MasterWorkPicture.class.getName(), sourceId);
        MasterWorkPicture target = (MasterWorkPicture) xdoDao.getObject(MasterWorkPicture.class.getName(), targetId);
        source.setSort(Integer.parseInt(targetSort));
        target.setSort(Integer.parseInt(sourceSort));
        xdoDao.saveOrUpdateObject(source);
        xdoDao.saveOrUpdateObject(target);
    }

    @Override
    public String saveMasterWork(HttpServletRequest request, MultipartRequest multipartRequest) {
        Master master;
        MasterWork masterWork = null;
        String id = request.getParameter("id");
        try {
            if (!StringUtils.isEmpty(request.getParameter("master.id"))) {
                master = (Master) xdoDao.getObject(Master.class.getName(), request.getParameter("master.id"));
                if (multipartRequest.getFile("picurl") != null) {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                    String identify = sdf.format(new Date());
                    String url = "banner/" + identify + multipartRequest.getFile("picurl").getOriginalFilename();
                    if (aliOssUploadManager.uploadFile(multipartRequest.getFile("picurl"), "tenant", url)) {
                        if (id == null || "".equals(id)){
                            masterWork = new MasterWork();
                        }else{
                            masterWork = (MasterWork) xdoDao.getObject(MasterWork.class.getName(),id);
                        }
                        masterWork.setPictureUrl(url);
                        masterWork.setMaster(master);
                        masterWork.setStatus("1");
                        masterWork.setName(request.getParameter("name"));
                        masterWork.setCreateDateTime(new Date());
                        masterWork.setDescription(request.getParameter("description"));
                        xdoDao.saveOrUpdateObject(masterWork);
                    }
                }
            }
        } catch (Exception e) {

            e.printStackTrace();
        }
        return masterWork.getId();
    }
}
