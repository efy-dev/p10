package com.ming800.core.does.model;

import java.util.LinkedHashMap;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: ming
 * Date: 12-11-28
 * Time: 上午9:51
 * To change this template use File | Settings | File Templates.
 */
public class Xentity {


    private String name;
    private String label;

    private String type;

    /*permission*/
    private String basic;
    private String others;

    private String reference;
    private String model;

    private Module module;

    private Map<String, Do> doMap;
    private LinkedHashMap<String, Field> fieldMap;
    private Map<String, Field> moFieldMap;


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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getBasic() {
        return basic;
    }

    public void setBasic(String basic) {
        this.basic = basic;
    }

    public String getOthers() {
        return others;
    }

    public void setOthers(String others) {
        this.others = others;
    }

    public String getReference() {
        return reference;
    }

    public void setReference(String reference) {
        this.reference = reference;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public Module getModule() {
        return module;
    }

    public void setModule(Module module) {
        this.module = module;
    }

    public Map<String, Do> getDoMap() {
        return doMap;
    }

    public void setDoMap(Map<String, Do> doMap) {
        this.doMap = doMap;
    }

    public LinkedHashMap<String, Field> getFieldMap() {
        return fieldMap;
    }

    public void setFieldMap(LinkedHashMap<String, Field> fieldMap) {
        this.fieldMap = fieldMap;
    }

    public Map<String, Field> getMoFieldMap() {
        return moFieldMap;
    }

    public void setMoFieldMap(Map<String, Field> moFieldMap) {
        this.moFieldMap = moFieldMap;
    }
}
