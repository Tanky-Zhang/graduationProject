package com.zzg.service.serviceImpl;


import com.zzg.mapper.UserMapper;
import com.zzg.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
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

    public Map getUserName(String username){

        return  userMapper.getUserName(username);

    }

    @Override
    @Transactional
    public void registUser(Map map) {

        userMapper.registUser(map);

    }

    @Override
    public List getUsers() {
        return userMapper.getUsers();
    }

    @Override
    public void givePer(String checkStr) {


        String[] checkArr = checkStr.split(",");

        userMapper.givePer(checkArr);
    }

    @Override
    public void updatePass(Map userMap) {
        userMapper.updatePass(userMap);
    }
}
