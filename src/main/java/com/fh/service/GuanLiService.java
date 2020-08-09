package com.fh.service;

import com.fh.model.DataTableResult;
import com.fh.model.Member;
import com.fh.model.MemberQuery;

public interface GuanLiService {
    DataTableResult queryList(MemberQuery memberQuery);

    Member findMemberByName(String memberName);
}
