package com.fh.action;

import com.fh.common.ResponseEnum;
import com.fh.common.ServerResponse;
import com.fh.model.DataTableResult;
import com.fh.model.Member;
import com.fh.model.MemberQuery;
import com.fh.service.GuanLiService;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@Controller
@RequestMapping("guanli")
public class GuanLiController {
    @Autowired
    private GuanLiService guanLiService;


    @RequestMapping("test")
    public String test(){
        return "memberList";
    }

    @RequestMapping("queryList")
    @ResponseBody
    public DataTableResult queryList(MemberQuery memberQuery){
        DataTableResult dataTableResult = guanLiService.queryList(memberQuery);
        return dataTableResult;
    }

    @RequestMapping("login")
    @ResponseBody
    public ServerResponse login(Member member, HttpServletRequest request){
            String memberName = member.getMemberName();
            String password = member.getPassword();
            if(StringUtils.isEmpty(memberName) || StringUtils.isEmpty(password)){
                return ServerResponse.error(ResponseEnum.USERNAME_PASSWORD_IS_NULL);
            }

            Member memberDB = guanLiService.findMemberByName(memberName);
            if(memberDB == null){
                return ServerResponse.error(ResponseEnum.USERNAME_IS_NOT_EXIST);
            }

        String memberPasswordDB = memberDB.getPassword();
            if(!password.equals(memberPasswordDB)){
                return ServerResponse.error(ResponseEnum.USER_PASSWORD_IS_ERROR);
            }

        return ServerResponse.success();
    }

}
