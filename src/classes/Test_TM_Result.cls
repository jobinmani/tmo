/**
 * TMobile Result Test Case
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 */
@isTest
private class Test_TM_Result 
{
    static testMethod void testSenario1() 
    {
        TM_Result result = new TM_Result();
        
        result.returnCode = TM_Result.RESULT_NO_ERROR;
        result.returnCode = TM_Result.RESULT_GENERAL_ERROR;
        result.returnCode = TM_Result.RESULT_NO_RESULTS_FOUND;   
        result.returnCode = TM_Result.RESULT_ERROR_INPUT_DATA; 
        result.returnCode = TM_Result.RESULT_ERROR_LEAD_NOT_FOUND;
        
        result.errorList.add('Test Error Message');
        result.valueObject = result;
    }
}