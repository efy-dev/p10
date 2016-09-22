package com.efeiyi.ec.system.yuanqu.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.organization.model.Image;
import com.efeiyi.ec.organization.model.ImagePanel;
import com.efeiyi.ec.organization.model.Panel;
import com.efeiyi.ec.product.model.Recommend;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.EnterpriseTenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.taglib.PageEntity;
import javafx.scene.layout.Pane;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.method.P;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 2016/9/6 0006.
 */
@Controller
@RequestMapping({"/yuanqu"})
public class OffLineTenantController {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Autowired
    private AutoSerialManager autoSerialManager;

    @RequestMapping({"/tenantForm"})
    public String tenantForm() {
        return "/yuanqu/tenantForm";
    }

    @RequestMapping({"/tenant/baseSubmit"})
    @ResponseBody
    public Object baseSubmit(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        EnterpriseTenant tenant;
        String id = request.getParameter("id");
        if (id != null) {
            tenant = (EnterpriseTenant) baseManager.getObject(EnterpriseTenant.class.getName(), id);
        } else {
            tenant = new EnterpriseTenant();
            tenant.setSerial(autoSerialManager.nextSerial("product"));
        }
        tenant.setName(request.getParameter("name"));
        tenant.setAddress(request.getParameter("address"));
        tenant.setLatitude(Double.parseDouble(request.getParameter("latitude")));
        tenant.setLongitude(Double.parseDouble(request.getParameter("longitude")));
        tenant.setContent(request.getParameter("content"));
        tenant.setTenantType(BigTenant.TENANT_TYPE_OFFLINE);
        tenant.setStatus("1");
        tenant.setCreateDateTime(new Date());
        baseManager.saveOrUpdate(EnterpriseTenant.class.getName(), tenant);
        Iterator<String> fileNames = multipartRequest.getFileNames();
        while (fileNames.hasNext()) {
            String filename = fileNames.next();
            MultipartFile multipartFile = multipartRequest.getFile(filename);
            String oName = multipartFile.getOriginalFilename();
            String nName;
            try {
                nName = System.currentTimeMillis() + "" + (int) (Math.random() * 1000000) + "." + oName.split("\\.")[1];
            } catch (Exception e) {
                continue;
            }
            String url = "image/" + nName;
            aliOssUploadManager.uploadFile(multipartFile, "ef-wiki", url);
            String fullUrl = PConst.OSS_EF_WIKI_HOST + url;
            if (filename.equals("pictureUrl")) {
                tenant.setPictureUrl(fullUrl);
            } else if (filename.equals("logoUrl")) {
                tenant.setLogoUrl(fullUrl);
            }
            Image image = new Image();
            image.setName(filename);
            image.setCreateTime(new Date());
            image.setOwner(tenant.getId());
            image.setSrc(fullUrl);
            image.setStatus("1");
            if (multipartFile.getContentType().contains("audio")) {
                image.setType("2");
            } else {
                image.setType("1");
            }
            baseManager.saveOrUpdate(Image.class.getName(), image);
        }
        baseManager.saveOrUpdate(EnterpriseTenant.class.getName(), tenant);
        return tenant;
    }


    @RequestMapping({"/tenant/checkSubmit"})
    @ResponseBody
    public Object checkSubmit(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        String id = request.getParameter("id");
        if (id == null) {
            return null;
        }
        EnterpriseTenant tenant = (EnterpriseTenant) baseManager.getObject(EnterpriseTenant.class.getName(), id);
        tenant.setContractNumber(request.getParameter("contractNumber"));
        tenant.setEpositBank(request.getParameter("epositBank"));
        tenant.setAccount(request.getParameter("account"));
        tenant.setIdentity(request.getParameter("identity"));
        tenant.setLegalName(request.getParameter("legalName"));
        tenant.setRegisteredAssets(request.getParameter("registeredAssets"));
        tenant.setBusinessScope(request.getParameter("businessScope"));
        tenant.setPhone(request.getParameter("phone"));
        Iterator<String> fileNames = multipartRequest.getFileNames();
        while (fileNames.hasNext()) {
            String filename = fileNames.next();
            MultipartFile multipartFile = multipartRequest.getFile(filename);
            String oName = multipartFile.getOriginalFilename();
            String nName;
            try {
                nName = System.currentTimeMillis() + "" + (int) (Math.random() * 1000000) + "." + oName.split("\\.")[1];
            } catch (Exception e) {
                continue;
            }
            String url = "image/" + nName;
            aliOssUploadManager.uploadFile(multipartFile, "ef-wiki", url);
            String fullUrl = PConst.OSS_EF_WIKI_HOST + url;
            if (filename.equals("organizationAttachment")) {
                tenant.setOrganizationAttachment(fullUrl);
            } else if (filename.equals("bankAttachment")) {
                tenant.setBankAttachment(fullUrl);
            } else if (filename.equals("businessLicense")) {
                tenant.setBusinessLicense(fullUrl);
            } else if (filename.equals("taxRegistrationAttachment")) {
                tenant.setTaxRegistrationAttachment(fullUrl);
            }
            Image image = new Image();
            image.setName(filename);
            image.setCreateTime(new Date());
            image.setOwner(tenant.getId());
            image.setSrc(fullUrl);
            image.setStatus("1");
            image.setType("1");
            baseManager.saveOrUpdate(Image.class.getName(), image);
        }
        baseManager.saveOrUpdate(EnterpriseTenant.class.getName(), tenant);
        return tenant;
    }

