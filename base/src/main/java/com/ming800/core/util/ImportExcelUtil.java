package com.ming800.core.util;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDateUtil;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;

import java.util.*;


/**
 * Created by IntelliJ IDEA.
 * User: lxh
 * Date: 2010-5-8
 * Time: 15:45:35
 * To change this template use File | Settings | File Templates.
 */
public class ImportExcelUtil {

    public static Map<String, Short> getFieldNameBaseMap(Properties properties, Sheet sheet) {
        Map<String, Short> fieldNameMap = new HashMap<String, Short>();
        Row titleRow = sheet.getRow(0);
        Iterator<Cell> cellIterator = null;
        if (titleRow != null)
            cellIterator = titleRow.iterator();
        short i = 0;
        while (cellIterator != null && cellIterator.hasNext()) {
            Cell cell = cellIterator.next();
            String colName = getCellValue(cell);
//            String propertyName = getFieldNameBase(properties, colName);
//            if (propertyName == null) {
            fieldNameMap.put(colName, i++);
//            } else {
//                fieldNameMap.put(propertyName, cell.getCellNum());
//            }
        }
        return fieldNameMap;
    }

    public static String getFieldNameBase(Properties properties, String colName) {
        Set<String> propertyNames = properties.stringPropertyNames();
        for (String propertyName : propertyNames) {

            String[] values = StringUtil.split(properties.getProperty(propertyName), ',');
            if (isMatchPropertyValue(values, colName)) {
                return propertyName;
            }

        }
        return null;
    }

    public static boolean isMatchPropertyValue(String[] propertyValues, String value) {
        for (String propertyValue : propertyValues) {
            if (value.equalsIgnoreCase(propertyValue)) {
                return true;
            }
        }
        return false;
    }

    public static Cell getCell(Row row, Short index) {
        if (index == null) {
            return null;
        }
        return row.getCell(index);
    }

    public static String getCellValue(Cell cell) {
        if (cell == null) {
            return null;
        }
        int type = cell.getCellType();
        if (type == HSSFCell.CELL_TYPE_BLANK) {
            return "";
        } else if (type == HSSFCell.CELL_TYPE_BOOLEAN) {
            return String.valueOf(cell.getBooleanCellValue());
        } else if (type == HSSFCell.CELL_TYPE_ERROR) {
            return String.valueOf(cell.getErrorCellValue());
        } else if (type == HSSFCell.CELL_TYPE_FORMULA) {
            return cell.getCellFormula();
        } else if (type == HSSFCell.CELL_TYPE_NUMERIC) {
            String str = null;
            if (HSSFDateUtil.isCellDateFormatted(cell)) {// 是否为日期型
                str = cell.getDateCellValue().toString(); //toLocaleString();
            } else {// 是否为数值型
                java.text.DecimalFormat formatter = new java.text.DecimalFormat("########");
                str = formatter.format(cell.getNumericCellValue());
            }
            return str;
        } else if (type == HSSFCell.CELL_TYPE_STRING) {
            return cell.getRichStringCellValue().getString();
        } else {
            return null;
        }
    }


    //删除将要添加到对象中的数据，得到将要添加到自定义表单的Map数据
    public static Map<String, Short> getPropertyDefMapByRemove(Map<String, Short> fieldNameMap, Properties properties) {
        Map<String, Short> fieldNameMap2 = new HashMap<String, Short>();
        fieldNameMap2.putAll(fieldNameMap);
        Set<String> propertyNames = properties.stringPropertyNames();
        for (String propertyName : propertyNames) {
            fieldNameMap2.remove(propertyName);
        }
        return fieldNameMap2;
    }

    public static String getCheckboxOptionValue(String options, String label) {
        String value = "";
        String[] labelvalues = {};
        if (label == null || "".equals(label)) {
            return label;
        }
        String flag = "";
        if (label.indexOf(",") > 0) {
            labelvalues = label.split(",");
            flag = "value";
        } else if (label.indexOf("，") > 0) {
            labelvalues = label.split("，");
            flag = "value";
        } else if (label.indexOf(";") > 0) {
            labelvalues = label.split(";");
            flag = "label";
        }
        if (labelvalues.length > 0) {
            if ("value".equals(flag)) {
                for (int j = 0; j < labelvalues.length; j++) {
                    String val = getOptionValue(options, labelvalues[j]);
                    if (!"".equals(val)) {
                        value += val + ";";
                    }
                }
            } else if ("label".equals(flag)) {
                for (int j = 0; j < labelvalues.length; j++) {
                    String val = getOptionValue(options, labelvalues[j]);
                    if (!"".equals(val)) {
                        value += val + "，";
                    }
                }
            }
            if (!"".equals(value)) {
                value = value.substring(0, value.length() - 1);
            }
        } else {
            value = getOptionValue(options, label);
        }
        return value;
    }

    public static String getOptionValue(String options, String label) {
        String option = "";
        String[] optionValues = options.split(";");
        for (int i = 0; i < optionValues.length; i++) {
            String[] temp = optionValues[i].split(",");
            if (label.equals(temp[1])) {
                option = temp[0];
            } else if (label.equals(temp[0])) {
                option = temp[1];
            }
        }
        return option;
    }

}
