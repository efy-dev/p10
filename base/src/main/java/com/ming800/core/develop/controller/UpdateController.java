package com.ming800.core.develop.controller;

import com.ming800.core.develop.service.UpdateHandler;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-5
 * Time: 下午3:24
 * To change this template use File | Settings | File Templates.
 */
@Controller
@RequestMapping("/update")
public class UpdateController {


    @RequestMapping("/formUpdate.do")
    public ModelAndView formUpdate() throws Exception {
        return new ModelAndView("/core/base/update");
    }


    @RequestMapping("/executeUpdate.do")
    @ResponseBody
    public Boolean executeUpdate(HttpServletRequest request) throws Exception {

        String modelName = request.getParameter("modelName");

        UpdateHandler updateHandler = (UpdateHandler) Class.forName(modelName).newInstance();

        return updateHandler.executeUpdate();
    }


}


