package com.efeiyi.ec.consumer.organization.service.impl;

import com.efeiyi.ec.consumer.organization.dao.UserDao;
import com.efeiyi.ec.consumer.organization.service.UserManager;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.MyUser;

import com.ming800.core.does.model.PageInfo;
import com.ming800.core.taglib.PageEntity;
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
public class UserManagerImpl implements UserManager, UserDetailsService {
    @Autowired
    private UserDao userDao;

    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException {
        String queryStr = "SELECT u FROM MyUser u WHERE u.username=:username AND u.status != 0";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("username", username);
        MyUser myUser = userDao.getUniqueMyUserByConditions(username, queryStr, queryParamMap);
        if (myUser == null) {
            throw new UsernameNotFoundException("user '" + username + "' not found...");
        } else {
            return myUser;
        }
    }

}
