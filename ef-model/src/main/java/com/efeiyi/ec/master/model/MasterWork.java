package com.efeiyi.ec.master.model;

import com.efeiyi.ec.product.model.ProductDescription;
import com.efeiyi.ec.product.model.ProductPicture;
import com.efeiyi.ec.project.model.Project;
import com.efeiyi.ec.project.model.ProjectCategory;
import com.fasterxml.jackson.annotation.JsonIgnore;
import org.hibernate.annotations.GenericGenerator;
import org.hibernate.annotations.Where;

import javax.persistence.*;
import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

/**
 * Created by Administrator on 2015/6/26.
 */
@Entity
@Table(name = "master_work")
public class MasterWork {
    private String id;
    private String name;
    private String serial;  //随机生成
    private String pictureUrl; //作品封面？
    private Master master;
    private ProjectCategory category;
    private BigDecimal price;
    private Integer sort; //传承人主页推荐的三个作品
    private List<MasterWorkPicture> masterWorkPictureList;
    private ProductDescription productDescription;
    private String status;
    private Project project;  //类别
    private Date createDateTime;
    private  List<MasterWorkRecommended> masterWorkRecommendedList;//推荐
    // /   private  MasterWorkRecommended recommended;//推荐作品
//    private List<ProjectTag> projectTagList;
    private String praiseStatus;
    private String storeStatus;
    private Integer amount;
    private Integer fsAmount;
    private Integer storeAmount;
    private String size;//尺寸 规格
    private String site;//馆藏地
    private String material;//材质
    private String description;//介绍
    private String audio;//语音

    @Transient
    public String getPraiseStatus() {
        return praiseStatus;
    }

    public void setPraiseStatus(String praiseStatus) {
        this.praiseStatus = praiseStatus;
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

    @Column(name = "name")
    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "sort")
    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }


    @Column(name = "serial")
    public String getSerial() {
        return serial;
    }

    public void setSerial(String serial) {
        this.serial = serial;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "master_id")
    public Master getMaster() {
        return master;
    }

    public void setMaster(Master master) {
        this.master = master;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "category_id")
    public ProjectCategory getCategory() {
        return category;
    }

    public void setCategory(ProjectCategory category) {
        this.category = category;
    }

    @Column(name = "picture_url")
    public String getPictureUrl() {
        return pictureUrl;
    }

    public void setPictureUrl(String pictureUrl) {
        this.pictureUrl = pictureUrl;
    }


    @Column(name = "price")
    public BigDecimal getPrice() {
        return price;
    }

    public void setPrice(BigDecimal price) {
        this.price = price;
    }

    @OneToMany(fetch = FetchType.LAZY, mappedBy = "masterWork")
    @Where(clause = "status=1")
    @OrderBy("sort asc")
    public List<MasterWorkPicture> getMasterWorkPictureList() {
        return masterWorkPictureList;
    }


    public void setMasterWorkPictureList(List<MasterWorkPicture> masterWorkPictureList) {
        this.masterWorkPictureList = masterWorkPictureList;
    }

    @JsonIgnore
    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_description_id")
    public ProductDescription getProductDescription() {
        return productDescription;
    }

    public void setProductDescription(ProductDescription productDescription) {
        this.productDescription = productDescription;
    }

    @Transient
    public String getStoreStatus() {
        return storeStatus;
    }

    public void setStoreStatus(String storeStatus) {
        this.storeStatus = storeStatus;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "project_id")
    public Project getProject() {
        return project;
    }

    public void setProject(Project project) {
        this.project = project;
    }

    @Column(name="create_datetime")
    public Date getCreateDateTime() {
        return createDateTime;
    }

    public void setCreateDateTime(Date createDateTime) {
        this.createDateTime = createDateTime;
    }

    @JsonIgnore
    @OneToMany(fetch = FetchType.LAZY,mappedBy = "masterWork")
    @Where(clause = "status=1")
    public List<MasterWorkRecommended> getMasterWorkRecommendedList() {
        return masterWorkRecommendedList;
    }

    public void setMasterWorkRecommendedList(List<MasterWorkRecommended> masterWorkRecommendedList) {
        this.masterWorkRecommendedList = masterWorkRecommendedList;
    }

    @Column(name = "comment_number")
    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    @Column(name = "fans_amount")
    public Integer getFsAmount() {
        return fsAmount;
    }

    public void setFsAmount(Integer fsAmount) {
        this.fsAmount = fsAmount;
    }

    @Column(name = "store_amount")
    public Integer getStoreAmount() {
        return storeAmount;
    }

    public void setStoreAmount(Integer storeAmount) {
        this.storeAmount = storeAmount;
    }

    @Column(name = "size")
    public String getSize() {
        return size;
    }

    public void setSize(String size) {
        this.size = size;
    }
    @Column(name = "site")
    public String getSite() {
        return site;
    }

    public void setSite(String site) {
        this.site = site;
    }
    @Column(name = "material")
    public String getMaterial() {
        return material;
    }

    public void setMaterial(String material) {
        this.material = material;
    }
    @Column(name = "description")
    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Column(name = "audio")
    public String getAudio() {
        return audio;
    }

    public void setAudio(String audio) {
        this.audio = audio;
    }

    @Override
    public String toString(){
        return  "MasterWork{id = "+id+"}";
    }
}