    @RequestMapping({"/tenant/masterSubmit"})
    @ResponseBody
    public Object masterSubmit(HttpServletRequest request) {
        String tenantId = request.getParameter("id");
        String masterId = request.getParameter("masterId");
        if (tenantId == null || masterId == null) {
            return null;
        }
        BigTenant tenant = (BigTenant) baseManager.getObject(BigTenant.class.getName(), tenantId);
        Master master = (Master) baseManager.getObject(Master.class.getName(), masterId);
        TenantMaster tenantMaster = new TenantMaster();
        tenantMaster.setTenant(tenant);
        tenantMaster.setMaster(master);
        tenantMaster.setStatus("1");
        baseManager.saveOrUpdate(TenantMaster.class.getName(), tenantMaster);
        List<TenantMaster> tenantMasters = new ArrayList<>();
        tenantMasters.add(tenantMaster);
        tenant.setTenantMasterList(tenantMasters);
        return tenant;
    }

    @RequestMapping({"/tenant/getTenantById"})
    @ResponseBody
    public Object getTenantById(HttpServletRequest request) {
        String id = request.getParameter("id");
        return baseManager.getObject(EnterpriseTenant.class.getName(), id);
    }


    @RequestMapping({"/tenant/getTenantMasterList"})
    @ResponseBody
    public Object getTenantMasterList(HttpServletRequest request) {
        String name = request.getParameter("name");
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        String hql = "select obj from Master obj where obj.fullName like :name and obj.status='1'";
        param.put("name", "%" + name + "%");
        return baseManager.listObject(hql, param);
    }

    @RequestMapping({"/tenant/getPanelListByTenant"})
    @ResponseBody
    public Object getPanelListByTenant(HttpServletRequest request) {
        String tenantId = request.getParameter("id");
        String hql = "select obj from Panel obj where obj.owner=:tenantId and obj.status='1'";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("tenantId", tenantId);
        return baseManager.listObject(hql, param);
    }


    @RequestMapping({"/tenant/getTenantList"})
    @ResponseBody
    public Object getTenantList(HttpServletRequest request) {
        int limit = Integer.parseInt(request.getParameter("limit"));
        int offset = Integer.parseInt(request.getParameter("offset"));
        String name = request.getParameter("name");
        String hql = "select obj from BigTenant obj where obj.tenantType='" + BigTenant.TENANT_TYPE_OFFLINE + "' and obj.status!='0'";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        if (name != null) {
            hql += " and obj.name=:name";
            param.put("name", name);
        }
        hql += " order by obj.createDateTime desc";
        PageEntity pageEntity = new PageEntity();
        pageEntity.setSize(limit);
        pageEntity.setrIndex(offset * -1);
        PageInfo pageInfo = baseManager.listPageInfo(hql, pageEntity, param);
        return pageInfo.getList();
    }

    @RequestMapping({"/tenant/getScenicList"})
    @ResponseBody
    public Object getScenicList(HttpServletRequest request) {
        int limit = Integer.parseInt(request.getParameter("limit"));
        int offset = Integer.parseInt(request.getParameter("offset"));
        String name = request.getParameter("name");
        String hql = "select obj from BigTenant obj where obj.tenantType='" + BigTenant.TENANT_TYPE_SCENIC + "' and obj.status!='0'";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        if (name != null) {
            hql += " and obj.name=:name";
            param.put("name", name);
        }
        hql += " order by obj.createDateTime desc";
        PageEntity pageEntity = new PageEntity();
        pageEntity.setSize(limit);
        pageEntity.setrIndex(offset * -1);
        PageInfo pageInfo = baseManager.listPageInfo(hql, pageEntity, param);
        return pageInfo.getList();
    }


