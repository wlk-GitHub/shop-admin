package com.fh.service.impl;

import com.fh.dao.UserMapper;
import com.fh.model.User;
import com.fh.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User findUser(String userName) {
        User user = userMapper.findUser(userName);
        return user;
    }
}
