package com.fh.service;

import com.fh.common.ServerResponse;
import com.fh.model.DataTableResult;
import com.fh.model.Product;
import com.fh.model.ProductSearchParam;

public interface ProductService {
    DataTableResult queryList(ProductSearchParam productSearchParam);


    ServerResponse updateHotStatus(Long id, Integer status);

    ServerResponse updateStatus(Long id, Integer status);

    ServerResponse addProduct(Product product);


    Product queryListById(Long id);

    void updateProduct(Product product);

    ServerResponse deleteProduct(Long id);
}
