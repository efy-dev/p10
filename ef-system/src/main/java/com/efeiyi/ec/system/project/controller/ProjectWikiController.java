package com.efeiyi.ec.system.project.controller;

import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.wiki.model.ProjectDescription;
import com.efeiyi.ec.wiki.model.ProjectPicture;
import com.efeiyi.ec.wiki.model.ProjectWiki;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartRequest;

import javax.servlet.http.HttpServletRequest;

/**
 * Created by Administrator on 2016/4/18 0018.
 */
@Controller
@RequestMapping("/projectWiki")
public class ProjectWikiController {

    @Autowired
    private AliOssUploadManager aliOssUploadManager;

    @Autowired
    private BaseManager baseManager;


    @RequestMapping({"update.do"})
    public String updateDescriptionAndMainPictureOfProjectWiki(HttpServletRequest request, MultipartRequest multipartRequest) throws Exception {

        ProjectWiki projectWiki = (ProjectWiki) baseManager.getObject(ProjectWiki.class.getName(), request.getParameter("projectWikiId"));
        //得到上传的图片文件并且上传到aliyun 并且保存ProjectPictrue对象
        MultipartFile multipartFile = multipartRequest.getFile("projectWikiMainPicture");
        if (multipartFile != null) {
            if (projectWiki.getMainPicture() != null) {
                ProjectPicture projectPicture2 = projectWiki.getMainPicture();
                projectPicture2.setStatus("2");
                baseManager.saveOrUpdate(ProjectPicture.class.getName(), projectPicture2);
            }
            String url = "wikiproject/" + multipartFile.getOriginalFilename();
            boolean result = aliOssUploadManager.uploadFile(multipartFile, "ef-wiki", url);
            ProjectPicture projectPicture = new ProjectPicture();
            projectPicture.setStatus("1");
            projectPicture.setPictureUrl(url);
            projectPicture.setProjectWiki(projectWiki);
            projectPicture.setSort(0);
            baseManager.saveOrUpdate(ProjectPicture.class.getName(), projectPicture);
        }

        //得到工艺描述的数据并且创建ProjectDescription对象
        String content = request.getParameter("description");
        ProjectDescription projectDescription = new ProjectDescription();
        projectDescription.setDescription(content);
        baseManager.saveOrUpdate(ProjectDescription.class.getName(), projectDescription);
        projectWiki.setProjectDescription(projectDescription);
        baseManager.saveOrUpdate(ProjectWiki.class.getName(), projectWiki);

        //返回工艺详情页面
        return "redirect:/basic/xm.do?qm=viewProjectWiki&id=" + projectWiki.getId();

    }

}
