package com.first.dao;

import com.first.core.mapper.Mapper;
import com.first.model.User;
import org.apache.ibatis.io.DefaultVFS;
import org.springframework.stereotype.Component;

@Component
public interface UserMapper extends Mapper<User> {
}