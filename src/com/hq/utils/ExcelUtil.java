package com.hq.utils;

import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.Collection;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

/**
 * @author zth
 * @Date 2019-05-22 16:44
 */
public class ExcelUtil {
    public static<T> HSSFWorkbook getHSSFWorkbook( String sheetNmae, String[] title, Collection<T> values){

        HSSFWorkbook workbook = new HSSFWorkbook();
        HSSFSheet sheet = workbook.createSheet(sheetNmae);

        HSSFRow row = sheet.createRow(0);
        row.setHeightInPoints(sheet.getDefaultRowHeightInPoints()*2);

        CellStyle cellStyle = workbook.createCellStyle();
        // 设置水平方向对齐方式
        cellStyle.setAlignment(HSSFCellStyle.ALIGN_CENTER);
        // 设置垂直方向对齐方式
        cellStyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);

        // 存储最大列宽
        Map<Integer,Integer> maxWidth = new HashMap<>();


        for (int i = 0; i < title.length; i++) {
            Cell cell = row.createCell(i);
            if (null != title[i]){
                cell.setCellValue(title[i].toString());
                maxWidth.put(i,cell.getStringCellValue().getBytes().length * 256 +800);
            }
            cell.setCellStyle(cellStyle);
        }

        
        int index = 1;
        Iterator<T> iterator = values.iterator();
        while (iterator.hasNext()){
            row = sheet.createRow(index++);
            T t = (T)iterator.next();
            Field[] fields = t.getClass().getDeclaredFields();
            for (int i = 0; i < fields.length; i++) {
                Field field = fields[i];
                String fieidName = field.getName();
                String methodName = "get"+fieidName.substring(0,1).toUpperCase()+fieidName.substring(1);

                try {
                    Method method = t.getClass().getDeclaredMethod(methodName,null);
                    Object value = method.invoke(t,null);

                    if (null != value){
                        Cell cell = row.createCell(i);
                        cell.setCellValue(value.toString());
                        cell.setCellStyle(cellStyle);
                        int length = cell.getStringCellValue().getBytes().length*256 +800;
                        if (length > 15000){
                            length = 15000;
                        }
                        if (null != maxWidth.get(i) && maxWidth.get(i) < length){
                            maxWidth.put(i,length);
                        }
                    }

                } catch (Exception e) {
                    System.out.println("获取对象值出错");
                    e.printStackTrace();
                }
            }
        }


        // 列宽自适应
        for (int i = 0; i < title.length; i++) {
            if (null != maxWidth.get(i)){
                sheet.setColumnWidth(i,maxWidth.get(i));
            }
        }

        return workbook;
    }

}














