package com.efeiyi.controller;

import com.efeiyi.util.SearchClient;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

/**
 * Created by Administrator on 2015/11/5.
 */
@Controller
@RequestMapping("/")
public class SearchController {

    @RequestMapping("/search.do")
    public List search(HttpServletRequest request, HttpServletResponse response) {

        String query = request.getParameter("q");
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
        List result = SearchClient.resultMap.get(query);
        return result;
    }
}
