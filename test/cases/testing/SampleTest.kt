package com.example.test

class SampleTest {
    // Test without descriptive name
    @Test
    fun test1() {
        val result = 2 + 2
        assertEquals(4, result)
    }
    
    // Multiple assertions
    @Test
    fun testMultipleOperations() {
        val addition = 2 + 3
        val multiplication = 2 * 3
        val division = 6 / 2
        
        assertEquals(5, addition)
        assertEquals(6, multiplication)
        assertEquals(3, division)
    }
    
    // Missing setup
    @Test
    fun testWithoutSetup() {
        val sampleClass = SampleClass()
        val result = sampleClass.calculateTotal(5)
        assertEquals(55, result)
    }
    
    // Hardcoded test values
    @Test
    fun testApiUrl() {
        val sampleClass = SampleClass()
        val url = sampleClass.getApiUrl()
        assertEquals("https://api.example.com/v1/data", url)
    }
    
    // No assertions
    @Test
    fun testWithoutAssertions() {
        val sampleClass = SampleClass()
        sampleClass.parseValue("123")
    }
}