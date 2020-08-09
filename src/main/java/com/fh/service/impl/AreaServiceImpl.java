package com.fh.service.impl;

import com.fh.common.ServerResponse;
import com.fh.dao.AreaMapper;
import com.fh.model.Area;
import com.fh.service.AreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AreaServiceImpl implements AreaService {
        @Autowired
        private AreaMapper areaMapper;

    @Override
    public ServerResponse findChilds(Long id) {
        List<Area> areaList = areaMapper.findChilds(id);
        return ServerResponse.success(areaList) ;
    }
}
