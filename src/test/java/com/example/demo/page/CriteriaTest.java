package com.example.demo.page;

import org.assertj.core.api.Assertions;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

class CriteriaTest {


    @Test
    void getOffset() {
        //given
        Criteria cri1 = new Criteria();
        Criteria cri2 = new Criteria(2, 10);

        //then
        Assertions.assertThat(cri1.getOffset()).isEqualTo(0);
        Assertions.assertThat(cri2.getOffset()).isEqualTo(10);
    }
}