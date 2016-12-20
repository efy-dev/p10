package com.efeiyi.ec.system.yuanqu.controller;

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
import com.efeiyi.ec.tenant.model.TenantGroup;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.p.PConst;
import com.ming800.core.p.service.AliOssUploadManager;
import com.ming800.core.p.service.AutoSerialManager;
import com.ming800.core.taglib.PageEntity;
import net.sf.json.JSONObject;
import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.swing.*;
import java.awt.*;
import java.awt.font.TextAttribute;
import java.awt.image.BufferedImage;
import java.beans.PropertyDescriptor;
import java.io.File;
import java.io.IOException;
import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.math.BigDecimal;
import java.text.AttributedCharacterIterator;
import java.text.AttributedString;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;

@Controller
@RequestMapping({"/yuanqu/product"})
public class OffLineProductController {

    @Autowired
    private BaseManager baseManager;

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Autowired
    private AutoSerialManager autoSerialManager;


    @RequestMapping({"/chooseTenantGroup"})
    @ResponseBody
    public Object chooseTenantGroup(HttpServletRequest request) {
        String productId = request.getParameter("productId");
        String tenantGroupId = request.getParameter("tenantGroupId");
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        TenantGroup tenantGroup = (TenantGroup) baseManager.getObject(TenantGroup.class.getName(), tenantGroupId);
        product.setTenantGroup(tenantGroup);
        baseManager.saveOrUpdate(Product.class.getName(), product);
        return product;
    }

    @RequestMapping({"/getMasterWorkList"})
    @ResponseBody
    public Object getMasterWorkList(HttpServletRequest request) {
        String name = request.getParameter("name");
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        String hql = "select obj from MasterWork obj where obj.name like :name and obj.status='1'";
        param.put("name", "%" + name + "%");
        List masterWorks = baseManager.listObject(hql, param);
        if (masterWorks != null && masterWorks.size() > 10) {
            masterWorks = masterWorks.subList(0, 10);
        }
        return masterWorks;
    }

    @RequestMapping({"/getProductModelNameList"})
    @ResponseBody
    public Object getProductModelNameList(HttpServletRequest request) {
        String name = request.getParameter("name");
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        String hql = "select obj from ProductModel obj where obj.name like :name and obj.status='1'";
        param.put("name", "%" + name + "%");
        List productModels = baseManager.listObject(hql, param);
        if (productModels != null && productModels.size() > 10) {
            productModels = productModels.subList(0, 10);
        }
        return productModels;
    }

