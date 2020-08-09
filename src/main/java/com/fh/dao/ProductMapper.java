package com.fh.dao;
import com.fh.model.Product;
import com.fh.model.ProductSearchParam;

import java.util.List;

public interface ProductMapper{
    Long queryCount(ProductSearchParam productSearchParam);

    List<Product> queryList(ProductSearchParam productSearchParam);


    void updateIshotById(Product product);

    void updateStatus(Product product);

    void addProduct(Product product);

    Product queryListById(Long id);

    void updateProduct(Product product);


    void deleteProduct(Long id);

}
