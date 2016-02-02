package com.efeiyi.ec.website.organization.service.impl;

import com.efeiyi.ec.website.organization.dao.UserDao;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.website.organization.service.UserManager;
import com.ming800.core.base.service.BaseManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.dao.DataAccessException;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;

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
    private BaseManager baseManager;


    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException {
        String queryStr = "SELECT u FROM MyUser u WHERE u.username=:username AND u.status != 0";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("username", username);
        MyUser myUser = (MyUser) baseManager.getUniqueObjectByConditions(queryStr, queryParamMap);
        if (myUser == null) {
            throw new UsernameNotFoundException("user '" + username + "' not found...");
        } else {
            return myUser;
        }
    }

    //从所有机构中查找学员用户（学员用户在所有机构中都不能重复）
    public UserDetails loadStudentUserByUsername(String username) throws UsernameNotFoundException, DataAccessException {
        String queryStr = "SELECT u FROM StudentUser u WHERE u.theStatus!=0 AND u.username=:username";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("username", username.split(",")[0]);

//        StudentUser studentUser = studentUserDao.getUniqueStudentUserByConditions(username.split(",")[1], queryStr, queryParamMap);
        return null;
    }

}
