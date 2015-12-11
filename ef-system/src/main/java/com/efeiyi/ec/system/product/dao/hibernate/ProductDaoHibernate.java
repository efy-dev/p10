package com.efeiyi.ec.system.product.dao.hibernate;

import com.efeiyi.ec.product.model.ProductPicture;
import com.efeiyi.ec.system.product.dao.ProductDao;
import com.ming800.core.base.dao.XdoDao;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * Created by Administrator on 2015/8/17.
 */
@Repository
public class ProductDaoHibernate implements ProductDao{

    @Autowired
    private  XdoDao xdoDao ;

    @Autowired
    @Qualifier("sessionFactory")
    private SessionFactory sessionFactory;

    public Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    public int getMaxRecommendedIndex(String categoryId) {
        Integer maxValue = (Integer) this.getSession().createSQLQuery("select max(p.recommended_index) from product p where p.category_id='"+categoryId+"'").uniqueResult();

        return maxValue;
    }

    @Override
    public List getResult() {
        String sql = "select " +
                "p.serial as 商品编号,p.name as 商品名称," +
                "pm.serial as 商品规格编号,pm.name as 商品规格名称,pm.price as 价格,pm.market_price as 市场价格,pm.amount as 库存," +
                "CONCAT('http://www.efeiyi.com/product/list/',pt.id) as 链接,"+
                "p.status " +
                "as 状态, " +
                "pt.name as 项目,t.name as 店铺," +
                "pg.name  as 类别, " +
                "p.create_datetime  as 商品创建时间 " +
                "from product_model pm " +
                "left join product p " +
                "on pm.product_id = p.id " +
                "left join project pt " +
                "on p.project_id = pt.id " +
                "left join tenant t " +
                "on t.id = p.tenant_id " +
                "left join project_category pg " +
                "on pg.id = pt.category_id " +
                "where pm.status!='0'" +
                "order by pt.name";
       List objectList = this.getSession().createSQLQuery(sql).list();
        return  objectList;
    }

    @Override
    public Integer getProductPicture(String productId) {
        String sql = "select MAX(sort)  " +
                "from product_picture pp " +
                "where pp.product_id = :productId "+
                " and pp.status in ('3','9') ";
        List<Object> objectList = this.getSession().createSQLQuery(sql).setParameter("productId",productId).list();
        if(objectList.get(0)==null){
            return 0;
        }else {
            return (Integer) objectList.get(0);
        }
    }

    @Override
    public Integer getProductPicture1(String productId) {
        String sql = "select MAX(sort)  " +
                "from product_picture pp " +
                "where pp.product_id = :productId "+
                " and pp.status in ('1','2') ";
        List<Object> objectList = this.getSession().createSQLQuery(sql).setParameter("productId",productId).list();
        if(objectList.get(0)==null){
            return 0;
        }else {
            return (Integer) objectList.get(0);
        }
    }
}
