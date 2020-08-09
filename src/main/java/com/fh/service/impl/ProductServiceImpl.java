package com.fh.service.impl;

import com.fh.common.ServerResponse;
import com.fh.dao.ProductMapper;
import com.fh.model.DataTableResult;
import com.fh.model.Product;
import com.fh.model.ProductSearchParam;
import com.fh.service.ProductService;
import com.fh.util.RedisUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;

@Service("productService")
public class ProductServiceImpl implements ProductService {
    @Autowired
    private ProductMapper productMapper;


    @Override
    public DataTableResult queryList(ProductSearchParam productSearchParam) {
        Long count = productMapper.queryCount(productSearchParam);
        List<Product> productList = productMapper.queryList(productSearchParam);
        DataTableResult dataTableResult = new DataTableResult(productSearchParam.getDraw(),count,count,productList);
        return dataTableResult;
    }

    @Override
    public ServerResponse updateHotStatus(Long id, Integer status) {
        Product product =new Product();
        product.setId(id);
        product.setIsHot(status);
        productMapper.updateIshotById(product);
        RedisUtil.delete("hotProductList");
        return ServerResponse.success();
    }

    @Override
    public ServerResponse updateStatus(Long id, Integer status) {
        Product product = new Product();
        product.setId(id);
        product.setStatus(status);
        productMapper.updateStatus(product);
        RedisUtil.delete("hotProductList");
        return ServerResponse.success();
    }

    @Override
    public ServerResponse addProduct(Product product) {
        product.setInsertTime(new Date());
        productMapper.addProduct(product);
        return ServerResponse.success();
    }

    @Override
    public Product queryListById(Long id) {
        Product product = productMapper.queryListById(id);
        return product;
    }

    @Override
    public void updateProduct(Product product) {
        product.setUpdateTime(new Date());
        productMapper.updateProduct(product);
    }

    @Override
    public ServerResponse deleteProduct(Long id) {
        productMapper.deleteProduct(id);
        return ServerResponse.success();
    }


}
