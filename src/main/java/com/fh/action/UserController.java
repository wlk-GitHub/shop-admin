package com.fh.action;

import com.fh.common.ResponseEnum;
import com.fh.common.ServerResponse;
import com.fh.model.User;
import com.fh.service.UserService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("login")
    @ResponseBody
    public ServerResponse login(String userName, String password, HttpServletRequest request){
            if(StringUtils.isEmpty(userName) || StringUtils.isEmpty(password)){
                return ServerResponse.error(ResponseEnum.USERNAME_PASSWORD_IS_NULL);
            }

            User user = userService.findUser(userName);
            if(user == null){
                return ServerResponse.error(ResponseEnum.USERNAME_IS_NOT_EXIST);
            }
            if(!password.equals(user.getPassword())){
                return ServerResponse.error(ResponseEnum.USER_PASSWORD_IS_ERROR);
            }
            request.getSession().setAttribute("user",user);

            return ServerResponse.success();
    }


}
