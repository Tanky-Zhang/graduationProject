package com.zzg.service.serviceImpl;

import com.zzg.mapper.UserMapper;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import java.util.List;
import java.util.Map;

/**
 * 定义一个realm做认证
 */
public class LoginRealm extends AuthorizingRealm {

    @Autowired
    UserMapper userMapper;

    @Override
    //授权方法
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {


        SimpleAuthorizationInfo info=new SimpleAuthorizationInfo();

        Map userMap=(Map)SecurityUtils.getSubject().getPrincipal();

        List<String> permissionList=userMapper.getPermission(userMap);


        for (String str:permissionList) {

            info.addStringPermission(str);
            
        }

        return info;


    }

    @Override
    /*做认证方法*/
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        System.out.println("realm中的认证方法执行了。。。。");

        UsernamePasswordToken token2=(UsernamePasswordToken)token;

        String username=token2.getUsername();

        //String password=Arrays.toString(token2.getPassword());

        Map userMap = userMapper.findByuserName(username);

        if (userMap==null){

            //账号不存在
            return null;

        }
        //授权方法的实现
        AuthenticationInfo info=new SimpleAuthenticationInfo(userMap,userMap.get("PASSWORD"),this.getName());

        return info;


    }

}
