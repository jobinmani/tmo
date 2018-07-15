/**
 * TMobile Result Service Class
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 */
public with sharing class TM_Result
{
    public static final Integer RESULT_NO_ERROR                         = 0;
    
    public static final Integer RESULT_GENERAL_ERROR                    = 50;
    public static final Integer RESULT_NO_RESULTS_FOUND                 = 100;
    public static final Integer RESULT_ERROR_INPUT_DATA                 = 101;
    public static final Integer RESULT_ERROR_LEAD_NOT_FOUND             = 101;
    public static final Integer RESULT_ERROR_ALREADY_RESERVED           = 102;

    public Decimal          returnCode        { set; get; }
    public List<String>     errorList         { set; get; }
    transient public Object valueObject       { set; get; }  
                    
    public TM_Result()
    {
        returnCode = 0;
        errorList  = new List<String>();
    }
}