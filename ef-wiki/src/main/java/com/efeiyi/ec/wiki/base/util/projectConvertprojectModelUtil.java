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
            projectModel.setPicture_url(project.getPicture_url() == null ? "" : project.getPicture_url());
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

    public static List<Praise2ProductModel> getpraise2ProductModel(List<Praise2Product> praise2Products) {
        List<Praise2ProductModel> list = new ArrayList<Praise2ProductModel>();
        if (praise2Products != null && praise2Products.size() >= 1) {
            for (Praise2Product productComment : praise2Products) {
                Praise2ProductModel praise2ProductModel = new Praise2ProductModel();
                praise2ProductModel.setModerator(productComment.getModerator());
                praise2ProductModel.setStatus(productComment.getStatus());
                praise2ProductModel.setWatch(productComment.getWatch());
                praise2ProductModel.setProduct(productComment.getProduct().getId());
                praise2ProductModel.setUser(productComment.getUser());
                praise2ProductModel.setComment(productComment.getComment());
                praise2ProductModel.setCreateDateTime(productComment.getCreateDateTime());
                praise2ProductModel.setType(productComment.getType());
                praise2ProductModel.setId(productComment.getId());
                list.add(praise2ProductModel);
            }
        }
        return list;
    }
}