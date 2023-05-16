package kr.co.project;

import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface OmokMapper {
	PlayerVO login(Map map);
}
	