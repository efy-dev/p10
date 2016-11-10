package com.efeiyi.ec.system.yuanqu.controller;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.organization.model.*;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.product.model.Recommend;
import com.efeiyi.ec.system.organization.util.AuthorizationUtil;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.efeiyi.ec.tenant.model.EnterpriseTenant;
import com.efeiyi.ec.tenant.model.TenantMaster;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.taglib.PageEntity;
import com.sun.net.httpserver.Authenticator;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import java.net.URLEncoder;
import java.util.*;

import static com.efeiyi.ec.system.yuanqu.controller.Util.createQRCode;

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
        String tempRedirect = "/yuanqu/tenantForm";
        return tempRedirect;
    }

    @RequestMapping({"/tenant/getUserTenantMessage"})
    @ResponseBody
    public Object getUserTenantMessage(HttpServletRequest request) {
        MyUser user = AuthorizationUtil.getMyUser();
        JSONObject jsonObject = new JSONObject();
        if (null != user) {
            String roleName = user.getRole() == null ? "" : user.getRole().getName();
            if (PConst.USER_PERMISSION_OFFLINE_MANAGER.equals(roleName)) {
                jsonObject.put("permission", PConst.USER_PERMISSION_OFFLINE_MANAGER);
                LinkedHashMap<String, Object> param = new LinkedHashMap<>();
                param.put("userId", user.getId());
                String hql = "select obj from UserTenant obj where obj.user.id=:userId and obj.user.status!='0'";
                List<UserTenant> userTenants = baseManager.listObject(hql, param);
                if (null != userTenants && userTenants.size() > 0) {
                    jsonObject.put("userTenant", userTenants.get(0).getTenant().getId());
                }
            }
        }
        return jsonObject;
    }

    @RequestMapping({"/tenant/deletePanelById"})
    @ResponseBody
    public Object deletePanelById(HttpServletRequest request) {
        JSONObject jsonObject = new JSONObject();
        try {
            String id = request.getParameter("id");
            if (id != null && !id.equals("")) {
                baseManager.delete(Panel.class.getName(), id);
            }
        } catch (Exception e) {
            jsonObject.put("code", "1");
            e.printStackTrace();
        }
        return jsonObject;
    }

    @RequestMapping({"/tenant/deleteHotById"})
    @ResponseBody
    public Object deleteHotById(HttpServletRequest request) {
        JSONObject jsonObject = new JSONObject();
        try {
            String id = request.getParameter("id");
            if (id != null && !id.equals("")) {
                baseManager.delete(HotSpot.class.getName(), id);
            }
        } catch (Exception e) {
            jsonObject.put("code", "1");
            e.printStackTrace();
        }
        return jsonObject;
    }

    @RequestMapping({"/tenant/deleteTenantById"})
    @ResponseBody
    public Object deleteTenantById(HttpServletRequest request) {
        JSONObject jsonObject = new JSONObject();
        try {
            String id = request.getParameter("id");
            if (id != null && !id.equals("")) {
                baseManager.remove(BigTenant.class.getName(), id);
            }
        } catch (Exception e) {
            jsonObject.put("code", "1");
            e.printStackTrace();
        }
        return jsonObject;
    }

    @RequestMapping({"/tenant/hotSubmit"})
    @ResponseBody
    public Object hotSubmit(HttpServletRequest request) throws Exception {
        Image image;
        HotSpot hot;
        ProductModel productModel;
        String id = request.getParameter("id");
        if (id != null && !id.equals("")) {
            hot = (HotSpot) baseManager.getObject(HotSpot.class.getName(), id);
        } else {
            hot = new HotSpot();
        }
        String imageId = request.getParameter("imageId");
        if (imageId != null && !imageId.equals("")) {
            image = (Image) baseManager.getObject(Image.class.getName(), imageId);
            hot.setImage(image);
        }
        String productModelId = request.getParameter("productModelId");
        if (productModelId != null && !productModelId.equals("")) {
            productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
            hot.setProductModel(productModel);
        }
        hot.setAbscissa(Double.parseDouble(request.getParameter("abscissa")));
        hot.setOrdinate(Double.parseDouble(request.getParameter("ordinate")));
        hot.setStatus("1");
        hot.setCreateDateTime(new Date());
        baseManager.saveOrUpdate(HotSpot.class.getName(), hot);
        return hot;
    }

    @RequestMapping({"/tenant/baseSubmit"})
    @ResponseBody
    public Object baseSubmit(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        EnterpriseTenant tenant;
        String id = request.getParameter("id");
        if (id != null && !id.equals("")) {
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
        BigTenant bigTenant = (BigTenant) baseManager.getObject(EnterpriseTenant.class.getName(), id);
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("id", id);
        String hql = "select obj from Image obj where obj.owner=:id and obj.type='2'";
        Image image = (Image) baseManager.getUniqueObjectByConditions(hql, param);
        String audio = image == null ? null : image.getSrc();
        bigTenant.setAudio(audio);
        return bigTenant;
    }


    @RequestMapping({"/tenant/getTenantMasterList"})
    @ResponseBody
    public Object getTenantMasterList(HttpServletRequest request) {
        String name = request.getParameter("name");
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        String hql = "select obj from Master obj where obj.fullName like :name and obj.status='1'";
        param.put("name", "%" + name + "%");
        List masters = baseManager.listObject(hql, param);
        if (masters != null && masters.size() > 10) {
            masters = masters.subList(0, 10);
        }
        return masters;
    }

    @RequestMapping({"/tenant/getHotListByImage"})
    @ResponseBody
    public Object getHotListByImage(HttpServletRequest request) {
        String id = request.getParameter("id");
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        String hql = "select obj from Hot obj where obj.image.id=: id and obj.status='1'";
        param.put("name", id);
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
        if (name != null && !"".equals(name)) {
            hql += " and obj.name=:name";
            param.put("name", name);
        }
        hql += " order by obj.createDateTime desc";
        PageEntity pageEntity = new PageEntity();
        pageEntity.setSize(limit);
        pageEntity.setrIndex(offset);
        PageInfo pageInfo = baseManager.listPageInfo(hql, pageEntity, param);
        return pageInfo;
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
    public List getRecommendList(HttpServletRequest request) {
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
        if (multipartFile != null) {
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


    @RequestMapping("/tenant/createQRCode.do")
    @ResponseBody
    public ResponseEntity<byte[]> createTenantQRCode(HttpServletRequest request) throws Exception {

        String tenantId = request.getParameter("id");

        String redirect = "http://www.efeiyi.com/qrcode/redirect/tenant/" + tenantId;
        String redirect_uri = "http://mall.efeiyi.com/wx/login.do?redirect=" + redirect;
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" +
                "appid=wx7f6aa253b75466dd" +
                "&redirect_uri=" +
                URLEncoder.encode(redirect_uri, "UTF-8") +
                "&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect";

        return createQRCode(this.getClass().getResource("/").getPath().toString(), tenantId, url);
    }

}
