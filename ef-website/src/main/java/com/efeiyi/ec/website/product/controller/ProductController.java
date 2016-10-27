package com.efeiyi.ec.website.product.controller;

import com.efeiyi.ec.organization.model.Image;
import com.efeiyi.ec.organization.model.MyUser;
import com.efeiyi.ec.organization.model.Panel;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.product.model.ProductFavorite;
import com.efeiyi.ec.product.model.ProductModel;
import com.efeiyi.ec.product.model.ProductPicture;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.purchase.model.PurchaseOrder;
import com.efeiyi.ec.purchase.model.PurchaseOrderProduct;
import com.efeiyi.ec.website.base.util.AuthorizationUtil;
import com.efeiyi.ec.wiki.model.Artistry;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.does.model.PageInfo;
import com.ming800.core.does.model.XQuery;
import com.ming800.core.does.model.XSaveOrUpdate;
import com.ming800.core.taglib.PageEntity;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Created by Administrator on 2015/7/8.
 */
@Controller
@RequestMapping("/product")
public class ProductController {

    @Autowired
    private BaseManager baseManager;


    @RequestMapping(value = "/productList.do")
    public ModelAndView listProduct(HttpServletRequest request, ModelMap model) throws Exception {
        String id = request.getParameter("id");
        XQuery xQuery = new XQuery("plistProduct_default", request);
        List productList = baseManager.listObject(xQuery);
        model.addAttribute("productList", productList);
        return new ModelAndView("/product/productList", model);
    }


