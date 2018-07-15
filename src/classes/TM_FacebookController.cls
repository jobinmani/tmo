/**
 * TMobile Facebook Controller
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 */
@RestResource(urlMapping='/facebook/service')
global class TM_FacebookController 
{
    @HttpPost
    global static void doPost() 
    {
        // Entry point to process inbound messages
        TM_FacebookService.processMessage();
    }
}