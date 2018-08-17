package com.qfedu.demo.ssh.mapper;

import com.qfedu.demo.ssh.po.StaffPosition;
import com.qfedu.demo.ssh.po.StaffPositionExample;
import java.util.List;
import org.apache.ibatis.annotations.Param;

public interface StaffPositionMapper {
    int countByExample(StaffPositionExample example);

    int deleteByExample(StaffPositionExample example);

    int insert(StaffPosition record);

    int insertSelective(StaffPosition record);

    List<StaffPosition> selectByExample(StaffPositionExample example);

    int updateByExampleSelective(@Param("record") StaffPosition record, @Param("example") StaffPositionExample example);

    int updateByExample(@Param("record") StaffPosition record, @Param("example") StaffPositionExample example);
}