    @RequestMapping({"/{productId}"})
    public String viewProduct(@PathVariable String productId, HttpServletRequest request, Model model) {
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productId);
        model.addAttribute("productModel", productModel);
        return "/product/productView";
    }

    @RequestMapping("/list/{projectId}")
    public String plistProduct(@PathVariable String projectId, HttpServletRequest request, Model model) throws Exception {
        //前端传递projectId
        XQuery xQuery = new XQuery("plistProductModel_default", request);
        xQuery.put("product_project_id", projectId);
        String sortString = request.getParameter("sort");
        String[] sort = new String[]{};
        if (sortString != null && sortString.length() > 0) {
            sort = sortString.split(":");
        }
        String str = null;
        int activeFlag = 0;
        if (sort.length > 0) {
            str = sort[0];
            switch (sort[1]) {
                case "price":
                    activeFlag = 1;
                    break;
                case "popularityAmount":
                    activeFlag = 2;
                    break;
                case "saleAmount":
                    activeFlag = 3;
                    break;
                case "product.createDateTime":
                    activeFlag = 4;
                    break;
                default:
                    activeFlag = 0;
            }
        }
        model.addAttribute("flag", activeFlag);
        xQuery.addRequestParamToModel(model, request);
        List<ProductModel> productModelList = baseManager.listPageInfo(xQuery).getList();
        Map<ProductModel, String> map = new HashMap<>();
        Project project = (Project) baseManager.getObject(Project.class.getName(), projectId);
        model.addAttribute("project", project);
        model.addAttribute("map", map);
        model.addAttribute("str", str);
        model.addAttribute("productModelList", productModelList);
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
     *
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
        XQuery xQuery = new XQuery("listProductModel_default", request);
        xQuery.put("product_project_id", project.getId());
        List<ProductModel> productModelList = baseManager.listObject(xQuery);
        Map<ProductModel, String> map = new HashMap<>();
        model.addAttribute("productModelList", productModelList);
        model.addAttribute("productModel", productModel);
        model.addAttribute("map", map);
        return "/product/recommendationList";
    }

    /**
     * 删除收藏产品
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/removeProductFavorite.do"})
    @ResponseBody
    public boolean removeProductFavorite(HttpServletRequest request) throws Exception {
        String productModelId = request.getParameter("id");
        XQuery xQuery = new XQuery("listProductFavorite_default", request);
        MyUser currentUser = AuthorizationUtil.getMyUser();
        xQuery.put("user_id", currentUser.getId());
        xQuery.put("productModel_id", productModelId);
        List<Object> productFavoriteList = baseManager.listObject(xQuery);
        ProductFavorite p = (ProductFavorite) productFavoriteList.get(0);
        baseManager.remove(ProductFavorite.class.getName(), p.getId());
        return true;
    }

    /**
     * 查看收藏产品
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/favorite/list"})
    public List<Object> listProductFavorite(HttpServletRequest request) throws Exception {
        XQuery xQuery = new XQuery("plistProductFavorite_default", request);
        List<Object> objectList = baseManager.listObject(xQuery);
        return objectList;
    }

    /**
     * 商品详情
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/productModel/{productModelId}"})
    public String productDetalis(@PathVariable String productModelId, HttpServletRequest request, Model model) throws Exception {
        ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
        productModel.setPopularityAmount(productModel.getPopularityAmount() == null ? 1 : productModel.getPopularityAmount() + 1);
        baseManager.saveOrUpdate(ProductModel.class.getName(), productModel);
        Product product = productModel.getProduct();
        Project project = product.getProject();
        XQuery purchaseOrderProductQuery = new XQuery("listPurchaseOrderProduct_default", request);
        purchaseOrderProductQuery.put("productModel_id", productModelId);
        List<Object> purchaseOrderProductList = new ArrayList<Object>();
        try {
            purchaseOrderProductList = baseManager.listObject(purchaseOrderProductQuery);
            if (purchaseOrderProductList != null && purchaseOrderProductList.size() > 0) {
                for (int i = 0; i < purchaseOrderProductList.size(); i++) {
                    PurchaseOrder purchaseOrder = ((PurchaseOrderProduct) purchaseOrderProductList.get(i)).getPurchaseOrder();
                    if (purchaseOrder.getId() == null || purchaseOrder.getUser() == null || purchaseOrder.getUser().getUsername() == null) {
                        purchaseOrderProductList.remove(i);
                    }
                }
                if (purchaseOrderProductList != null && purchaseOrderProductList.size() > 0) {
                    Collections.reverse(purchaseOrderProductList);
                }
            }
        } catch (Exception e) {
            purchaseOrderProductList = null;
        }
        model.addAttribute("purchaseOrderProductList", purchaseOrderProductList);
        XQuery productPicturexQuery = new XQuery("listProductPicture_default", request);
        productPicturexQuery.put("product_id", product.getId());
        List<Object> productPictureList = baseManager.listObject(productPicturexQuery);
        model.addAttribute("productPictureList", productPictureList);
        List<ProductModel> productModelListTmp = product.getProductModelList();
        List<ProductPicture> productPictures = product.getProductPictureList();
        ProductPicture productPicture = new ProductPicture();
        if (productPictures != null && productPictures.size() > 0) {
            for (ProductPicture p : productPictures) {
                if ("2".equals(p.getStatus())) {
                    productPicture = p;
                    break;
                }
            }
        }

        if (productModel != null) {
            String hql = "select obj from Artistry obj where obj.project.id=:projectId";
            LinkedHashMap<String, Object> param = new LinkedHashMap<>();
            param.put("projectId", productModel.getProduct().getProject().getId());
            List<Artistry> artistries = baseManager.listObject(hql, param);
            if (artistries != null && !artistries.isEmpty()) {
                model.addAttribute("artistry", artistries.get(0));
            }
        }

        model.addAttribute("productModelList", productModelListTmp);
        model.addAttribute("productModel", productModel);
        model.addAttribute("product", product);
        model.addAttribute("productPicture", productPicture);
        model.addAttribute("productPictures", productPictures);
        model.addAttribute("purchaseOrderProductList", purchaseOrderProductList);
        model.addAttribute("project", project);
        return "/product/productDetails";
    }

    /**
     * 商品收藏状态判断
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/favorite/productFavoriteStatus.do"})
    @ResponseBody
    public Boolean productFavoriteStatus(HttpServletRequest request) throws Exception {
        MyUser currentUser = AuthorizationUtil.getMyUser();
        Boolean flag = false;
        if (currentUser.getId() != null) {
            String productModelId = request.getParameter("id");
            XQuery xQuery = new XQuery("listProductFavorite_default", request);
            xQuery.put("user_id", currentUser.getId());
            xQuery.put("productModel_id", productModelId);
            List<ProductFavorite> productFavoriteList = baseManager.listObject(xQuery);
            if (productFavoriteList != null && productFavoriteList.size() > 0) {
                if ("1".equals(productFavoriteList.get(0).getStatus())) {
                    flag = true;
                }
            }
        }
        return flag;
    }

    /**
     * 根据projectId取推荐商品
     *
     * @param request
     * @return
     * @throws Exception
     */
    @RequestMapping({"/recommend/listProductModel.do"})
    @ResponseBody
    public List<Object> listProjectProduct(HttpServletRequest request) throws Exception {
        String projectId = request.getParameter("projectId");
        XQuery xQuery = new XQuery("listProductModel_projectIdRecommend", request);
        xQuery.put("product_project_id", projectId);
        List<Object> productModelList = baseManager.listObject(xQuery);
        return productModelList;
    }


    // url : /product/getProductModelList
    @RequestMapping({"/getProductModelList"})
    @ResponseBody
    public Object getProductModelList(HttpServletRequest request) {
        try {
            JSONObject jsonObject = JSONObject.fromObject(request.getParameter("param"));
            int limit = Integer.parseInt(request.getParameter("limit"));
            int offset = Integer.parseInt(request.getParameter("offset"));
            LinkedHashMap<String, Object> param = new LinkedHashMap<>();
            StringBuilder hql = new StringBuilder("select productModel from ProductModel productModel where productModel.status!=0 and productModel.product.type='3' ");
            for (Object key : jsonObject.keySet()) {
                hql.append("and ");
                hql.append("productModel.");
                hql.append(key.toString());
                hql.append("=:");
                hql.append(paramKeyFillter(key.toString()));
                hql.append(" ");
                param.put(paramKeyFillter(key.toString()), jsonObject.get(key));
            }
            PageEntity pageEntity = new PageEntity();
            pageEntity.setSize(limit);
            pageEntity.setrIndex(offset);
            PageInfo pageInfo = baseManager.listPageInfo(hql.toString(), pageEntity, param);
            return pageInfo.getList();
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "1");
            return jsonObject;
        }
    }

    private String paramKeyFillter(String key) {
        return key.replaceAll("\\.", "_");
    }

    // url: /product/getProductModelById
    @RequestMapping({"/getProductModelById"})
    @ResponseBody
    public Object getProductModelById(HttpServletRequest request) {
        try {
            String id = request.getParameter("id");
            ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), id);
            LinkedHashMap<String, Object> param = new LinkedHashMap<>();
            param.put("productId", productModel.getProduct().getId());
            String audioHql = "select obj from Image obj where obj.owner=:productId and obj.status!='0' and obj.type='2'";
            Image image = (Image) baseManager.getUniqueObjectByConditions(audioHql, param);
            String src = image == null ? "" : image.getSrc();
            productModel.setAudio(src);
            return productModel;
        } catch (Exception e) {
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "1");
            return jsonObject;
        }
    }

    @RequestMapping({"/getColumnListByProductModel"})
    @ResponseBody
    public Object getColumnListByProductModel(HttpServletRequest request) {
        try {
            String productModelId = request.getParameter("id");
            ProductModel productModel = (ProductModel) baseManager.getObject(ProductModel.class.getName(), productModelId);
            String productId = productModel.getProduct().getId();
            List<Panel> result;
            String hql = "select obj from " + Panel.class.getName() + " obj where obj.owner=:id";
            LinkedHashMap<String, Object> param = new LinkedHashMap<>();
            param.put("id", productId);
            result = baseManager.listObject(hql, param);
            if (result.isEmpty()) {
                param.put("id", productModelId);
                result = baseManager.listObject(hql, param);
            }
            return result;
        } catch (Exception e) {
            e.printStackTrace();
            JSONObject jsonObject = new JSONObject();
            jsonObject.put("code", "1");
            return jsonObject;
        }
    }
}
