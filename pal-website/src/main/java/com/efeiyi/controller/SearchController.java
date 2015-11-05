package com.efeiyi.controller;

import com.efeiyi.util.SearchClient;
import com.ming800.core.taglib.PageEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.List;

/**
 * Created by Administrator on 2015/11/5.
 */
@Controller
@RequestMapping("/")
public class SearchController {

    @RequestMapping("/search.do")
    public ModelAndView search(HttpServletRequest request, ModelMap modelMap) {

        String query = request.getParameter("q");

        try {
            query = URLEncoder.encode(query, "utf-8");
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }

        modelMap.put("q", query);

        PageEntity pageEntity = new PageEntity();
        String pageIndex = request.getParameter("pageEntity.index");
        String pageSize = request.getParameter("pageEntity.size");
        if (pageIndex != null) {
            pageEntity.setIndex(Integer.parseInt(pageIndex));
            pageEntity.setSize(Integer.parseInt(pageSize));
        }

        SearchClient.pageEntity = pageEntity;
        SearchClient.searchList.add(query);
        synchronized (query) {
            try {
                synchronized (SearchClient.searchList){
                    SearchClient.searchList.notifyAll();
                }
                query.wait();
            } catch (Exception e) {
                Thread.currentThread().interrupt();
                e.printStackTrace();
            }

        }
        List result = (List) SearchClient.resultMap.get(query);

        modelMap.put("linkedHashMapList", result);
        modelMap.put("pageEntity", pageEntity);

        return new ModelAndView("/search");
    }

//    @RequestMapping("/search.do")
//    public List search(HttpServletRequest request, HttpServletResponse response) {
//
//        String query = request.getParameter("q");
//        SearchClient.searchList.add(query);
//        synchronized (query) {
//            try {
//                synchronized (SearchClient.searchList){
//                    SearchClient.searchList.notifyAll();
//                }
//                query.wait();
//            } catch (Exception e) {
//                Thread.currentThread().interrupt();
//                e.printStackTrace();
//            }
//
//        }
//        List result = SearchClient.resultMap.get(query);
//        return result;
//    }
}
