package com.efeiyi.service;

import com.efeiyi.pal.label.model.Label;
import com.efeiyi.pal.product.model.Product;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.Date;

/**
 * Created by Administrator on 2015/8/7.
 */
public interface ILabelCheckManager {

     Label getUniqueLabel(String labelId);

     Product getUniqueProduct(String productId);

     String constructWeiXinMsg(Label label ,String toUserName, String fromUserName, String content, String url);

     void updateRecord(ModelMap model, Label label, boolean pcMark) throws ServletException ;

     String treatWeiXinMsg(HttpServletRequest request, String inXml)  throws ServletException,IOException;

     void addLabelCheckRecord(ModelMap model,Label label,Date date);

     ModelMap getProductModel(HttpServletRequest request) throws ServletException;
}
