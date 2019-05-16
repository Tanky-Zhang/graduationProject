package com.zzg.mapper;

import java.util.List;
import java.util.Map;

public interface UserMapper {


    public Map findByuserName(String userName);

    List<String> getPermission(Map userMap);

}
