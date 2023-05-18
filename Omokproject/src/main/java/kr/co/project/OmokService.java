package kr.co.project;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.co.project.member.MemberVO;

@Service
public class OmokService {

		@Autowired
		OmokMapper mapper;
		//시권
		public PlayerVO login(String id, String password){
			Map<String, String> map = new HashMap<>();
			map.put("id", id);
			map.put("password", password);
			return mapper.login(map);
		}
		
		public int updateInfo(PlayerVO vo) {
			return mapper.updateInfo(vo);
		}
		//창준
		public int updateVictory(PlayerVO vo) {
			return mapper.updateVictory(vo);
		}
		
		//서영
		public int insert(PlayerVO vo) {
			return mapper.insert(vo);
		}
		
		public int dupCheck(String id) {
			Map map = new HashMap();
			map.put("id", id);
			return mapper.dupCheck(map);
		}
		//지원
		public List<PlayerVO> addList(PlayerVO vo){
			//log.debug(mapper.getClass().getName());
			//int total = mapper.count(vo);
			//log.debug("total "+total);
			return mapper.allList(vo);
		}
		
		public int count(PlayerVO vo) {
			return mapper.count(vo);
		}
}
