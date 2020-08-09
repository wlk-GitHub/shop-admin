package com.fh.action;

import com.fh.common.ServerResponse;
import com.fh.service.AreaService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;

@Controller
@RequestMapping("area")
public class AreaController {

    @Autowired
    private AreaService areaService;

    @RequestMapping("findChilds")
    @ResponseBody
    public ServerResponse findChilds(Long id){
        return areaService.findChilds(id);
    }

}
