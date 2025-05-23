@IsTest
private class DateUtilitiesTest {
    
    @IsTest
    static void testGetFirstDayOfMonth() {
        // Test regular case
        Date testDate = Date.newInstance(2024, 3, 15);
        Date firstDay = DateUtilities.getFirstDayOfMonth(testDate);
        System.assertEquals(Date.newInstance(2024, 3, 1), firstDay, 'First day should be March 1');
        
        // Test first day of month
        testDate = Date.newInstance(2024, 3, 1);
        firstDay = DateUtilities.getFirstDayOfMonth(testDate);
        System.assertEquals(Date.newInstance(2024, 3, 1), firstDay, 'Should handle first day of month');
        
        // Test last day of month
        testDate = Date.newInstance(2024, 3, 31);
        firstDay = DateUtilities.getFirstDayOfMonth(testDate);
        System.assertEquals(Date.newInstance(2024, 3, 1), firstDay, 'Should handle last day of month');
        
        // Test null input
        firstDay = DateUtilities.getFirstDayOfMonth(null);
        System.assertEquals(null, firstDay, 'Should handle null input');
    }
    
    @IsTest
    static void testGetLastDayOfMonth() {
        // Test regular case
        Date testDate = Date.newInstance(2024, 3, 15);
        Date lastDay = DateUtilities.getLastDayOfMonth(testDate);
        System.assertEquals(Date.newInstance(2024, 3, 31), lastDay, 'Last day should be March 31');
        
        // Test February in leap year
        testDate = Date.newInstance(2024, 2, 15);
        lastDay = DateUtilities.getLastDayOfMonth(testDate);
        System.assertEquals(Date.newInstance(2024, 2, 29), lastDay, 'Should handle leap year February');
        
        // Test February in non-leap year
        testDate = Date.newInstance(2023, 2, 15);
        lastDay = DateUtilities.getLastDayOfMonth(testDate);
        System.assertEquals(Date.newInstance(2023, 2, 28), lastDay, 'Should handle non-leap year February');
        
        // Test null input
        lastDay = DateUtilities.getLastDayOfMonth(null);
        System.assertEquals(null, lastDay, 'Should handle null input');
    }
    
    @IsTest
    static void testIsWeekend() {
        // Test Saturday
        Date saturday = Date.newInstance(2024, 3, 16);
        System.assert(DateUtilities.isWeekend(saturday), 'Saturday should be weekend');
        
        // Test Sunday
        Date sunday = Date.newInstance(2024, 3, 17);
        System.assert(DateUtilities.isWeekend(sunday), 'Sunday should be weekend');
        
        // Test weekday
        Date wednesday = Date.newInstance(2024, 3, 13);
        System.assert(!DateUtilities.isWeekend(wednesday), 'Wednesday should not be weekend');
        
        // Test null input
        System.assert(!DateUtilities.isWeekend(null), 'Null should return false');
    }
    
    @IsTest
    static void testGetBusinessDays() {
        // Test one week
        Date monday = Date.newInstance(2024, 3, 11);
        Date friday = Date.newInstance(2024, 3, 15);
        Integer businessDays = DateUtilities.getBusinessDays(monday, friday);
        System.assertEquals(5, businessDays, 'Monday to Friday should be 5 business days');
        
        // Test including weekend
        Date nextMonday = Date.newInstance(2024, 3, 18);
        businessDays = DateUtilities.getBusinessDays(monday, nextMonday);
        System.assertEquals(6, businessDays, 'Monday to next Monday should be 6 business days');
        
        // Test same day
        businessDays = DateUtilities.getBusinessDays(monday, monday);
        System.assertEquals(1, businessDays, 'Same day should count as 1 business day');
        
        // Test invalid range
        businessDays = DateUtilities.getBusinessDays(friday, monday);
        System.assertEquals(0, businessDays, 'End date before start date should return 0');
        
        // Test null inputs
        businessDays = DateUtilities.getBusinessDays(null, friday);
        System.assertEquals(0, businessDays, 'Null start date should return 0');
        
        businessDays = DateUtilities.getBusinessDays(monday, null);
        System.assertEquals(0, businessDays, 'Null end date should return 0');
    }
    
    @IsTest
    static void testAddBusinessDays() {
        // Test adding 5 business days from Monday
        Date monday = Date.newInstance(2024, 3, 11);
        Date result = DateUtilities.addBusinessDays(monday, 5);
        System.assertEquals(Date.newInstance(2024, 3, 15), result, 'Adding 5 days from Monday should be Friday');
        
        // Test adding days spanning weekend
        result = DateUtilities.addBusinessDays(monday, 7);
        System.assertEquals(Date.newInstance(2024, 3, 19), result, 'Adding 7 business days should skip weekend');
        
        // Test adding zero days
        result = DateUtilities.addBusinessDays(monday, 0);
        System.assertEquals(monday, result, 'Adding 0 days should return same date');
        
        // Test adding negative days
        result = DateUtilities.addBusinessDays(monday, -1);
        System.assertEquals(monday, result, 'Negative days should return original date');
        
        // Test null date
        result = DateUtilities.addBusinessDays(null, 5);
        System.assertEquals(null, result, 'Null input should return null');
    }
}