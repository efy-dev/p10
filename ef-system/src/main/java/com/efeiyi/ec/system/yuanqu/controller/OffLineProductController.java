package com.efeiyi.ec.system.yuanqu.controller;

import com.alibaba.fastjson.JSONObject;
import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.master.model.MasterWork;
import com.efeiyi.ec.master.model.MasterWorkProduct;
import com.efeiyi.ec.organization.model.Image;
import com.efeiyi.ec.organization.model.ImagePanel;
import com.efeiyi.ec.organization.model.Panel;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.tenant.model.BigTenant;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.taglib.PageEntity;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

import static com.efeiyi.ec.system.yuanqu.controller.Util.createQRCode;

@Controller
@RequestMapping({"/yuanqu/product"})
public class OffLineProductController {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Autowired
    private AutoSerialManager autoSerialManager;

    @RequestMapping({"/getMasterWorkList"})
    @ResponseBody
    public Object getMasterWorkList(HttpServletRequest request) {
        String name = request.getParameter("name");
            LinkedHashMap<String, Object> param = new LinkedHashMap<>();
            String hql = "select obj from MasterWork obj where obj.name like :name and obj.status='1'";
            param.put("name", "%" + name + "%");
            return baseManager.listObject(hql, param);
    }

    @RequestMapping({"/deleteProductById"})
    @ResponseBody
    public Object deleteProductById(HttpServletRequest request) {
        JSONObject jsonObject = new JSONObject();
        try {
            String id = request.getParameter("id");
            if (id != null && !id.equals("")) {
                baseManager.delete(Product.class.getName(), id);
            }
        } catch (Exception e) {
            jsonObject.put("code", "1");
            e.printStackTrace();
        }
        return jsonObject;
    }

    @RequestMapping({"/deleteProductModelById"})
    @ResponseBody
    public Object deleteProductModelById(HttpServletRequest request) {
        JSONObject jsonObject = new JSONObject();
        try {
            String id = request.getParameter("id");
            if (id != null && !id.equals("")) {
                baseManager.delete(ProductModel.class.getName(), id);
            }
        } catch (Exception e) {
            jsonObject.put("code", "1");
            e.printStackTrace();
        }
        return jsonObject;
    }

    @RequestMapping({"/getProductById"})
    @ResponseBody
    public Object getProductById(HttpServletRequest request) {
        String id = request.getParameter("id");
        Product product = (Product) baseManager.getObject(Product.class.getName(), id);
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("productId", product.getId());
        String audioHql = "select obj from Image obj where obj.owner=:productId and obj.status!='0' and obj.type='2'";
        Image image = (Image) baseManager.getUniqueObjectByConditions(audioHql, param);
        if (image != null) {
            product.setAudio(image.getSrc());
        }
        return product;
    }
    @RequestMapping({"/getProductPanelById"})
    @ResponseBody
    public Object getProductPanelById(HttpServletRequest request) {
        JSONObject jsonObject = new JSONObject();
        String id = request.getParameter("id");
        String hql = "select obj from Panel obj where obj.owner=:id and obj.status!='0'";
        LinkedHashMap<String, Object> panelParam = new LinkedHashMap<>();
        panelParam.put("id", id);
        List<Panel> panels = (List<Panel>) baseManager.listObject(hql, panelParam);
        if (panels != null && panels.size() > 0) {
            LinkedHashMap<String, Object> imagesParam = new LinkedHashMap<>();
            imagesParam.put("panelId", panels.get(0).getId());
            String imageHql = "select obj from ImagePanel obj where obj.panel.id=:panelId and obj.image.status!='0' and obj.image.type='1'";
            String audioHql = "select obj from Image obj where obj.owner=:panelId and obj.status!='0' and obj.type='2'";
            Image audio = (Image) baseManager.getUniqueObjectByConditions(audioHql, imagesParam);
            List<ImagePanel> images = (List<ImagePanel>) baseManager.listObject(imageHql, imagesParam);
            panels.get(0).setImageList(images);
            if (audio != null) {
                panels.get(0).setMedia(audio);
            }
            return panels.get(0);
        }
        jsonObject.put("code", "1");
        return jsonObject;
    }
    @RequestMapping({"/getProductsByTenantId"})
    @ResponseBody
    public Object getProductsByTenantId(HttpServletRequest request) {
        String id = request.getParameter("id");
        String hql="select obj from  Product where obj.tenant_id="+id;
        Product product = (Product) baseManager.getObject(Product.class.getName(), id);
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("productId", product.getId());
        String audioHql = "select obj from Image obj where obj.owner=:productId and obj.status!='0' and obj.type='2'";
        Image image = (Image) baseManager.getUniqueObjectByConditions(audioHql, param);
        if (image != null) {
            product.setAudio(image.getSrc());
        }
        return product;
    }

