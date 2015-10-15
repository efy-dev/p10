package com.efeiyi.ec.system.professional.service.impl;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.organization.model.Professional;
import com.efeiyi.ec.product.model.*;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectPropertyValue;
import com.efeiyi.ec.system.product.dao.ProductDao;
import com.efeiyi.ec.system.product.model.ProductModelBean;
import com.efeiyi.ec.system.product.service.ProductManager;
import com.efeiyi.ec.system.professional.service.ProfessionalManager;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
@Service
public class ProfessionalManagerImpl implements ProfessionalManager{


    @Autowired
    private XdoDao xdoDao;


    @Override
    public String saveProfessional(Professional professional) throws Exception{
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
        String date = sdf.format(new Date());
        if("".equals(professional.getPassword())){
            Professional tempProfessional =(Professional)xdoDao.getObject(Professional.class.getName(), professional.getId());
            professional.setPassword(tempProfessional.getPassword());
        }
        professional.setPassword(StringUtil.encodePassword(professional.getPassword(), "SHA"));
        professional.setStatus("1");
        professional.setEnabled(true);
        professional.setAccountExpired(false);
        professional.setAccountLocked(false);
        professional.setCredentialsExpired(false);
        if("".equals(professional.getId())){
            professional.setId(null);
        }
        if(professional.getCreateDatetime()==null){
            professional.setCreateDatetime(sdf.parse(date));
        }
        xdoDao.saveOrUpdateObject(professional);
        return professional.getId();
    }
}
