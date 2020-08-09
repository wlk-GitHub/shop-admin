package com.fh.action;


import com.fh.common.ServerResponse;
import com.fh.model.DataTableResult;
import com.fh.model.Product;
import com.fh.model.ProductSearchParam;
import com.fh.service.ProductService;
import com.fh.util.OSSUtil;
import com.fh.util.RedisUtil;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("/product")
public class ProductController {

    @Resource(name = "productService")
    private ProductService productService;


    @RequestMapping("/toList")
    public String toList() {
        return "product";
    }

    @RequestMapping("/toAdd")
    public String toAdd() {
        return "addProduct";
    }


    @RequestMapping("/toEdit")
    public String toEdit() {
        return "edit";
    }





    @RequestMapping("queryList")
    @ResponseBody
    public DataTableResult queryList(ProductSearchParam productSearchParam){
        DataTableResult dataTableResult = productService.queryList(productSearchParam);
        return dataTableResult;
    }


    @RequestMapping("updateHotStatus")
    @ResponseBody
    public ServerResponse updateHotStatus(Long id, Integer status) {
        return productService.updateHotStatus(id, status);
    }

    @RequestMapping("updateStatus")
    @ResponseBody
    public ServerResponse updateStatus(Long id, Integer status) {
        return productService.updateStatus(id, status);
    }


    @RequestMapping("addProduct")
    @ResponseBody
    public ServerResponse addProduct(Product product){
        return  productService.addProduct(product);
    }

    @RequestMapping("queryListById")
    @ResponseBody
    public ServerResponse queryListById(Long id){
        Product product = productService.queryListById(id);
        return ServerResponse.success(product);
    }



    @RequestMapping("updateProduct")
    @ResponseBody
    public ServerResponse updateProduct(Product product, HttpServletRequest request){
        if (StringUtils.isNotEmpty(product.getMainImagePath())) {
            // 上传新图片
            // 删除老图片
            String oldMainImagePath = product.getOldMainImagePath();
            if (StringUtils.isNotEmpty(oldMainImagePath)) {
                OSSUtil.deleteFile(oldMainImagePath);
            }
        } else {
            // 还是老图片
            product.setMainImagePath(product.getOldMainImagePath());
        }
        productService.updateProduct(product);
        return ServerResponse.success();
    }

    @RequestMapping("deleteProduct")
    @ResponseBody
    public ServerResponse deleteProduct(Long id){
        return  productService.deleteProduct(id);
    }

    @RequestMapping("clearCache")
    @ResponseBody
    public ServerResponse clearCache(){
        RedisUtil.delete("hotProductList");
        return ServerResponse.success();
    }


}
