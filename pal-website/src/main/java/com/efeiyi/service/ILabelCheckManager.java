package com.efeiyi.service;

import com.efeiyi.pal.label.model.Label;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

/**
 * Created by Administrator on 2015/8/7.
 */
public interface ILabelCheckManager {

     Label getUniqueLabel(String labelId);

     String constructWeiXinMsg(String toUserName, String fromUserName, String content,String url);

     ModelMap updateRecord(ModelMap model, Label label) throws Exception ;

     void saveOrUpdate(String name,Object obj);
}
