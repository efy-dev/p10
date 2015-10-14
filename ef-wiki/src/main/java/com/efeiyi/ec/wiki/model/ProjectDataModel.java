package com.efeiyi.ec.wiki.model;

import com.efeiyi.ec.master.model.Master;
import com.efeiyi.ec.product.model.Product;

import java.io.Serializable;
import java.util.List;

/**
 * Created by Administrator on 2015/10/14.
 *
 */
public class ProjectDataModel implements Serializable {

    private List<Master> Masters;
    private List<Product> products;
    private ProjectModel projectModel;

    public ProjectModel getProjectModel() {
        return projectModel;
    }

    public void setProjectModel(ProjectModel projectModel) {
        this.projectModel = projectModel;
    }

    public List<Master> getMasters() {
        return Masters;
    }

    public void setMasters(List<Master> masters) {
        Masters = masters;
    }

    public List<Product> getProducts() {
        return products;
    }

    public void setProducts(List<Product> products) {
        this.products = products;
    }
}
