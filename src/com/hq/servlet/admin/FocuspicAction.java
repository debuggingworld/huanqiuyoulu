package com.hq.servlet.admin;

import com.hq.bean.Focuspic;
import com.hq.db.DB;
import com.hq.fileUpload.FilePart;
import com.hq.fileUpload.FileUploadUtil;
import com.hq.servlet.core.Action;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;


/**
 * @author zth
 * @Date 2019-05-09 16:44
 */
@WebServlet("/admin/focuspic")
public class FocuspicAction extends Action {
    private static Logger log = Logger.getLogger(FocuspicAction.class);
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        List<Focuspic> flist = null;

        String sql = "select * from focuspic order by level";
        try {
            flist = DB.getAll(Focuspic.class,sql);
            mapping.setAttr("flist",flist);
        } catch (SQLException e) {
            log.error("com.hq.servlet.admin.FocuspicAction_查询焦点图失败");
            e.printStackTrace();
        }

        mapping.forward("admin/focuspic_list.jsp");
    }

    /**
     * 上传焦点图
     */
    public void uploadPic(Mapping mapping) throws ServletException, IOException {
        String basePath = this.getServletContext().getRealPath("ups");

        FileUploadUtil fup = new FileUploadUtil(mapping.getReq(),1024*1024*10,new String[]{".jpg",".bmp",".gif",".png"},basePath);

        try {
            fup.uploadFile();

            if (fup.getFileParts().size() == 1 && fup.getFileParts().get(0).getResult() == 0){
                FilePart fp=fup.getFileParts().get(0);
                String sql="insert into focuspic( path, level,dis,link) value(?,?,?,?)";
                DB.update(sql,mapping.basePath()+"ups/"+fp.getNewName(),fup.getFormValues().get("level"),fup.getFormValues().get("dis"),fup.getFormValues().get("link"));
                mapping.setAttr("msg", "增加焦点成功！");
            }
        } catch (Exception e) {
            log.error("com.hq.servlet.admin.FocuspicAction_上传焦点图失败!"+e);
            mapping.setAttr("err", "增加焦点失败！");
        }
        this.index(mapping);
    }
}
