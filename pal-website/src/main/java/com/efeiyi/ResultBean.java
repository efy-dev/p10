package com.efeiyi;

import com.efeiyi.pal.product.model.Product;

/**
 * Created by Administrator on 2015/7/29.
 */
public class ResultBean{
    private String logo;
    private String msg;
    private int authenticity;
    private boolean isTimeLimited = false;
    private int timeLimit;

    public String getLogo() {
        return logo;
    }

    public String getMsg() {
        return msg;
    }

    public void setLogo(String logo) {
        this.logo = logo;
    }

    public void setMsg(String msg) {
        this.msg = msg;
    }

    public int getAuthenticity() {
        return authenticity;
    }

    public void setAuthenticity(int authenticity) {
        this.authenticity = authenticity;
    }

    public boolean getIsTimeLimited() {
        return isTimeLimited;
    }

    public void setIsTimeLimited(boolean isTimeLimited) {
        this.isTimeLimited = isTimeLimited;
    }

    public int getTimeLimit() {
        return PalConst.getInstance().timeLimit;
    }
}
