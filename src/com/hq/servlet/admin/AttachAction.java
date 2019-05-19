package com.hq.servlet.admin;

import com.hq.bean.Attach;
import com.hq.db.DB;
import com.hq.db.PageDiv;
import com.hq.servlet.core.Action;
import org.apache.commons.dbutils.handlers.BeanListHandler;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.File;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @author zth
 * @Date 2019-05-19 16:23
 */
@WebServlet("/admin/attach")
public class AttachAction extends Action {
    private Logger log = Logger.getLogger(AttachAction.class);
    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        int pageNo = 1;
        if (mapping.getInt("pageNo") > 0){
            pageNo = mapping.getInt("pageNo");
        }
        int pageSize = 8;

        try {
            PageDiv<Attach> pageDiv =DB.getByPage(Attach.class,pageNo,pageSize);
            mapping.setAttr("pageDiv",pageDiv);
        } catch (SQLException e) {
            log.error("com.hq.servlet.admin.AttachAction_查询附件失败"+e.getMessage());
        }
        mapping.forward("admin/attach_list.jsp");
    }

    public void del(Mapping mapping) throws ServletException, IOException{
        int[] ids = mapping.getIntArray("ids");

        if (null != ids && ids.length >0){
            StringBuilder str = new StringBuilder();
            for (int i:ids){
                str.append(i+",");
            }
            str.deleteCharAt(str.length()-1);

            String sql = "select * from attach where id in ("+str.toString()+")";
            try {
                List<Attach> attaches = DB.query(sql,new BeanListHandler<Attach>(Attach.class));

                // 从数据库中删除
                String sql1 = "delete from attach where id in ("+str.toString()+")";
                DB.update(sql1);

                // 从服务器中删除
                for (Attach attach:attaches) {
                    int index = attach.getNewpath().lastIndexOf("ups");
                    File file = new File(this.getServletContext().getRealPath(attach.getNewpath().substring(index)));
                    if (file.exists()){
                        file.delete();
                    }

                }
                mapping.setAttr("msg","删除成功");

            } catch (SQLException e) {
                log.error("com.hq.servlet.admin.AttachAction_删除附件失败"+e.getMessage());
                mapping.setAttr("err","删除失败");
            }
        }
        index(mapping);
    }
}











