package com.zzg.mapper;

import java.util.List;
import java.util.Map;

public interface UserMapper {


    public Map findByuserName(String userName);

    List<String> getPermission(Map userMap);

    Map getUserName(String username);

    void registUser(Map map);

    List getUsers();

    void givePer(String checkStr);

    void givePer(String[] checkArr);

    void updatePass(Map userMap);
}
