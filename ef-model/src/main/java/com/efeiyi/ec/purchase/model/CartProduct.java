package com.efeiyi.ec.purchase.model;

import com.efeiyi.ec.product.model.ProductModel;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by Administrator on 2015/6/15.
 */
@Entity
@Table(name = "purchase_cart_product")
public class CartProduct implements Serializable {

    private String id;
    private Cart cart;
    private ProductModel productModel;
    private Integer amount;
    private String status; // 9:临时数据
    private String isChoose; // 1：已选中 2：未选中
    private Cart cartCatch;

    @Transient
    public Cart getCartCatch() {
        return cartCatch;
    }

    public void setCartCatch(Cart cartCatch) {
        this.cartCatch = cartCatch;
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


    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "cart_id")
    public Cart getCart() {
        return cart;
    }

    public void setCart(Cart cart) {
        this.cart = cart;
    }

    @ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name = "product_id")
    public ProductModel getProductModel() {
        return productModel;
    }

    public void setProductModel(ProductModel productModel) {
        this.productModel = productModel;
    }


    @Column(name = "amount")
    public Integer getAmount() {
        return amount;
    }

    public void setAmount(Integer amount) {
        this.amount = amount;
    }

    @Column(name = "status")
    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    @Column(name = "is_choose")
    public String getIsChoose() {
        return isChoose;
    }

    public void setIsChoose(String isChoose) {
        this.isChoose = isChoose;
    }

    @Override
    public String toString() {
        return "CartProduct{id = " + id + "}";
    }
}
