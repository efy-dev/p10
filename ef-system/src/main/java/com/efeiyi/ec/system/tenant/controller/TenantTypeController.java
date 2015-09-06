package com.efeiyi.ec.system.tenant.controller;

import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductPicture;
import com.efeiyi.ec.tenant.model.EnterpriseTenant;
import com.efeiyi.ec.tenant.model.PersonalTenant;
import com.efeiyi.ec.tenant.model.PrivateTenant;
import com.efeiyi.ec.tenant.model.Tenant;
import com.ming800.core.base.controller.BaseController;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.Map;

/**
 * Created by AC丶man on 2015/9/1.
 */
@Controller
@RequestMapping("/tenant")
public class TenantTypeController extends BaseController {

	@Autowired
	private AliOssUploadManager aliOssUploadManager;
	@Autowired
	private BaseManager baseManager;

	@RequestMapping("/uploadify.do")
	@ResponseBody
	public String uploadProductImg(HttpServletRequest request,String dataType) throws Exception{
		String data = "";
		String tenantId = request.getParameter("tenantId");
		Tenant tenant = (Tenant)baseManager.getObject(Tenant.class.getTypeName(),tenantId);
		MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
		Map<String,MultipartFile> fileMap = multipartRequest.getFileMap();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String identify = sdf.format(new Date());
		String url = "" ;
		for (Map.Entry<String,MultipartFile> entry : fileMap.entrySet()){
			//上传文件

			MultipartFile mf = entry.getValue();
			String fileName = mf.getOriginalFilename();//获取原文件名
			url = "tenant/"+fileName.substring(0,fileName.indexOf(".jpg"))+identify+".jpg";
			if ("13".equals(tenant.getTenantType())){
				PersonalTenant personalTenant = (PersonalTenant) baseManager.getObject(PersonalTenant.class.getName(),tenant.getId());
				if("frontPhotoUrl".equals(dataType)){
					personalTenant.setFrontPhotoUrl(url);
				}else if("versoPhotoUrl".equals(dataType)){
					personalTenant.setVersoPhotoUrl(url);
				}else if("identityPhotoUrl".equals(dataType)){
					personalTenant.setIdentityPhotoUrl(url);
				}
				baseManager.saveOrUpdate(PersonalTenant.class.getName(),personalTenant);
			}else if("12".equals(tenant.getTenantType())){
				PrivateTenant privateTenant = (PrivateTenant) baseManager.getObject(PrivateTenant.class.getName(),tenant.getId());
				if("businessLicense".equals(dataType)){
					privateTenant.setBusinessLicense(url);
				}else if("frontPhotoUrl".equals(dataType)){
					privateTenant.setFrontPhotoUrl(url);
				}else if("versoPhotoUrl".equals(dataType)){
					privateTenant.setVersoPhotoUrl(url);
				}else if("taxRegistrationAttachment".equals(dataType)){
					privateTenant.setTaxRegistrationAttachment(url);
				}
				baseManager.saveOrUpdate(PrivateTenant.class.getName(),privateTenant);
			}else if("11".equals(tenant.getTenantType())){
				EnterpriseTenant enterpriseTenant = (EnterpriseTenant) baseManager.getObject(EnterpriseTenant.class.getName(),tenant.getId());
				if("organizationAttachment".equals(dataType)){
					enterpriseTenant.setOrganizationAttachment(url);
				}else if("bankAttachment".equals(dataType)){
					enterpriseTenant.setBankAttachment(url);
				}else if("businessLicense".equals(dataType)){
					enterpriseTenant.setBusinessLicense(url);
				}else if("taxRegistrationAttachment".equals(dataType)){
					enterpriseTenant.setTaxRegistrationAttachment(url);
				}else if("businessLicense".equals(dataType)){
					enterpriseTenant.setBusinessLicense(url);
				}else if("frontPhotoUrl".equals(dataType)){
					enterpriseTenant.setFrontPhotoUrl(url);
				}else if("versoPhotoUrl".equals(dataType)){
					enterpriseTenant.setVersoPhotoUrl(url);
				}
				baseManager.saveOrUpdate(EnterpriseTenant.class.getName(),enterpriseTenant);
			}
			try {
				aliOssUploadManager.uploadFile(mf, "ec-efeiyi", url);
				data = tenant.getId() + ":" + url;
			}catch (Exception e){
				e.printStackTrace();
			}
		}
		System.out.print(url);
		return data;


	}
}
