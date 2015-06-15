package com.ming800.core.does.model;

import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-17
 * Time: 下午6:09
 * To change this template use File | Settings | File Templates.
 */
public interface Do {

    public String getName();

    public void setName(String name);

    public String getLabel();

    public void setLabel(String label);

    public String getType();

    public void setType(String type);

    /*public String getModel();
    public void setModel(String model);*/
    public Xentity getXentity();

    public void setXentity(Xentity xentity);

    public String getExecute();

    public void setExecute(String execute);

/*    public String getEntity();
    public void setEntity(String entity);*/

    public String getResult();

    public void setResult(String result);

    public String getAccess();

    public void setAccess(String access);

    public List<DoQuery> getDoQueryList();

    public void setDoQueryList(List<DoQuery> doQueryList);

    public List<Page> getPageList();

    public void setPageList(List<Page> pageList);

    public DoQuery getDoQueryByName(String name);

    public String getData();

    public void setData(String data);
}
