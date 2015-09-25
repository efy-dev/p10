package com.efeiyi.association.service;

import com.efeiyi.association.dao.UserDao;
import com.efeiyi.ec.association.model.AssMyUser;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.LinkedHashMap;

/**
 * Created by Administrator on 2015/8/10.
 */
@Service
@Transactional
public class UserLoginManager implements UserDetailsService {

    @Autowired
    private UserDao userLoginDao;

    public void setUserLoginDao(UserDao userLoginDao) {
        this.userLoginDao = userLoginDao;
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {

        String queryStr = "SELECT u FROM AssMyUser u WHERE u.name=:username AND u.status != 0";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("username", username);
        System.out.println("username is " + username);

        AssMyUser myUser = userLoginDao.getUniqueMyUserByConditions(username, queryStr, queryParamMap);
        System.out.println("查询完数据 ");
        if (myUser == null) {
            System.out.println("myuser is null");
            throw new UsernameNotFoundException("user '" + username + "' not found...");
        } else {
            return myUser;
        }
    }

}
