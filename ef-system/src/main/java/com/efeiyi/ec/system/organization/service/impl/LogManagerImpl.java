package com.efeiyi.ec.system.organization.service.impl;

import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.system.organization.OrganizationConst;
import com.efeiyi.ec.system.organization.dao.UserDao;
import com.efeiyi.ec.system.organization.service.LogManager;
import com.efeiyi.ec.system.organization.service.UserManager;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.taglib.PageEntity;
import org.aspectj.lang.JoinPoint;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-10-15
 * Time: 下午5:02
 * To change this template use File | Settings | File Templates.
 */

@Service
@Transactional
public class LogManagerImpl implements LogManager {

     private void  saveInfoLog(JoinPoint point){

     }


}
