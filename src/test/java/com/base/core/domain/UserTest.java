package com.base.core.domain;

import static org.junit.jupiter.api.Assertions.assertEquals;

import org.junit.jupiter.api.Test;

public class UserTest {

    @Test
    void testShouldSumTwoPositiveNumbers() {
        // Arrange
        User user = new User();

        // Act
        int result = user.sum(2, 3);

        // Assert
        assertEquals(5, result);
    }
}
