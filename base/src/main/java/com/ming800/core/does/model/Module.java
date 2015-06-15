package com.ming800.core.does.model;



import java.util.List;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-4-19
 * Time: 下午5:55
 * To change this template use File | Settings | File Templates.
 */
public class Module {


    private String name;
    private String label;
    private String version;
    private String packagePath;
    private String path;


    private List<Xentity> xentityList;
    private List<ConfigProperty> configPropertyList;


    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getLabel() {
        return label;
    }

    public void setLabel(String label) {
        this.label = label;
    }

    public String getVersion() {
        return version;
    }

    public void setVersion(String version) {
        this.version = version;
    }

    public String getPackagePath() {
        return packagePath;
    }

    public void setPackagePath(String packagePath) {
        this.packagePath = packagePath;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public List<Xentity> getXentityList() {
        return xentityList;
    }

    public void setXentityList(List<Xentity> xentityList) {
        this.xentityList = xentityList;
    }

    public List<ConfigProperty> getConfigPropertyList() {
        return configPropertyList;
    }

    public void setConfigPropertyList(List<ConfigProperty> configPropertyList) {
        this.configPropertyList = configPropertyList;
    }
}
