package com.efeiyi.controller;

import com.efeiyi.util.SearchClient;
import com.ming800.core.taglib.PageEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.net.URLEncoder;
import java.util.List;
import java.util.Map;

/**
 * Created by Administrator on 2015/11/5.
 */
@Controller
public class SearchController {

    @RequestMapping("/search.do")
    public ModelAndView search(HttpServletRequest request, ModelMap modelMap) throws Exception {

        String query = request.getParameter("q");
        query = URLEncoder.encode(query, "utf-8");

        PageEntity pageEntity = new PageEntity();
        String pageIndex = request.getParameter("pageEntity.index");
        String pageSize = request.getParameter("pageEntity.size");
        if (pageIndex != null) {
            pageEntity.setIndex(Integer.parseInt(pageIndex));
            pageEntity.setSize(Integer.parseInt(pageSize));
        }

        query = new StringBuilder(query)
                .append("&start=")
                .append((pageEntity.getIndex()-1)*pageEntity.getSize())
                .append("&rows=")
                .append(pageEntity.getIndex()*pageEntity.getSize()).toString();
        SearchClient.searchList.add(query);

        synchronized (query) {
            try {
                synchronized (SearchClient.searchList) {
                    SearchClient.searchList.notifyAll();
                }
                query.wait();
            } catch (Exception e) {
                Thread.currentThread().interrupt();
                e.printStackTrace();
            }

        }
        Map resultMap = (Map) SearchClient.resultMap.remove(query);
        List resultList = (List) resultMap.get("docs");
        Integer num = (Integer) resultMap.get("numFound");
        pageEntity.setCount(num);
        modelMap.put("q", query);
        modelMap.put("searchList", resultList);
        modelMap.put("pageEntity", pageEntity);

        return new ModelAndView("/search");
    }

}
