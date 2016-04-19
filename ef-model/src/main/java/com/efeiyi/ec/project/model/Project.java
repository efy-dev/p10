package com.efeiyi.ec.project.model;

import com.efeiyi.ec.master.model.MasterProject;
import com.efeiyi.ec.organization.model.AddressCity;
import com.efeiyi.ec.organization.model.AddressDistrict;
import com.efeiyi.ec.product.model.Product;
import com.efeiyi.ec.wiki.model.ProjectContent;
import com.efeiyi.ec.wiki.model.ProjectWiki;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonIgnoreProperties;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import javax.persistence.criteria.Fetch;
import java.io.Serializable;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/6/24.
 * 非遗项目管理
 */
@Entity
@Table(name="project")
@JsonIgnoreProperties(value = {"hibernateLazyInitializer", "handler"})
public class Project implements Serializable {
    private String id;
    private String serial;//项目编号
    private String name;//项目名称-
    private String status;//状态
    private String level;//级别
    private String type; //类别 1.美术 2.技艺



    private Project fatherProject;//父id
    private ProjectCategory projectCategory;//类别
    private Date createDateTime;//忽略
    private List<Project> subProjectList;//子项目
    private List<ProjectTag> projectTagList;//项目标签
    private  List<ProjectProperty> projectPropertyList;//项目属性
    private String description;// project描述
    private String picture_url;//project图片
    private String picture_pc_url;//pc端图片project图片
    private String picture_wap_url;//移动端图片project图片
    private List<Product> productList;
    private List<ProjectContent> projectContents;
    private List<ProjectFollowed> projectFolloweds;
    private AddressDistrict addressDistrict;
    private List<ProjectRecommended> projectRecommendeds;
    private Long fsAmount;
    private List<MasterProject> masterProjects;
    private ProjectWiki projectWiki;

    @Column(name="picture_wap_url")
    public String getPicture_wap_url() {
        return picture_wap_url;
    }

    public void setPicture_wap_url(String picture_wap_url) {
        this.picture_wap_url = picture_wap_url;
    }
    @Column(name="picture_url")
    public String getPicture_url() {
        return picture_url;
    }

    public void setPicture_url(String picture_url) {
        this.picture_url = picture_url;
    }
    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY, mappedBy = "project")
    public List<Product> getProductList() {
        return productList;
    }

    public void setProductList(List<Product> productList) {
        this.productList = productList;
    }

    @Id
    @GenericGenerator(name = "id", strategy = "com.ming800.core.p.model.M8idGenerator")
    @GeneratedValue(generator = "id")
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    @Column(name="serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "father_project_id")
    public  Project getFatherProject(){
        return  fatherProject;
    }

    public void  setFatherProject(Project fatherProject){
        this.fatherProject = fatherProject;
    }

    @Column(name="name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name="status")
    @Where(clause = "status=1")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name="level")
    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }
    @Column(name="description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }
    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="category_id")
    public ProjectCategory getProjectCategory() {
        return projectCategory;
    }

    public void setProjectCategory(ProjectCategory projectCategory) {
        this.projectCategory = projectCategory;
    }

    @Column(name="create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    @Column(name="type")
    public  String getType(){
        return  type;
    }

    public  void  setType(String type){
        this.type=type;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY,mappedBy = "project")
    @Where(clause = "status=1")
    public  List<ProjectTag> getProjectTagList(){
        return  projectTagList;
    }
    public  void  setProjectTagList(List<ProjectTag> projectTagList){
        this.projectTagList = projectTagList;
    }
    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY  ,mappedBy = "fatherProject")
    @Where(clause = "status=1")
    public  List<Project> getSubProjectList(){
        return  subProjectList;
    }
    public  void  setSubProjectList(List<Project> subProjectList){
        this.subProjectList = subProjectList;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY,mappedBy = "project")
    @Where(clause = "status=1")
    public List<ProjectProperty> getProjectPropertyList() {
        return projectPropertyList;
    }

    public void setProjectPropertyList(List<ProjectProperty> projectPropertyList) {
        this.projectPropertyList = projectPropertyList;
    }
    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY  ,mappedBy = "project")
    public List<ProjectContent> getProjectContents() {
        return projectContents;
    }

    public void setProjectContents(List<ProjectContent> projectContents) {
        this.projectContents = projectContents;
    }

    //    @Column(name="father_project_id")
//    public String getFatherProjectId(){return  fatherProjectId;}
//    public void  setFatherProjectId(String fatherProjectId){
//          this.fatherProjectId = fatherProjectId;
//    }
    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY  ,mappedBy = "project")
    public List<ProjectFollowed> getProjectFolloweds() {
        return projectFolloweds;
    }

    public void setProjectFolloweds(List<ProjectFollowed> projectFolloweds) {
        this.projectFolloweds = projectFolloweds;
    }

    //@JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY,optional = true)
    @JoinColumn(name="district_id")

    public AddressDistrict getAddressDistrict() {
        return addressDistrict;
    }

    public void setAddressDistrict(AddressDistrict addressDistrict) {
        this.addressDistrict = addressDistrict;
    }


    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY  ,mappedBy = "project")
    public List<ProjectRecommended> getProjectRecommendeds() {
        return projectRecommendeds;
    }

    public void setProjectRecommendeds(List<ProjectRecommended> projectRecommendeds) {
        this.projectRecommendeds = projectRecommendeds;
    }
    @Column(name="fans_amount")
    public Long getFsAmount() {
        return fsAmount;
    }

    public void setFsAmount(Long fsAmount) {
        this.fsAmount = fsAmount;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY  ,mappedBy = "project")
    public List<MasterProject> getMasterProjects() {
        return masterProjects;
    }

    public void setMasterProjects(List<MasterProject> masterProjects) {
        this.masterProjects = masterProjects;
    }
    @Column(name="picture_pc_url")
    public String getPicture_pc_url() {
        return picture_pc_url;
    }

    public void setPicture_pc_url(String picture_pc_url) {
        this.picture_pc_url = picture_pc_url;
    }

    @Override
    public String toString() {
        return "Project{id = " + id + "}";
    }
    @JsonIgnore
    @OneToOne(fetch = FetchType.LAZY, mappedBy = "project")
    public ProjectWiki getProjectWiki() {
        return projectWiki;
    }

    public void setProjectWiki(ProjectWiki projectWiki) {
        this.projectWiki = projectWiki;
    }
}