    @RequestMapping({"/tenant/getScenicRegionById"})
    @ResponseBody
    public Object getScenicRegionById(HttpServletRequest request) {
        String id = request.getParameter("id");
        BigTenant tenant = (BigTenant) baseManager.getObject(BigTenant.class.getName(), id);
        return tenant;
    }

    @RequestMapping({"/tenant/panelSubmit"})
    @ResponseBody
    public Object panelSubmit(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        Panel panel = new Panel();
        panel.setStatus("1");
        panel.setType("1");
        panel.setName(request.getParameter("name"));
        panel.setOwner(request.getParameter("id"));
        panel.setContent(request.getParameter("content"));
        baseManager.saveOrUpdate(Panel.class.getName(), panel);
        for (MultipartFile multipartFile : multipartRequest.getFiles("imageList")) {
            String oName = multipartFile.getOriginalFilename();
            String nName;
            try {
                nName = System.currentTimeMillis() + "" + (int) (Math.random() * 1000000) + "." + oName.split("\\.")[1];
            } catch (Exception e) {
                continue;
            }
            String url = "image/" + nName;
            aliOssUploadManager.uploadFile(multipartFile, "ef-wiki", url);
            String fullUrl = PConst.OSS_EF_WIKI_HOST + url;
            Image image = new Image();
            image.setStatus("1");
            image.setType("1");
            image.setOwner(panel.getId());
            image.setCreateTime(new Date());
            image.setSrc(fullUrl);
            ImagePanel imagePanel = new ImagePanel();
            imagePanel.setImage(image);
            imagePanel.setPanel(panel);
            baseManager.saveOrUpdate(Image.class.getName(), image);
            baseManager.saveOrUpdate(ImagePanel.class.getName(), imagePanel);
        }

        MultipartFile multipartFile = multipartRequest.getFile("media");
        if (multipartFile != null) {
            String oName = multipartFile.getOriginalFilename();
            String nName;
            String fullUrl = null;
            try {
                nName = System.currentTimeMillis() + "" + (int) (Math.random() * 1000000) + "." + oName.split("\\.")[1];
                String url = "image/" + nName;
                aliOssUploadManager.uploadFile(multipartFile, "ef-wiki", url);
                fullUrl = PConst.OSS_EF_WIKI_HOST + url;
            } catch (Exception e) {
                e.printStackTrace();
            }
            Image image = new Image();
            image.setStatus("1");
            image.setType("2");
            image.setOwner(panel.getId());
            image.setCreateTime(new Date());
            image.setSrc(fullUrl);
            baseManager.saveOrUpdate(Image.class.getName(), image);
            panel.setMedia(image);
            baseManager.saveOrUpdate(Panel.class.getName(), panel);
        }
        return panel;
    }


    @RequestMapping({"/tenant/scenicSubmit"})
    @ResponseBody
    public Object scenicSubmit(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        BigTenant tenant;
        String id = request.getParameter("id");
        if (id != null) {
            tenant = (BigTenant) baseManager.getObject(BigTenant.class.getName(), id);
        } else {
            tenant = new BigTenant();
            tenant.setSerial(autoSerialManager.nextSerial("product"));
        }
        tenant.setName(request.getParameter("name"));
        tenant.setAddress(request.getParameter("address"));
        tenant.setLatitude(Double.parseDouble(request.getParameter("latitude")));
        tenant.setLongitude(Double.parseDouble(request.getParameter("longitude")));
        tenant.setContent(request.getParameter("content"));
        tenant.setTenantType(BigTenant.TENANT_TYPE_SCENIC);
        tenant.setStatus("1");
        tenant.setCreateDateTime(new Date());
        baseManager.saveOrUpdate(BigTenant.class.getName(), tenant);
        Iterator<String> fileNames = multipartRequest.getFileNames();
        while (fileNames.hasNext()) {
            String filename = fileNames.next();
            MultipartFile multipartFile = multipartRequest.getFile(filename);
            String oName = multipartFile.getOriginalFilename();
            String nName;
            try {
                nName = System.currentTimeMillis() + "" + (int) (Math.random() * 1000000) + "." + oName.split("\\.")[1];
            } catch (Exception e) {
                continue;
            }
            String url = "image/" + nName;
            aliOssUploadManager.uploadFile(multipartFile, "ef-wiki", url);
            String fullUrl = PConst.OSS_EF_WIKI_HOST + url;
            if (filename.equals("pictureUrl")) {
                tenant.setPictureUrl(fullUrl);
            }
            Image image = new Image();
            image.setName(filename);
            image.setCreateTime(new Date());
            image.setOwner(tenant.getId());
            image.setSrc(fullUrl);
            image.setStatus("1");
            if (multipartFile.getContentType().contains("audio")) {
                image.setType("2");
            } else {
                image.setType("1");
            }
            baseManager.saveOrUpdate(Image.class.getName(), image);
        }
        baseManager.saveOrUpdate(BigTenant.class.getName(), tenant);
        return tenant;
    }


