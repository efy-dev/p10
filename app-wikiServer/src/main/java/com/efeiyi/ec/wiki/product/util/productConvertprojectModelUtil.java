package com.efeiyi.ec.wiki.product.util;

import com.efeiyi.ec.organization.model.AddressCity;
import com.efeiyi.ec.organization.model.AddressProvince;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectRecommended;
import com.efeiyi.ec.wiki.model.ProductComment;
import com.efeiyi.ec.wiki.model.ProductPraise;
import com.efeiyi.ec.wiki.product.model.ProductCommentModel;
import com.efeiyi.ec.wiki.product.model.ProductPraiseModel;
import com.efeiyi.ec.wiki.project.model.ProjectDataModel;
import com.efeiyi.ec.wiki.project.model.ProjectModel;
import com.efeiyi.ec.wiki.project.model.ProjectRecommendedModel;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/10/10.
 *
 */
public class productConvertprojectModelUtil {
    private static Logger logger = Logger.getLogger(productConvertprojectModelUtil.class);


    public static List<ProductCommentModel> getProductCommentModel(List<ProductComment> productComments) {
        List<ProductCommentModel> list = new ArrayList<ProductCommentModel>();
        if (productComments != null && productComments.size() >= 1) {
            for (ProductComment productComment : productComments) {
                ProductCommentModel productCommentModel = new ProductCommentModel();
                productCommentModel.setModerator(productComment.getModerator() == null ? null : productComment.getModerator());
                productCommentModel.setStatus(productComment.getStatus() == null ? "" : productComment.getStatus());
                productCommentModel.setWatch(productComment.getWatch() == null ? "" : productComment.getWatch());
                productCommentModel.setUser(productComment.getUser() == null ? null : productComment.getUser());
                productCommentModel.setProduct(productComment.getProduct() == null ? null : productComment.getProduct().getId());
                productCommentModel.setContent(productComment.getContent() == null ? "" : productComment.getContent());
                productCommentModel.setCreateDateTime(productComment.getCreateDateTime() == null ? new Date() : productComment.getCreateDateTime());
                productCommentModel.setFatherComment(productComment);
                productCommentModel.setId(productComment.getId());
                productCommentModel.setSubComment(productComment.getSubComment() == null ? null : productComment.getSubComment());
                list.add(productCommentModel);
            }
        }
        return list;
    }

    public static List<ProductPraiseModel> getpraise2ProductModel(List<ProductPraise> productPraises) {
        List<ProductPraiseModel> list = new ArrayList<ProductPraiseModel>();
        if (productPraises != null && productPraises.size() >= 1) {
            for (ProductPraise productComment : productPraises) {
                ProductPraiseModel productPraiseModel = new ProductPraiseModel();
                productPraiseModel.setModerator(productComment.getModerator());
                productPraiseModel.setStatus(productComment.getStatus());
                productPraiseModel.setWatch(productComment.getWatch());
                productPraiseModel.setProduct(productComment.getProduct().getId());
                productPraiseModel.setUser(productComment.getUser());
                productPraiseModel.setComment(productComment.getComment());
                productPraiseModel.setCreateDateTime(productComment.getCreateDateTime());
                productPraiseModel.setType(productComment.getType());
                productPraiseModel.setId(productComment.getId());
                list.add(productPraiseModel);
            }
        }
        return list;
    }
}