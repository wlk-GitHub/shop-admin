package com.fh.service.impl;

import com.fh.common.ServerResponse;
import com.fh.dao.BrandMapper;
import com.fh.model.Brand;
import com.fh.service.BrandService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service("brandService")
public class BrandServiceImpl implements BrandService {
    @Autowired
    private BrandMapper brandMapper;

    @Override
    public ServerResponse queryBrandList() {
        List<Brand> brandList =brandMapper.queryBrandList();
        return ServerResponse.success(brandList);
    }
}
