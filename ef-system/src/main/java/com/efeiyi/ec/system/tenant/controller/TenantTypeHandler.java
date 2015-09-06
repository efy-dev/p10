package com.efeiyi.ec.system.tenant.controller;

import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.Do;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.does.service.MultipartHandler;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.util.ApplicationContextUtil;
import org.springframework.ui.ModelMap;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

/**
 * Created by AC丶man on 2015/8/29.
 */
public class TenantTypeHandler implements MultipartHandler {

	private AliOssUploadManager aliOssUploadManager = (AliOssUploadManager) ApplicationContextUtil.getApplicationContext().getBean("aliOssUploadManagerImpl");
	private BaseManager baseManager = (BaseManager) ApplicationContextUtil.getApplicationContext().getBean("baseManagerImpl");

	@Override
	public ModelMap handleMultipart(Do tempDo, ModelMap modelMap, HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
		String type = request.getParameter("type");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String identify = sdf.format(new Date());
		String url = "photo/" + identify + ".jpg";
		XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate(tempDo.getName(), request);
		HashMap<String, Object> paramMap = xSaveOrUpdate.getParamMap();
		MultipartHttpServletRequest multipartRequests = (MultipartHttpServletRequest) request;
		Map<String,MultipartFile> fileMap = multipartRequest.getFileMap();
		if("13".equals(type)){
			String path = request.getParameter("identityPhotoUrl");
			if (!multipartRequest.getFile("identityPhotoUrl").getOriginalFilename().equals("")) {
//				aliOssUploadManager.uploadFile(multipartRequest.getFile("identityPhotoUrl"), "tenant", multipartRequest.getFile("identityPhotoUrl").getOriginalFilename());
				paramMap.put("identityPhotoUrl", multipartRequest.getFile("identityPhotoUrl").getOriginalFilename());
			}
		}else if("12".equals(type)){
			if (!multipartRequest.getFile("businessLicense").getOriginalFilename().equals("")) {
//				aliOssUploadManager.uploadFile(multipartRequest.getFile("businessLicense"), "tenant", multipartRequest.getFile("businessLicense").getOriginalFilename());
				paramMap.put("businessLicense", multipartRequest.getFile("businessLicense").getOriginalFilename());
			}
			if (!multipartRequest.getFile("taxRegistrationAttachment").getOriginalFilename().equals("")) {
//				aliOssUploadManager.uploadFile(multipartRequest.getFile("taxRegistrationAttachment"), "tenant", multipartRequest.getFile("taxRegistrationAttachment").getOriginalFilename());
				paramMap.put("taxRegistrationAttachment", multipartRequest.getFile("taxRegistrationAttachment").getOriginalFilename());
			}
		}else if("11".equals(type)){
			if (!multipartRequest.getFile("businessLicense").getOriginalFilename().equals("")) {
//				aliOssUploadManager.uploadFile(multipartRequest.getFile("businessLicense"), "tenant", multipartRequest.getFile("businessLicense").getOriginalFilename());
				paramMap.put("businessLicense", multipartRequest.getFile("businessLicense").getOriginalFilename());
			}
			if (!multipartRequest.getFile("taxRegistrationAttachment").getOriginalFilename().equals("")) {
//				aliOssUploadManager.uploadFile(multipartRequest.getFile("taxRegistrationAttachment"), "tenant", multipartRequest.getFile("taxRegistrationAttachment").getOriginalFilename());
				paramMap.put("taxRegistrationAttachment", multipartRequest.getFile("taxRegistrationAttachment").getOriginalFilename());
			}
			if (!multipartRequest.getFile("organizationAttachment").getOriginalFilename().equals("")) {
//				aliOssUploadManager.uploadFile(multipartRequest.getFile("organizationAttachment"), "tenant", multipartRequest.getFile("organizationAttachment").getOriginalFilename());
				paramMap.put("organizationAttachment", multipartRequest.getFile("organizationAttachment").getOriginalFilename());
			}
			if (!multipartRequest.getFile("bankAttachment").getOriginalFilename().equals("")) {
//				aliOssUploadManager.uploadFile(multipartRequest.getFile("bankAttachment"), "tenant", multipartRequest.getFile("bankAttachment").getOriginalFilename());
				paramMap.put("bankAttachment", multipartRequest.getFile("bankAttachment").getOriginalFilename());
			}
		}

		if (!multipartRequest.getFile("frontPhotoUrl").getOriginalFilename().equals("")) {
//			aliOssUploadManager.uploadFile(multipartRequest.getFile("frontPhotoUrl"), "tenant", multipartRequest.getFile("frontPhotoUrl").getOriginalFilename());
			paramMap.put("frontPhotoUrl", multipartRequest.getFile("frontPhotoUrl").getOriginalFilename());
		}
		if (!multipartRequest.getFile("versoPhotoUrl").getOriginalFilename().equals("")) {
//			aliOssUploadManager.uploadFile(multipartRequest.getFile("versoPhotoUrl"), "tenant", multipartRequest.getFile("versoPhotoUrl").getOriginalFilename());
			paramMap.put("versoPhotoUrl", multipartRequest.getFile("versoPhotoUrl").getOriginalFilename());
		}

		//������� start
		Object object = baseManager.saveOrUpdate(xSaveOrUpdate);
		//������� end
		modelMap.put("object", object);

		return modelMap;
	}
}
