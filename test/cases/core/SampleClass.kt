package com.example.test

/**
 * A simple sample class for testing MDC rules
 */
class SampleClass {
    // Some fields with different naming styles
    private val camelCaseVariable = "test"
    private val snake_case_variable = "test"
    private val PascalCaseVariable = "test"

    // Some magic numbers
    fun calculateTotal(quantity: Int): Int {
        return quantity * 10 + 5
    }

    // Method with potential null issues
    fun processData(data: String?): String {
        return data!!.uppercase()
    }

    // Method with hardcoded values
    fun getApiUrl(): String {
        return "https://api.example.com/v1/data"
    }

    // Method with poor error handling
    fun parseValue(input: String): Int {
        return input.toInt()
    }
}