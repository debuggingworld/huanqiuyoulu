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
}
