({    
    doInit : function(component, event, helper) 
    {
        var action = component.get("c.getAppointmentDetails"); 
       var lead = component.get("v.recordId");  
        
      // alert(lead); 
       action.setParams({
            "lead" : lead
             });
        
           // ii. Register the callback function
          action.setCallback(this, function(response) 
           {
            var state = response.getState();   
               //alert(state);
             if (state === "SUCCESS") 
              {
                   component.set("v.isTable",true);//added now 10/5
                  var EventDetails = new Array();
                  EventDetails = response.getReturnValue();  
                 // alert(EventDetails);
                 if (EventDetails.length < 1)
                 {
                     //alert("No Confirmed Appointments available for this Lead");
                        component.set("v.msg","No active appointments, Please proceed to click on Retail Appointment button to create a new Appointment");
                        component.set("v.showmsg",true);
                          component.set("v.isTable",true);//added now 
                 } 
                  else
                  {    
                  // Logic to convert start date as 9/28/2017 6:00 PM from 2017-09-29T01:00:00.000Z
                  var start = new Date(EventDetails[0].StartDateTime);
                  // var startdate = start.format('yyyy-MM-dd HH:mm:ss', 'PST'); 
                  
                  var hours = start.getHours();
                  var month = start.getMonth()+1;//Get Month
                  var date = start.getDate();// Get date
                  var Year = start.getFullYear();//Get Year
                  var dd = "AM"; 
                  var h = hours;
                    if(h >= 12){
                           h = hours - 12;
                           dd = "PM";   
                         }  
                   if (h == 0) {
                           h = 12;
                          }
                  
                  var startdate =  month +'/'+ date +'/'+ Year +' '+ h +':'+'00'+ dd;   
               
               component.set("v.startdate",startdate); 
                  
                  //end of logic to convert start date
                  //Logic to convert enda date as 9/28/2017 7:00 PM from 2017-09-29T02:00:00.000Z
                   var end = new Date(EventDetails[0].EndDateTime);
                  var hours1 = end.getHours();
                  var month1 = end.getMonth()+1;//Get Month
                  var date1 = end.getDate();// Get date
                  var Year1 = end.getFullYear();//Get Year
                  var dd1 = "AM"; 
                  var h1 = hours1;
                   if(h1 >= 12){
                           h1 = hours1 - 12;
                          dd1 = "PM";   
                         }  
                   if (h1 == 0) {
                           h1 = 12;
                          }
                  
                  var enddate =  month1 +'/'+ date1 +'/'+ Year1 +' '+ h1 +':'+'00'+ dd1;   
                    component.set("v.end",enddate); 
                  // End of logic to convert end date
                 //alert(EventDetails[0].Store_SAP_c__c);

                  component.set("v.storename",EventDetails[0].StoreName);
                  component.set("v.storeaddress",EventDetails[0].StoreAddress);
                  component.set("v.ID",EventDetails[0].externalid);
                  component.set("v.storeid",EventDetails[0].Storeid);
                  component.set("v.appointmentdate",EventDetails[0].Appointmentdate);    
                 // alert(response.getReturnValue()); 
               }
              }
            if (state === "ERROR") 
               {
                 // alert("No Confirmed appointment Available for this Lead")
               component.set("v.msg","No active appointments, Please proceed to click on Retail Appointment button to create a new Appointment");
                        component.set("v.showmsg",true);
                   component.set("v.isTable",false);//added now 
              }
        });
       
        // Invoke the service
        $A.enqueueAction(action);
        component.set("v.showmsg",false);
        

    },
//1. Cancel Appointment
  CancelAppointment : function(component, event, helper) 
    {
        var action = component.get("c.cancelAppointment"); 
       var lead = component.get("v.recordId");  
       var eventid = component.get("v.ID");
        
      // alert(lead); 
       //alert(eventid); 
       action.setParams({
            "leadId" : lead,
           "eventId":eventid
             });
        
           // ii. Register the callback function
          action.setCallback(this, function(response) 
           {
            var state = response.getState();  
               //alert(state);
             if (state === "SUCCESS") 
              {
                  var result = response.getReturnValue();
                // alert(result);
                 component.set("v.result",result);//.scrollTo('Top',0,0);
                 component.set("v.showresult",true);
                 component.set("v.isOpen",true);//added now 
                 
               /* // updating is event scheduled checkbox true on lead
                        if(result == '"Appointment Cancelled Successfully"'){

                           // var test = comp.get("v.result");
                            //alert(test);
                            //alert("test");

                            var action = component.get("c.updateLead");                          
                            action.setParams({
                                "leadId" : lead           
                            }); 
                            
                            action.setCallback(this, function(response) 
                            {
                                var state = response.getState();
                                if (state === "SUCCESS") 
                                {
                                   // alert("test");  
                                  //alert(response.getReturnValue());                       

                                }    
                            });
                            
                            $A.enqueueAction(action);
                      }
                // end of updating is event scheduled checkbox*/
               }
            if (state === "ERROR") 
               {
                  
              }
        });
       
        // Invoke the service
        $A.enqueueAction(action);
     component.set("v.showresult",false);
                 component.set("v.isOpen",false);//added now 
            
    },
    
 //2. Reschedule Appointment
 RescheduleAppointment : function(comp, event, helper) 
    {
       var action = comp.get("c.rescheduleAppointment"); 
       var lead = comp.get("v.recordId");  
       var eventid = comp.get("v.ID");
        
      // alert(lead); 
      // alert(eventid); 
       action.setParams({
            "leadId" : lead,
           "eventId":eventid
             });
        
        comp.set("v.isNew",true);//added now 
          
           // ii. Register the callback function
          action.setCallback(this, function(response) 
           {
            var state = response.getState();  
               //alert(state);  
             if (state === "SUCCESS") 
              {
                  var result = response.getReturnValue();
                 // alert(result);
               
               }
            if (state === "ERROR") 
               {
                  
             }
        });

       
        // Invoke the service
        $A.enqueueAction(action);

    },
    
    //Logic for new Appointment
//2. Show Available Slots Button Logic
    clickCreateItem: function(comp)
    {   
       // var event = comp.get("v.msg");
        var msg = comp.get("v.showmsg");
        
        var action = comp.get("c.getAvailableSlots");       
        var store = comp.find("storeid");
        var storeid = store.get("v.value");
        var validRequest = true;
        
        var lead = comp.get("v.recordId");
        
      //  var storen = comp.find("storename");
       // var storename = storen.get("v.value");
        
        var appointment = comp.find("appointmentdate");
        var appointmentdate = appointment.get("v.value");
        
        var d = new Date(appointmentdate);
       // d = d+1;
       // alert(d);
var weekday = new Array(7);
weekday[0] =  "Sunday";
weekday[1] = "Monday";
weekday[2] = "Tuesday";
weekday[3] = "Wednesday";
weekday[4] = "Thursday";
weekday[5] = "Friday";
weekday[6] = "Saturday";

var Dayofweek = weekday[d.getDay()];
//alert (Dayofweek);
        
        //alert(appointmentdate);
        var storedat = comp.find("storedates");
        var today = new Date();
        var Maxappoint =  new Date(today.getFullYear(), today.getMonth(), today.getDate()+21);
               
        var dd = today.getDate();       
        var mm = today.getMonth()+1; 
        var yyyy = today.getFullYear();
        
        if(dd<10){
        dd='0'+dd;
       } 
       if(mm<10){
        mm='0'+mm;
       } 
        var today = yyyy+'-'+mm+'-'+dd;  
    
        var dd = Maxappoint.getDate();       
        var mm = Maxappoint.getMonth()+1; 
        var yyyy = Maxappoint.getFullYear();
        if(dd<10){
        dd='0'+dd;
       } 
       if(mm<10){
        mm='0'+mm;
       } 
        var Maxappoint = yyyy+'-'+mm+'-'+dd;
        
        if ($A.util.isEmpty(storeid)){ 
            validRequest = false;
            store.set("v.errors", [{message:"Store SAP ID can't be blank"}]);
        }
        else {
            store.set("v.errors", null);
        }
        
        if ($A.util.isEmpty(appointmentdate)){ 
            validRequest = false;
            appointment.set("v.errors", [{message:"Appointment date can't be blank"}]);
        }
        else if(today>appointmentdate)
        {
            validRequest = false;
            appointment.set("v.errors", [{message:"Appointment date can not be past date"}]);
        }
        else if(Maxappoint<appointmentdate)
        {
            validRequest = false;
            appointment.set("v.errors", [{message:"Appointment date can not booked more than 3 weeks in advance"}]);
        }
        
        else if(Dayofweek == 'Saturday')
        {
            validRequest = false;
            appointment.set("v.errors", [{message:"No slots available to schedule appointment please try another calendar day"}]);
        }
        
        
        else {
            appointment.set("v.errors", null);
        }       
        
        
        //i. set params for Server side controller 
        action.setParams({
            "Store_SAP_ID" : storeid,
            "reqDate": appointmentdate
            });  
              
        // ii. Register the callback function
          action.setCallback(this, function(response) 
           {               
            if(validRequest)
            {
              //var event = comp.get("v.msg");  
               // alert(event);
              //if (event==null) 
              if(msg==false)
              {
             var state = response.getState();
             var dates = new Array();// 5 pm to 6 pm
             var date;
             var labels = new Array();// number plus time slot ex: 17 5 pm to 6 pm
             var label;  
             var items = new Array();//number 17   
             if (state === "SUCCESS") 
              {
                 comp.set("v.items",response.getReturnValue());                  
                  items = comp.get("{!v.items}");                  
                  if (items.length < 1)
                  {
                      comp.set("v.slotmsg","No slots available to schedule appointment please try another calendar day");
                      comp.set("v.slotshowmsg",true);
                      //comp.set("v.DisableCheckbox","true");
                      //var err = comp.find("Error");
                      //alert("No slots available to schedule appointment please try another calendar day"); 
                      //err.set("v.errors", [{message:"No slots available to schedule appointment please try another calendar day"}]);
                  }
                   else 
                   {
                     for (var i=0; i<items.length; i++){
                        //convert label from GMT time format ex: 17 to 5 PM
                         var start = new Date(appointmentdate+' '+items[i]+':'+'00'+':'+'00');
                         //alert(start);
                          var time1 = items[i]+1;
                          var end = new Date(appointmentdate+' '+time1+':'+'00'+':'+'00');
                          var hours = start.getHours();
                          var hours1 = end.getHours();
                          //alert(hours);
                          var dd = "AM";
                          var dd1 = "AM";
                          var m = start.getMinutes();
                          var m1 = end.getMinutes();
                          var s = start.getSeconds();
                          var s1 = end.getSeconds();  
                          var h = hours;
                          var h1 = hours1;
                          if (h1 >= 12) {
                           h1 = hours1 - 12;
                           dd1 = "PM";
                          }
                         if(h >= 12){
                           h = hours - 12;
                           dd = "PM";   
                         }

                         if (h == 0) {
                           h = 12;
                           //h1 = 12;  
                          }
                         if (h1 == 0)
                         {
                             h1 = 12;
                         }
                        
                        m = m < 10 ? "0" + m : m;
                        m1 = m1 < 10 ? "0" + m1 : m1;  
                        var replacement = h + ":" + m;
                        var replacement1 = h1 + ":" + m;  
                        replacement += " " + dd;
                        replacement1 += " " + dd1;  
                      //end of label for start time
                      
                      // Show slots for next top of hour 
                             var today = new Date(); 
                             var dd = today.getDate();       
                             var mm = today.getMonth()+1; 
                             var yyyy = today.getFullYear();
                             if(dd<10){
                                dd='0'+dd;
                              } 
                            if(mm<10){
                               mm='0'+mm;
                              } 
                             var date = yyyy+'-'+mm+'-'+dd;
                             var hoursnow;
                             var minsnow;

                         if(date == appointmentdate)
                         {
                             hoursnow = today.getHours();
                             //hoursnow = 14;//for testing
                             minsnow = today.getMinutes();
                             minsnow = minsnow < 10 ? "0" + minsnow : minsnow;
                             //minsnow = 50;//for testing
                     
                             if(minsnow>45)//take next top up hour when leadtime is less than 15 mins
                             {
                               hoursnow = hoursnow+1;  
                             }    
                                                      
                          if(hours>hoursnow)
                          { 
                           date = replacement + ' ' + '-' +' ' + replacement1;
                           dates.push(date); 
                          }   
                          if(hours=hoursnow)
                          { 
                              if(m>minsnow)
                             {    
                               date = replacement + ' ' + '-' +' ' + replacement1;
                               dates.push(date); 
                              }  
                           }  
                         }
                         
                     //End of show slots for next top of hour
                     else
                     {
                         //alert("test");
                      date = replacement + ' ' + '-' +' ' + replacement1;
                      dates.push(date); 
                     }
                    }//end of for loop
              }//end of else 

               
                  for (var j=0; j<items.length; j++){
                     for(var k=0; k<dates.length; k++)
                      {
                          if(j==k)
                          {    
                              label = items[j] +'  '+dates[k]; 
                              labels.push(label);
                          }    
                      }
                  }
                  
                  comp.set("v.dates",dates);
                  comp.set("v.label",labels);
               }
            if (state === "ERROR") 
               {
                //alert("Slots fetch failed"); 
                storedat.set("v.errors", [{message:"Appointmentdate can't be blank."}]);
                store.set("v.errors", [{message:"store unavailable to schedule in-store appointments"}]);   
               }
            }
             }
           
        });
       
        // Invoke the service
        $A.enqueueAction(action);
       //Clear data after button click event
        //comp.set("v.recordId" , ' ');
        comp.set("v.items",' ');
        comp.set("v.dates",' ');
        comp.set("v.startcheck",' ');//added now
        comp.set("v.showbutton",'false');
        comp.set("v.slot",' ');
        //comp.set("v.storename",' ');commened 9/25
        comp.set("v.slotmsg",' ');
        comp.set("v.slotshowmsg",false);
        comp.set("v.selectedCount",0);
        
   }, //End of ShowavailableSlots button Logic
    
    //3. checkbox logic event call
    updateSlotSelected: function(component,event){
          var checkbox = event.getSource();   
          var selectedcheckbox = checkbox.get("v.text");  //selected checkbox text  
          var selectedrec = checkbox.get("v.value");//true if checkbox selected
          var slotList=component.get("v.seletedslots");
          var getSelectedNumber = component.get("v.selectedCount");

          //if(selectedcheckbox!=null)
          if(selectedrec==true)    
         {
           slotList.push(selectedcheckbox);
          component.set("v.slot",selectedcheckbox);//to retrieve selected slot  
          component.set("v.showbutton","true");//to show schedule appointment button when slot is selected
          getSelectedNumber++;
         }
        else
        {
            slotList.splice(slotList.indexOf(selectedcheckbox),1);
            getSelectedNumber--;
        }
        //alert(getSelectedNumber);
        component.set("v.selectedCount", getSelectedNumber);
      
        component.set("v.seletedslots", slotList);
        //alert(slotList[0]);
        if(slotList.length>0)
        	component.set("v.slot",slotList[0]);
        else
            component.set("v.slot",'');
        
       // var error = component.find("Error");
       // var storedates = component.find(storedates);
        if(getSelectedNumber >1)
        {    
        //alert("Please select only one available slot");
         component.set("v.slotmsg","Please select only one available slot");
         component.set("v.slotshowmsg",true);
      //  storedates.set(Please select only one available slot);
        }  
        else
        {
           // alert("test");
         component.set("v.slotmsg",' ');
         component.set("v.slotshowmsg",false);  
         //component.set("v.slot",' ');//to retrieve selected slot  
         //component.set("v.showbutton","false");//to show schedule appointment button when slot is selected
        }
    },//End of checkbox Logic
    
 //4. Auto populate logic event call
    updateStoreDetails: function(comp,event){
          //alert("test");
          var store = comp.find("storeid");   
          var storename = comp.find("storename");
          var id = store.get("v.value");  //Entered Store SAP ID  
           //alert(id);
           
           var action = comp.get("c.getStoreDetails");
            
           // alert("test1");
             action.setParams({
            "Store_SAP_ID" : id
             });
           
        // ii. Register the callback function
          action.setCallback(this, function(response) 
           {
             //alert("test2");
             var state = response.getState();   
             if (state === "SUCCESS") 
              {
                 comp.set("v.mystores", response.getReturnValue()); 
                 //alert(response.getReturnValue());
                  if(response.getReturnValue().length>0)
                  {
                      //alert("test");
                  comp.set("v.flag",true);
                  comp.set("v.dates",' ');//added now
                  comp.set("v.start",' '); //added now    
                  }    

              else
               {
                   store.set("v.errors", [{message:"store unavailable to schedule in-store appointments"}]);
                   comp.set("v.store",true);//added now
                   comp.set("v.dates",' ');//added now
                   comp.set("v.start",' ');//added now
               }
               }
   
            if (state === "ERROR") 
               {
                   //check for valid SAP ID
            store.set("v.errors", [{message:"store unavailable to schedule in-store appointments"}]);
                   comp.set("v.store",true);//added now
                   comp.set("v.dates",' ');//added now
                   comp.set("v.start",' ');//added now
               }
      
               
        });
       
        // Invoke the service
        $A.enqueueAction(action);
        store.set("v.errors",' ');
       // comp.set("v.storename",' ');
        comp.set("v.newItem.Name__c",' ');
        //comp.set("v.newItem.Store_Address__c",' ');    
        //comp.set("v.msg",' ')  
        //comp.set("v.showmsg",false);
         comp.set("v.flag",false);
    },    
             
          
   // },//End of autopopulate Logic
   
        //On change of date -- added now
    updateDate: function(comp,event){
        var appointment = comp.find("appointmentdate");
        var appointmentdate = appointment.get("v.value");
        //alert("test");
         //comp.set("v.appointmentdate",' ');commented 9/25
         comp.set("v.dates",' ');
        comp.set("v.startcheck",' ');
 
    },    
 //end of on change of date --added now
    
   //5. ScheduleAppointment Button Logic    
    scheduleAppointment: function(comp,event,helper)
    {
        var action = comp.get("c.createEvent");
        
      //  var storen = comp.find("storename");
       // var storename = storen.get("v.value");
        
        var store = comp.find("storeid");
        var storeid = store.get("v.value");
        //alert(storeid);
         var validRequest = true;
        var slotshowmsg = comp.get("v.slotshowmsg");
        var lead = comp.get("v.recordId");
        
                comp.set("v.lead",lead);//added now 10/4 for multiple appointments restriction
        comp.set("v.lead1",lead);//added now 10/4 for cancellation logic
        
        //alert(lead);
        
        var appointment = comp.find("appointmentdate");
        var appointmentdate = appointment.get("v.value");
        //alert(appointmentdate);//2017-08-18
        
        var storecheck = comp.get("v.store");//added now
        
        //get slot
        var slot = comp.get("v.slot");
        //alert(slot);
        var s = slot.split(" ");
        //alert(s[0]);
        //alert(s[1]);
        
  
        var time = s[0];
        time = time.split(":");
        //alert(time[0]);

        var time1 = parseInt(time[0]);
        var time3;
        if((s[1] == 'PM'))
        {
            time3= time1+12;
        }
        else{
            //alert(time1);
            time3= time1;
            //alert(time3);
        }
        
        
       
        if((s[1] == 'PM')&&(time1 == 12))
        {
            time3= 12;
        }
   

        //alert(time3);
        var time2 = time3+1;
       // alert(time2);
      
        var start = new Date(appointmentdate+' '+time3+':'+'00'+':'+'00');
        var end = new Date(appointmentdate+' '+time2+':'+'00'+':'+'00');
        
        comp.set("v.start",start);// added now
        
        //alert(start);
        //alert(end);
        var subject = " Appointment with Customer ( ";
            
        //begin of code added now
        var getSelectedNumber = comp.get("v.selectedCount");
        //alert(getSelectedNumber);
        if(getSelectedNumber>1)
        { 
          comp.set("v.start",' ');
        } 
        
        var startcheck = comp.get("v.start");
        //alert(startcheck); end of code added now
         lead = comp.get("v.lead");//added now 10/4 to avoid multiple appointments
        
        //i. set params for Server side controller 
        action.setParams({
            "recordId" : lead,
            "storeSapId" : storeid,
            "StartDateTime" : startcheck,
            "endDateTime"  : end,
            "subject" : subject
            //"appointmentdate" :appointmentdate
        }); 
        
        // ii. Register the callback function
          action.setCallback(this, function(response) 
           {
             if(validRequest)
             { 
             if(storecheck==false)//added now
              {
              if(slotshowmsg==false)
              {
               //var getSelectedNumber = comp.get("v.selectedCount"); commented now   
               //alert(getSelectedNumber);
               
                   //alert("test");
            var state = response.getState();
                if (state === "SUCCESS") 
                 {                  

                        var result = response.getReturnValue(); 
                  comp.set("v.result",result);//.scrollTo('Top',0,0);
                  comp.set("v.showresult",true);
                  comp.set("v.isOpen",true);//added now   
                        
                 // updating is event scheduled checkbox true on lead
                       if(result == '"Appointment Succesfully Created."'){
                           var action = comp.get("c.updateLead");                          
                            action.setParams({
                               "leadId" : lead,
                               "storeSapId" : storeid            
                           }); 
                            
                           action.setCallback(this, function(response) 
                          {
                              var state = response.getState();
                               if (state === "SUCCESS") 
                                {
                                    console.log(response.getReturnValue());
                               }    
                            });
                            
                            $A.enqueueAction(action);
                           comp.set("v.lead",' ');//added on 10/4
                           //Start Cancelling appointment
                            var action = comp.get("c.cancelAppointmentreschedule"); 
       var lead = comp.get("v.lead1");  //added now 10/4  
       var eventid = comp.get("v.ID");
        
      // alert(lead); 
       //alert(eventid); 
       action.setParams({
            "leadId" : lead,
           "eventId":eventid
             });
        
           // ii. Register the callback function
          action.setCallback(this, function(response) 
           {
            var state = response.getState();  
               //alert(state);
             if (state === "SUCCESS") 
              {
                  //var result = response.getReturnValue();
                // alert(result);
                 //component.set("v.result",result);//.scrollTo('Top',0,0);
                 //component.set("v.showresult",true);
                // component.set("v.isOpen",true);//added now 
                 
               /* // updating is event scheduled checkbox true on lead
                        if(result == '"Appointment Cancelled Successfully"'){

                           // var test = comp.get("v.result");
                            //alert(test);
                            //alert("test");

                            var action = component.get("c.updateLead");                          
                            action.setParams({
                                "leadId" : lead           
                            }); 
                            
                            action.setCallback(this, function(response) 
                            {
                                var state = response.getState();
                                if (state === "SUCCESS") 
                                {
                                   // alert("test");  
                                  //alert(response.getReturnValue());                       

                                }    
                            });
                            
                            $A.enqueueAction(action);
                      }
                // end of updating is event scheduled checkbox*/
               }
            if (state === "ERROR") 
               {
                  
              }
        });
       
        // Invoke the service
        $A.enqueueAction(action);
                           //End Cancelling Appointment
                      }
                // end of updating is event scheduled checkbox
//$A.get('e.force:refreshView').fire();
                    }
                     
               if (state === "ERROR") 
               {   
              //code added to prevent multiple appointments for lead
                    var lead1 = comp.get("v.lead");  //added now 10/4 
                   if(lead1 == ' ')//changed now 10/4
                    {
                   //alert("Appointment already created for this Lead");
                  comp.set("v.slotmsg","Appointment already created for this Lead");//.scrollTo('Top',0,0);
                  comp.set("v.slotshowmsg",true); 
                    } 
                   if(startcheck == ' ')
                   {
                     comp.set("v.slotmsg","Please select only one available slot");//.scrollTo('Top',0,0);
                     comp.set("v.slotshowmsg",true);   
                   }    
                   if(lead1 != ' ')
                    {
              // End of code added to prevent multiple appointments for lead     
               // alert("Appointment Scheduling failed");  
                  comp.set("v.slotmsg","Appointment Scheduling failed");//.scrollTo('Top',0,0);
                  comp.set("v.slotshowmsg",true);   
                    }
               }//end of error state                 
             }  
             }
             }
        });
       
// Invoke the service
        $A.enqueueAction(action);
        
        //added to avoid multiple appointments when schedule appointment is clicked again
        // comp.set("v.recordId" , ' ');
         comp.set("v.lead",' ');//addded now now 10/4  shouldn't clear record id
         comp.set("v.storeSapId" , ' ');
         comp.set("v.StartDateTime" , ' ');
         comp.set("v.endDateTime"  , ' ');
         comp.set("v.subject" , ' ');
        comp.set("v.slotmsg",' ');//added now
        comp.set("v.slotshowmsg",false);//added now
         comp.set("v.result",' ');
         comp.set("v.showresult",false);
         comp.set("v.start",' ');
        comp.set("v.end",' ');
        comp.set("v.store",' ');
        comp.set("v.slot",' ');
         //End of code added to avoid multiple appointments when schedule appointment is clicked again
    },
    
    autoclose: function(comp,event)
    {
       // window.location.reload();
        //location.reload();
        //window.close();
        $A.get('e.force:refreshView').fire();
        $A.get('e.force:closeQuickAction').fire(); // to close quick action panel
        
    }
    //End of Logic for new Appointment
})