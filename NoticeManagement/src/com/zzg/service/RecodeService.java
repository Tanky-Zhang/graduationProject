package com.zzg.service;

import com.zzg.utils.PageBean;

import java.util.List;
import java.util.Map;

public interface RecodeService {

    List getList(String name, PageBean pageBean);

    void saveMessage(Map map);

    void delMessage(String sidstr);

    List getMessage(String sid);

    void editMessage(Map map);

    Map<String,Object> getStudentByid(String sid);

}
