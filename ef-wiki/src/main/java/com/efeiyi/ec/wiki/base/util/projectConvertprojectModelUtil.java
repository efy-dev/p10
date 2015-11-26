package com.efeiyi.ec.wiki.base.util;

import com.efeiyi.ec.organization.model.AddressCity;
import com.efeiyi.ec.organization.model.AddressProvince;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectRecommended;
import com.efeiyi.ec.wiki.model.*;
import org.apache.log4j.Logger;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/10/10.
 *
 */
public class projectConvertprojectModelUtil {
    private static Logger logger = Logger.getLogger(projectConvertprojectModelUtil.class);

    public static ProjectModel projectConvertprojectModel(Project project) {
        ProjectModel projectModel = new ProjectModel();
        if (project != null) {
            projectModel.setCreateDateTime(project.getCreateDateTime() == null ? new Date() : project.getCreateDateTime());
            AddressCity addressCity;
            AddressProvince addressProvince;
            String addressProvinceName = "";
            if (null != project.getAddressDistrict()) {
                addressCity = project.getAddressDistrict().getAddressCity();
                if (null != addressCity) {
                    addressProvince = project.getAddressDistrict().getAddressCity().getAddressProvince();
                    if (null != addressProvince) {
                        addressProvinceName = addressProvince.getName();
                    }
                }
            }
            projectModel.setAddressDistrict(addressProvinceName == null ? "" : addressProvinceName);
            projectModel.setDescription(project.getDescription() == null ? "" : project.getDescription());
            projectModel.setFsAmount(project.getFsAmount() == null ? 0l : project.getFsAmount());
            projectModel.setLevel(project.getLevel() == null ? "" : project.getLevel());
            projectModel.setMasters((long) project.getMasterProjects().size());
            projectModel.setPicture_pc_url(project.getPicture_pc_url() == null ? "" : project.getPicture_pc_url());
            projectModel.setPicture_wap_url(project.getPicture_wap_url() == null ? "" : project.getPicture_wap_url());
            projectModel.setProjectId(project.getId() == null ? "" : project.getId());
            projectModel.setProjectName(project.getName() == null ? "" : project.getName());
            projectModel.setWorks((long) project.getProductList().size());
        }

        return projectModel;
    }


    public static ProjectDataModel getProjectDataModel(Project project) {
        ProjectModel projectModel = projectConvertprojectModel(project);
        ProjectDataModel projectDataModel = new ProjectDataModel();
        projectDataModel.setProjectModel(projectModel);
        projectDataModel.setProducts(project.getProductList());
        return projectDataModel;
    }


    public static ProjectRecommendedModel getProjectRecommendedModel(ProjectRecommended projectRecommended) {
        ProjectRecommendedModel projectRecommendedModel = new ProjectRecommendedModel();
        projectRecommendedModel.setStatus(projectRecommended.getStatus());
        projectRecommendedModel.setId(projectRecommended.getId());
        projectRecommendedModel.setGroupName(projectRecommended.getGroupName());
        projectRecommendedModel.setSort(projectRecommended.getSort());
        projectRecommendedModel.setProject(projectRecommended.getProject());
        projectRecommendedModel.setAttention("0");
        return projectRecommendedModel;
    }

    public static List<ProjectRecommendedModel> getProjectRecommendedModels(List<ProjectRecommended> projectRecommendeds) {
        List<ProjectRecommendedModel> list = new ArrayList<ProjectRecommendedModel>();
        for (ProjectRecommended projectRecommended : projectRecommendeds) {
            ProjectRecommendedModel projectRecommendedModel = new ProjectRecommendedModel();
            projectRecommendedModel.setStatus(projectRecommended.getStatus());
            projectRecommendedModel.setId(projectRecommended.getId());
            projectRecommendedModel.setGroupName(projectRecommended.getGroupName());
            projectRecommendedModel.setSort(projectRecommended.getSort());
            projectRecommendedModel.setProject(projectRecommended.getProject());
            projectRecommendedModel.setAttention("0");
            list.add(projectRecommendedModel);
        }

        return list;
    }

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