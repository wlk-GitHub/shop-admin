package com.fh.action;


import com.fh.common.ServerResponse;
import com.fh.service.BrandService;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;

@Controller
@RequestMapping("brand")
public class BrandController {

    @Resource(name = "brandService")
    private BrandService brandService;

    @RequestMapping("queryBrandList")
    @ResponseBody
    public ServerResponse queryBrandList(){
            return brandService.queryBrandList();
    }
}
