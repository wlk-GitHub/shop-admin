package com.fh.dao;

import com.fh.model.Area;

import java.util.List;

public interface AreaMapper {
    List<Area> findChilds(Long id);

}
