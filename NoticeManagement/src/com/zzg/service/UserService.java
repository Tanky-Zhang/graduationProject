package com.zzg.service;

import java.util.List;
import java.util.Map;

public interface UserService {

    Boolean find(String userName, String passWord);

    Map getUserName(String username);

    void registUser(Map map);

    List getUsers();

    void givePer(String checkStr);

    void updatePass(Map userMap);
}
