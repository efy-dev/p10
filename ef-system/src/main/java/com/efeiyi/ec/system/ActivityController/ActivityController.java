package com.efeiyi.ec.system.ActivityController;

import com.efeiyi.ec.organization.model.ConsumerAddress;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * Created by AC丶man on 2015/8/31.
 */
@Controller
@RequestMapping("/activity")
public class ActivityController {

	@Autowired
	private BaseManager baseManager;


	@RequestMapping("/yx.do")

	public String  yx(HttpServletRequest request)throws Exception{

		return  "redirect:http://tuan.efeiyi.com/group/sendRedPacket";

	}

}
