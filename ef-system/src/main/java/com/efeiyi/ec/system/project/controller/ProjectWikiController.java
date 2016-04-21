package com.efeiyi.ec.system.project.controller;

import com.efeiyi.ec.wiki.model.ArtistryDescription;
import com.efeiyi.ec.wiki.model.ArtistryPicture;
import com.efeiyi.ec.wiki.model.Artistry;
import com.ming800.core.base.service.BaseManager;
import com.ming800.core.p.service.AliOssUploadManager;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

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

        Artistry projectWiki = (Artistry) baseManager.getObject(Artistry.class.getName(), request.getParameter("projectWikiId"));
        //得到上传的图片文件并且上传到aliyun 并且保存ProjectPictrue对象
        CommonsMultipartFile multipartFile = (CommonsMultipartFile) multipartRequest.getFile("projectWikiMainPicture");
        long size = multipartFile.getFileItem().getSize();
        if (multipartFile.getFileItem().getSize() > 0) {
            if (projectWiki.getMainPicture() != null) {
                ArtistryPicture projectPicture2 = projectWiki.getMainPicture();
                projectPicture2.setStatus("2");
                baseManager.saveOrUpdate(ArtistryPicture.class.getName(), projectPicture2);
            }
            String url = "wikiproject/" + multipartFile.getOriginalFilename();
            boolean result = aliOssUploadManager.uploadFile(multipartFile, "ef-wiki", url);
            if (result) {
                ArtistryPicture projectPicture = new ArtistryPicture();
                projectPicture.setStatus("1");
                projectPicture.setPictureUrl(url);
                projectPicture.setArtistry(projectWiki);
                projectPicture.setSort(0);
                baseManager.saveOrUpdate(ArtistryPicture.class.getName(), projectPicture);
            }
        }

        //得到工艺描述的数据并且创建ProjectDescription对象
        //得到当前工艺的描述，如果有描述对象就用之前的，如果没有就新建一个新的
        String content = request.getParameter("description");
        if (projectWiki.getArtistryDescription() != null) {
            ArtistryDescription projectDescription = projectWiki.getArtistryDescription();
            projectDescription.setDescriptionPC(content);
            baseManager.saveOrUpdate(ArtistryDescription.class.getName(), projectDescription);
        } else {
            ArtistryDescription projectDescription = new ArtistryDescription();
            projectDescription.setDescriptionPC(content);
            baseManager.saveOrUpdate(ArtistryDescription.class.getName(), projectDescription);
            projectWiki.setArtistryDescription(projectDescription);
            baseManager.saveOrUpdate(Artistry.class.getName(), projectWiki);
        }

        //返回工艺详情页面
        return "redirect:/basic/xm.do?qm=viewProjectWiki&id=" + projectWiki.getId();

    }

}
