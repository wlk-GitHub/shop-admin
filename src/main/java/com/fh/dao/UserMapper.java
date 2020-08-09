package com.fh.dao;

import com.fh.model.User;

public interface UserMapper {
    User findUser(String userName);

}
