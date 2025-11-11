/**
 * @description Test class for DateUtilities
 * @author Copado AI
 * @date 2025-11-11
 */
@IsTest
private class DateUtilitiesTest {

    /**
     * @description Test getFirstDayOfMonth method with various dates
     */
    @IsTest
    static void testGetFirstDayOfMonth() {
        // Test mid-month date
        Date midMonth = Date.newInstance(2024, 3, 15);
        Date firstDay = DateUtilities.getFirstDayOfMonth(midMonth);
        System.assertEquals(Date.newInstance(2024, 3, 1), firstDay, 
            'First day of March 2024 should be March 1, 2024');

        // Test last day of month
        Date lastDay = Date.newInstance(2024, 2, 29);
        Date firstDayFeb = DateUtilities.getFirstDayOfMonth(lastDay);
        System.assertEquals(Date.newInstance(2024, 2, 1), firstDayFeb, 
            'First day of February 2024 should be February 1, 2024');

        // Test first day of month
        Date alreadyFirst = Date.newInstance(2024, 1, 1);
        Date firstDayJan = DateUtilities.getFirstDayOfMonth(alreadyFirst);
        System.assertEquals(Date.newInstance(2024, 1, 1), firstDayJan, 
            'First day of January 2024 should remain January 1, 2024');

        // Test null input
        Date nullResult = DateUtilities.getFirstDayOfMonth(null);
        System.assertEquals(null, nullResult, 
            'Null input should return null');
    }

    /**
     * @description Test getLastDayOfMonth method with various dates
     */
    @IsTest
    static void testGetLastDayOfMonth() {
        // Test 31-day month
        Date marchDate = Date.newInstance(2024, 3, 15);
        Date lastDayMarch = DateUtilities.getLastDayOfMonth(marchDate);
        System.assertEquals(Date.newInstance(2024, 3, 31), lastDayMarch, 
            'Last day of March 2024 should be March 31, 2024');

        // Test 30-day month
        Date aprilDate = Date.newInstance(2024, 4, 10);
        Date lastDayApril = DateUtilities.getLastDayOfMonth(aprilDate);
        System.assertEquals(Date.newInstance(2024, 4, 30), lastDayApril, 
            'Last day of April 2024 should be April 30, 2024');

        // Test February in leap year
        Date febLeapYear = Date.newInstance(2024, 2, 15);
        Date lastDayFebLeap = DateUtilities.getLastDayOfMonth(febLeapYear);
        System.assertEquals(Date.newInstance(2024, 2, 29), lastDayFebLeap, 
            'Last day of February 2024 (leap year) should be February 29, 2024');

        // Test February in non-leap year
        Date febNonLeapYear = Date.newInstance(2023, 2, 15);
        Date lastDayFebNonLeap = DateUtilities.getLastDayOfMonth(febNonLeapYear);
        System.assertEquals(Date.newInstance(2023, 2, 28), lastDayFebNonLeap, 
            'Last day of February 2023 (non-leap year) should be February 28, 2023');

        // Test December (year transition)
        Date decDate = Date.newInstance(2024, 12, 15);
        Date lastDayDec = DateUtilities.getLastDayOfMonth(decDate);
        System.assertEquals(Date.newInstance(2024, 12, 31), lastDayDec, 
            'Last day of December 2024 should be December 31, 2024');

        // Test null input
        Date nullResult = DateUtilities.getLastDayOfMonth(null);
        System.assertEquals(null, nullResult, 
            'Null input should return null');
    }

    /**
     * @description Test isWeekend method with various days
     */
    @IsTest
    static void testIsWeekend() {
        // Test Saturday
        Date saturday = Date.newInstance(2024, 11, 9); // November 9, 2024 is a Saturday
        System.assertEquals(true, DateUtilities.isWeekend(saturday), 
            'Saturday should be identified as weekend');

        // Test Sunday
        Date sunday = Date.newInstance(2024, 11, 10); // November 10, 2024 is a Sunday
        System.assertEquals(true, DateUtilities.isWeekend(sunday), 
            'Sunday should be identified as weekend');

        // Test Monday
        Date monday = Date.newInstance(2024, 11, 11); // November 11, 2024 is a Monday
        System.assertEquals(false, DateUtilities.isWeekend(monday), 
            'Monday should not be identified as weekend');

        // Test Wednesday
        Date wednesday = Date.newInstance(2024, 11, 13); // November 13, 2024 is a Wednesday
        System.assertEquals(false, DateUtilities.isWeekend(wednesday), 
            'Wednesday should not be identified as weekend');

        // Test Friday
        Date friday = Date.newInstance(2024, 11, 15); // November 15, 2024 is a Friday
        System.assertEquals(false, DateUtilities.isWeekend(friday), 
            'Friday should not be identified as weekend');

        // Test null input
        System.assertEquals(false, DateUtilities.isWeekend(null), 
            'Null input should return false');
    }

