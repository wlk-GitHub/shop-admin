package com.fh.dao;

import com.fh.model.Member;
import com.fh.model.MemberQuery;

import java.util.List;

public interface GuanLiMapper {
    Long queryCount(MemberQuery memberQuery);

    List<Member> queryList(MemberQuery memberQuery);

    Member findMemberByName(String memberName);

}
