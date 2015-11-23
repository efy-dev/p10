package com.efeiyi.ec.website.product.controller;

import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.product.model.*;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.purchase.model.Cart;
import com.efeiyi.ec.website.organization.util.AuthorizationUtil;
import com.google.zxing.WriterException;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGEncodeParam;
import com.sun.image.codec.jpeg.JPEGImageEncoder;
import org.jboss.marshalling.util.BooleanReadField;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.imageio.ImageIO;
import javax.servlet.http.HttpServletRequest;
import javax.swing.*;
import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.*;
import java.util.List;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.MultiFormatWriter;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
/**
 * Created by Administrator on 2015/7/8.
 */
@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private BaseManager baseManager;
    //@Autowired
    //private List<ProductModel> productModelListTmp;

    private static final String CHARSET = "utf-8";
    private static final String FORMAT_NAME = "JPG";
    // 二维码尺寸
    private static final int QRCODE_SIZE = 200;
    // LOGO宽度
    private static final int WIDTH = 60;
    // LOGO高度
    private static final int HEIGHT = 60;
    @RequestMapping(value = "/productList.do")
    public ModelAndView listProduct(HttpServletRequest request, ModelMap model) throws Exception{
        String id = request.getParameter("id");
        XQuery xQuery = new XQuery("plistProduct_default",request);
        List productList = baseManager.listObject(xQuery);
        model.addAttribute("productList",productList);
        return  new ModelAndView("/product/productList",model);
    }


    @RequestMapping({"/{productId}"})
    public String viewProduct(@PathVariable String productId, HttpServletRequest request ,Model model){
        ProductModel productModel = (ProductModel)baseManager.getObject(ProductModel.class.getName(),productId);
        model.addAttribute("productModel",productModel);
        return "/product/productView";
    }

    @RequestMapping("/list/{projectId}")
    public String plistProduct(@PathVariable String projectId,HttpServletRequest request, Model model) throws Exception{
        //前端传递projectId
        XQuery xQuery = new XQuery("plistProductModel_default",request);
        xQuery.put("product_project_id", projectId);
        String sortString= request.getParameter("sort");
        String[] sort = new String[]{};
        if(sortString!=null&&sortString.length()>0){
            sort = sortString.split(":");
        }
        String str = null;
        if(sort.length>0){
            str = sort[0];
        }

        xQuery.addRequestParamToModel(model,request);
        List<ProductModel> productModelList = baseManager.listPageInfo(xQuery).getList();
        Map<ProductModel,String> map = new HashMap<>();
        if(productModelList!=null&&productModelList.size()>0){
            for(ProductModel productModelTemp:productModelList){
                StringBuilder s = new StringBuilder(productModelTemp.getProduct().getName());
                if(productModelTemp.getProduct().getProductModelList().size()==1){
                    map.put(productModelTemp,s.toString());
                }else{
                    s.append("[").append(productModelTemp.getName());
                    if(s.toString().length()>14){
                        s = new StringBuilder(s.substring(0,14));
                        s.append("...").append("]");
                    }else{
                        s.append("]");
                    }
                    map.put(productModelTemp,s.toString());
                }
            }
        }
        Project project  = (Project)baseManager.getObject(Project.class.getName(),projectId);
        String proName = project.getName();
        model.addAttribute("proName",proName);
        model.addAttribute("project",project);
        model.addAttribute("map",map);
        model.addAttribute("str",str);
        model.addAttribute("productModelList",productModelList);
        return "/product/productModelList";
    }
    @RequestMapping(value = "/getProduct.do")
    public String getProduct(HttpServletRequest request, Model model) {
        String id = request.getParameter("id");
        Product product = (Product) baseManager.getObject(Product.class.getName(), id);
        model.addAttribute("product", product);
        return "/product/productView";
    }

    /**
     * 产品收藏
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/addProductFavorite.do"})
    @ResponseBody
    public boolean addProductFavorite(HttpServletRequest request) throws Exception {
        MyUser currentUser = AuthorizationUtil.getMyUser();
        Boolean flag = true;
        if (currentUser.getId() != null) {
            String productModelId = request.getParameter("id");
            XSaveOrUpdate xSaveOrUpdate = new XSaveOrUpdate("saveOrUpdateProductFavorite", request);
            xSaveOrUpdate.getParamMap().put("user_id", AuthorizationUtil.getMyUser().getId());
            xSaveOrUpdate.getParamMap().put("productModel_id", productModelId);
            xSaveOrUpdate.getParamMap().remove("id");
            baseManager.saveOrUpdate(xSaveOrUpdate);
        } else {
            flag = false;
        }
        return flag;
    }
    /**
     * 爆款推荐
     */
    @RequestMapping({"/hot/{productModelId}"})
    public String recommendation(@PathVariable String productModelId, HttpServletRequest request, Model model) throws Exception {
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
        Project project = productModel.getProduct().getProject();
        XQuery xQuery = new XQuery("listProductModel_default",request);
        xQuery.put("product_project_id", project.getId());
        List<Object> productModelList =  baseManager.listObject(xQuery);
        Map<ProductModel,String> map = new HashMap<>();
        if(productModelList!=null&&productModelList.size()>0){
            for(Object productModelTemp:productModelList){
                StringBuilder s = new StringBuilder();
                s.append(((ProductModel) productModelTemp).getProduct().getName());
                List<ProductPropertyValue> productPropertyValueList = ((ProductModel) productModelTemp).getProductPropertyValueList();
                if(productPropertyValueList==null||productPropertyValueList.size()==0||productPropertyValueList.size()==1){
                    if (s.toString().length() > 14){
                        s = new StringBuilder(s.substring(0,14));
                        s.append("...");
                    }
                    map.put((ProductModel)productModelTemp,s.toString());

                }else if(productPropertyValueList!=null&&productPropertyValueList.size()>1){
                    s.append("[");
                    for(ProductPropertyValue productPropertyValue:((ProductModel)productModelTemp).getProductPropertyValueList()){
                        s.append(productPropertyValue.getProjectPropertyValue().getValue());
                    }
                    if(s.toString().length()>14){
                        s = new StringBuilder(s.substring(0,14));
                        s.append("...");
                    }
                    s.append("]");
                    map.put((ProductModel) productModelTemp, s.toString());

                }

            }
        }
        model.addAttribute("productModelList", productModelList);
        model.addAttribute("productModel", productModel);
        model.addAttribute("map",map);
        return "/product/recommendationList";
    }
    /**
     * 删除收藏产品
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/removeProductFavorite.do"})
    @ResponseBody
    public boolean removeProductFavorite(HttpServletRequest request) throws Exception{
        String productModelId = request.getParameter("id");
        XQuery xQuery = new XQuery("listProductFavorite_default",request);
        MyUser currentUser = AuthorizationUtil.getMyUser();
        xQuery.put("user_id", currentUser.getId());
        xQuery.put("productModel_id",productModelId);
        List<Object> productFavoriteList =  baseManager.listObject(xQuery);
        ProductFavorite p = (ProductFavorite)productFavoriteList.get(0);
        baseManager.remove(ProductFavorite.class.getName(),p.getId());
        return true;
    }

    /**
     * 查看收藏产品
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/favorite/list"})
    public List<Object> listProductFavorite(HttpServletRequest request) throws Exception{
        XQuery xQuery = new XQuery("plistProductFavorite_default",request);
        List<Object> objectList = baseManager.listObject(xQuery);
        return objectList;
    }

    /**商品详情
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/productModel/{productModelId}"})
    public String productDetalis(@PathVariable String productModelId, HttpServletRequest request, Model model) throws Exception {
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
        Product product = productModel.getProduct();
        Project project = product.getProject();
        XQuery purchaseOrderProductQuery = new XQuery("listPurchaseOrderProduct_default",request);
        purchaseOrderProductQuery.put("productModel_id", productModelId);
        List<Object> purchaseOrderProductList = new ArrayList<Object>();
        try{
            purchaseOrderProductList = baseManager.listObject(purchaseOrderProductQuery);
            if(purchaseOrderProductList!=null&&purchaseOrderProductList.size()>0){
                Collections.reverse(purchaseOrderProductList);
            }
        }catch (Exception e){
            purchaseOrderProductList = null;
        }
        model.addAttribute("purchaseOrderProductList",purchaseOrderProductList);
        XQuery productPicturexQuery = new XQuery("listProductPicture_default",request);
        productPicturexQuery.put("product_id",product.getId());
        List<Object> productPictureList = baseManager.listObject(productPicturexQuery);
        model.addAttribute("productPictureList",productPictureList);
        List<ProductModel> productModelListTmp = product.getProductModelList();
        List<ProductPicture> productPictures = product.getProductPictureList();
        ProductPicture productPicture = new ProductPicture();
        if (productPictures != null && productPictures.size() > 0) {
            for (ProductPicture p : productPictures) {
                if("2".equals(p.getStatus())){
                    productPicture = p;
                    break;
                }
            }
        }
        model.addAttribute("productModelList", productModelListTmp);
        model.addAttribute("productModel", productModel);
        model.addAttribute("product", product);
        model.addAttribute("productPicture",productPicture);
        model.addAttribute("productPictures",productPictures);
        model.addAttribute("purchaseOrderProductList",purchaseOrderProductList);
        model.addAttribute("project",project);
        return "/product/productDetails";
    }
    /**商品收藏状态判断
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/favorite/productFavoriteStatus.do"})
    @ResponseBody
    public Boolean productFavoriteStatus(HttpServletRequest request) throws Exception{
        MyUser currentUser = AuthorizationUtil.getMyUser();
        Boolean flag = false;
        if (currentUser.getId() != null) {
            String productModelId = request.getParameter("id");
            XQuery xQuery = new XQuery("listProductFavorite_default",request);
            xQuery.put("user_id", currentUser.getId());
            xQuery.put("productModel_id", productModelId);
            List<ProductFavorite> productFavoriteList =  baseManager.listObject(xQuery);
            if(productFavoriteList!=null&&"1".equals(productFavoriteList.get(0).getStatus())){
                flag = true;
            }
        }
        return flag;
    }
    /**商品收藏状态判断
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/test/test.do"})
    @ResponseBody
    public void productPicture(HttpServletRequest request) throws Exception{
        String word = "我精心为你准备了礼物，希望你收下";
        //背景图设置
        String srcFilePath = "c://1.jpg";
        ImageIcon imgIcon = new ImageIcon(srcFilePath);
        Image theImg = imgIcon.getImage();
        int width=theImg.getWidth(null);
        int height=theImg.getHeight(null);
        BufferedImage bimage = new BufferedImage(width,height, BufferedImage.TYPE_INT_RGB);
        Graphics  g = bimage.createGraphics();
        g.setColor(Color.black);
        g.drawImage(theImg, 0, 0, null );
        //设置字体、字型、字号
        g.setFont(new Font(null,Font.BOLD,15));
        //背景图set文字显示
        g.drawString(word,40,height/2+30);
        g.dispose();
        //二维码生成
        Map<EncodeHintType, Object> hints = new HashMap<EncodeHintType, Object>();
        hints.put(EncodeHintType.MARGIN, 0);
        BitMatrix bitMatrix = null;
        try {
            bitMatrix = new QRCodeWriter().encode("do you like me?",
                    BarcodeFormat.QR_CODE, 154, 154,hints);//二维码像素
        } catch (WriterException e) {
            e.printStackTrace();
        }
        int qRWidth = bitMatrix.getWidth();
        int qRHeight = bitMatrix.getHeight();
        BufferedImage image = new BufferedImage(qRWidth, qRHeight,BufferedImage.TYPE_INT_ARGB);
        for (int x = 0; x < qRWidth; x++) {
            for (int y = 0; y < qRHeight; y++) {
                image.setRGB(x, y, bitMatrix.get(x, y) == true ?
                        Color.BLACK.getRGB():Color.WHITE.getRGB());
            }
        }
        FileOutputStream out = null;
        try {
            out = new FileOutputStream("c://test1.jpg");
            JPEGImageEncoder encoder =JPEGCodec.createJPEGEncoder(out);
            JPEGEncodeParam param = encoder.getDefaultJPEGEncodeParam(image);
            encoder.encode(image,param);
        } catch (IOException e) {
            e.printStackTrace();
        }finally {
            out.close();
        }
        BufferedImage combined = new BufferedImage(bimage.getWidth(), bimage.getHeight(), BufferedImage.TYPE_INT_RGB);
        //图像合并
        g = combined.getGraphics();
        g.drawImage(bimage, 0, 0, null);
        g.drawImage(image, 100, 750, null);
        ImageIO.write(combined, "JPG", new File("c://test2.jpg"));

    }

}
