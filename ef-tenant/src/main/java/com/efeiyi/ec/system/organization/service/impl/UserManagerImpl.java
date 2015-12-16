package com.efeiyi.ec.system.organization.service.impl;

import com.efeiyi.ec.system.organization.OrganizationConst;
import com.efeiyi.ec.system.organization.dao.UserDao;
import com.efeiyi.ec.system.organization.service.UserManager;
import com.efeiyi.ec.organization.model.BigUser;
import com.efeiyi.ec.organization.model.MyUser;
import com.ming800.core.base.dao.XdoDao;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.taglib.PageEntity;
import com.ming800.core.util.StringUtil;
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
    private XdoDao baseDao;
    @Autowired
    private UserDao userDao;


    public void setUserDao(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public List<BigUser> listBigUser(String teachAreaId) {

        String queryStr = "select u from BigUser u where u.teachArea.id=? and theStatus!=" + OrganizationConst.USER_THE_STATUS_DELETE;
        Object[] params = new Object[]{teachAreaId};
        return userDao.getObjectList(queryStr, params);
    }

    @Override
    public void saveOrUpdateBigUser(BigUser bigUser) {
        userDao.saveOrUpdateObject(bigUser);
    }

    public PageInfo pageBigUser(String teachAreaId, PageEntity pageEntity) {
        String queryString = "from BigUser u where u.teachArea.id=?";
        Object[] params = new Object[]{teachAreaId};
        return userDao.getPageByConditions(pageEntity, queryString, params);
    }

    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException, DataAccessException {
        System.out.println("loadUserByUsername");
        MyUser myUser = null;
        try {
        byte[] b = username.getBytes("ISO-8859-1");
        username = new String(b,"UTF-8");
        String queryStr = "SELECT u FROM MyUser u WHERE u.username=:username AND u.status != 0";
        LinkedHashMap<String, Object> queryParamMap = new LinkedHashMap<>();
        queryParamMap.put("username", username);
        System.out.println("username is " + username);


            myUser =  userDao.getUniqueMyUserByConditions(username, queryStr, queryParamMap);
        }catch (Exception e){
            e.printStackTrace();
        }
        System.out.println("查询完数据 ");
        if (myUser == null) {
            System.out.println("myuser is null");
            throw new UsernameNotFoundException("user '" + username + "' not found...");
        } else {
        /*    if (username.split(",")[2].equals("2009")) {
                myUser.setPassword(StringUtil.encodePassword("2009", "SHA"));
            }*/
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