    @RequestMapping({"/baseSubmit"})
    @ResponseBody
    public Object baseSubmit(HttpServletRequest request, MultipartRequest multipartRequest) {
        Product product;
        if (request.getParameter("id") != null && !request.getParameter("id").equals("")) {
            product = (Product) baseManager.getObject(Product.class.getName(), request.getParameter("id"));
        } else {
            product = new Product();
            if (request.getParameter("tenantId") != null&&!request.getParameter("tenantId").equals("")) {
                BigTenant tenant = (BigTenant) baseManager.getObject(BigTenant.class.getName(), request.getParameter("tenantId"));
                product.setBigTenant(tenant);
            }
        }
        product.setName(request.getParameter("name"));
        product.setSubName(request.getParameter("subName"));
        product.setCreateDateTime(new Date());
        product.setStatus(Product.PRODUCT_STATUS_DOWN);
        product.setType(Product.PRODUCT_TYPE_OFFLINE);
        baseManager.saveOrUpdate(Product.class.getName(), product);
        String pictureUrl = uploadImage(multipartRequest.getFile("picture_url"));//主图
        if (!"".equals(pictureUrl)) {
            product.setPicture_url(pictureUrl);
            Image image = new Image(product.getName(), pictureUrl, product.getId(), "1", "1");
            baseManager.saveOrUpdate(Image.class.getName(), image);
        }
        String audioUrl = uploadImage(multipartRequest.getFile("audio"));
        if (!"".equals(audioUrl)) {
            List<Image> oAudio = baseManager.listObject("select obj from Image obj where obj.status='1' and obj.type='2' and obj.owner='" + product.getId() + "'");
            if (oAudio != null) {
                for (Image image : oAudio) {
                    image.setStatus("0");
                    baseManager.saveOrUpdate(Image.class.getName(), image);
                }
            }
            Image audio = new Image(product.getName() + "_audio", audioUrl, product.getId(), "1", "2");
            baseManager.saveOrUpdate(Image.class.getName(), audio);
        }
        baseManager.saveOrUpdate(Product.class.getName(), product);
        return product;
    }


    @RequestMapping({"/getProductList"})
    @ResponseBody
    public Object getProductList(HttpServletRequest request) {
        int limit = Integer.parseInt(request.getParameter("limit"));
        int offset = Integer.parseInt(request.getParameter("offset"));
        String name = request.getParameter("name");
        String tenantId = request.getParameter("tenantId");
        String hql = "select obj from Product obj where obj.type='" + Product.PRODUCT_TYPE_OFFLINE + "' and obj.status!='0'";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        if (name != null && !"".equals(name)) {
            hql += " and obj.name=:name";
            param.put("name", name);
        }
        if (tenantId != null) {
            hql += " and obj.tenant.id=:tenantId";
            param.put("tenantId", tenantId);
        }
        hql += " order by obj.createDateTime desc";
        PageEntity pageEntity = new PageEntity();
        pageEntity.setSize(limit);
        pageEntity.setrIndex(offset);
        PageInfo pageInfo = baseManager.listPageInfo(hql, pageEntity, param);
        return pageInfo.getList();
    }