    /**
     * @description Test getBusinessDays method with various date ranges
     */
    @IsTest
    static void testGetBusinessDays() {
        // Test Monday to Friday (same week)
        Date monday = Date.newInstance(2024, 11, 11);
        Date friday = Date.newInstance(2024, 11, 15);
        Integer businessDays = DateUtilities.getBusinessDays(monday, friday);
        System.assertEquals(5, businessDays, 
            'Monday to Friday should be 5 business days');

        // Test Friday to Monday (crossing weekend)
        Date friday2 = Date.newInstance(2024, 11, 8);
        Date monday2 = Date.newInstance(2024, 11, 11);
        Integer businessDaysWeekend = DateUtilities.getBusinessDays(friday2, monday2);
        System.assertEquals(2, businessDaysWeekend, 
            'Friday to Monday should be 2 business days (excluding weekend)');

        // Test same day
        Date sameDay = Date.newInstance(2024, 11, 11);
        Integer sameDayResult = DateUtilities.getBusinessDays(sameDay, sameDay);
        System.assertEquals(1, sameDayResult, 
            'Same day should return 1 business day');

        // Test Saturday to Sunday
        Date saturday = Date.newInstance(2024, 11, 9);
        Date sunday = Date.newInstance(2024, 11, 10);
        Integer weekendDays = DateUtilities.getBusinessDays(saturday, sunday);
        System.assertEquals(0, weekendDays, 
            'Saturday to Sunday should be 0 business days');

        // Test two weeks
        Date startDate = Date.newInstance(2024, 11, 4); // Monday
        Date endDate = Date.newInstance(2024, 11, 15); // Friday
        Integer twoWeeks = DateUtilities.getBusinessDays(startDate, endDate);
        System.assertEquals(10, twoWeeks, 
            'Two full weeks should be 10 business days');

        // Test null inputs
        System.assertEquals(0, DateUtilities.getBusinessDays(null, friday), 
            'Null start date should return 0');
        System.assertEquals(0, DateUtilities.getBusinessDays(monday, null), 
            'Null end date should return 0');
        System.assertEquals(0, DateUtilities.getBusinessDays(null, null), 
            'Both null dates should return 0');
    }

    /**
     * @description Test addBusinessDays method with various scenarios
     */
    @IsTest
    static void testAddBusinessDays() {
        // Test adding 1 business day to Monday
        Date monday = Date.newInstance(2024, 11, 11);
        Date tuesday = DateUtilities.addBusinessDays(monday, 1);
        System.assertEquals(Date.newInstance(2024, 11, 12), tuesday, 
            'Adding 1 business day to Monday should give Tuesday');

        // Test adding 5 business days to Monday (should skip weekend)
        Date nextMonday = DateUtilities.addBusinessDays(monday, 5);
        System.assertEquals(Date.newInstance(2024, 11, 18), nextMonday, 
            'Adding 5 business days to Monday should give next Monday');

        // Test adding business days from Friday (crossing weekend)
        Date friday = Date.newInstance(2024, 11, 8);
        Date mondayAfter = DateUtilities.addBusinessDays(friday, 1);
        System.assertEquals(Date.newInstance(2024, 11, 11), mondayAfter, 
            'Adding 1 business day to Friday should give Monday');

        // Test adding 0 business days
        Date sameDate = DateUtilities.addBusinessDays(monday, 0);
        System.assertEquals(monday, sameDate, 
            'Adding 0 business days should return the same date');

        // Test adding 10 business days (two weeks)
        Date twoWeeksLater = DateUtilities.addBusinessDays(monday, 10);
        System.assertEquals(Date.newInstance(2024, 11, 25), twoWeeksLater, 
            'Adding 10 business days should skip two weekends');

        // Test adding business days from Saturday
        Date saturday = Date.newInstance(2024, 11, 9);
        Date mondayFromSat = DateUtilities.addBusinessDays(saturday, 1);
        System.assertEquals(Date.newInstance(2024, 11, 11), mondayFromSat, 
            'Adding 1 business day to Saturday should give Monday');

        // Test null input
        Date nullResult = DateUtilities.addBusinessDays(null, 5);
        System.assertEquals(null, nullResult, 
            'Null start date should return null');
    }

    /**
     * @description Test edge cases and boundary conditions
     */
    @IsTest
    static void testEdgeCases() {
        // Test year transition
        Date endOfYear = Date.newInstance(2024, 12, 31);
        Date firstDayNextYear = DateUtilities.getFirstDayOfMonth(endOfYear);
        System.assertEquals(Date.newInstance(2024, 12, 1), firstDayNextYear, 
            'First day of December should be December 1');

        // Test adding business days across year boundary
        Date lastBusinessDay2024 = Date.newInstance(2024, 12, 31); // Tuesday
        Date firstBusinessDay2025 = DateUtilities.addBusinessDays(lastBusinessDay2024, 1);
        System.assertEquals(Date.newInstance(2025, 1, 1), firstBusinessDay2025, 
            'Adding 1 business day to Dec 31 should give Jan 1');

        // Test business days calculation across month boundary
        Date endOfMonth = Date.newInstance(2024, 11, 29); // Friday
        Date startOfNextMonth = Date.newInstance(2024, 12, 2); // Monday
        Integer daysAcrossMonths = DateUtilities.getBusinessDays(endOfMonth, startOfNextMonth);
        System.assertEquals(2, daysAcrossMonths, 
            'Friday to Monday across month boundary should be 2 business days');
    }
}