package com.zzg.mapper;

import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

public interface RecodeMapper {
    List getList(@Param("name") String name, @Param("start") int start, @Param("pageSize") int pageSize);

    Integer getCount();

    void saveMessage(Map map);

    void delMessage(String[] ids);

    List<Map> getMessage(String sid);

    void editMessage(Map map);

    Map<String,Object> getStudentByid(String sid);

    Integer getCount(@Param("name")String name);
}
