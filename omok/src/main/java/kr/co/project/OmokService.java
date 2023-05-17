package kr.co.project;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OmokService {

		@Autowired
		OmokMapper mapper;
		public PlayerVO login(String id, String password){
			Map<String, String> map = new HashMap<>();
			map.put("id", id);
			map.put("password", password);
			return mapper.login(map);
		}
		
}
