package com.hq.servlet.admin;

import com.hq.bean.Channel;
import com.hq.db.DB;
import com.hq.servlet.core.Action;
import org.apache.log4j.Logger;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

/**
 * @author zth
 * @Date 2019-05-19 10:21
 */
@WebServlet("/admin/artchannel")
public class ChannelAction extends Action {
    private Logger log = Logger.getLogger(ChannelAction.class);

    @Override
    public void index(Mapping mapping) throws ServletException, IOException {
        List<Channel> channels = null;
        try {
            channels = DB.getAll(Channel.class);
            mapping.setAttr("channels",channels);
        } catch (SQLException e) {
            log.error("com.hq.servlet.admin.ChannelAction_index_出错"+e.getMessage());
        }

        mapping.forward("admin/channel_list.jsp");
    }

    /**
     * 添加栏目
     */
    public void saveAdd(Mapping mapping) throws ServletException, IOException {
        Channel channel = new Channel();
        mapping.getBean(channel);

        try {
            DB.add(channel);
            mapping.setAttr("msg","增加成功");
        } catch (SQLException e) {
            mapping.setAttr("err","增加失败");
            log.error("com.hq.servlet.admin.ChannelAction_增加栏目出错"+e.getMessage());
        }
        this.index(mapping);
    }

    /**
     * 修改栏目
     */
    public void update(Mapping mapping) throws ServletException, IOException{
        Channel channel = new Channel();
        mapping.getBean(channel);
        try {
            DB.update(channel);
            mapping.setAttr("msg","修改成功");
        } catch (SQLException e) {
            mapping.setAttr("err","修改失败");
            log.error("com.hq.servlet.admin.ChannelAction_修改栏目出错"+e.getMessage());
        }
        this.index(mapping);
    }

    /**
     * 删除栏目
     */
    public void del(Mapping mapping) throws ServletException, IOException{
        int id = mapping.getInt("id");

        try {
            if (id>0) DB.delete(id,Channel.class);
            mapping.setAttr("msg","删除成功");
        } catch (SQLException e) {
            mapping.setAttr("err","删除失败");
            log.error("com.hq.servlet.admin.ChannelAction_删除栏目出错"+e.getMessage());
        }
        this.index(mapping);
    }
}
