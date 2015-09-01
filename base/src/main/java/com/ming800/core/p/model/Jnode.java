package com.ming800.core.p.model;

import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.Arrays;
import java.util.List;

/**
 * Created by IntelliJ IDEA.
 * User: ming
 * Date: 12-8-6
 * Time: 上午10:03
 * To change this template use File | Settings | File Templates.
 */
public class Jnode {
    private String id;
    private String text_zh_CN;
    private String url;
    private String state;
    private String access;
    private List<Jnode> children;
    private Jnode father;//节点的父节点
    private List<String> matchList; //菜单相关页面的匹配项

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getText_zh_CN() {
        return text_zh_CN;
    }

    public void setText_zh_CN(String text_zh_CN) {
        this.text_zh_CN = text_zh_CN;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getAccess() {
        return access;
    }

    public void setAccess(String access) {
        this.access = access;
    }

    public List<Jnode> getChildren() {
        return children;
    }

    public void setChildren(List<Jnode> children) {
        this.children = children;
    }

    public List<String> getMatchList() {
        return matchList;
    }

    public void setMatchList(List<String> matchList) {
        this.matchList = matchList;
    }

    @JsonIgnore
    public Jnode getFather() {
        return father;
    }

    @JsonIgnore
    public Jnode getRootFather() {
        if (father == null) {
            return this;
        } else
            return getRootFather(father);
    }

    private Jnode getRootFather(Jnode jnode) {
        if (jnode.father == null) {
            return jnode;
        } else {
            return getRootFather(jnode.father);
        }
    }

    public void setFather(Jnode father) {
        this.father = father;
    }


    /**
     * 判断jnode中是否包含匹配项
     *
     * @param match 匹配项，在配置文件中配置
     * @return
     */
    public boolean contain(String match) {
        boolean flag = false;
        if (matchList != null && matchList.size() > 0 && match != null && !"".equals(match)) {
            for (String matchTemp : matchList) {
                if (!matchTemp.trim().equals("") & match.trim().startsWith(matchTemp.trim())) {
                    flag = true;
                }
            }
        }
        return flag;
    }


    //只匹配** a** a**b **b
    private boolean isMatch(String configurationStr, String matchStr) {
        boolean flag = false;
        if (!configurationStr.contains("**")) {
            return flag;
        } else if (configurationStr.startsWith("**")) {
            //通配前缀
            String tepStr = configurationStr.substring(2, configurationStr.length());
            if (matchStr.endsWith(tepStr)) {
                flag = true;
            }
        } else if (configurationStr.endsWith("**")) {
            //通配后缀
            String tepStr = configurationStr.substring(0, configurationStr.length() - 2);
            if (matchStr.startsWith(tepStr)) {
                flag = true;
            }
        } else {
            List<String> tepStrList = Arrays.asList(configurationStr.split("\\*\\*"));
            //通配中间部分
            String tepStr0 = tepStrList.get(0);
            String tepStr1 = tepStrList.get(1);
            if (matchStr.startsWith(tepStr0) && matchStr.endsWith(tepStr1)) {
                flag = true;
            }
        }
        return flag;
    }

    public boolean contain(Jnode jnode, String match) {
        if (jnode.matchList != null && jnode.matchList.size() > 0 && match != null && !"".equals(match)) {
            boolean flag = false;
            for (String matchTemp : jnode.matchList) {
                if (match.trim().equals(matchTemp.trim())) {
                    flag = true;
                }
            }
            return flag;
        } else {
            return false;
        }
    }

    public String jnodeMatch(String style, String url) {
        if (!url.equals("") && contain(url)) {
            return style;
        } else return "";
    }

    public String jnodeMatch(String style, Jnode jnode) {

        if (jnode != null && id.equals(jnode.getId())) {

            return style;
        } else return "";
    }

}
