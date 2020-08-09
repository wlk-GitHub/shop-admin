package com.fh.service.impl;

import com.fh.dao.GuanLiMapper;
import com.fh.model.DataTableResult;
import com.fh.model.Member;
import com.fh.model.MemberQuery;
import com.fh.service.GuanLiService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GuanLiServiceImpl implements GuanLiService {
    @Autowired
    private GuanLiMapper guanLiMapper;

    @Override
    public DataTableResult queryList(MemberQuery memberQuery) {

        Long count = guanLiMapper.queryCount(memberQuery);
        List<Member> empList = guanLiMapper.queryList(memberQuery);
        DataTableResult dataTableResult = new DataTableResult(memberQuery.getDraw(),count,count,empList);
        return dataTableResult;
    }

    @Override
    public Member findMemberByName(String memberName) {
        Member member = guanLiMapper.findMemberByName(memberName);
        return member;
    }
}
