package com.base;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class MainTest {

    @Test
    void testSomaPositiveNumbers() {
        Main m = new Main();
        assertEquals(5, m.soma(2, 3));
    }

    @Test
    void testSomaWithNegative() {
        Main m = new Main();
        assertEquals(-1, m.soma(2, -3));
    }

}