    @RequestMapping({"/tenant/getRecommendList"})
    @ResponseBody
    public Object getRecommendList(HttpServletRequest request) {
        int limit = Integer.parseInt(request.getParameter("limit"));
        int offset = Integer.parseInt(request.getParameter("offset"));
        String group = request.getParameter("group");
        String name = request.getParameter("name");
        String hql = "select obj from Recommend obj where obj.status!='0'";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        if (name != null) {
            hql += " and obj.name=:name";
            param.put("name", name);
        }
        if (group != null) {
            hql += " and obj.group=:group";
            param.put("group", group);
        }
        hql += " order by obj.createDatetime desc";
        PageEntity pageEntity = new PageEntity();
        pageEntity.setSize(limit);
        pageEntity.setrIndex(offset * -1);
        PageInfo pageInfo = baseManager.listPageInfo(hql, pageEntity, param);
        return pageInfo.getList();
    }

    @RequestMapping({"/tenant/getRecommendById"})
    @ResponseBody
    public Object getRecommendById(HttpServletRequest request) {
        String id = request.getParameter("id");
        return baseManager.getObject(Recommend.class.getName(), id);
    }


    @RequestMapping({"/tenant/recommendSubmit"})
    @ResponseBody
    public Object recommendSubmit(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        String id = request.getParameter("id");
        Recommend recommend;
        if (id != null && !"".equals(id)) {
            recommend = (Recommend) baseManager.getObject(Recommend.class.getName(), id);
        } else {
            recommend = new Recommend();
        }
        recommend.setStatus("1");
        recommend.setType("0");
        recommend.setShortText(request.getParameter("shortText"));
        recommend.setTitle(request.getParameter("title"));
        recommend.setCreateDatetime(new Date());
        recommend.setGroup(request.getParameter("group"));
        recommend.setRedirect(request.getParameter("redirect"));
        baseManager.saveOrUpdate(Recommend.class.getName(), recommend);
        MultipartFile multipartFile = multipartRequest.getFile("image");
        String oName = multipartFile.getOriginalFilename();
        String nName;
        try {
            nName = System.currentTimeMillis() + "" + (int) (Math.random() * 1000000) + "." + oName.split("\\.")[1];
            String url = "image/" + nName;
            aliOssUploadManager.uploadFile(multipartFile, "ef-wiki", url);
            String fullUrl = PConst.OSS_EF_WIKI_HOST + url;
            Image image = new Image();
            image.setName("recommendImage");
            image.setCreateTime(new Date(System.currentTimeMillis()));
            image.setOwner(recommend.getId());
            image.setSrc(fullUrl);
            image.setStatus("1");
            image.setType("1");
            baseManager.saveOrUpdate(Image.class.getName(), image);
            recommend.setImage(image);
        } catch (Exception e) {
            e.printStackTrace();
        }
        baseManager.saveOrUpdate(Recommend.class.getName(), recommend);
        return recommend;
    }

    @RequestMapping({"/tenant/saveTenantRecommend"})
    @ResponseBody
    public Object saveTenantRecommend(HttpServletRequest request) {
        String id = request.getParameter("id");
        BigTenant bigTenant = (BigTenant) baseManager.getObject(BigTenant.class.getName(), id);
        Recommend recommend = new Recommend();
        recommend.setShortText(bigTenant.getContent());
        recommend.setStatus("1");
        recommend.setTitle(bigTenant.getName());
        recommend.setType("0");
        //@TODO 需要换成真实链接
        recommend.setRedirect(PConst.WEBURL);
        recommend.setGroup(Recommend.GROUP_GARDEN_HOME);
        recommend.setCreateDatetime(new Date(System.currentTimeMillis()));
        baseManager.saveOrUpdate(Recommend.class.getName(), recommend);
        Image image = new Image();
        image.setCreateTime(new Date(System.currentTimeMillis()));
        image.setSrc(bigTenant.getPictureUrl());
        image.setName(bigTenant.getName());
        image.setOwner(recommend.getId());
        image.setType("1");
        baseManager.saveOrUpdate(Image.class.getName(), image);
        recommend.setImage(image);
        baseManager.saveOrUpdate(Recommend.class.getName(), recommend);
        return recommend;
    }

}
