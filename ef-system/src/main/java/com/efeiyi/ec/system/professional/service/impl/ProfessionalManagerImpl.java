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
import org.springframework.util.StringUtils;

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
        Professional tempProfessional = null;
        if("".equals(professional.getId())){
            tempProfessional = new Professional();
        }else {
            tempProfessional =(Professional)xdoDao.getObject(Professional.class.getName(), professional.getId());
        }
        if(!"".equals(professional.getPassword())){

            professional.setPassword(StringUtil.encodePassword(professional.getPassword(), "SHA"));
        }
        tempProfessional.setBigTenant(professional.getBigTenant());
        tempProfessional.setName(professional.getName());
        tempProfessional.setUsername(professional.getUsername());
        tempProfessional.setPhone(professional.getPhone());
        tempProfessional.setSex(professional.getSex());
        tempProfessional.setEmail(professional.getEmail());
        tempProfessional.setStatus("1");
        tempProfessional.setEnabled(true);
        tempProfessional.setAccountExpired(false);
        tempProfessional.setAccountLocked(false);
        tempProfessional.setCredentialsExpired(false);

        if(professional.getCreateDatetime()==null){
            tempProfessional.setCreateDatetime(sdf.parse(date));
        }
        xdoDao.saveOrUpdateObject(tempProfessional);
        return tempProfessional.getId();
    }
}