    @RequestMapping({"/deleteProductById"})
    @ResponseBody
    public Object deleteProductById(HttpServletRequest request) {
        JSONObject jsonObject = new JSONObject();
        try {
            String id = request.getParameter("id");
            if (id != null && !id.equals("")) {
                baseManager.remove(Product.class.getName(), id);
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
                baseManager.remove(ProductModel.class.getName(), id);
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
        Image audio = null;
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
            List<Image> audios = (List<Image>) baseManager.listObject(audioHql, imagesParam);
            if (audios != null && audios.size() > 0) {
                audio = audios.get(0);
            }
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

    @RequestMapping({"/baseSubmit"})
    @ResponseBody
    public Object baseSubmit(HttpServletRequest request, MultipartRequest multipartRequest) {
        Product product;
        if (request.getParameter("id") != null && !request.getParameter("id").equals("")) {
            product = (Product) baseManager.getObject(Product.class.getName(), request.getParameter("id"));
        } else {
            product = new Product();
            if (request.getParameter("tenantId") != null && !request.getParameter("tenantId").equals("")) {
                BigTenant tenant = (BigTenant) baseManager.getObject(BigTenant.class.getName(), request.getParameter("tenantId"));
                product.setBigTenant(tenant);
            }
        }
        product.setName(request.getParameter("name"));
        product.setSubName(request.getParameter("subName"));
        product.setCreateDateTime(new Date());
        product.setStatus(Product.PRODUCT_STATUS_DOWN);
        product.setType(Product.PRODUCT_TYPE_OFFLINE);
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
        return pageInfo;
    }

    @RequestMapping({"/getProductModelList"})
    @ResponseBody
    public Object getProductModelList(HttpServletRequest request) {
        String productId = request.getParameter("productId");
        Product product = (Product) baseManager.getObject(Product.class.getName(), productId);
        return product.getProductModelList();
    }

    @RequestMapping({"/getSKUList"})
    @ResponseBody
    public Object getSKUList(HttpServletRequest request) {
        String name = request.getParameter("name") == null ? "" : request.getParameter("name");
        int limit = Integer.parseInt(request.getParameter("limit"));
        int offset = Integer.parseInt(request.getParameter("offset"));
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        String hql = "select obj from ProductModel obj where obj.status!='0' and obj.name like :name ";
        param.put("name", "%" + name + "%");
        PageEntity pageEntity = new PageEntity();
        pageEntity.setSize(limit);
        pageEntity.setrIndex(offset);
        PageInfo pageInfo = baseManager.listPageInfo(hql, pageEntity, param);
        return pageInfo;
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
        String price = request.getParameter("price");
        if (price != null && !price.equals("")) {
            productModel.setPrice(new BigDecimal(price));
        }
        String marketPrice = request.getParameter("marketPrice");
        if (marketPrice != null && !marketPrice.equals("")) {
            productModel.setMarketPrice(new BigDecimal(marketPrice));
        } else if (price != null && !price.equals("")) {
            productModel.setMarketPrice(new BigDecimal(price));
        }
        productModel.setStatus("1");
        String productModelUrl = uploadImage(multipartRequest.getFile("productModel_url"));
        if (!"".equals(productModelUrl)) {
            productModel.setProductModel_url(uploadImage(multipartRequest.getFile("productModel_url")));
        }
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

    @RequestMapping({"/getPanelById"})
    @ResponseBody
    public Object getPanelById(HttpServletRequest request) {
        JSONObject jsonObject = new JSONObject();
        try {
            String id = request.getParameter("id");
            if (null != id && !"".equals(id)) {
                return baseManager.getObject(Panel.class.getName(), id);
            } else {
                jsonObject.put("code", "1");
                return jsonObject;
            }
        } catch (Exception e) {
            e.printStackTrace();
            jsonObject.put("code", "1");
            return jsonObject;
        }
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
        String imageHql = "select obj from ImagePanel obj where obj.panel.id=:panelId and obj.image.status!='0' and obj.image.type='1'";
        LinkedHashMap<String, Object> imagesParam = new LinkedHashMap<>();
        imagesParam.put("panelId", id);
        String audioHql = "select obj from Image obj where obj.owner=:panelId and obj.status!='0' and obj.type='2'";
        LinkedHashMap<String, Object> audioParam = new LinkedHashMap<>();
        audioParam.put("panelId", id);
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
        if (multipartRequest.getFiles("imageList") != null && multipartRequest.getFiles("imageList").size() > 0) {
            cascadeRemove(imageHql, imagesParam, ImagePanel.class);
            uploadMultimedia("imageList", panel, "1", multipartRequest);
        }
        if (multipartRequest.getFile("media") != null) {
            cascadeRemove(audioHql, audioParam, Image.class);
            uploadMultimedia("media", panel, "2", multipartRequest);
        }
        return panel;
    }

    @RequestMapping({"/modelpanelSubmit"})
    @ResponseBody
    public Object modelpanelSubmit(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {
        String id = request.getParameter("id");
        String productModelId = request.getParameter("productModelId");
        String imageHql = "select obj from ImagePanel obj where obj.panel.id=:panelId";
        LinkedHashMap<String, Object> imagesParam = new LinkedHashMap<>();
        imagesParam.put("panelId", id);
        String audioHql = "select obj from Image obj where obj.owner=:id and obj.status!='0' and obj.type='2'";
        LinkedHashMap<String, Object> audioParam = new LinkedHashMap<>();
        audioParam.put("id", id);
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
        if (multipartRequest.getFiles("imageList") != null && multipartRequest.getFiles("imageList").size() > 0) {
            cascadeRemove(imageHql, imagesParam, ImagePanel.class);
            uploadMultimedia("imageList", panel, "1", multipartRequest);
        }
        if (multipartRequest.getFile("media") != null) {
            cascadeRemove(audioHql, audioParam, Image.class);
            uploadMultimedia("media", panel, "2", multipartRequest);
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
        List projects = baseManager.listObject(hql, param);
        if (projects != null && projects.size() > 10) {
            projects = projects.subList(0, 10);
        }
        return projects;
    }

    @RequestMapping("/setProductModelStatus")
    @ResponseBody
    public Object setProductModelStatus(HttpServletRequest request) {
        String data = request.getParameter("data");
        JSONObject json = JSONObject.fromObject(data);
        String id = (String) json.get("id");
        String status = (String) json.get("status");
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), id);
        productModel.setStatus(status);
        if (status.equals("1")) {
            productModel.setCreateDateTime(new Date());
        }
        baseManager.saveOrUpdate(productModel.getClass().getName(), productModel);
        return productModel;
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

    @RequestMapping("/createQRCodeSample.do")
    @ResponseBody
    public ResponseEntity<byte[]> createQRCodeSample(HttpServletRequest request) throws Exception {
        String productModelId = request.getParameter("productModelId");
        String tenantId = request.getParameter("tenantId");
        String panelId = request.getParameter("panelId");
        String id = "";
        String redirect = "";
        String markContent = "";
        int contentLength = 0;

        if (tenantId != null && !tenantId.equals("")) {
            redirect = "0/" + tenantId;
            id = tenantId;
        } else if (productModelId != null && !productModelId.equals("")) {
            ProductModel productModel = (ProductModel)
                    baseManager.getObject(ProductModel.class.getName(), productModelId);
            markContent = productModel.getSerial() + "：" + productModel.getName();
            contentLength = markContent.length();
            redirect = "1/" + productModelId;
            id = productModelId;
        } else if (panelId != null && !panelId.equals("")) {
            redirect = "2/" + panelId;
            id = panelId;
        }

        String url = "http://www.efeiyi.com/createWxLoginUrl/" + redirect;

        QRCodeGenerator QRCodeGenerator = new QRCodeGenerator(url);
        QRCodeGenerator.createQRCode(470, 470).assembleBackground("http://m.315cheng.com/images/erweima2016120801.jpg", 175, 200);

        ImageIcon imageIcon = new ImageIcon(QRCodeGenerator.getImageResult());
        java.awt.Image img = imageIcon.getImage();
        int width = img.getWidth(null);
        int height = img.getHeight(null);
        BufferedImage bimage = new BufferedImage(width, height, BufferedImage.TYPE_INT_RGB);
        Graphics2D g = bimage.createGraphics();
        g.setColor(Color.BLACK);
        g.setBackground(Color.white);
        g.drawImage(img, 0, 0, null);
        AttributedString ats = new AttributedString(markContent);
        Font font = new Font("微软雅黑", Font.PLAIN, 22);
        g.setFont(font);
        /* 消除java.awt.Font字体的锯齿 */
        g.setRenderingHint(RenderingHints.KEY_ANTIALIASING, RenderingHints.VALUE_ANTIALIAS_ON);
        if (contentLength != 0) {
            ats.addAttribute(TextAttribute.FONT, font, 0, contentLength);
        }
        AttributedCharacterIterator iter = ats.getIterator();
        g.drawString(iter, 180, 698);
        g.dispose();

        File imageFile = new File(id + ".jpg");
        ImageIO.write(bimage, "jpg", imageFile);
        HttpHeaders headers = new HttpHeaders();
        headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
        headers.setContentDispositionFormData("attachment", id + ".jpg");
        byte[] bytes = FileUtils.readFileToByteArray(imageFile);
        return new ResponseEntity<>(bytes, headers, HttpStatus.OK);
    }


    @RequestMapping({"/batchExportQRCode"})
    @ResponseBody
    public int batchExportQRCode(HttpServletRequest request) throws Exception {
        String tenantGroupId = request.getParameter("tenantGroupId");
        String hql = "select obj from ProductModel obj where obj.product.tenantGroup.id=:tenantGroupId and obj.status!='0'";
        LinkedHashMap<String, Object> param = new LinkedHashMap<>();
        param.put("tenantGroupId", tenantGroupId);
        List<ProductModel> productModels = baseManager.listObject(hql, param);
        for (ProductModel productModel : productModels) {
            try {
                generateQRCode(productModel);
            } catch (Exception e) {
                continue;
            }
        }
        return productModels.size();
    }


    private void generateQRCode(ProductModel productModel) throws Exception {



    }











    /*商品规格详情和商品详情编辑提交时，避免图片累加*/

    public void cascadeRemove(String hql, LinkedHashMap param, Class clazz) throws Exception {
        List<String> ids = new ArrayList<>();
        List<Object> objs = baseManager.listObject(hql, param);
        if (objs != null && objs.size() > 0) {
            for (Object obj : objs) {
                Field field = obj.getClass().getDeclaredField("id");
                PropertyDescriptor pd = new PropertyDescriptor(field.getName(), clazz);
                Method getMethod = pd.getReadMethod();
                Object o = getMethod.invoke(obj);
                ids.add(o.toString());
            }
            if (ids != null && ids.size() > 0) {
                if (clazz.getSimpleName().equals("ImagePanel")) {
                    baseManager.batchDelete(clazz.getName(), ids.toArray(new String[ids.size()]));
                } else {
                    baseManager.batchRemove(clazz.getName(), ids.toArray(new String[ids.size()]));
                }
            }
        }
    }

    public void uploadMultimedia(String fileNames, Panel panel, String type, MultipartRequest multipartRequest) throws Exception {
        for (MultipartFile multipartFile : multipartRequest.getFiles(fileNames)) {
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
            image.setType(type);
            image.setOwner(panel.getId());
            image.setCreateTime(new Date());
            image.setSrc(fullUrl);
            if (type.equals("2")) {
                baseManager.saveOrUpdate(Image.class.getName(), image);
                panel.setMedia(image);
                baseManager.saveOrUpdate(Panel.class.getName(), panel);
            } else if (type.equals("1")) {
                ImagePanel imagePanel = new ImagePanel();
                imagePanel.setImage(image);
                imagePanel.setPanel(panel);
                baseManager.saveOrUpdate(Image.class.getName(), image);
                baseManager.saveOrUpdate(ImagePanel.class.getName(), imagePanel);
            }
        }
    }

}