    @RequestMapping({"/getProductModelList"})
    @ResponseBody
    public Object getProductModelList(HttpServletRequest request) {
        String productId = request.getParameter("productId");
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        return product.getProductModelList();
    }

    @RequestMapping({"/modelSubmit"})
    @ResponseBody
    public Object modelSubmit(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        String id = request.getParameter("id");
        String productId = request.getParameter("productId");
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        ProductModel productModel;
        if (id != null && !"".equals(id)) {
            productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), id);
        } else {
            productModel = new ProductModel();
            productModel.setSerial(autoSerialManager.nextSerial("product"));
            productModel.setProduct(product);
        }
        productModel.setName(request.getParameter("name"));
        String amountStr = request.getParameter("amount");
        productModel.setAmount(amountStr != null && !amountStr.equals("") ? Integer.parseInt(amountStr) : 1);
        String marketPrice = request.getParameter("marketPrice");
        if (marketPrice != null && !marketPrice.equals("")) {
            productModel.setMarketPrice(new BigDecimal(marketPrice));
        }
        productModel.setPrice(new BigDecimal(request.getParameter("price")));
        productModel.setStatus("1");
        productModel.setProductModel_url(uploadImage(multipartRequest.getFile("productModel_url")));
        productModel.setCreateDateTime(new Date());
        baseManager.saveOrUpdate(ProductModel.class.getName(), productModel);
        return productModel;
    }


    @RequestMapping({"/masterSubmit"})
    @ResponseBody
    public Object masterSubmit(HttpServletRequest request) {
        String id = request.getParameter("id");
        Product product = (Product) baseManager.getObject(Product.class.getName(), id);
        String masterId = request.getParameter("masterId");
        String projectId = request.getParameter("projectId");
        if (masterId != null) {
            Master master = (Master) baseManager.getObject(Master.class.getName(), masterId);
            product.setMaster(master);
        }
        if (projectId != null) {
            Project project = (Project) baseManager.getObject(Project.class.getName(), projectId);
            product.setProject(project);
        }
        baseManager.saveOrUpdate(Product.class.getName(), product);
        return product;
    }
    @RequestMapping({"/masterWorkSubmit"})
    @ResponseBody
    public Object masterWorkSubmit(HttpServletRequest request) {
        String id = request.getParameter("id");
        Product product = (Product) baseManager.getObject(Product.class.getName(), id);
        String masterWorkId = request.getParameter("masterWorkId");
        MasterWork masterWork = null;
        MasterWorkProduct masterWorkProduct = null;
        if (masterWorkId != null) {
            masterWork = (MasterWork) baseManager.getObject(MasterWork.class.getName(), masterWorkId);
        }
        if (masterWork != null && product != null) {
            masterWorkProduct = new MasterWorkProduct();
            masterWorkProduct.setProduct(product);
            masterWorkProduct.setMasterWork(masterWork);
            masterWorkProduct.setStatus("1");
            baseManager.saveOrUpdate(MasterWorkProduct.class.getName(), masterWorkProduct);
        }
        return product;
    }

    @RequestMapping({"/getProductModelById"})
    @ResponseBody
    public Object getProductModelById(HttpServletRequest request) {
        String id = request.getParameter("id");
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), id);
        productModel.getProduct();
        productModel.getProduct().getTenant();
        return productModel;
    }

    @RequestMapping({"/getPanelListByProductModel"})
    @ResponseBody
    public Object getPanelListByProductModel(HttpServletRequest request) {
        String productModelId = request.getParameter("id");
        String hql = "select obj from Panel obj where obj.owner=:productModelId and obj.status='1'";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("productModelId", productModelId);
        return baseManager.listObject(hql, param);
    }

    @RequestMapping({"/panelSubmit"})
    @ResponseBody
    public Object panelSubmit(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        String id = request.getParameter("id");
        String productId = request.getParameter("productId");
        Panel panel;
        if (id != null && !"".equals(id)) {
            panel = (Panel) baseManager.getObject(Panel.class.getName(), id);
        } else {
            panel = new Panel();
            Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
            panel.setOwner(product.getId());
        }
        panel.setStatus("1");
        panel.setType("1");
        panel.setName(request.getParameter("name"));
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

    @RequestMapping({"/modelpanelSubmit"})
    @ResponseBody
    public Object modelpanelSubmit(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        String id = request.getParameter("id");
        String productModelId = request.getParameter("productId");
        Panel panel;
        if (id != null && !"".equals(id)) {
            panel = (Panel) baseManager.getObject(Panel.class.getName(), id);
        } else {
            panel = new Panel();
            ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
            panel.setOwner(productModel.getId());
        }
        panel.setStatus("1");
        panel.setType("1");
        panel.setName(request.getParameter("name"));
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


    @RequestMapping({"/getProjectList"})
    @ResponseBody
    public Object getProjectList(HttpServletRequest request) {
        String name = request.getParameter("name");
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        String hql = "select obj from Project obj where obj.name like :name and obj.status='1'";
        param.put("name", "%" + name + "%");
        return baseManager.listObject(hql, param);
    }


    private String uploadImage(MultipartFile multipartFile) {
        if (multipartFile == null) {
            return "";
        }
        String oName = multipartFile.getOriginalFilename();
        String nName;
        try {
            nName = System.currentTimeMillis() + "" + (int) (Math.random() * 1000000) + "." + oName.split("\\.")[1];
        } catch (Exception e) {
            return "";
        }
        String url = "image/" + nName;
        try {
            boolean uploadSuccess = aliOssUploadManager.uploadFile(multipartFile, "ef-wiki", url);
            if (!uploadSuccess) {
                return "";
            }
        } catch (Exception e) {
            return "";
        }
        return PConst.OSS_EF_WIKI_HOST + url;
    }

    @RequestMapping("/createQRCode.do")
    @ResponseBody
    public ResponseEntity<byte[]> createProductQRCode(HttpServletRequest request) throws Exception {
        String productId = request.getParameter("id");

        String redirect = "http://www.efeiyi.com/qrcode/redirect/product/" + productId;
        String redirect_uri = "http://mall.efeiyi.com/wx/login.do?redirect=" + redirect;
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" +
                "appid=wx7f6aa253b75466dd" +
                "&redirect_uri=" +
                URLEncoder.encode(redirect_uri, "UTF-8") +
                "&response_type=code&scope=snsapi_userinfo&state=123#wechat_redirect";

        return createQRCode(this.getClass().getResource("/").getPath().toString(), productId, url);
    }
    @RequestMapping("/createQRCodeSample.do")
    @ResponseBody
    public ResponseEntity<byte[]> createProductQRCodeSample(HttpServletRequest request) throws Exception {

        String productId = request.getParameter("id");
        String redirect = "0/" + productId;
        String redirect_uri = "http://mall.efeiyi.com/wl";
        String url = "https://open.weixin.qq.com/connect/oauth2/authorize?" +
                "appid=wx7f6aa253b75466dd" +
                "&redirect_uri=" +
                URLEncoder.encode(redirect_uri, "UTF-8") +
                "&response_type=code&scope=snsapi_userinfo&state=" + URLEncoder.encode(redirect, "UTF-8") + "#wechat_redirect";

        QRCodeGenerator QRCodeGenerator = new QRCodeGenerator(url);
        return QRCodeGenerator
                .createQRCode(582, 582)
                .assembleLogo("http://ef-wiki.oss-cn-beijing.aliyuncs.com/test/logo.png")
                .assembleBackground("http://ef-wiki.oss-cn-beijing.aliyuncs.com/test/background.jpg", 123, 92)
                .getResponseEntityResult(productId + "jpg");


    }

}
