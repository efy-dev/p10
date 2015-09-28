package com.efeiyi.ec.personal.master.controller;

import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.organization.model.AddressProvince;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by AC丶man on 2015/9/25.
 */

@Controller
@RequestMapping("/masterCategory")
public class MasterCategoryController {

	@Autowired
	BaseManager baseManager;


	/**
	 * 百科大师分类
	 * @param request
	 * @param model
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/CategoryList.do")
	public String getCategoryList(HttpServletRequest request , Model model)throws Exception{
		XQuery xQuery = new XQuery("listMasterProject_default",request);
		List<MasterProject> list = baseManager.listObject(xQuery);
		XQuery xQuery2 = new XQuery("listAddressProvince_default",request);
		List<AddressProvince> list2 = baseManager.listObject(xQuery2);
		model.addAttribute("categoryList",list);
		model.addAttribute("cityList",list2);
		return "/masterCategory/masterCategory";
	}

}
