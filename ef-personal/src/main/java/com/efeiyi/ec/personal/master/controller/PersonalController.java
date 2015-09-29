package com.efeiyi.ec.personal.master.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * Created by AC丶man on 2015/9/28.
 */
@Controller
@RequestMapping("/personal")
public class PersonalController {


	@RequestMapping("getPersonal.do")
	public String getPersonal(){
		return "/personal/personalCenter";
	}

}
