/**
 * TMobile Facebook Service Class
 * 
 * TMobile - Copyright 2018 All rights reserved.
 *
 * @company TMobile
 * @author Chris Matthews
 *
 */
public with sharing class TM_Globals 
{
    // Transient Store (Facade)
    public class Store
    {
        public String    name                { set; get; }
        public String    storeId             { set; get; }
        public String    type                { set; get; }
        public String    channel             { set; get; }
        public String    address             { set; get; }
        public String    city                { set; get; }
        public String    state               { set; get; }
        public String    postalCode          { set; get; }
        public String    phone               { set; get; }
        public String    email               { set; get; }
        public Decimal   longitude           { set; get; }
        public Decimal   latitude            { set; get; }
    }

    // Transient Store Appointment (Facade)
    public class StoreAppointment
    {
        public String    storeId             { set; get; }
        public String    appointmentId       { set; get; }
        public String    appointmentDate     { set; get; }
        public String    appointmentTime     { set; get; }
    }
}