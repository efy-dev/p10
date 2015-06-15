package com.ming800.core.p.service.impl;

import com.ming800.core.base.util.SystemValueUtil;
import com.ming800.core.base.model.MethodCache;
import com.ming800.core.does.model.StatusTypeItem;
import com.ming800.core.does.model.Xentity;
import com.ming800.core.does.model.Field;
import com.ming800.core.p.model.*;
import com.ming800.core.p.service.DictionaryDataManager;
import com.ming800.core.does.service.ModuleManager;
import com.ming800.core.util.*;
import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created with IntelliJ IDEA.
 * User: Administrator
 * Date: 13-3-19
 * Time: 上午9:33
 * To change this template use File | Settings | File Templates.
 */

/**
 * 导出处理
 * 1.new ImportProcessor() 创建导入类
 * 2.调用initDictionary 初始化entity 以及excel的表头信息
 * 3.parseRow/parseRowToObject 对excel的每一行进行数据处理
 * 使用示例：BigStudentManagerImpl.saveImportBigStudent
 */
public class ImportProcessor {

    private ModuleManager moduleManager = (ModuleManager) ApplicationContextUtil.getApplicationContext().getBean("moduleManagerImpl");
    private DictionaryDataManager dictionaryDataManager = (DictionaryDataManager) ApplicationContextUtil.getApplicationContext().getBean("dictionaryDataManagerImpl");
    private Map<String, String> dictionaryMap;       //数据字典<entityName_fieldName_dataValue,dataId>

    private Map<String, Short> fieldNameMap;       //excel文件 头信息 例如:名称，电话，性别，生日。。。（需要与配置文件中的field.label对应）

    private Xentity xentity;

    /**
     * @param entityName   配置文件 Entity.name  例:导入学员 entityName="BigStudent"
     * @param fieldNameMap excel文件 头信息 例如:名称，电话，性别，生日。。。（需要与配置文件中的field.label对应）
     */
    public void initDictionary(String entityName, Map<String, Short> fieldNameMap) {
        this.xentity = moduleManager.fetchXentity(entityName);
        this.fieldNameMap = fieldNameMap;
        this.dictionaryMap = new HashMap<>();
        for (Field field : xentity.getFieldMap().values()) {
            if (field.getInputType().equals("select_dictionary")) {
                Dictionary dictionary = (Dictionary) xentity.getFieldMap().get(field.getName());
                List<DictionaryData> dictionaryDataList = dictionaryDataManager.getDictionaryDataList(dictionary.getSid());
                if (dictionaryDataList != null) {
                    for (DictionaryData dictionaryData : dictionaryDataList) {
                        this.dictionaryMap.put(xentity.getName() + "_" + field.getName() + "_" + dictionaryData.getData(), dictionaryData.getId());
                    }
                }
            }
        }
    }

    /**
     * 对excel的一行进行处理
     * 读入一行对数据字典、状态等类型进行转换然后返回这一行
     *
     * @param row
     * @return
     * @throws Exception
     */
    public Row parseRow(Row row) throws Exception {
        for (Field field : xentity.getFieldMap().values()) {
            Cell cell = ImportExcelUtil.getCell(row, fieldNameMap.get(field.getLabel()));
            String text = ImportExcelUtil.getCellValue(cell);
            if (text != null && !text.equals("")) {
                Object value = null;
                if (field.getInputType() == null) {
                    field.setInputType("text");
                }
                if (field.getInputType().equals("select_dictionary") || field.getInputType().equals("radio_dictionary")) {
                    value = dictionaryMap.get(xentity.getName() + "_" + field.getName() + "_" + text);
                } else if (field.getInputType().equals("select_status")) {
                    List<StatusTypeItem> statusTypeItemList = moduleManager.listStatusTypeItem(xentity.getName() + "." + field.getName());
                    if (statusTypeItemList != null) {
                        for (StatusTypeItem statusTypeItem : statusTypeItemList) {
                            if (statusTypeItem.getLabel().equals(text)) {
                                value = statusTypeItem.getValue();
                            }
                        }
                    }
                } else {
                    value = text;
                }
                cell.setCellValue(value == null ? null : value.toString());
            }
        }
        return row;
    }

    /**
     * 对excel的一行进行处理
     * 读入一行对数据字典、状态等类型进行转换
     * 根据entity创建对象并通过反射赋值
     * 返回创建的对象
     *
     * @param row
     * @return
     * @throws Exception
     */
    public Object parseRowToObject(Row row, MethodCache methodCache) throws Exception {
        Object object = Class.forName(xentity.getModel()).newInstance();

        for (Field field : xentity.getFieldMap().values()) {
            Cell cell = ImportExcelUtil.getCell(row, fieldNameMap.get(field.getLabel()));
            String text = ImportExcelUtil.getCellValue(cell);
            text = SystemValueUtil.transformSpecialSymbol(text);
            if (text != null && !text.equals("")) {
                String reflectFieldName = field.getName();    //要进行反射的字段名
                Object value = null;                          //要进行反射的值
                if (field.getInputType() == null) {
                    continue;
                }
                if (field.getInputType().equals("select_dictionary") || field.getInputType().equals("radio_dictionary")) {

                    String dataId = dictionaryMap.get(xentity.getName() + "_" + reflectFieldName + "_" + text);
                    if (StringUtils.isEmpty(dataId)) {
                        throw new Exception("请先在系统中对\"" + field.getLabel() + "\"字段定义数据字典值\"" + text + "\",否则该列不能导入");
                    }
                    String[] array = reflectFieldName.split("\\.");
                    Object tempObject = dictionaryDataManager.getDictionaryDataById(dataId);
                    reflectFieldName = array[0];
                    value = tempObject;

                } else if (field.getInputType().equals("select_status")) {
                    List<StatusTypeItem> statusTypeItemList = moduleManager.listStatusTypeItem(xentity.getName() + "." + reflectFieldName);
                    if (statusTypeItemList != null) {
                        for (StatusTypeItem statusTypeItem : statusTypeItemList) {
                            if (statusTypeItem.getLabel().equals(text)) {
                                value = statusTypeItem.getValue();
                            }
                        }
                    }
                } else if (field.getInputType().equals("text") || field.getInputType().equals("date")) {
                    value = text;
                } else {
                    continue;
                }

                if (value != null) {      //根据字段类型做反射处理
                    if (field.getDataType() != null && field.getDataType().equals("date")) {
//                        ReflectUtil.invokeSetterMethod(object, reflectFieldName, DateUtil.parseDate(text));
                        methodCache.getMethodSetting(object.getClass(), reflectFieldName).getMethod().invoke(object, DateUtil.parseDate(value.toString()));
                    } else if (field.getDataType() != null && field.getDataType().equals("datetime")) {
//                        ReflectUtil.invokeSetterMethod(object,reflectFieldName,DateUtil.parseDateTime(text));
                        methodCache.getMethodSetting(object.getClass(), reflectFieldName).getMethod().invoke(object, DateUtil.parseDateTime(value.toString()));
                    } else if (field.getDataType() != null && field.getDataType().equals("int")) {
//                        ReflectUtil.invokeSetterMethod(object,reflectFieldName,Integer.parseInt(value.toString()));
                        methodCache.getMethodSetting(object.getClass(), reflectFieldName).getMethod().invoke(object, Integer.parseInt(value.toString()));
                    } else {
//                        ReflectUtil.invokeSetterMethod(object,reflectFieldName,value);
                        methodCache.getMethodSetting(object.getClass(), reflectFieldName).getMethod().invoke(object, value);
                    }
                }
            }
        }
        return object;
    }
}
