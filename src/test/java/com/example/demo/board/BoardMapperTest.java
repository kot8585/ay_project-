package com.example.demo.board;

import com.example.demo.page.Criteria;
import lombok.extern.slf4j.Slf4j;
import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.BeforeAll;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.springframework.transaction.annotation.Transactional;

import javax.lang.model.type.ArrayType;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import static org.assertj.core.api.Assertions.*;


@SpringBootTest
@ExtendWith(SpringExtension.class)
@Slf4j
class BoardMapperTest {

    @Autowired
    BoardMapper boardMapper;

    @Test
    @DisplayName("게시판의 글을 10개만 가져온다.") //더미 데이터를 넣고난 후 실행해야 한다.
    void getList() {
        //given
        String type = "faq";
        Criteria cri = new Criteria();
        HashMap<String ,Object> map = new HashMap<>();
        map.put("type", type);
        map.put("cri", cri);

        //when
        List<Board> result = boardMapper.getListWithPaging(map);

        //then
        assertThat(result.size()).isEqualTo(10);
    }

    @Test
    @DisplayName("두번째로 조회하는 페이지의 id는 첫번째의 id보다 작다.")
    public void getListWithPagingCursor() {
        //given
        //cursorID가 null일 때(첫번쨰 조회)
        Criteria cri1 = new Criteria();
        HashMap<String, Object> map1 = new HashMap<>();
        map1.put("type", "faq");
        map1.put("cri", cri1);
        List<Board> firstPaging = boardMapper.getListWithPagingCursor(map1);
        
        Integer cursorId = firstPaging.get(9).getNum(); //제일 마지막으로 가져온 id를 cursorId로 설정
        log.info("cursorId: {}", String.valueOf(cursorId));

        //cursorID가 전해질떄(두번쨰 이상 조회)
        Criteria cri2 = new Criteria();
        cri2.setCursorId(cursorId);
        HashMap<String, Object> map2 = new HashMap<>();
        map2.put("type", "faq");
        map2.put("cri", cri2);

        //when
        List<Board> secondPaging = boardMapper.getListWithPagingCursor(map2);

        //then //뭘로 확인하지....
        Assertions.assertThat(secondPaging.get(0).getNum()).isLessThan(firstPaging.get(9).getNum());
    }
}