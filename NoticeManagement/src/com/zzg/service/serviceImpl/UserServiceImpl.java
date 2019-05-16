package com.zzg.service.serviceImpl;


import com.zzg.mapper.UserMapper;
import com.zzg.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserMapper userMapper;


    @Override
    public Boolean find(String userName, String passWord) {

        Map map=userMapper.findByuserName(userName);

        if (map==null){

            return false;

        }else {

            if (map.get("PASSWORD").equals(passWord)){

                return true;

            }else {

                return false;
            }

        }

    }
}
