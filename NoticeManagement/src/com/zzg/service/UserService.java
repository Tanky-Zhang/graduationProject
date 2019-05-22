package com.zzg.service;

import java.util.Map;

public interface UserService {

    Boolean find(String userName, String passWord);

    String getUserName(String username);

    void registUser(Map map);
}
