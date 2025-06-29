package aaaPattern;
import org.junit.Before;
import org.junit.After;
import org.junit.Test;

import static org.junit.Assert.*;
public class BankAccountTest {
	private BankAccount account;

    @Before
    public void setUp() {
        // Arrange: Common setup for all tests
        account = new BankAccount(100);
        System.out.println("Opening account with ₹100");
    }

    @After
    public void tearDown() {
        // Cleanup after each test
        account = null;
        System.out.println("Closing account");
    }

    @Test
    public void testDeposit() {
        // Arrange
        int depositAmount = 50;

        // Act
        account.deposit(depositAmount);

        // Assert
        assertEquals(150, account.getBalance());
    }

    @Test
    public void testWithdraw() {
        // Arrange
        int withdrawAmount = 30;

        // Act
        account.withdraw(withdrawAmount);

        // Assert
        assertEquals(70, account.getBalance());
    }

    @Test
    public void testWithdrawMoreThanBalance() {
        // Arrange
        int withdrawAmount = 200;

        // Act
        account.withdraw(withdrawAmount);

        // Assert
        assertEquals(100, account.getBalance()); // Should not allow overdraw
    }

    @Test
    public void testWithdrawExactBalance() {
        // Arrange
        int withdrawAmount = 100;

        // Act
        account.withdraw(withdrawAmount);

        // Assert
        assertEquals(0, account.getBalance());
    }
}