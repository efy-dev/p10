package com.efeiyi.ec.system.master.service.impl;

import com.efeiyi.ec.master.model.*;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.project.model.ProjectTag;
import com.efeiyi.ec.system.master.service.MasterManager;
import com.efeiyi.ec.system.master.service.MasterWorkManager;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.efeiyi.ec.tenant.model.TenantProject;
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
import java.util.List;

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

    @Autowired
    private AutoSerialManager autoSerialManager;

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
    public boolean saveMasterWork(HttpServletRequest request,MultipartRequest multipartRequest) {

        Master master = null;
        try {
            if(StringUtils.isEmpty(request.getParameter("master.id"))){
                return  false;
            }
            master = (Master)xdoDao.getObject(Master.class.getName(),request.getParameter("master.id"));
            if(multipartRequest.getFile("picurl")!=null) {
                SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
                String identify = sdf.format(new Date());
                String url = "banner/" + identify + multipartRequest.getFile("picurl").getOriginalFilename();
                if (!aliOssUploadManager.uploadFile(multipartRequest.getFile("picurl"), "tenant", url)) {
                    return false;
                }

                MasterWork masterWork = new MasterWork();
                masterWork.setPictureUrl(url);
                masterWork.setMaster(master);
                masterWork.setStatus("1");
                masterWork.setName(request.getParameter("name"));
                masterWork.setSerial(autoSerialManager.nextSerial("MasterWork"));
                masterWork.setCreateDateTime(new Date());
                masterWork.setDescription(request.getParameter("description"));

                xdoDao.saveOrUpdateObject(masterWork);

//                String[] tags = request.getParameterValues("tag");
//                if(tags!=null && tags.length>0){
//                    for(String tag : tags){
//                        MasterWorkTag masterWorkTag = new MasterWorkTag();
//                        masterWorkTag.setStatus("1");
//                        masterWorkTag.setMasterWork(masterWork);
//                        masterWorkTag.setProjectTag((ProjectTag)xdoDao.getObject(ProjectTag.class.getName(),tag));
//                        xdoDao.saveOrUpdateObject(masterWorkTag);
//                    }
//                }
            }
        }catch (Exception e){

            e.printStackTrace();
            return  false;
        }


        return  true;
    }
}
