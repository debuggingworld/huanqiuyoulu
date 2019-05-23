package com.hq.servlet.admin;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.hq.bean.Admin;
import com.hq.db.DB;
import com.hq.servlet.core.Action;
import com.hq.utils.ExcelUtil;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;

import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @author zth
 * @Date 2019-05-22 16:40
 */
@WebServlet("/admin/printExcel")
public class ExcelAction extends Action {
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {

    }

    public void admin(Mapping mapping) throws ServletException, IOException{
        String[] title = new String[]{"ID","邮箱","密码","权限"};
        String jsonTitle = JSON.toJSONString(title);

        JSONArray tti = JSON.parseArray(jsonTitle);
        List<Admin> admins = null;

        try {
            admins = DB.getAll(Admin.class,"select * from admin order by id");
        } catch (SQLException e) {
            e.printStackTrace();
        }
        HSSFWorkbook workbook = ExcelUtil.getHSSFWorkbook( "管理员",title,admins);

        String fileName = "管理员.xls";
        download(mapping,fileName,workbook);
    }

    private void download(Mapping mapping, String fileName, Workbook workbook) throws ServletException, IOException{
        // 文件下载
        String downName = new String (fileName.getBytes("utf-8"),"iso-8859-1");

        mapping.getResp().setHeader("Content-Disposition","attachment;filename="+downName);

        ServletOutputStream outputStream = mapping.getResp().getOutputStream();

        workbook.write(outputStream);

        outputStream.close();
    }

}
