package com.zzg.controller;

import com.google.gson.Gson;
import com.zzg.service.RecodeService;
import com.zzg.utils.PageBean;
import org.apache.ibatis.annotations.Param;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequestMapping("/recode")
public class RecodeController {

    @Autowired
    RecodeService recodeService;


    @RequestMapping("/getList")
    @ResponseBody
    public Map getList(@Param("stuName") String stuName, @RequestParam(value = "pageOffset",required = false) Integer pageOffset,
                       @RequestParam(value = "pageSize",required = false) Integer pageSize , Model model, HttpServletRequest request) {


        //if (pageOffset==null){pageOffset=0;}
        //String stuName1 = request.getParameter("stuName");

        PageBean pageBean = new PageBean();

        pageBean.setCurrentPage(pageOffset);

        pageBean.setPageSize(pageSize);

        List list = recodeService.getList(stuName, pageBean);

        Map map = new HashMap();

        //System.out.println(pageBean.getRows());

        map.put("total", pageBean.getTotal());

        map.put("rows", pageBean.getRows());

        return map;

    }

    @RequestMapping("/saveMessage")
    @ResponseBody
    @RequiresPermissions("save-resource")
    public String saveMessage(String mparam) {

        if (mparam != null && !mparam.equals("")) {
            Map map = new Gson().fromJson(mparam, Map.class);

            String uuid = UUID.randomUUID().toString();

            uuid.replaceAll("-", "");

            map.put("ID", uuid);
            recodeService.saveMessage(map);
        }
        return "success";
    }

    @RequestMapping("/deleMessage")
    @ResponseBody
    @RequiresPermissions("delete-resource")
    public String delMessage(String sid) {

        recodeService.delMessage(sid);

        return "success";
    }

    @RequestMapping("/getMessage")
    @ResponseBody
    public Map getMessage(String sid) {

        List<Map> list = recodeService.getMessage(sid);

        Map map = new HashMap();

        map = list.get(0);

        //model.addAttribute("map",map);

        return map;
    }

    @RequestMapping("/editMessage")
    @ResponseBody
    @RequiresPermissions("edit-resource")
    public String editMessage(String mparam) {

        if (mparam != null && !mparam.equals("")) {

            Map map = new Gson().fromJson(mparam, Map.class);

            recodeService.editMessage(map);

        }
        return "success";
    }

    @RequestMapping("/print/{sid}")
    @RequiresPermissions("print-Resource")
    public String printTongzhi(@PathVariable String sid, Model model) {

        Map<String, Object> stuMap = recodeService.getStudentByid(sid);

        //获取当前的年份 月份 日期
        Calendar cal = Calendar.getInstance();

        String year = cal.get(Calendar.YEAR) + "";

        String month = cal.get(Calendar.MONTH) + 1 + "";

        String day = cal.get(Calendar.DATE) + "";

        model.addAttribute("year", year);

        model.addAttribute("month", month);

        model.addAttribute("day", day);

        model.addAttribute("stu", stuMap);

        // System.out.println(stuMap);

        //return "redirect:/recod";

        // 请求转发：request.getRequestDispatcher("/student_list.jsp").forward(request,response);

        // System.out.println(11111);

        // String str=request.getContextPath();

        //System.out.println(str);

        //response.sendRedirect( str+ "/recod.jsp");

        //request.getRequestDispatcher("/WEB-INF/jsp/recod.jsp").forward(request,response);
        return "recod";

    }


    @RequestMapping("/printSave")
    @RequiresPermissions("printSave-resource")
    public String printUpdateAndAdd(String myformString, String status, Model model) {

        if (myformString != null && !myformString.equals("")) {

            Map map = new Gson().fromJson(myformString, Map.class);


                if (status.equals("1")) {

                String uuid = UUID.randomUUID().toString();

                uuid.replace("-", "");


                map.put("ID", uuid);

                recodeService.saveMessage(map);


            } else {

                recodeService.editMessage(map);

            }

            model.addAttribute("stu", map);
        }

        //获取当前的年份 月份 日期
        Calendar cal = Calendar.getInstance();

        String year = cal.get(Calendar.YEAR) + "";

        String month = cal.get(Calendar.MONTH) + 1 + "";

        String day = cal.get(Calendar.DATE) + "";

        model.addAttribute("year", year);

        model.addAttribute("month", month);

        model.addAttribute("day", day);

        return "recod";

    }


}
