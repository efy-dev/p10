package com.efeiyi.ec.project.model;

import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import javax.persistence.criteria.Fetch;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/6/24.
 * 非遗项目管理
 */
@Entity
@Table(name="project")
public class Project {
    private String id;
    private String serial;//项目编号
    private String name;//项目名称
    private String status;//状态
    private String level;//级别
    private String type; //类别 1.美术 2.技艺
    private Project fatherProject;//父id
    private ProjectCategory projectCategory;//类别
    private Date createDateTime;//忽略
    private List<Project> subProjectList;//子项目
    private List<ProjectTag> projectTagList;//项目标签
    private  List<ProjectProperty> projectPropertyList;//项目属性

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

    @OneToMany(fetch = FetchType.LAZY,mappedBy = "project")
    @Where(clause = "status=1")
    public  List<ProjectTag> getProjectTagList(){
        return  projectTagList;
    }
    public  void  setProjectTagList(List<ProjectTag> projectTagList){
         this.projectTagList = projectTagList;
    }

    @OneToMany(fetch = FetchType.LAZY  ,mappedBy = "fatherProject")
    @Where(clause = "status=1")
    public  List<Project> getSubProjectList(){
        return  subProjectList;
    }
    public  void  setSubProjectList(List<Project> subProjectList){
        this.subProjectList = subProjectList;
    }

    @OneToMany(fetch = FetchType.LAZY,mappedBy = "project")
    @Where(clause = "status=1")
    public List<ProjectProperty> getProjectPropertyList() {
        return projectPropertyList;
    }

    public void setProjectPropertyList(List<ProjectProperty> projectPropertyList) {
        this.projectPropertyList = projectPropertyList;
    }

    //    @Column(name="father_project_id")
//    public String getFatherProjectId(){return  fatherProjectId;}
//    public void  setFatherProjectId(String fatherProjectId){
//          this.fatherProjectId = fatherProjectId;
//    }
}

