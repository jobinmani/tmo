function Mocks() {
    this.DASHBOARD_TUNNEL_URL = "https://dashboard.callinize.com", this.API_TUNNEL_URL = "api.callinize.com", 
    this.callinizeStaticSettings = {
        protocol: "https",
        apiUri: this.API_TUNNEL_URL,
        websiteUri: "dashboard.callinize.com",
        websiteUrl: this.DASHBOARD_TUNNEL_URL,
        port: "",
        pubnub: {
            subscribe_key: "sub-c-832c615c-2b1d-11e4-bbfa-02ee2ddab7fe",
            ssl: !0,
            restore: !0
        },
        callbox_state: {
            CLOSED: "closed",
            MINIMIZED: "minimized",
            OPEN: "open"
        },
        raygun_api_key_production: "E/leR0zmTy+0Fn1Z67nXRg==",
        raygun_api_key_development: "BqTDB24N9SEMzxqRKdHc1w==",
        rollbarConfig: {
            accessToken: "6ac05f307cd243729b4bfa673931d952",
            captureUncaught: !0,
            payload: {
                environment: "production"
            }
        },
        install_type: !1,
        development_version: !1
    };
}

function ChromeMock() {
    var noop = function() {};
    this.commandHandlers = {}, this.setCommandHandler = function(command, commandHandler) {
        this.commandHandlers[command] = commandHandler;
    }, this.browserAction = {
        setIcon: noop,
        setPopup: noop
    }, this.cookies = {
        get: function(opts, callback) {
            return callback();
        },
        onChanged: {
            addListener: noop
        },
        onMessage: {
            addListener: noop
        }
    }, this.i18n = {
        getMessage: function(str) {
            if ("@@ui_locale" == str) return "en_US";
            window.mockLocale || (window.mockLocale = "en"), window.mockLocales || (window.mockLocales = getLocales());
            var locale = window.mockLocales[window.mockLocale], msg = locale && locale[str];
            return msg && msg.message || str;
        }
    }, this.runtime = {
        onMessage: {
            addListener: noop,
            lastError: !1
        },
        reload: noop,
        sendMessage: function(message, callback) {
            if (!message.command) throw new Error("Message must have a command property");
            this.commandHandlers[message.command] && this.commandHandlers[message.command](message, callback);
        }.bind(this),
        requestUpdateCheck: noop,
        getManifest: noop,
        onUpdateAvailable: {
            addListener: noop
        }
    }, this.storage = {
        local: {
            get: noop,
            remove: noop,
            set: noop
        }
    }, this.app = {
        getDetails: function() {
            return {
                version: "TEST",
                current_locale: "en_US"
            };
        }
    }, this.tabs = {
        create: noop,
        query: noop,
        onUpdated: {
            addListener: noop
        }
    }, this.extension = {
        getURL: noop
    }, this.notifications = {
        create: noop
    };
}

function getLocales() {
    return {
        cz: {
            extName: {
                message: "Callinize",
                description: "extension name -- Do not translate this... this is our company name."
            },
            extDescription: {
                message: "Tenfold Enhanced CallerID & Automatic CRM Call Logging",
                description: "Shown in chrome://extensions page and maybe in the chrome store -- Translate it to say something like CRM Telephony Integration"
            },
            extShortName: {
                message: "CRM Telephony Integration",
                description: "Shown in chrome://extensions page and maybe in the chrome store"
            },
            selectContact: {
                message: "Vyberte kontakt",
                description: "Shown when there are multiple matching contacts"
            },
            matches: {
                message: "v�sledk�",
                description: "when there are multiple matches from the crm, this string shows - X matches"
            },
            unknownCaller: {
                message: "��slo nenalezeno",
                description: "Shown where contact name goes when phone number isn't found in CRM"
            },
            unknownNumber: {
                message: "Nezn�m� ��slo",
                description: "Shown when the phoneNumber is empty... this happens in cases like CallerID is blocked"
            },
            addNotes: {
                message: "Zadejte pozn�mku ...",
                description: "placeholder text shown in note input box"
            },
            savedSuccessfully: {
                message: "�sp�n� ulo�eno",
                description: "title when call notes are saved"
            },
            outboundCall: {
                message: "Click To Dial",
                description: "title when call notes are saved"
            },
            callNotesSaved: {
                message: "Pozn�mka ulo�ena",
                description: "shown in desktop notification"
            },
            noteNotSaved: {
                message: "Neulo�eno",
                description: "title when call notes are not saved"
            },
            noteSaveError: {
                message: "Nepoda�ilo se ulo�it pozn�mku",
                description: "shown in desktop notification"
            },
            createRecordErrorTitle: {
                message: "Není Vytvořeno",
                description: "title when create records are not saved"
            },
            createRecordErrorDescription: {
                message: "Chyba: Nepodařilo se vytvořit záznam.",
                description: "shown in desktop notification  when records are not created"
            },
            taskCreatedFor: {
                message: "Vytvo�en �kol s term�nem spln�n�: ",
                description: "shown in desktop notification"
            },
            emailSentTo: {
                message: "Email odesl�n na: ",
                description: "shown in desktop notification"
            },
            incoming: {
                message: "P��CHOZ�",
                description: "direction of the call, used in title bar and probably other places"
            },
            outgoing: {
                message: "ODCHOZ�",
                description: "direction of the call, used in title bar and probably other places"
            },
            incomingCall: {
                message: "P��CHOZ� HOVOR",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            outgoingCall: {
                message: "ODCHOZ� HOVOR",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            call: {
                message: "HOVOR",
                description: "typically combined with incoming/outgoing above in title bar."
            },
            emailTo: {
                message: "Pozn�mky budou zaslan� na ",
                description: "help text shown on hover over email indicator"
            },
            createTask: {
                message: "Creating task assigned to you for ",
                description: "help text shown on hover over task indicator"
            },
            queue: {
                message: "Fronta",
                description: "Shown on calls to an inbound call queue as a prefix"
            },
            hour: {
                message: "hod"
            },
            min: {
                message: "min",
                description: "short for minutes"
            },
            sec: {
                message: "sek",
                description: "short for seconds"
            },
            searchingForActivities: {
                message: "Vyhled�v�m aktivity...",
                description: "Activities box status message while the activities fetch in progress"
            },
            noActivitiesFound: {
                message: "Aktivity nenalezeny",
                description: "Activities box status message when no activities are being found"
            },
            createNewContact: {
                message: "Vytvo�it nov� kontakt",
                description: "When multiple contacts displays matching, but the caller is not one of them create new contact"
            },
            create: {
                message: "Vytvo�it",
                description: "create"
            },
            save: {
                message: "Ulo�it",
                description: "save"
            },
            noMatchEnterNameHere: {
                message: "Vlo�te jm�no ...",
                description: "When no match allow user to create contact"
            },
            noMatchEnterNameHelper: {
                message: "To access all fields you must create the record first",
                description: "To access all fields you must create the record first"
            },
            createRecord: {
                message: "Vytvo�it ->",
                description: "To access all fields you must create the record first"
            },
            creatingRecord: {
                message: "Vytv���m z�znam",
                description: "Transition dialog for creating a record"
            },
            retrievingRecord: {
                message: "Z�sk�v�m z�znam",
                description: "Transition dialog for retrieving a record"
            },
            savingUpdates: {
                message: "Saving Updates",
                description: "Transition dialog for saving updates"
            },
            info: {
                message: "Info",
                description: "Info navigation button for different pages on top right"
            },
            dialpad: {
                message: "Telefon",
                description: "Dialpad navigation button for different pages on top right"
            },
            back: {
                message: "Zp�t",
                description: "Back"
            },
            disabledDialpad: {
                message: "Dialpad disabled during call",
                description: "Dialpad disabled during call"
            },
            lead: {
                message: "Lead",
                description: "Lead"
            },
            contact: {
                message: "Kontakt",
                description: "Contact"
            },
            cancel: {
                message: "Zru�it",
                description: "Cancel"
            },
            searchingRecords: {
                message: "Prohled�v�m z�znamy...",
                description: "Searching Records..."
            },
            noMatchTitle: {
                message: "Z�znam nenalezen",
                description: "SNo Match Found"
            },
            createRecordType: {
                message: "Vyberte typ z�znamu",
                description: "Create record type?"
            },
            name: {
                message: "Jm�no",
                description: "Name"
            },
            answeredBy: {
                message: "Answered by",
                description: "Answered by"
            },
            loadingHistory: {
                message: "Nahr�v�m historii...",
                description: "Loading History..."
            },
            noInternet: {
                message: "No internet...",
                description: "No internet..."
            },
            showCallinize: {
                message: "Zobrazit Popup",
                description: "Show Popup"
            },
            showTour: {
                message: "Spustit prohl�dku",
                description: "Show Tour"
            },
            settings: {
                message: "Settings",
                description: "Settings"
            },
            allCallHistory: {
                message: "Historie v�ech hovor�",
                description: "All Call History"
            },
            clickToDial: {
                message: "Click to dial",
                description: "Click to dial"
            },
            noExtension: {
                message: "��dn� klapka",
                description: "No Extension"
            },
            unknownContact: {
                message: "Nezn�m� kontakt",
                description: "Shown for unknown contacts in history view"
            },
            reload: {
                message: "Reload",
                description: "Reload"
            },
            updateStatusUpToDate: {
                message: "Newest Version",
                description: "Newest Version"
            },
            updateStatusOldVersion: {
                message: "Old Version",
                description: "Old Version"
            },
            switchToThisCallAndSaveExistingNotes: {
                message: "Přepnout & Save",
                description: "Přepnout & Save"
            },
            ignore: {
                message: "Ignorovat",
                description: "Ignorovat"
            },
            extensionConfigurationErrorTitle: {
                message: "Žádné prodloužení nakonfigurován",
                description: "No extension configured"
            },
            extensionConfigurationErrorMessage: {
                message: "Chcete-li konfigurovatrozšíření jít do <a href='https://dashboard.tenfold.com/profile'>Callinize Dashboard</a> a přidat telefonní linku ",
                description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
            },
            microphonePermission: {
                message: "Při prvním spuštění této aplikace musíte dát svolení k tomu, aby použití mikrofonu . Přejděte na kartu vytvořili a dát svolení.",
                description: "Ask for microphone permission"
            },
            noLoginTokenTitle: {
                message: "Tenfold odhlášeni",
                description: ""
            },
            noLoginTokenMessage: {
                message: "Prosím, přihlašte se <a href='https://dashboard.tenfold.com'>Callinize</a>.  Než to uděláte , nebudete dostávat volání automaticky otevíraná okna.",
                description: "Message when a user clears there cookie and has nothing in chrome storage"
            },
            enabledRequirementTitle: {
                message: "Vaše uživatelské není povoleno. Volání automaticky otevíraná okna nebude fungovat, dokud jsou povoleny.",
                description: "Message displayed to user when they are not enabled"
            },
            enabledRequirementMessage: {
                message: "Pokud jste admin login na <a href='https://dashboard.tenfold.com/users'>Callinize Dashboard</a> a povolit sami, nebo, pokud jste uživatel, emailem správce a požádejte ho, aby vám umožnil.",
                description: "Message displayed to user when they are not enabled"
            },
            enterAccountHere: {
                message: "Enter Account Name",
                description: "Enter Account Name Here"
            },
            active: {
                message: "Aktivní",
                description: "Topbar toggle option to show the active call"
            },
            recent: {
                message: "Nedávný",
                description: "Topbar toggle option to show recent calls"
            }
        },
        en: {
            extName: {
                message: "Tenfold",
                description: "extension name -- Do not translate this... this is our company name."
            },
            extDescription: {
                message: "Tenfold Enhanced CallerID & Automatic CRM Call Logging",
                description: "Shown in chrome://extensions page and maybe in the chrome store -- Translate it to say something like CRM Telephony Integration"
            },
            extShortName: {
                message: "CRM Telephony Integration",
                description: "Shown in chrome://extensions page and maybe in the chrome store"
            },
            selectContact: {
                message: "Select contact",
                description: "Shown when there are multiple matching contacts"
            },
            matches: {
                message: "matches",
                description: "when there are multiple matches from the crm, this string shows - X matches"
            },
            unknownCaller: {
                message: "Unrecognized caller",
                description: "Shown where contact name goes when phone number isn't found in CRM"
            },
            unknownNumber: {
                message: "Unknown number",
                description: "Shown when the phoneNumber is empty... this happens in cases like CallerID is blocked"
            },
            addNotes: {
                message: "Click here to add notes",
                description: "placeholder text shown in note input box"
            },
            savedSuccessfully: {
                message: "Saved Successfully",
                description: "title when call notes are saved"
            },
            outboundCall: {
                message: "Click To Dial",
                description: "title when call notes are saved"
            },
            callNotesSaved: {
                message: "Call Notes Saved",
                description: "shown in desktop notification"
            },
            noteNotSaved: {
                message: "Not Saved",
                description: "title when call notes are not saved"
            },
            noteSaveError: {
                message: "Error. Failed to save the Note",
                description: "shown in desktop notification  when notes are saved"
            },
            createRecordErrorTitle: {
                message: "Not Created",
                description: "title when create records are not saved"
            },
            createRecordErrorDescription: {
                message: "Error. Failed to create the record.",
                description: "shown in desktop notification  when records are not created"
            },
            taskCreatedFor: {
                message: "Task Created with due date of: ",
                description: "shown in desktop notification when notes are saved"
            },
            emailSentTo: {
                message: "Email Sent To: ",
                description: "shown in desktop notification when notes are saved"
            },
            incoming: {
                message: "INCOMING",
                description: "direction of the call, used in title bar and probably other places"
            },
            outgoing: {
                message: "OUTGOING",
                description: "direction of the call, used in title bar and probably other places"
            },
            incomingCall: {
                message: "INCOMING CALL",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            outgoingCall: {
                message: "OUTGOING CALL",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            call: {
                message: "CALL",
                description: "typically combined with incoming/outgoing above in title bar."
            },
            emailTo: {
                message: "Notes will be emailed to ",
                description: "help text shown on hover over email indicator"
            },
            createTask: {
                message: "Creating task assigned to you for ",
                description: "help text shown on hover over task indicator"
            },
            queue: {
                message: "Queue",
                description: "Shown on calls to an inbound call queue as a prefix"
            },
            hour: {
                message: "hour"
            },
            min: {
                message: "min",
                description: "short for minutes"
            },
            sec: {
                message: "sec",
                description: "short for seconds"
            },
            searchingForActivities: {
                message: "Searching for activities...",
                description: "Activities box status message while the activities fetch in progress"
            },
            noActivitiesFound: {
                message: "No activities found",
                description: "Activities box status message when no activities are being found"
            },
            createNewContact: {
                message: "Create New Contact",
                description: "When multiple contacts displays matching, but the caller is not one of them create new contact"
            },
            create: {
                message: "Create",
                description: "create"
            },
            save: {
                message: "Save",
                description: "save"
            },
            noMatchEnterNameHere: {
                message: "Enter Name",
                description: "When no match allow user to create contact"
            },
            associateToExisting: {
                message: "Associate to existing record",
                description: "Associate to existing record"
            },
            noMatchEnterNameHelper: {
                message: "To access all fields you must create the record first",
                description: "To access all fields you must create the record first"
            },
            createRecord: {
                message: "Create ->",
                description: "To access all fields you must create the record first"
            },
            creatingRecord: {
                message: "Creating Record",
                description: "Transition dialog for creating a record"
            },
            retrievingRecord: {
                message: "Retrieving Record",
                description: "Transition dialog for retrieving a record"
            },
            savingUpdates: {
                message: "Saving Updates",
                description: "Transition dialog for saving updates"
            },
            info: {
                message: "Info",
                description: "Info navigation button for different pages on top right"
            },
            dialpad: {
                message: "Dialpad",
                description: "Dialpad navigation button for different pages on top right"
            },
            back: {
                message: "Back",
                description: "Back"
            },
            disabledDialpad: {
                message: "Dialpad disabled during call",
                description: "Dialpad disabled during call"
            },
            lead: {
                message: "Lead",
                description: "Lead"
            },
            contact: {
                message: "Contact",
                description: "Contact"
            },
            cancel: {
                message: "Cancel",
                description: "Cancel"
            },
            searchingRecords: {
                message: "Searching Records...",
                description: "Searching Records..."
            },
            noMatchTitle: {
                message: "No Match Found",
                description: "Displayed when no matching record is found in CRM"
            },
            createRecordType: {
                message: "Select record type",
                description: "Create record type?"
            },
            name: {
                message: "Name",
                description: "Name"
            },
            answeredBy: {
                message: "Answered by",
                description: "Answered by"
            },
            calledBy: {
                message: "Called by",
                description: "Called by"
            },
            assignedTo: {
                message: "Assigned to",
                description: "Assigned to"
            },
            createdBy: {
                message: "Created By",
                description: "'Created by' as in the call was 'Created By: John'"
            },
            loadingHistory: {
                message: "Loading History...",
                description: "Loading History..."
            },
            noInternet: {
                message: "No internet...",
                description: "No internet..."
            },
            showCallinize: {
                message: "Show Popup",
                description: "Show Popup"
            },
            showTour: {
                message: "Show Tour",
                description: "Show Tour"
            },
            settings: {
                message: "Settings",
                description: "Settings"
            },
            allCallHistory: {
                message: "All Call History",
                description: "All Call History"
            },
            openDashboard: {
                message: "Open Dashboard",
                description: "Open Dashboard"
            },
            clickToDial: {
                message: "Click to dial",
                description: "Click to dial"
            },
            noExtension: {
                message: "No Extension",
                description: "No Extension"
            },
            unknownContact: {
                message: "Unknown Contact",
                description: "Shown for unknown contacts in history view"
            },
            reportProblemCall: {
                message: "Report Problem Call",
                description: "Report Problem Call"
            },
            reload: {
                message: "Reload Extension",
                description: "Reload Extension"
            },
            updateStatusUpToDate: {
                message: "Newest Version",
                description: "Newest Version"
            },
            updateStatusOldVersion: {
                message: "Old Version",
                description: "Old Version"
            },
            switchToThisCallAndSaveExistingNotes: {
                message: "Switch & Save",
                description: "Displayed to the user when a new call comes in while old call is active"
            },
            ignore: {
                message: "Ignore",
                description: "Ignore"
            },
            extensionConfigurationErrorTitle: {
                message: "No extension configured",
                description: "No extension configured"
            },
            extensionConfigurationErrorMessage: {
                message: "To configure an extension go to  <a href='https://dashboard.tenfold.com/profile'>Tenfold Dashboard</a> and add your phone extension.",
                description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
            },
            microphonePermission: {
                message: "When you first start this application you must give permission for it to use your microphone.  Please go to the tab created and give permission.",
                description: "Ask for microphone permission"
            },
            cleanupMessage: {
                message: "Tenfold: chrome does not allow us to automatically reload the chrome newtab page when updates occur.  Until this page refreshes your popup will not work correctly.  If you have notes on this page, please copy them now.",
                description: "Tenfold: chrome does not allow us to automatically reload the chrome newtab page when updates occur.  Until this page refreshes your popup will not work correctly.  If you have notes on this page, please copy them now."
            },
            noLoginTokenTitle: {
                message: "Tenfold logged out",
                description: ""
            },
            noLoginTokenMessage: {
                message: "Please login at <a href='https://dashboard.tenfold.com'>Tenfold</a>. Before you do, you will not receive call popups.",
                description: "Message when a user clears there cookie and has nothing in chrome storage"
            },
            enabledRequirementTitle: {
                message: "You are not presently enabled.  Call popups will not work until you are enabled.",
                description: "Message displayed to user when they are not enabled"
            },
            enabledRequirementMessage: {
                message: "If you are the admin login at <a href='https://dashboard.tenfold.com/users'>Tenfold Dashboard</a> and enable yourself or if you are a user, email your admin and ask them to enable you",
                description: "Message displayed to user when they are not enabled"
            },
            enterAccountHere: {
                message: "Enter Account Name",
                description: "Enter Account Name Here"
            },
            searchOrCreateNew: {
                message: "Search or Add New",
                description: "Search for a user not listed here or create new user."
            },
            opportunities: {
                message: "Opportunities",
                description: "Opportunities title"
            },
            opportunityRelateButBlocked: {
                message: "A opportunity is related to this call",
                description: "Text shown besides priority in activity's case number"
            },
            errorSearchingActivities: {
                message: "No response from API. Contact your admin or",
                description: "Activities box status message while the activities fetch in progress"
            },
            waitForDispositions: {
                message: "Fetching the dispositions...",
                description: "Dispositions box status message while the Dispositions fetch in progress"
            },
            waitForResources: {
                message: "Searching for resources...",
                description: "Resources box status message while the resources fetch in progress"
            },
            createNew: {
                message: "Create New",
                description: "create"
            },
            refreshResources: {
                message: "Fetch resources that you just created in the CRM",
                description: "Fetch resources that you just created in the CRM"
            },
            amount: {
                message: "Amount: ",
                description: "amount"
            },
            probability: {
                message: "Probability: ",
                description: "probability"
            },
            noDispositions: {
                message: "No dispositions for this records",
                description: "save"
            },
            login: {
                message: "Login",
                description: "Message when a user clears there cookie and has nothing in chrome storage"
            },
            created: {
                message: "created",
                description: "Text shown besides priority in activity's cases"
            },
            case: {
                message: "Case",
                description: "Text shown besides priority in activity's case number"
            },
            caseRelateButBlocked: {
                message: "A case is related to this call",
                description: "Text shown besides priority in activity's case number"
            },
            cases: {
                message: "Cases",
                description: "Text shown besides priority in activity's case number"
            },
            relateResource: {
                message: "Relate / Resource",
                description: "Text shown besides priority in activity's case number"
            },
            orCreateNew: {
                message: "Or, create new...",
                description: "Single match create buttons"
            },
            emailTemplate: {
                message: "Email Templates",
                description: "Email Templates button text"
            },
            notConnected: {
                message: "You are not connected to the internet. Please check your network settings.",
                description: "You are not connected to the internet. Please check your network settings."
            },
            filterResults: {
                message: "Filter Results",
                description: "Multi-match filter input placeholder"
            },
            notesDisabled: {
                message: "Notes feature is disabled for your organization",
                description: "Notes feature is disabled for your organization"
            },
            active: {
                message: "Active",
                description: "Topbar toggle option to show the active call"
            },
            recent: {
                message: "Recent",
                description: "Topbar toggle option to show recent calls"
            },
            inviteEmail: {
                message: "Email to send invite to the meeting",
                description: "Email to send invite to the meeting"
            },
            createMeeting: {
                message: "Create Online Meeting",
                description: "Create online meeting label"
            },
            go: {
                message: "Go",
                description: "Go"
            },
            available: {
                message: "Available",
                description: "Displayed when the agent's status is Available"
            },
            busy: {
                message: "Unavailable",
                description: "Displayed when the agent's status is Unavailable"
            },
            wrapUp: {
                message: "Wrap-Up",
                description: "Displayed when the agent's status is Wrap-Up"
            },
            offline: {
                message: "Offline",
                description: "Displayed when the agent's status is Offline"
            }
        },
        es: {
            extName: {
                message: "Callinize",
                description: "extension name"
            },
            extDescription: {
                message: "Tenfold Mejorado CallerID y CRM automática de llamadas Registro"
            },
            extShortName: {
                message: "Mejorado CallerID"
            },
            selectContact: {
                message: "Seleccione el contacto"
            },
            matches: {
                message: "conectado",
                description: "when there are multiple matches from the crm, this string shows - X connected"
            },
            addNotes: {
                message: "Haga clic aquí para añadir notas"
            },
            savedSuccessfully: {
                message: "Guardado Correctamente",
                description: "title when call notes are saved"
            },
            callNotesSaved: {
                message: "Llamar Notas Guardadas",
                description: "shown in desktop notification"
            },
            noteNotSaved: {
                message: "Not Saved",
                description: "title when call notes are not saved"
            },
            noteSaveError: {
                message: "Error. Failed to save the Note",
                description: "shown in desktop notification"
            },
            createRecordErrorTitle: {
                message: "No se ha creado",
                description: "title when create records are not saved"
            },
            createRecordErrorDescription: {
                message: "Error: No se ha podido crear el registro.",
                description: "shown in desktop notification  when records are not created"
            },
            taskCreatedFor: {
                message: "Tarea Creada",
                description: "shown in desktop notification"
            },
            emailSentTo: {
                message: "Correo Electrónico Enviado a",
                description: "shown in desktop notification"
            },
            incoming: {
                message: "ENTRANTE"
            },
            outgoing: {
                message: "SALIENTE"
            },
            incomingCall: {
                message: "LLAMADA ENTRANTE",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            outgoingCall: {
                message: "LLAMADA SALIENTE",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            call: {
                message: "LLAMADA"
            },
            unknownNumber: {
                message: "Número desconocido"
            },
            emailTo: {
                message: "Por email a"
            },
            assignTo: {
                message: "Asigne tareas a"
            },
            queue: {
                message: "Cola"
            },
            hour: {
                message: "hora"
            },
            min: {
                message: "min",
                description: "short for minutes"
            },
            sec: {
                message: "seg",
                description: "short for seconds"
            },
            searchingForActivities: {
                message: "Búsqueda de actividades ...",
                description: "Mensaje de estado de cuadro de actividades, mientras que los programas de actividades traen en curso"
            },
            noActivitiesFound: {
                message: "No hay actividades encontradas",
                description: "Actividades cuadro de mensaje de estado cuando se están encontrando ninguna actividad"
            },
            createNewContact: {
                message: "Crear nuevo contacto",
                description: "Cuando varios contactos muestra coincidente, pero éste no es uno de ellos crear nuevo contacto"
            },
            create: {
                message: "Crear",
                description: "crear"
            },
            save: {
                message: "Guardar",
                description: "guardar"
            },
            noMatchEnterNameHere: {
                message: "Ingresa aquí",
                description: "Cuando hay coincidencia permite al usuario crear contactos"
            },
            noMatchEnterNameHelper: {
                message: "Para acceder a todos los campos que debe crear el registro primero",
                description: "Para acceder a todos los campos que debe crear el registro primero"
            },
            createRecord: {
                message: "Crear ->",
                description: "Para acceder a todos los campos que debe crear el registro primero"
            },
            creatingRecord: {
                message: "Creación de Registro",
                description: "Utilizado como el estado de transición para la creación de registro"
            },
            retrievingRecord: {
                message: "Recuperando Record",
                description: "De diálogo Transición para recuperar un registro"
            },
            savingUpdates: {
                message: "Ahorrar actualizaciones",
                description: "Transición de diálogo para guardar cambios"
            },
            info: {
                message: "Info",
                description: "Info navigation button for different pages on top right"
            },
            dialpad: {
                message: "Teclado",
                description: "Dialpad navigation button for different pages on top right"
            },
            back: {
                message: "Espalda",
                description: "Botón de navegación Teclado telefónico para diferentes páginas en la parte superior derecha"
            },
            disabledDialpad: {
                message: "Dialpad desactivado durante la llamada",
                description: "Dialpad desactivado durante la llamada"
            },
            lead: {
                message: "Lead",
                description: "Lead"
            },
            contact: {
                message: "Contacto",
                description: "Contacto"
            },
            searchingRecords: {
                message: "Buscando Registros ...",
                description: "Buscando Registros ..."
            },
            answeredBy: {
                message: "Respondida por",
                description: "Respondida por"
            },
            loadingHistory: {
                message: "Cargando Historial...",
                description: "Cargando Historial..."
            },
            noInternet: {
                message: "No hay Internet...",
                description: "No hay Internet..."
            },
            showCallinize: {
                message: "Show Popup",
                description: "Show Popup"
            },
            showTour: {
                message: "Show Tour",
                description: "Show Tour"
            },
            settings: {
                message: "Settings",
                description: "Settings"
            },
            allCallHistory: {
                message: "Todo el Historial de llamadas",
                description: "Todo el Historial de llamadas"
            },
            clickToDial: {
                message: "Haga clic para llamar",
                description: "Haga clic para llamar"
            },
            noExtension: {
                message: "No Extensión",
                description: "No Extensión"
            },
            unknownContact: {
                message: "Contacto desconocido",
                description: "Contacto desconocido"
            },
            reportProblemCall: {
                message: "Informe de Incidencia Call",
                description: "Informe de Incidencia Call"
            },
            reload: {
                message: "Actualizar Extensión",
                description: "Actualizar Extensión"
            },
            updateStatusUpToDate: {
                message: "La más nueva versión",
                description: "La más nueva versión"
            },
            updateStatusOldVersion: {
                message: "Versión anterior",
                description: "Versión anterior"
            },
            switchToThisCallAndSaveExistingNotes: {
                message: "Cambie y ahorre",
                description: "Cambie y ahorre"
            },
            ignore: {
                message: "Desatender",
                description: "Desatender"
            },
            extensionConfigurationErrorTitle: {
                message: "No hay extensión configurada",
                description: "No extension configured"
            },
            extensionConfigurationErrorMessage: {
                message: "Para configurar una extensión de ir a <a href='https://dashboard.tenfold.com/profile'>Callinize Dashboard</a> y añadir su extensión telefónica .",
                description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
            },
            microphonePermission: {
                message: "Al empezar esta aplicación es necesario dar permiso para que use el micrófono. Por favor, vaya a la pestaña creada y dar permiso.",
                description: "Ask for microphone permission"
            },
            noLoginTokenTitle: {
                message: "Tenfold desconectó",
                description: ""
            },
            noLoginTokenMessage: {
                message: "Tenfold desconectó <a href='https://dashboard.tenfold.com'>Callinize</a>.  Antes de hacerlo, no recibirá llamadas pop-ups.",
                description: "Message when a user clears there cookie and has nothing in chrome storage"
            },
            enabledRequirementTitle: {
                message: "Tu usuario no está habilitado. Popups de llamadas no funcionará hasta que se habilitó.",
                description: "Message displayed to user when they are not enabled"
            },
            enabledRequirementMessage: {
                message: "Si usted es el administrador de inicio de sesión en <a href='https://dashboard.tenfold.com/users'>Callinize Dashboard</a> y permitir a sí mismo o si usted es un usuario, correo electrónico su administrador y pida que permitirá.",
                description: "Message displayed to user when they are not enabled"
            },
            enterAccountHere: {
                message: "Enter Account Name",
                description: "Enter Account Name Here"
            },
            active: {
                message: "Activo",
                description: "Topbar toggle option to show the active call"
            },
            recent: {
                message: "Reciente",
                description: "Topbar toggle option to show recent calls"
            }
        },
        fr: {
            extName: {
                message: "Callinize",
                description: "extension name -- Do not translate this... this is our company name."
            },
            extDescription: {
                message: "Tenfold fournit l'identification de l'appelant et le GRC avec enregistrement des appels automatique amélioré",
                description: "Shown in chrome://extensions page and maybe in the chrome store -- Translate it to say something like CRM Telephony Integration"
            },
            extShortName: {
                message: "Couplage téléphonie GRC",
                description: "Shown in chrome://extensions page and maybe in the chrome store"
            },
            selectContact: {
                message: "Sélectionner le contact",
                description: "Shown when there are multiple matching contacts"
            },
            matches: {
                message: "Correspondances",
                description: "when there are multiple matches from the crm, this string shows - X matches"
            },
            unknownCaller: {
                message: "Appelant non reconnu",
                description: "Shown where contact name goes when phone number isn't found in CRM"
            },
            unknownNumber: {
                message: "Numéro inconnu",
                description: "Shown when the phoneNumber is empty... this happens in cases like CallerID is blocked"
            },
            addNotes: {
                message: "Cliquer ici pour ajouter des notes",
                description: "placeholder text shown in note input box"
            },
            savedSuccessfully: {
                message: "Sauvegarde effectuée",
                description: "title when call notes are saved"
            },
            outboundCall: {
                message: "Cliquer pour composer le numéro",
                description: "title when call notes are saved"
            },
            callNotesSaved: {
                message: "Notes d'appel sauvegardées",
                description: "shown in desktop notification"
            },
            noteNotSaved: {
                message: "Non sauvegardé",
                description: "title when call notes are not saved"
            },
            noteSaveError: {
                message: "Erreur. Échec de la sauvegarde",
                description: "shown in desktop notification  when notes are saved"
            },
            createRecordErrorTitle: {
                message: "Non créé",
                description: "title when create records are not saved"
            },
            createRecordErrorDescription: {
                message: "Erreur. Échec de l'enregistrement.",
                description: "shown in desktop notification  when records are not created"
            },
            taskCreatedFor: {
                message: "Tâche créée, échéance prévue le : ",
                description: "shown in desktop notification when notes are saved"
            },
            emailSentTo: {
                message: "Email envoyé à : ",
                description: "shown in desktop notification when notes are saved"
            },
            incoming: {
                message: "ENTRANT",
                description: "direction of the call, used in title bar and probably other places"
            },
            outgoing: {
                message: "SORTANT",
                description: "direction of the call, used in title bar and probably other places"
            },
            incomingCall: {
                message: "APPEL ENTRANT",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            outgoingCall: {
                message: "APPEL SORTANT",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            call: {
                message: "APPEL",
                description: "typically combined with incoming/outgoing above in title bar."
            },
            emailTo: {
                message: "Les notes seront envoyées à ",
                description: "help text shown on hover over email indicator"
            },
            createTask: {
                message: "Créer une tâche vous étant destinée pour ",
                description: "help text shown on hover over task indicator"
            },
            queue: {
                message: "Queue",
                description: "Shown on calls to an inbound call queue as a prefix"
            },
            hour: {
                message: "heure"
            },
            min: {
                message: "min",
                description: "short for minutes"
            },
            sec: {
                message: "sec",
                description: "short for seconds"
            },
            searchingForActivities: {
                message: "Recherche des activités...",
                description: "Activities box status message while the activities fetch in progress"
            },
            noActivitiesFound: {
                message: "Pas d'activités trouvées",
                description: "Activities box status message when no activities are being found"
            },
            createNewContact: {
                message: "Créer un nouveau contact",
                description: "When multiple contacts displays matching, but the caller is not one of them create new contact"
            },
            create: {
                message: "Créer",
                description: "create"
            },
            save: {
                message: "Enregistrer",
                description: "save"
            },
            noMatchEnterNameHere: {
                message: "Entrer le nom",
                description: "When no match allow user to create contact"
            },
            associateToExisting: {
                message: "Associer à un enregistrement existant",
                description: "Associate to existing record"
            },
            noMatchEnterNameHelper: {
                message: "Vous devez créer l'enregistrement avant de pouvoir accéder à tous les champs",
                description: "To access all fields you must create the record first"
            },
            createRecord: {
                message: "Créer ->",
                description: "To access all fields you must create the record first"
            },
            creatingRecord: {
                message: "Création de l'enregistrement",
                description: "Transition dialog for creating a record"
            },
            retrievingRecord: {
                message: "Récupération de l'enregistrement",
                description: "Transition dialog for retrieving a record"
            },
            savingUpdates: {
                message: "Sauvegarde des mises à jour",
                description: "Transition dialog for saving updates"
            },
            info: {
                message: "Info",
                description: "Info navigation button for different pages on top right"
            },
            dialpad: {
                message: "Pavé numérique",
                description: "Dialpad navigation button for different pages on top right"
            },
            back: {
                message: "Retour",
                description: "Back"
            },
            disabledDialpad: {
                message: "Pavé numérique désactivé pendant l'appel",
                description: "Dialpad disabled during call"
            },
            lead: {
                message: "Cible",
                description: "Lead"
            },
            contact: {
                message: "Contact",
                description: "Contact"
            },
            cancel: {
                message: "Effacer",
                description: "Cancel"
            },
            searchingRecords: {
                message: "Recherche des enregistrements...",
                description: "Searching Records..."
            },
            noMatchTitle: {
                message: "Aucune correspondance",
                description: "Displayed when no matching record is found in CRM"
            },
            createRecordType: {
                message: "Sélectionner le type d'enregistrement",
                description: "Create record type?"
            },
            name: {
                message: "Nom",
                description: "Name"
            },
            answeredBy: {
                message: "Répondu par",
                description: "Answered by"
            },
            calledBy: {
                message: "Appelé par",
                description: "Called by"
            },
            assignedTo: {
                message: "Assigné à",
                description: "Assigned to"
            },
            createdBy: {
                message: "Créé par",
                description: "'Created by' as in the call was 'Created By: John'"
            },
            loadingHistory: {
                message: "Chargement de l'historique...",
                description: "Loading History..."
            },
            noInternet: {
                message: "Pas d'internet...",
                description: "No internet..."
            },
            showCallinize: {
                message: "Afficher le popup",
                description: "Show Popup"
            },
            showTour: {
                message: "Guide d'utilisation",
                description: "Show Tour"
            },
            settings: {
                message: "Paramètres",
                description: "Settings"
            },
            allCallHistory: {
                message: "Tout l'historique des appels",
                description: "All Call History"
            },
            clickToDial: {
                message: "Cliquer pour composer",
                description: "Click to dial"
            },
            noExtension: {
                message: "Pas d'extension",
                description: "No Extension"
            },
            unknownContact: {
                message: "Contact inconnu",
                description: "Shown for unknown contacts in history view"
            },
            reportProblemCall: {
                message: "Reporter un problème d'appel",
                description: "Report Problem Call"
            },
            reload: {
                message: "Recharger l'extension",
                description: "Reload Extension"
            },
            updateStatusUpToDate: {
                message: "Dernière version",
                description: "Newest Version"
            },
            updateStatusOldVersion: {
                message: "Ancienne version",
                description: "Old Version"
            },
            switchToThisCallAndSaveExistingNotes: {
                message: "Changer et enregistrer",
                description: "Displayed to the user when a new call comes in while old call is active"
            },
            ignore: {
                message: "Ignorer",
                description: "Ignore"
            },
            extensionConfigurationErrorTitle: {
                message: "Pas d'extension configurée",
                description: "No extension configured"
            },
            extensionConfigurationErrorMessage: {
                message: "Pour configurer une extension aller à  <a href='https://dashboard.tenfold.com/profile'>Callinize Dashboard</a> and add your phone extension.",
                description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
            },
            microphonePermission: {
                message: "Lorsque vous utilisez cette application pour la première fois vous devez l'autoriser à utiliser le microphone.  Allez sur l'onglez créé et autorisez l'application.",
                description: "Ask for microphone permission"
            },
            cleanupMessage: {
                message: "Callinize: Chrome ne nous permet pas de recharger automatiquement la page nouvel onglet de Chrome lorsque les mises à jour sont en cours.  Votre popup ne fonctionnera pas correctement tant que la page ne sera pas rafraîchie.  Si vous avez des notes sur cette page, copiez-les maintenant.",
                description: "Callinize: chrome does not allow us to automatically reload the chrome newtab page when updates occur.  Until this page refreshes your popup will not work correctly.  If you have notes on this page, please copy them now."
            },
            noLoginTokenTitle: {
                message: "Tenfold déconnecté",
                description: ""
            },
            noLoginTokenMessage: {
                message: "Connectez vous à <a href='https://dashboard.tenfold.com'>Callinize</a>. Avant cela, vous ne recevrez pas les popups d'appel.",
                description: "Message when a user clears there cookie and has nothing in chrome storage"
            },
            enabledRequirementTitle: {
                message: "Vous n'êtes pas habilité pour le moment.  Les popups d'appel ne fonctionneront pas tant que vous ne serez pas habilité.",
                description: "Message displayed to user when they are not enabled"
            },
            enabledRequirementMessage: {
                message: "Si vous êtes l'administrateur, connectez vous à <a href='https://dashboard.tenfold.com/users'>Callinize Dashboard</a> et habilitez vous ou si vous êtes un utilisateur, envoyez un email à votre admin pour lui demander de vous habiliter",
                description: "Message displayed to user when they are not enabled"
            },
            enterAccountHere: {
                message: "Entrer le nom du compte",
                description: "Enter Account Name Here"
            },
            searchOrCreateNew: {
                message: "Rechercher ou Créer un nouvel utilisateur",
                description: "Search for a user not listed here or create new user."
            },
            opportunities: {
                message: "Opportunités",
                description: "Opportunities title"
            },
            opportunityRelateButBlocked: {
                message: "Une opportunité est liée à cet appel",
                description: "Text shown besides priority in activity's case number"
            },
            errorSearchingActivities: {
                message: "Pas de réponse de l'API. Contactez votre admin ou",
                description: "Activities box status message while the activities fetch in progress"
            },
            waitForDispositions: {
                message: "Recherche d'arrangements...",
                description: "Dispositions box status message while the Dispositions fetch in progress"
            },
            waitForResources: {
                message: "Recherche de ressources...",
                description: "Resources box status message while the resources fetch in progress"
            },
            createNew: {
                message: "Créer nouveau",
                description: "create"
            },
            refreshResources: {
                message: "Importer les ressources que vous avez crées dans le GRC",
                description: "Fetch resources that you just created in the CRM"
            },
            amount: {
                message: "Montant : ",
                description: "amount"
            },
            probability: {
                message: "Probabilité : ",
                description: "probability"
            },
            noDispositions: {
                message: "Pas d'arrangements pour cet enregistrement",
                description: "save"
            },
            login: {
                message: "Connexion",
                description: "Message when a user clears there cookie and has nothing in chrome storage"
            },
            created: {
                message: "crée",
                description: "Text shown besides priority in activity's cases"
            },
            case: {
                message: "Cas",
                description: "Text shown besides priority in activity's case number"
            },
            caseRelateButBlocked: {
                message: "Un cas est lié  cet appel",
                description: "Text shown besides priority in activity's case number"
            },
            cases: {
                message: "Cas",
                description: "Text shown besides priority in activity's case number"
            },
            relateResource: {
                message: "Lier / Ressource",
                description: "Text shown besides priority in activity's case number"
            },
            orCreateNew: {
                message: "Ou, créer nouveau...",
                description: "Single match create buttons"
            },
            emailTemplate: {
                message: "Modèles d'emails",
                description: "Email Templates button text"
            },
            notConnected: {
                message: "Vous n'êtes pas connecté à internet. Vérifiez vos paramètres réseau.",
                description: "You are not connected to the internet. Please check your network settings."
            },
            filterResults: {
                message: "Filtrer les résultats",
                description: "Multi-match filter input placeholder"
            },
            active: {
                message: "Actif",
                description: "Topbar toggle option to show the active call"
            },
            recent: {
                message: "Récent",
                description: "Topbar toggle option to show recent calls"
            }
        },
        it: {
            extName: {
                message: "Callinize",
                description: "extension name -- Do not translate this... this is our company name."
            },
            extDescription: {
                message: "Tenfold Integrazione avanzata tra CRM e Telefonia con Log Automatico delle Chiamate",
                description: "Shown in chrome://extensions page and maybe in the chrome store -- Translate it to say something like CRM Telephony Integration"
            },
            extShortName: {
                message: "Integrazione tra Telefonia e CRM",
                description: "Shown in chrome://extensions page and maybe in the chrome store"
            },
            selectContact: {
                message: "Scegli il contatto",
                description: "Shown when there are multiple matching contacts"
            },
            matches: {
                message: "Corrispondenze",
                description: "when there are multiple matches from the crm, this string shows - X matches"
            },
            unknownCaller: {
                message: "Chiamante non riconosciuto",
                description: "Shown where contact name goes when phone number isn't found in CRM"
            },
            unknownNumber: {
                message: "Numero sconosciuto",
                description: "Shown when the phoneNumber is empty... this happens in cases like CallerID is blocked"
            },
            addNotes: {
                message: "Click per aggiungere note",
                description: "placeholder text shown in note input box"
            },
            savedSuccessfully: {
                message: "Note salvate con successo",
                description: "title when call notes are saved"
            },
            outboundCall: {
                message: "Click per chiamare",
                description: "title when call notes are saved"
            },
            callNotesSaved: {
                message: "Note chiamata salvate",
                description: "shown in desktop notification"
            },
            noteNotSaved: {
                message: "Note non salvate",
                description: "title when call notes are not saved"
            },
            noteSaveError: {
                message: "Errore. Impossibile salvare le Note",
                description: "shown in desktop notification  when notes are saved"
            },
            createRecordErrorTitle: {
                message: "Record non creato",
                description: "title when create records are not saved"
            },
            createRecordErrorDescription: {
                message: "Errore. Impossibile creare il Record.",
                description: "shown in desktop notification  when records are not created"
            },
            taskCreatedFor: {
                message: "Task creato con scadenza il: ",
                description: "shown in desktop notification when notes are saved"
            },
            emailSentTo: {
                message: "Email inviata a: ",
                description: "shown in desktop notification when notes are saved"
            },
            incoming: {
                message: "IN ARRIVO",
                description: "direction of the call, used in title bar and probably other places"
            },
            outgoing: {
                message: "IN USCITA",
                description: "direction of the call, used in title bar and probably other places"
            },
            incomingCall: {
                message: "CHIAMATA IN INGRESSO",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            outgoingCall: {
                message: "CHIAMATA IN USCITA",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            call: {
                message: "CHIAMATA",
                description: "typically combined with incoming/outgoing above in title bar."
            },
            emailTo: {
                message: "Le note saranno inviate per email a ",
                description: "help text shown on hover over email indicator"
            },
            createTask: {
                message: "Creo task assegnato a te per ",
                description: "help text shown on hover over task indicator"
            },
            queue: {
                message: "Coda",
                description: "Shown on calls to an inbound call queue as a prefix"
            },
            hour: {
                message: "ora"
            },
            min: {
                message: "min",
                description: "short for minutes"
            },
            sec: {
                message: "sec",
                description: "short for seconds"
            },
            searchingForActivities: {
                message: "Ricerca attività...",
                description: "Activities box status message while the activities fetch in progress"
            },
            noActivitiesFound: {
                message: "Nessuna attività trovata",
                description: "Activities box status message when no activities are being found"
            },
            createNewContact: {
                message: "Crea Nuovo contatto",
                description: "When multiple contacts displays matching, but the caller is not one of them create new contact"
            },
            create: {
                message: "Crea",
                description: "create"
            },
            save: {
                message: "Salva",
                description: "save"
            },
            noMatchEnterNameHere: {
                message: "Inserisci il nome ",
                description: "When no match allow user to create contact"
            },
            noMatchEnterNameHelper: {
                message: "Per accedere a tutti i campi occorre prima un nuovo record",
                description: "To access all fields you must create the record first"
            },
            createRecord: {
                message: "Crea ->",
                description: "To access all fields you must create the record first"
            },
            creatingRecord: {
                message: "Creazione Record",
                description: "Transition dialog for creating a record"
            },
            retrievingRecord: {
                message: "Recupero del Record",
                description: "Transition dialog for retrieving a record"
            },
            savingUpdates: {
                message: "Salvataggio Modifiche ",
                description: "Transition dialog for saving updates"
            },
            info: {
                message: "Info",
                description: "Info navigation button for different pages on top right"
            },
            dialpad: {
                message: "Tastierino numerico",
                description: "Dialpad navigation button for different pages on top right"
            },
            back: {
                message: "Indietro",
                description: "Back"
            },
            disabledDialpad: {
                message: "Tastierino disabilitato durante la chiamata",
                description: "Dialpad disabled during call"
            },
            lead: {
                message: "Lead",
                description: "Lead"
            },
            contact: {
                message: "Contatto",
                description: "Contact"
            },
            cancel: {
                message: "Cancella",
                description: "Cancel"
            },
            searchingRecords: {
                message: "Ricerca Records...",
                description: "Searching Records..."
            },
            noMatchTitle: {
                message: "Nessuna corrispondenza Trovata",
                description: "Displayed when no matching record is found in CRM"
            },
            createRecordType: {
                message: "Scegli il tipo di record da creare",
                description: "Create record type?"
            },
            name: {
                message: "Nome",
                description: "Name"
            },
            answeredBy: {
                message: "Risposta da",
                description: "Answered by"
            },
            loadingHistory: {
                message: "Caricamento cronologia...",
                description: "Loading History..."
            },
            noInternet: {
                message: "No internet...",
                description: "No internet..."
            },
            showCallinize: {
                message: "Mostra Popup",
                description: "Show Popup"
            },
            showTour: {
                message: "Mostra Tour",
                description: "Show Tour"
            },
            settings: {
                message: "Impostazioni",
                description: "Settings"
            },
            allCallHistory: {
                message: "Cronologia di tutte le chiamate",
                description: "All Call History"
            },
            clickToDial: {
                message: "Click per comporre",
                description: "Click to dial"
            },
            noExtension: {
                message: "Nessun Interno",
                description: "No Extension"
            },
            unknownContact: {
                message: "Contatto sconosciuto",
                description: "Shown for unknown contacts in history view"
            },
            reportProblemCall: {
                message: "Report Problem Call",
                description: "Report Problem Call"
            },
            reload: {
                message: "Ricarica Interno",
                description: "Reload Extension"
            },
            updateStatusUpToDate: {
                message: "Versione più recente",
                description: "Newest Version"
            },
            updateStatusOldVersion: {
                message: "Vecchia versione",
                description: "Old Version"
            },
            switchToThisCallAndSaveExistingNotes: {
                message: "Commuta & Salva",
                description: "Displayed to the user when a new call comes in while old call is active"
            },
            ignore: {
                message: "Ignora",
                description: "Ignore"
            },
            extensionConfigurationErrorTitle: {
                message: "Nessun interno configurato",
                description: "No extension configured"
            },
            extensionConfigurationErrorMessage: {
                message: "Per configurare un interno vai su <a href='https://dashboard.tenfold.com/profile'>Callinize Dashboard</a> and add your phone extension.",
                description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
            },
            microphonePermission: {
                message: "Quando attivi l'applicazione devi permettere accesso al microfono. Seleziona il tab creato e concedi permesso.",
                description: "Ask for microphone permission"
            },
            cleanupMessage: {
                message: "Callinize: Chrome non permette di ricaricare automaticamente la pagina  quando si aggiorna.  Fino a quando la pagina si aggiornerà il popup non funzionerà correttamente.  Se ci sono note su questa pagina, copiale ora.",
                description: "Callinize: chrome does not allow us to automatically reload the chrome newtab page when updates occur.  Until this page refreshes your popup will not work correctly.  If you have notes on this page, please copy them now."
            },
            noLoginTokenTitle: {
                message: "Tenfold desconectó",
                description: ""
            },
            noLoginTokenMessage: {
                message: "Effettua l'accesso alle <a href='https://dashboard.tenfold.com'>Callinize</a>. Prima di farlo , non riceverai popup di chiamata.",
                description: "Message when a user clears there cookie and has nothing in chrome storage"
            },
            enabledRequirementTitle: {
                message: "Il tuo utente non è abilitato. Popup di chiamata non funzioneranno fino a quando non sono abilitati.",
                description: "Message displayed to user when they are not enabled"
            },
            enabledRequirementMessage: {
                message: "Se siete il logon a <a href='https://dashboard.tenfold.com/users'>Callinize Dashboard</a> e attivare voi stessi o se sei un utente, e-mail l'amministratore e chiedere loro di consentire.",
                description: "Message displayed to user when they are not enabled"
            },
            enterAccountHere: {
                message: "Enter Account Name",
                description: "Enter Account Name Here"
            },
            active: {
                message: "Attivo",
                description: "Topbar toggle option to show the active call"
            },
            recent: {
                message: "Recente",
                description: "Topbar toggle option to show recent calls"
            }
        },
        nl: {
            extName: {
                message: "Callinize",
                description: "extension name -- Do not translate this... this is our company name."
            },
            extDescription: {
                message: "Tenfold Enhanced CallerID & Automatic CRM Call Logging",
                description: "Shown in chrome://extensions page and maybe in the chrome store -- Translate it to say something like CRM Telephony Integration"
            },
            extShortName: {
                message: "CRM Telephonie Integratie",
                description: "Shown in chrome://extensions page and maybe in the chrome store"
            },
            selectContact: {
                message: "Selecteer contactpersoon",
                description: "Shown when there are multiple matching contacts"
            },
            matches: {
                message: "Overeenkomsten",
                description: "when there are multiple matches from the crm, this string shows - X matches"
            },
            unknownCaller: {
                message: "Onbekende beller",
                description: "Shown where contact name goes when phone number isn't found in CRM"
            },
            unknownNumber: {
                message: "Onbekend nummer",
                description: "Shown when the phoneNumber is empty... this happens in cases like CallerID is blocked"
            },
            addNotes: {
                message: "Klik hier om notities toe te voegen",
                description: "placeholder text shown in note input box"
            },
            savedSuccessfully: {
                message: "Succesvol opgeslagen",
                description: "title when call notes are saved"
            },
            callNotesSaved: {
                message: "Gespreksnotities opgeslagen",
                description: "shown in desktop notification"
            },
            noteNotSaved: {
                message: "Not Saved",
                description: "title when call notes are not saved"
            },
            noteSaveError: {
                message: "Error: Failed to save the Note",
                description: "shown in desktop notification"
            },
            createRecordErrorTitle: {
                message: "Niet Gemaakt",
                description: "title when create records are not saved"
            },
            createRecordErrorDescription: {
                message: "Fout: Mislukt om het record te creëren.",
                description: "shown in desktop notification  when records are not created"
            },
            taskCreatedFor: {
                message: "Taak aangemaakt met opleverdatum van: ",
                description: "shown in desktop notification"
            },
            emailSentTo: {
                message: "Email Verzonden Aan: ",
                description: "shown in desktop notification"
            },
            incoming: {
                message: "INKOMEND",
                description: "direction of the call, used in title bar and probably other places"
            },
            outgoing: {
                message: "UITGAAND",
                description: "direction of the call, used in title bar and probably other places"
            },
            incomingCall: {
                message: "INKOMEND GESPREK",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            outgoingCall: {
                message: "UITGAAND GESPREK",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            call: {
                message: "GESPREK",
                description: "typically combined with incoming/outgoing above in title bar."
            },
            emailTo: {
                message: "Notities worden verzonden naar",
                description: "help text shown on hover over email indicator"
            },
            createTask: {
                message: "Taak wordt voor u aangemaakt voor",
                description: "help text shown on hover over task indicator"
            },
            queue: {
                message: "Wachtrij",
                description: "Shown on calls to an inbound call queue as a prefix"
            },
            hour: {
                message: "uur"
            },
            min: {
                message: "min",
                description: "short for minutes"
            },
            sec: {
                message: "sec",
                description: "short for seconds"
            },
            searchingForActivities: {
                message: "Zoeken naar activiteiten ...",
                description: "Activiteiten doos statusbericht terwijl de actviteiten te halen in progress"
            },
            noActivitiesFound: {
                message: "Geen activiteiten gevonden",
                description: "Activiteiten box statusbericht wanneer er geen activiteiten worden gevonden"
            },
            createNewContact: {
                message: "Nieuwe contactpersoon maken",
                description: "Wanneer meerdere contactpersonen weergeeft matching, maar de beller is niet een van hen nieuwe contactpunten"
            },
            create: {
                message: "Creëren",
                description: "creëren"
            },
            save: {
                message: "Besparen",
                description: "besparen"
            },
            noMatchEnterNameHere: {
                message: "Vul hier de naam",
                description: "Als er geen match zodat de gebruiker contact te maken"
            },
            noMatchEnterNameHelper: {
                message: "Om alle velden die u moet het record eerst creëren",
                description: "Om alle velden die u moet het record eerst creëren"
            },
            createRecord: {
                message: "Creëren ->",
                description: "To access all fields you must create the record first"
            },
            creatingRecord: {
                message: "Het creëren van Record",
                description: "Utilizado como el estado de transición para la creación de registro"
            },
            retrievingRecord: {
                message: "Record Opgehaald",
                description: "Dialoog Transition voor het ophalen van een record"
            },
            savingUpdates: {
                message: "Besparing Updates",
                description: "Dialoog Transition voor het opslaan van updates"
            },
            info: {
                message: "Info",
                description: "Info navigation button for different pages on top right"
            },
            dialpad: {
                message: "Dialpad",
                description: "Dialpad navigation button for different pages on top right"
            },
            back: {
                message: "Terug",
                description: "Terug"
            },
            dialpadDisabled: {
                message: "Toetsenblok uitgeschakeld tijdens een gesprek",
                description: "Toetsenblok uitgeschakeld tijdens een gesprek"
            },
            lead: {
                message: "Lead",
                description: "Lead"
            },
            contact: {
                message: "Contact",
                description: "Contact"
            },
            searchingRecords: {
                message: "Zoeken Records ....",
                description: "Zoeken Records ..."
            },
            answeredBy: {
                message: "Beantwoord door",
                description: "Beantwoord door"
            },
            loadingHistory: {
                message: "laden van historie...",
                description: "laden van historie..."
            },
            noInternet: {
                message: "geen internet...",
                description: "geen internet..."
            },
            showCallinize: {
                message: "Toon Popup",
                description: "Toon Popup"
            },
            showTour: {
                message: "Toon Tour",
                description: "Toon Tour"
            },
            settings: {
                message: "Settings",
                description: "Settings"
            },
            allCallHistory: {
                message: "Alle Oproepen",
                description: "Alle Oproepen"
            },
            clickToDial: {
                message: "Klik om te bellen",
                description: "Klik om te bellen"
            },
            noExtension: {
                message: "geen Uitbreiding",
                description: "geen Uitbreiding"
            },
            unknownContact: {
                message: "Neem contact op",
                description: "Neem contact op"
            },
            reportProblemCall: {
                message: "Probleem Melden Call",
                description: "Probleem Melden Call"
            },
            reload: {
                message: "Reload Extension",
                description: "Reload Extension"
            },
            updateStatusUpToDate: {
                message: "De nieuwste versie",
                description: "De nieuwste versie"
            },
            updateStatusOldVersion: {
                message: "oude versie",
                description: "oude versie"
            },
            switchToThisCallAndSaveExistingNotes: {
                message: "Switch & Save",
                description: "Switch & Save"
            },
            ignore: {
                message: "Negeren",
                description: "Negeren"
            },
            extensionConfigurationErrorTitle: {
                message: "Geen uitbreiding geconfigureerd",
                description: "No extension configured"
            },
            extensionConfigurationErrorMessage: {
                message: "Voor het configureren van een uitbreiding naar<a href='https://dashboard.tenfold.com/profile'>Callinize Dashboard</a> en voeg uw toestelnummer .",
                description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
            },
            microphonePermission: {
                message: "Wanneer u voor het eerst deze toepassing te starten , moet je toestemming voor geven om je microfoon te gebruiken . Ga dan naar het tabblad gemaakt en toestemming te geven .",
                description: "Ask for microphone permission"
            },
            noLoginTokenTitle: {
                message: "Tenfold uitgelogd",
                description: ""
            },
            noLoginTokenMessage: {
                message: "Log dan in op <a href='https://dashboard.tenfold.com'>Callinize</a>.  Voordat je dat doet , zult u geen oproep popups ontvangen.",
                description: "Message when a user clears there cookie and has nothing in chrome storage"
            },
            enabledRequirementTitle: {
                message: "Uw gebruikersnaam is niet ingeschakeld. Call popups zal niet werken totdat u zijn ingeschakeld.",
                description: "Message displayed to user when they are not enabled"
            },
            enabledRequirementMessage: {
                message: "Als u de admin login op <a href='https://dashboard.tenfold.com/users'>Callinize Dashboard</a> en in staat stellen zelf of als je een gebruiker bent, mail je admin en vraag hen om u in staat",
                description: "Message displayed to user when they are not enabled"
            },
            enterAccountHere: {
                message: "Enter Account Name",
                description: "Enter Account Name Here"
            },
            active: {
                message: "Actief",
                description: "Topbar toggle option to show the active call"
            },
            recent: {
                message: "Recent",
                description: "Topbar toggle option to show recent calls"
            }
        },
        pl: {
            extName: {
                message: "Callinize",
                description: "extension name -- Do not translate this... this is our company name."
            },
            extDescription: {
                message: "Tenfold integracja telefonii z CRM",
                description: "Shown in chrome://extensions page and maybe in the chrome store -- Translate it to say something like CRM Telephony Integration"
            },
            extShortName: {
                message: "Integracja telefonii z CRM",
                description: "Shown in chrome://extensions page and maybe in the chrome store"
            },
            selectContact: {
                message: "Wybierz kontakt",
                description: "Shown when there are multiple matching contacts"
            },
            matches: {
                message: "pokrywa się",
                description: "when there are multiple matches from the crm, this string shows - X matches"
            },
            unknownCaller: {
                message: "Nierozpoznany rozmówca",
                description: "Shown where contact name goes when phone number isn't found in CRM"
            },
            unknownNumber: {
                message: "Nieznany numer",
                description: "Shown when the phoneNumber is empty... this happens in cases like CallerID is blocked"
            },
            addNotes: {
                message: "Kliknij aby dodać notatkę",
                description: "placeholder text shown in note input box"
            },
            savedSuccessfully: {
                message: "Zapisano",
                description: "title when call notes are saved"
            },
            outboundCall: {
                message: "Kliknij aby zadzwonić",
                description: "title when call notes are saved"
            },
            callNotesSaved: {
                message: "Zapisano notatkę z rozmowy",
                description: "shown in desktop notification"
            },
            noteNotSaved: {
                message: "Nie zapisano",
                description: "title when call notes are not saved"
            },
            noteSaveError: {
                message: "Błąd. Nie zapisano notatki.",
                description: "shown in desktop notification  when notes are saved"
            },
            createRecordErrorTitle: {
                message: "Nie utworzono",
                description: "title when create records are not saved"
            },
            createRecordErrorDescription: {
                message: "Błąd. Nie udało się utworzyć rekord.",
                description: "shown in desktop notification  when records are not created"
            },
            taskCreatedFor: {
                message: "Zadanie zapisano z datą: ",
                description: "shown in desktop notification when notes are saved"
            },
            emailSentTo: {
                message: "Wiadomość wysłana do: ",
                description: "shown in desktop notification when notes are saved"
            },
            incoming: {
                message: "PRZYCHODZĄCA",
                description: "direction of the call, used in title bar and probably other places"
            },
            outgoing: {
                message: "WYCHODZĄCA",
                description: "direction of the call, used in title bar and probably other places"
            },
            incomingCall: {
                message: "ROZMOWA PRZYCHODZĄCA",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            outgoingCall: {
                message: "ROZMOWA WYCHODZĄCA",
                description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
            },
            call: {
                message: "ROZMOWA",
                description: "typically combined with incoming/outgoing above in title bar."
            },
            emailTo: {
                message: "Notatka zostanie wysłana do ",
                description: "help text shown on hover over email indicator"
            },
            createTask: {
                message: "Tworzenie zadania przypisanego do Ciebie ",
                description: "help text shown on hover over task indicator"
            },
            queue: {
                message: "Kolejka",
                description: "Shown on calls to an inbound call queue as a prefix"
            },
            hour: {
                message: "godz"
            },
            min: {
                message: "min",
                description: "short for minutes"
            },
            sec: {
                message: "sek",
                description: "short for seconds"
            },
            searchingForActivities: {
                message: "Szukam...",
                description: "Activities box status message while the activities fetch in progress"
            },
            noActivitiesFound: {
                message: "Nie znaleziono",
                description: "Activities box status message when no activities are being found"
            },
            createNewContact: {
                message: "Utwórz nowy kontakt",
                description: "When multiple contacts displays matching, but the caller is not one of them create new contact"
            },
            create: {
                message: "Utwórz",
                description: "create"
            },
            save: {
                message: "Zapisz",
                description: "save"
            },
            noMatchEnterNameHere: {
                message: "Podaj imię",
                description: "When no match allow user to create contact"
            },
            noMatchEnterNameHelper: {
                message: "Aby uzyskać dostęp do wszystkich pól, najpierw utwórz rekord",
                description: "To access all fields you must create the record first"
            },
            createRecord: {
                message: "Utwórz ->",
                description: "To access all fields you must create the record first"
            },
            creatingRecord: {
                message: "Tworzę rekord",
                description: "Transition dialog for creating a record"
            },
            retrievingRecord: {
                message: "Pobieram rekord",
                description: "Transition dialog for retrieving a record"
            },
            savingUpdates: {
                message: "Zapisuję aktualizację",
                description: "Transition dialog for saving updates"
            },
            info: {
                message: "Info",
                description: "Info navigation button for different pages on top right"
            },
            dialpad: {
                message: "Klawiatura",
                description: "Dialpad navigation button for different pages on top right"
            },
            back: {
                message: "Wstecz",
                description: "Back"
            },
            disabledDialpad: {
                message: "Klawiatura wyłączona podczas rozmowy",
                description: "Dialpad disabled during call"
            },
            lead: {
                message: "Sprawa",
                description: "Lead"
            },
            contact: {
                message: "Kontakt",
                description: "Contact"
            },
            cancel: {
                message: "Anuluj",
                description: "Cancel"
            },
            searchingRecords: {
                message: "Szukam rekordów...",
                description: "Searching Records..."
            },
            noMatchTitle: {
                message: "Nie znaleziono",
                description: "Displayed when no matching record is found in CRM"
            },
            createRecordType: {
                message: "Wybierz typ rekordu",
                description: "Create record type?"
            },
            name: {
                message: "Imię",
                description: "Name"
            },
            answeredBy: {
                message: "Odebrane przez",
                description: "Answered by"
            },
            calledBy: {
                message: "Dzwoniący przez",
                description: "Called by"
            },
            assignedTo: {
                message: "Przypisane do",
                description: "Assigned to"
            },
            createdBy: {
                message: "Utworzone przez",
                description: "'Created by' as in the call was 'Created By: John'"
            },
            loadingHistory: {
                message: "Wczytuję historię...",
                description: "Loading History..."
            },
            noInternet: {
                message: "Brak sieci internet...",
                description: "No internet..."
            },
            showCallinize: {
                message: "Pokaż Popup",
                description: "Show Popup"
            },
            showTour: {
                message: "Pokaż objaśnienia",
                description: "Show Tour"
            },
            settings: {
                message: "Ustawienia",
                description: "Settings"
            },
            allCallHistory: {
                message: "Historia wszystkich rozmów",
                description: "All Call History"
            },
            clickToDial: {
                message: "Kliknij aby zadzwonić",
                description: "Click to dial"
            },
            noExtension: {
                message: "Brak Extension",
                description: "No Extension"
            },
            unknownContact: {
                message: "Nieznany kontakt",
                description: "Shown for unknown contacts in history view"
            },
            reportProblemCall: {
                message: "Zgłoś problem",
                description: "Report Problem Call"
            },
            reload: {
                message: "Przeładuj Extension",
                description: "Reload Extension"
            },
            updateStatusUpToDate: {
                message: "Nowsza wersja",
                description: "Newest Version"
            },
            updateStatusOldVersion: {
                message: "Stara wersja",
                description: "Old Version"
            },
            switchToThisCallAndSaveExistingNotes: {
                message: "Przełącz i zapisz",
                description: "Displayed to the user when a new call comes in while old call is active"
            },
            ignore: {
                message: "Ignoruj",
                description: "Ignore"
            },
            extensionConfigurationErrorTitle: {
                message: "Przedłużenie skonfigurowany",
                description: "No extension configured"
            },
            extensionConfigurationErrorMessage: {
                message: "Aby skonfigurowaćrozszerzenie go do <a href='https://dashboard.tenfold.com/profile'>Callinize Dashboard</a> i dodaj rozszerzenie telefonu .",
                description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
            },
            microphonePermission: {
                message: "When you first start this application you must give permission for it to use your microphone.  Please go to the tab created and give permission.",
                description: "Ask for microphone permission"
            },
            noLoginTokenTitle: {
                message: "Tenfold wylogowany",
                description: ""
            },
            noLoginTokenMessage: {
                message: "Zaloguj się na <a href='https://dashboard.tenfold.com'>Callinize</a>.  Zanim to zrobisz , nie będziesz otrzymywać wyskakujące okienka połączeń.",
                description: "Message when a user clears there cookie and has nothing in chrome storage"
            },
            enabledRequirementTitle: {
                message: "Twój użytkownik nie jest aktywny. Wyskakujące okienka połączeń nie będzie działać, dopóki nie zostaną włączone.",
                description: "Message displayed to user when they are not enabled"
            },
            enabledRequirementMessage: {
                message: "Jeśli jesteś logowanie administratora w <a href='https://dashboard.tenfold.com/users'>Callinize Dashboard</a> i włączyć się lub jeżeli jesteś użytkownikiem, napisz z administratorem i poproś, aby umożliwić Ci.",
                description: "Message displayed to user when they are not enabled"
            },
            enterAccountHere: {
                message: "Enter Account Name",
                description: "Enter Account Name Here"
            },
            active: {
                message: "Aktywny",
                description: "Topbar toggle option to show the active call"
            },
            recent: {
                message: "Niedawny",
                description: "Topbar toggle option to show recent calls"
            }
        }
    };
}

function NLPDate(localeCode) {
    this.localeCode = localeCode, this.verbs = [ "Follow Up", "Folow Up", "follow-up", "folow-up", "Follow through", "Follow through", "Followup", "Folowup", "FU w/", "FU", "FUP", "fup", "Callback", "Call back", "Call", "CB", "Task", "Remind me to call ", "Remind me", "Remind", "Retry", "Try Again", "Set Appointment", "llamar", "dar seguimiento", "Junta de Seguimiento", "seguimiento", "Seguire", "controllare", "Dare seguito", "Richiamare", "Richiamare", "Chiamare", "CB", "Compito", "Ricordami di chiamare", "Ricordamelo", "Ricorda", "Riprovare", "provare di nuovo", "chiamare", "dar seguimiento", "gesprek", "apeller", "apelle", "Erinnere mich", "erinnere mich", "Ruf", "ruf", "Ruf am", "ruf am", "Wiedervorlage", "wiedervorlage", "wvl", "WVL" ], 
    this.daysOfTheWeek = [ {
        phrase: " monday ",
        replace: new Date(getNextDayOfWeek(1))
    }, {
        phrase: " tuesday ",
        replace: new Date(getNextDayOfWeek(2))
    }, {
        phrase: " wednesday ",
        replace: new Date(getNextDayOfWeek(3))
    }, {
        phrase: " thursday ",
        replace: new Date(getNextDayOfWeek(4))
    }, {
        phrase: " friday ",
        replace: new Date(getNextDayOfWeek(5))
    }, {
        phrase: " saturday ",
        replace: new Date(getNextDayOfWeek(6))
    }, {
        phrase: " sunday ",
        replace: new Date(getNextDayOfWeek(0))
    }, {
        phrase: " montag ",
        replace: new Date(getNextDayOfWeek(1))
    }, {
        phrase: " dienstag ",
        replace: new Date(getNextDayOfWeek(2))
    }, {
        phrase: " mittwoch ",
        replace: new Date(getNextDayOfWeek(3))
    }, {
        phrase: " donnerstag",
        replace: new Date(getNextDayOfWeek(4))
    }, {
        phrase: " freitag ",
        replace: new Date(getNextDayOfWeek(5))
    }, {
        phrase: " samstag ",
        replace: new Date(getNextDayOfWeek(6))
    }, {
        phrase: " sonntag ",
        replace: new Date(getNextDayOfWeek(0))
    } ], this.replacements = [ {
        phrase: " in an ",
        replace: " in 1 "
    }, {
        phrase: " in einer ",
        replace: " in 1 "
    }, {
        phrase: " in 2",
        replace: " in two"
    }, {
        phrase: " in a ",
        replace: " in 1 "
    }, {
        phrase: "(in\\s+)?(a\\s+)?half hour",
        replace: "in 30 minutes"
    }, {
        phrase: " on ",
        replace: " "
    }, {
        phrase: " call ",
        replace: " "
    }, {
        phrase: " morning ",
        replace: " 9am "
    }, {
        phrase: " afternoon ",
        replace: " 1pm "
    }, {
        phrase: " around noon ",
        replace: " 12pm "
    }, {
        phrase: " after lunch ",
        replace: " 12pm "
    }, {
        phrase: "before C\\.?O\\.?B",
        replace: "4:30pm"
    }, {
        phrase: "before COB",
        replace: "4:30pm"
    }, {
        phrase: " around ",
        replace: " "
    }, {
        phrase: "at beginning",
        replace: "beginning"
    }, {
        phrase: "at the beginning",
        replace: "beginning"
    }, {
        phrase: "this week",
        replace: "in 2 days"
    }, {
        phrase: " in una ",
        replace: " in 1 "
    }, {
        phrase: " in un ",
        replace: " in 1 "
    }, {
        phrase: " chiama ",
        replace: " "
    }, {
        phrase: "mattina",
        replace: "9am"
    }, {
        phrase: "pomeriggio",
        replace: "1pm"
    }, {
        phrase: "verso mezzogiorno",
        replace: "12pm"
    }, {
        phrase: "all'inizio",
        replace: "inizio"
    }, {
        phrase: "dopo pranzo",
        replace: "12pm"
    }, {
        phrase: " verso ",
        replace: " "
    }, {
        phrase: " at ",
        replace: " "
    }, {
        phrase: "in 1 week",
        replace: "next week"
    }, {
        phrase: "in a week",
        replace: "next week"
    }, {
        phrase: "next week",
        replace: new Date(new Date().setDate(new Date().getDate() + 7)).toString()
    }, {
        phrase: "two weeks",
        replace: new Date(new Date().setDate(new Date().getDate() + 14)).toString()
    }, {
        phrase: "three weeks",
        replace: new Date(new Date().setDate(new Date().getDate() + 21)).toString()
    }, {
        phrase: "next month",
        replace: new Date(new Date().setDate(new Date().getDate() + 30)).toString()
    }, {
        phrase: "two months",
        replace: new Date(new Date().setDate(new Date().getDate() + 60)).toString()
    }, {
        phrase: "before ",
        replace: ""
    }, {
        phrase: " in ",
        replace: " "
    }, {
        phrase: "am ",
        replace: ""
    }, {
        phrase: " in zwei",
        replace: " in two"
    }, {
        phrase: "nächste Woche",
        replace: new Date(new Date().setDate(new Date().getDate() + 7)).toString()
    }, {
        phrase: "in einer Woche",
        replace: "next week"
    }, {
        phrase: "naechste Woche",
        replace: new Date(new Date().setDate(new Date().getDate() + 7)).toString()
    }, {
        phrase: "zwei Wochen",
        replace: new Date(new Date().setDate(new Date().getDate() + 14)).toString()
    }, {
        phrase: "2 Wochen",
        replace: new Date(new Date().setDate(new Date().getDate() + 14)).toString()
    }, {
        phrase: "drei Wochen",
        replace: new Date(new Date().setDate(new Date().getDate() + 21)).toString()
    }, {
        phrase: "3 Wochen",
        replace: new Date(new Date().setDate(new Date().getDate() + 21)).toString()
    }, {
        phrase: "nächsten Monat",
        replace: new Date(new Date().setDate(new Date().getDate() + 30)).toString()
    }, {
        phrase: "naechsten Monat",
        replace: new Date(new Date().setDate(new Date().getDate() + 30)).toString()
    } ], this.pattern = "(?:.*?)" + _arrToCapGrp(this.verbs, !1) + "\\s+(.*?)([\\.\\!\\?]|$)";
}

function _arrToCapGrp(arr, isNonCapturing) {
    var s = "(";
    !0 === isNonCapturing && (s += "?:");
    for (var i = 0; i < arr.length; i++) s += arr[i], i < arr.length - 1 && (s += "|");
    return s += ")";
}

function getNextDayOfWeek(dayOfWeek) {
    var date = new Date(), resultDate = new Date(date.getTime());
    return date.getDay() === dayOfWeek ? resultDate.setDate(date.getDate() + (7 + dayOfWeek - date.getDay() % 7)) : resultDate.setDate(date.getDate() + (7 + dayOfWeek - date.getDay()) % 7), 
    resultDate;
}

function Spinner() {
    this.show = function(message) {
        this.setMessage(message);
        var pb = document.getElementById("spinner");
        pb.style.display = "flex", setTimeout(function() {
            pb.classList.add("active");
        }, 0);
    }, this.hide = function() {
        var pb = document.getElementById("spinner");
        pb.classList.remove("active"), setTimeout(function() {
            pb.style.display = "none";
        }, 500);
    }, this.setMessage = function(message) {
        message || (message = "Loading..."), document.getElementById("spinner").querySelector(".progressbar-message").innerHTML = message;
    };
}

var IS_LOCAL_DASHBOARD = !1, IS_LOCAL_API = !1, API_TUNNEL_URL = "https://16719f56.ngrok.io", API_LOCAL_URL = !!IS_LOCAL_API && (API_TUNNEL_URL || "http://localhost:3020"), API_BASE_URL = IS_LOCAL_API ? API_LOCAL_URL : "https://api.tenfold.com", DASHBOARD_TUNNEL_URL = "https://72c2db6f.ngrok.io", DASHBOARD_LOCAL_URL = !!IS_LOCAL_DASHBOARD && (DASHBOARD_TUNNEL_URL || "http://localhost:3000"), DASHBOARD_BASE_URL = IS_LOCAL_DASHBOARD ? DASHBOARD_LOCAL_URL : "https://dashboard.tenfold.com";

window.mocks = new Mocks(), window.chrome = new ChromeMock(), $.ajaxSetup({
    xhrFields: {
        withCredentials: !0
    },
    crossDomain: !0
}), localStorage.removeItem("fb_tenfold_user"), localStorage.removeItem("fb_tenfold_organization");

var app = angular.module("callinize", [ "angularMoment", "firebase", "logger", "utils", "ngAudio", "datePicker" ]);

app.config(function($httpProvider) {
    $httpProvider.defaults.useXDomain = !0, $httpProvider.defaults.withCredentials = !0;
}), app.run(function(OpenCTIService, $rootScope) {
    $rootScope.lightningView = OpenCTIService.isLightningView();
}), app.constant("isDevMode", !0).constant("CACHE_NAME", "OpenCtiCache").constant("DASHBOARD_LOCAL_URL", DASHBOARD_LOCAL_URL).constant("API_LOCAL_URL", API_LOCAL_URL).constant("DASHBOARD_URL", DASHBOARD_BASE_URL).constant("FIREBASE_URL", "https://incandescent-inferno-925.firebaseio.com/"), 
app.filter("capitalizeFirst", function() {
    return function(input) {
        return input ? input.charAt(0).toUpperCase() + input.substr(1).toLowerCase() : "";
    };
});

var locales = {
    cz: {
        extName: {
            message: "Callinize",
            description: "extension name -- Do not translate this... this is our company name."
        },
        extDescription: {
            message: "Tenfold Enhanced CallerID & Automatic CRM Call Logging",
            description: "Shown in chrome://extensions page and maybe in the chrome store -- Translate it to say something like CRM Telephony Integration"
        },
        extShortName: {
            message: "CRM Telephony Integration",
            description: "Shown in chrome://extensions page and maybe in the chrome store"
        },
        selectContact: {
            message: "Vyberte kontakt",
            description: "Shown when there are multiple matching contacts"
        },
        matches: {
            message: "v�sledk�",
            description: "when there are multiple matches from the crm, this string shows - X matches"
        },
        unknownCaller: {
            message: "��slo nenalezeno",
            description: "Shown where contact name goes when phone number isn't found in CRM"
        },
        unknownNumber: {
            message: "Nezn�m� ��slo",
            description: "Shown when the phoneNumber is empty... this happens in cases like CallerID is blocked"
        },
        addNotes: {
            message: "Zadejte pozn�mku ...",
            description: "placeholder text shown in note input box"
        },
        savedSuccessfully: {
            message: "�sp�n� ulo�eno",
            description: "title when call notes are saved"
        },
        outboundCall: {
            message: "Click To Dial",
            description: "title when call notes are saved"
        },
        callNotesSaved: {
            message: "Pozn�mka ulo�ena",
            description: "shown in desktop notification"
        },
        noteNotSaved: {
            message: "Neulo�eno",
            description: "title when call notes are not saved"
        },
        noteSaveError: {
            message: "Nepoda�ilo se ulo�it pozn�mku",
            description: "shown in desktop notification"
        },
        createRecordErrorTitle: {
            message: "Není Vytvořeno",
            description: "title when create records are not saved"
        },
        createRecordErrorDescription: {
            message: "Chyba: Nepodařilo se vytvořit záznam.",
            description: "shown in desktop notification  when records are not created"
        },
        taskCreatedFor: {
            message: "Vytvo�en �kol s term�nem spln�n�: ",
            description: "shown in desktop notification"
        },
        emailSentTo: {
            message: "Email odesl�n na: ",
            description: "shown in desktop notification"
        },
        incoming: {
            message: "P��CHOZ�",
            description: "direction of the call, used in title bar and probably other places"
        },
        outgoing: {
            message: "ODCHOZ�",
            description: "direction of the call, used in title bar and probably other places"
        },
        incomingCall: {
            message: "P��CHOZ� HOVOR",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        outgoingCall: {
            message: "ODCHOZ� HOVOR",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        call: {
            message: "HOVOR",
            description: "typically combined with incoming/outgoing above in title bar."
        },
        emailTo: {
            message: "Pozn�mky budou zaslan� na ",
            description: "help text shown on hover over email indicator"
        },
        createTask: {
            message: "Creating task assigned to you for ",
            description: "help text shown on hover over task indicator"
        },
        queue: {
            message: "Fronta",
            description: "Shown on calls to an inbound call queue as a prefix"
        },
        hour: {
            message: "hod"
        },
        min: {
            message: "min",
            description: "short for minutes"
        },
        sec: {
            message: "sek",
            description: "short for seconds"
        },
        searchingForActivities: {
            message: "Vyhled�v�m aktivity...",
            description: "Activities box status message while the activities fetch in progress"
        },
        noActivitiesFound: {
            message: "Aktivity nenalezeny",
            description: "Activities box status message when no activities are being found"
        },
        createNewContact: {
            message: "Vytvo�it nov� kontakt",
            description: "When multiple contacts displays matching, but the caller is not one of them create new contact"
        },
        create: {
            message: "Vytvo�it",
            description: "create"
        },
        save: {
            message: "Ulo�it",
            description: "save"
        },
        noMatchEnterNameHere: {
            message: "Vlo�te jm�no ...",
            description: "When no match allow user to create contact"
        },
        noMatchEnterNameHelper: {
            message: "To access all fields you must create the record first",
            description: "To access all fields you must create the record first"
        },
        createRecord: {
            message: "Vytvo�it ->",
            description: "To access all fields you must create the record first"
        },
        creatingRecord: {
            message: "Vytv���m z�znam",
            description: "Transition dialog for creating a record"
        },
        retrievingRecord: {
            message: "Z�sk�v�m z�znam",
            description: "Transition dialog for retrieving a record"
        },
        savingUpdates: {
            message: "Saving Updates",
            description: "Transition dialog for saving updates"
        },
        info: {
            message: "Info",
            description: "Info navigation button for different pages on top right"
        },
        dialpad: {
            message: "Telefon",
            description: "Dialpad navigation button for different pages on top right"
        },
        back: {
            message: "Zp�t",
            description: "Back"
        },
        disabledDialpad: {
            message: "Dialpad disabled during call",
            description: "Dialpad disabled during call"
        },
        lead: {
            message: "Lead",
            description: "Lead"
        },
        contact: {
            message: "Kontakt",
            description: "Contact"
        },
        cancel: {
            message: "Zru�it",
            description: "Cancel"
        },
        searchingRecords: {
            message: "Prohled�v�m z�znamy...",
            description: "Searching Records..."
        },
        noMatchTitle: {
            message: "Z�znam nenalezen",
            description: "SNo Match Found"
        },
        createRecordType: {
            message: "Vyberte typ z�znamu",
            description: "Create record type?"
        },
        name: {
            message: "Jm�no",
            description: "Name"
        },
        answeredBy: {
            message: "Answered by",
            description: "Answered by"
        },
        loadingHistory: {
            message: "Nahr�v�m historii...",
            description: "Loading History..."
        },
        noInternet: {
            message: "No internet...",
            description: "No internet..."
        },
        showCallinize: {
            message: "Zobrazit Popup",
            description: "Show Popup"
        },
        showTour: {
            message: "Spustit prohl�dku",
            description: "Show Tour"
        },
        settings: {
            message: "Settings",
            description: "Settings"
        },
        allCallHistory: {
            message: "Historie v�ech hovor�",
            description: "All Call History"
        },
        clickToDial: {
            message: "Click to dial",
            description: "Click to dial"
        },
        noExtension: {
            message: "��dn� klapka",
            description: "No Extension"
        },
        unknownContact: {
            message: "Nezn�m� kontakt",
            description: "Shown for unknown contacts in history view"
        },
        reload: {
            message: "Reload",
            description: "Reload"
        },
        updateStatusUpToDate: {
            message: "Newest Version",
            description: "Newest Version"
        },
        updateStatusOldVersion: {
            message: "Old Version",
            description: "Old Version"
        },
        switchToThisCallAndSaveExistingNotes: {
            message: "Přepnout & Save",
            description: "Přepnout & Save"
        },
        ignore: {
            message: "Ignorovat",
            description: "Ignorovat"
        },
        extensionConfigurationErrorTitle: {
            message: "Žádné prodloužení nakonfigurován",
            description: "No extension configured"
        },
        extensionConfigurationErrorMessage: {
            message: "Chcete-li konfigurovatrozšíření jít do <a href='https://dashboard.tenfold.com/profile'>Callinize Dashboard</a> a přidat telefonní linku ",
            description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
        },
        microphonePermission: {
            message: "Při prvním spuštění této aplikace musíte dát svolení k tomu, aby použití mikrofonu . Přejděte na kartu vytvořili a dát svolení.",
            description: "Ask for microphone permission"
        },
        noLoginTokenTitle: {
            message: "Tenfold odhlášeni",
            description: ""
        },
        noLoginTokenMessage: {
            message: "Prosím, přihlašte se <a href='https://dashboard.tenfold.com'>Callinize</a>.  Než to uděláte , nebudete dostávat volání automaticky otevíraná okna.",
            description: "Message when a user clears there cookie and has nothing in chrome storage"
        },
        enabledRequirementTitle: {
            message: "Vaše uživatelské není povoleno. Volání automaticky otevíraná okna nebude fungovat, dokud jsou povoleny.",
            description: "Message displayed to user when they are not enabled"
        },
        enabledRequirementMessage: {
            message: "Pokud jste admin login na <a href='https://dashboard.tenfold.com/users'>Callinize Dashboard</a> a povolit sami, nebo, pokud jste uživatel, emailem správce a požádejte ho, aby vám umožnil.",
            description: "Message displayed to user when they are not enabled"
        },
        enterAccountHere: {
            message: "Enter Account Name",
            description: "Enter Account Name Here"
        },
        active: {
            message: "Aktivní",
            description: "Topbar toggle option to show the active call"
        },
        recent: {
            message: "Nedávný",
            description: "Topbar toggle option to show recent calls"
        }
    },
    en: {
        extName: {
            message: "Tenfold",
            description: "extension name -- Do not translate this... this is our company name."
        },
        extDescription: {
            message: "Tenfold Enhanced CallerID & Automatic CRM Call Logging",
            description: "Shown in chrome://extensions page and maybe in the chrome store -- Translate it to say something like CRM Telephony Integration"
        },
        extShortName: {
            message: "CRM Telephony Integration",
            description: "Shown in chrome://extensions page and maybe in the chrome store"
        },
        selectContact: {
            message: "Select contact",
            description: "Shown when there are multiple matching contacts"
        },
        matches: {
            message: "matches",
            description: "when there are multiple matches from the crm, this string shows - X matches"
        },
        unknownCaller: {
            message: "Unrecognized caller",
            description: "Shown where contact name goes when phone number isn't found in CRM"
        },
        unknownNumber: {
            message: "Unknown number",
            description: "Shown when the phoneNumber is empty... this happens in cases like CallerID is blocked"
        },
        addNotes: {
            message: "Click here to add notes",
            description: "placeholder text shown in note input box"
        },
        savedSuccessfully: {
            message: "Saved Successfully",
            description: "title when call notes are saved"
        },
        outboundCall: {
            message: "Click To Dial",
            description: "title when call notes are saved"
        },
        callNotesSaved: {
            message: "Call Notes Saved",
            description: "shown in desktop notification"
        },
        noteNotSaved: {
            message: "Not Saved",
            description: "title when call notes are not saved"
        },
        noteSaveError: {
            message: "Error. Failed to save the Note",
            description: "shown in desktop notification  when notes are saved"
        },
        createRecordErrorTitle: {
            message: "Not Created",
            description: "title when create records are not saved"
        },
        createRecordErrorDescription: {
            message: "Error. Failed to create the record.",
            description: "shown in desktop notification  when records are not created"
        },
        taskCreatedFor: {
            message: "Task Created with due date of: ",
            description: "shown in desktop notification when notes are saved"
        },
        emailSentTo: {
            message: "Email Sent To: ",
            description: "shown in desktop notification when notes are saved"
        },
        incoming: {
            message: "INCOMING",
            description: "direction of the call, used in title bar and probably other places"
        },
        outgoing: {
            message: "OUTGOING",
            description: "direction of the call, used in title bar and probably other places"
        },
        incomingCall: {
            message: "INCOMING CALL",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        outgoingCall: {
            message: "OUTGOING CALL",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        call: {
            message: "CALL",
            description: "typically combined with incoming/outgoing above in title bar."
        },
        emailTo: {
            message: "Notes will be emailed to ",
            description: "help text shown on hover over email indicator"
        },
        createTask: {
            message: "Creating task assigned to you for ",
            description: "help text shown on hover over task indicator"
        },
        queue: {
            message: "Queue",
            description: "Shown on calls to an inbound call queue as a prefix"
        },
        hour: {
            message: "hour"
        },
        min: {
            message: "min",
            description: "short for minutes"
        },
        sec: {
            message: "sec",
            description: "short for seconds"
        },
        searchingForActivities: {
            message: "Searching for activities...",
            description: "Activities box status message while the activities fetch in progress"
        },
        noActivitiesFound: {
            message: "No activities found",
            description: "Activities box status message when no activities are being found"
        },
        createNewContact: {
            message: "Create New Contact",
            description: "When multiple contacts displays matching, but the caller is not one of them create new contact"
        },
        create: {
            message: "Create",
            description: "create"
        },
        save: {
            message: "Save",
            description: "save"
        },
        noMatchEnterNameHere: {
            message: "Enter Name",
            description: "When no match allow user to create contact"
        },
        associateToExisting: {
            message: "Associate to existing record",
            description: "Associate to existing record"
        },
        noMatchEnterNameHelper: {
            message: "To access all fields you must create the record first",
            description: "To access all fields you must create the record first"
        },
        createRecord: {
            message: "Create ->",
            description: "To access all fields you must create the record first"
        },
        creatingRecord: {
            message: "Creating Record",
            description: "Transition dialog for creating a record"
        },
        retrievingRecord: {
            message: "Retrieving Record",
            description: "Transition dialog for retrieving a record"
        },
        savingUpdates: {
            message: "Saving Updates",
            description: "Transition dialog for saving updates"
        },
        info: {
            message: "Info",
            description: "Info navigation button for different pages on top right"
        },
        dialpad: {
            message: "Dialpad",
            description: "Dialpad navigation button for different pages on top right"
        },
        back: {
            message: "Back",
            description: "Back"
        },
        disabledDialpad: {
            message: "Dialpad disabled during call",
            description: "Dialpad disabled during call"
        },
        lead: {
            message: "Lead",
            description: "Lead"
        },
        contact: {
            message: "Contact",
            description: "Contact"
        },
        cancel: {
            message: "Cancel",
            description: "Cancel"
        },
        searchingRecords: {
            message: "Searching Records...",
            description: "Searching Records..."
        },
        noMatchTitle: {
            message: "No Match Found",
            description: "Displayed when no matching record is found in CRM"
        },
        createRecordType: {
            message: "Select record type",
            description: "Create record type?"
        },
        name: {
            message: "Name",
            description: "Name"
        },
        answeredBy: {
            message: "Answered by",
            description: "Answered by"
        },
        calledBy: {
            message: "Called by",
            description: "Called by"
        },
        assignedTo: {
            message: "Assigned to",
            description: "Assigned to"
        },
        createdBy: {
            message: "Created By",
            description: "'Created by' as in the call was 'Created By: John'"
        },
        loadingHistory: {
            message: "Loading History...",
            description: "Loading History..."
        },
        noInternet: {
            message: "No internet...",
            description: "No internet..."
        },
        showCallinize: {
            message: "Show Popup",
            description: "Show Popup"
        },
        showTour: {
            message: "Show Tour",
            description: "Show Tour"
        },
        settings: {
            message: "Settings",
            description: "Settings"
        },
        allCallHistory: {
            message: "All Call History",
            description: "All Call History"
        },
        openDashboard: {
            message: "Open Dashboard",
            description: "Open Dashboard"
        },
        clickToDial: {
            message: "Click to dial",
            description: "Click to dial"
        },
        noExtension: {
            message: "No Extension",
            description: "No Extension"
        },
        unknownContact: {
            message: "Unknown Contact",
            description: "Shown for unknown contacts in history view"
        },
        reportProblemCall: {
            message: "Report Problem Call",
            description: "Report Problem Call"
        },
        reload: {
            message: "Reload Extension",
            description: "Reload Extension"
        },
        updateStatusUpToDate: {
            message: "Newest Version",
            description: "Newest Version"
        },
        updateStatusOldVersion: {
            message: "Old Version",
            description: "Old Version"
        },
        switchToThisCallAndSaveExistingNotes: {
            message: "Switch & Save",
            description: "Displayed to the user when a new call comes in while old call is active"
        },
        ignore: {
            message: "Ignore",
            description: "Ignore"
        },
        extensionConfigurationErrorTitle: {
            message: "No extension configured",
            description: "No extension configured"
        },
        extensionConfigurationErrorMessage: {
            message: "To configure an extension go to  <a href='https://dashboard.tenfold.com/profile'>Tenfold Dashboard</a> and add your phone extension.",
            description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
        },
        microphonePermission: {
            message: "When you first start this application you must give permission for it to use your microphone.  Please go to the tab created and give permission.",
            description: "Ask for microphone permission"
        },
        cleanupMessage: {
            message: "Tenfold: chrome does not allow us to automatically reload the chrome newtab page when updates occur.  Until this page refreshes your popup will not work correctly.  If you have notes on this page, please copy them now.",
            description: "Tenfold: chrome does not allow us to automatically reload the chrome newtab page when updates occur.  Until this page refreshes your popup will not work correctly.  If you have notes on this page, please copy them now."
        },
        noLoginTokenTitle: {
            message: "Tenfold logged out",
            description: ""
        },
        noLoginTokenMessage: {
            message: "Please login at <a href='https://dashboard.tenfold.com'>Tenfold</a>. Before you do, you will not receive call popups.",
            description: "Message when a user clears there cookie and has nothing in chrome storage"
        },
        enabledRequirementTitle: {
            message: "You are not presently enabled.  Call popups will not work until you are enabled.",
            description: "Message displayed to user when they are not enabled"
        },
        enabledRequirementMessage: {
            message: "If you are the admin login at <a href='https://dashboard.tenfold.com/users'>Tenfold Dashboard</a> and enable yourself or if you are a user, email your admin and ask them to enable you",
            description: "Message displayed to user when they are not enabled"
        },
        enterAccountHere: {
            message: "Enter Account Name",
            description: "Enter Account Name Here"
        },
        searchOrCreateNew: {
            message: "Search or Add New",
            description: "Search for a user not listed here or create new user."
        },
        opportunities: {
            message: "Opportunities",
            description: "Opportunities title"
        },
        opportunityRelateButBlocked: {
            message: "A opportunity is related to this call",
            description: "Text shown besides priority in activity's case number"
        },
        errorSearchingActivities: {
            message: "No response from API. Contact your admin or",
            description: "Activities box status message while the activities fetch in progress"
        },
        waitForDispositions: {
            message: "Fetching the dispositions...",
            description: "Dispositions box status message while the Dispositions fetch in progress"
        },
        waitForResources: {
            message: "Searching for resources...",
            description: "Resources box status message while the resources fetch in progress"
        },
        createNew: {
            message: "Create New",
            description: "create"
        },
        refreshResources: {
            message: "Fetch resources that you just created in the CRM",
            description: "Fetch resources that you just created in the CRM"
        },
        amount: {
            message: "Amount: ",
            description: "amount"
        },
        probability: {
            message: "Probability: ",
            description: "probability"
        },
        noDispositions: {
            message: "No dispositions for this records",
            description: "save"
        },
        login: {
            message: "Login",
            description: "Message when a user clears there cookie and has nothing in chrome storage"
        },
        created: {
            message: "created",
            description: "Text shown besides priority in activity's cases"
        },
        case: {
            message: "Case",
            description: "Text shown besides priority in activity's case number"
        },
        caseRelateButBlocked: {
            message: "A case is related to this call",
            description: "Text shown besides priority in activity's case number"
        },
        cases: {
            message: "Cases",
            description: "Text shown besides priority in activity's case number"
        },
        relateResource: {
            message: "Relate / Resource",
            description: "Text shown besides priority in activity's case number"
        },
        orCreateNew: {
            message: "Or, create new...",
            description: "Single match create buttons"
        },
        emailTemplate: {
            message: "Email Templates",
            description: "Email Templates button text"
        },
        notConnected: {
            message: "You are not connected to the internet. Please check your network settings.",
            description: "You are not connected to the internet. Please check your network settings."
        },
        filterResults: {
            message: "Filter Results",
            description: "Multi-match filter input placeholder"
        },
        notesDisabled: {
            message: "Notes feature is disabled for your organization",
            description: "Notes feature is disabled for your organization"
        },
        active: {
            message: "Active",
            description: "Topbar toggle option to show the active call"
        },
        recent: {
            message: "Recent",
            description: "Topbar toggle option to show recent calls"
        },
        inviteEmail: {
            message: "Email to send invite to the meeting",
            description: "Email to send invite to the meeting"
        },
        createMeeting: {
            message: "Create Online Meeting",
            description: "Create online meeting label"
        },
        go: {
            message: "Go",
            description: "Go"
        }
    },
    es: {
        extName: {
            message: "Callinize",
            description: "extension name"
        },
        extDescription: {
            message: "Tenfold Mejorado CallerID y CRM automática de llamadas Registro"
        },
        extShortName: {
            message: "Mejorado CallerID"
        },
        selectContact: {
            message: "Seleccione el contacto"
        },
        matches: {
            message: "conectado",
            description: "when there are multiple matches from the crm, this string shows - X connected"
        },
        addNotes: {
            message: "Haga clic aquí para añadir notas"
        },
        savedSuccessfully: {
            message: "Guardado Correctamente",
            description: "title when call notes are saved"
        },
        callNotesSaved: {
            message: "Llamar Notas Guardadas",
            description: "shown in desktop notification"
        },
        noteNotSaved: {
            message: "Not Saved",
            description: "title when call notes are not saved"
        },
        noteSaveError: {
            message: "Error. Failed to save the Note",
            description: "shown in desktop notification"
        },
        createRecordErrorTitle: {
            message: "No se ha creado",
            description: "title when create records are not saved"
        },
        createRecordErrorDescription: {
            message: "Error: No se ha podido crear el registro.",
            description: "shown in desktop notification  when records are not created"
        },
        taskCreatedFor: {
            message: "Tarea Creada",
            description: "shown in desktop notification"
        },
        emailSentTo: {
            message: "Correo Electrónico Enviado a",
            description: "shown in desktop notification"
        },
        incoming: {
            message: "ENTRANTE"
        },
        outgoing: {
            message: "SALIENTE"
        },
        incomingCall: {
            message: "LLAMADA ENTRANTE",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        outgoingCall: {
            message: "LLAMADA SALIENTE",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        call: {
            message: "LLAMADA"
        },
        unknownNumber: {
            message: "Número desconocido"
        },
        emailTo: {
            message: "Por email a"
        },
        assignTo: {
            message: "Asigne tareas a"
        },
        queue: {
            message: "Cola"
        },
        hour: {
            message: "hora"
        },
        min: {
            message: "min",
            description: "short for minutes"
        },
        sec: {
            message: "seg",
            description: "short for seconds"
        },
        searchingForActivities: {
            message: "Búsqueda de actividades ...",
            description: "Mensaje de estado de cuadro de actividades, mientras que los programas de actividades traen en curso"
        },
        noActivitiesFound: {
            message: "No hay actividades encontradas",
            description: "Actividades cuadro de mensaje de estado cuando se están encontrando ninguna actividad"
        },
        createNewContact: {
            message: "Crear nuevo contacto",
            description: "Cuando varios contactos muestra coincidente, pero éste no es uno de ellos crear nuevo contacto"
        },
        create: {
            message: "Crear",
            description: "crear"
        },
        save: {
            message: "Guardar",
            description: "guardar"
        },
        noMatchEnterNameHere: {
            message: "Ingresa aquí",
            description: "Cuando hay coincidencia permite al usuario crear contactos"
        },
        noMatchEnterNameHelper: {
            message: "Para acceder a todos los campos que debe crear el registro primero",
            description: "Para acceder a todos los campos que debe crear el registro primero"
        },
        createRecord: {
            message: "Crear ->",
            description: "Para acceder a todos los campos que debe crear el registro primero"
        },
        creatingRecord: {
            message: "Creación de Registro",
            description: "Utilizado como el estado de transición para la creación de registro"
        },
        retrievingRecord: {
            message: "Recuperando Record",
            description: "De diálogo Transición para recuperar un registro"
        },
        savingUpdates: {
            message: "Ahorrar actualizaciones",
            description: "Transición de diálogo para guardar cambios"
        },
        info: {
            message: "Info",
            description: "Info navigation button for different pages on top right"
        },
        dialpad: {
            message: "Teclado",
            description: "Dialpad navigation button for different pages on top right"
        },
        back: {
            message: "Espalda",
            description: "Botón de navegación Teclado telefónico para diferentes páginas en la parte superior derecha"
        },
        disabledDialpad: {
            message: "Dialpad desactivado durante la llamada",
            description: "Dialpad desactivado durante la llamada"
        },
        lead: {
            message: "Lead",
            description: "Lead"
        },
        contact: {
            message: "Contacto",
            description: "Contacto"
        },
        searchingRecords: {
            message: "Buscando Registros ...",
            description: "Buscando Registros ..."
        },
        answeredBy: {
            message: "Respondida por",
            description: "Respondida por"
        },
        loadingHistory: {
            message: "Cargando Historial...",
            description: "Cargando Historial..."
        },
        noInternet: {
            message: "No hay Internet...",
            description: "No hay Internet..."
        },
        showCallinize: {
            message: "Show Popup",
            description: "Show Popup"
        },
        showTour: {
            message: "Show Tour",
            description: "Show Tour"
        },
        settings: {
            message: "Settings",
            description: "Settings"
        },
        allCallHistory: {
            message: "Todo el Historial de llamadas",
            description: "Todo el Historial de llamadas"
        },
        clickToDial: {
            message: "Haga clic para llamar",
            description: "Haga clic para llamar"
        },
        noExtension: {
            message: "No Extensión",
            description: "No Extensión"
        },
        unknownContact: {
            message: "Contacto desconocido",
            description: "Contacto desconocido"
        },
        reportProblemCall: {
            message: "Informe de Incidencia Call",
            description: "Informe de Incidencia Call"
        },
        reload: {
            message: "Actualizar Extensión",
            description: "Actualizar Extensión"
        },
        updateStatusUpToDate: {
            message: "La más nueva versión",
            description: "La más nueva versión"
        },
        updateStatusOldVersion: {
            message: "Versión anterior",
            description: "Versión anterior"
        },
        switchToThisCallAndSaveExistingNotes: {
            message: "Cambie y ahorre",
            description: "Cambie y ahorre"
        },
        ignore: {
            message: "Desatender",
            description: "Desatender"
        },
        extensionConfigurationErrorTitle: {
            message: "No hay extensión configurada",
            description: "No extension configured"
        },
        extensionConfigurationErrorMessage: {
            message: "Para configurar una extensión de ir a <a href='https://dashboard.tenfold.com/profile'>Callinize Dashboard</a> y añadir su extensión telefónica .",
            description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
        },
        microphonePermission: {
            message: "Al empezar esta aplicación es necesario dar permiso para que use el micrófono. Por favor, vaya a la pestaña creada y dar permiso.",
            description: "Ask for microphone permission"
        },
        noLoginTokenTitle: {
            message: "Tenfold desconectó",
            description: ""
        },
        noLoginTokenMessage: {
            message: "Tenfold desconectó <a href='https://dashboard.tenfold.com'>Callinize</a>.  Antes de hacerlo, no recibirá llamadas pop-ups.",
            description: "Message when a user clears there cookie and has nothing in chrome storage"
        },
        enabledRequirementTitle: {
            message: "Tu usuario no está habilitado. Popups de llamadas no funcionará hasta que se habilitó.",
            description: "Message displayed to user when they are not enabled"
        },
        enabledRequirementMessage: {
            message: "Si usted es el administrador de inicio de sesión en <a href='https://dashboard.tenfold.com/users'>Callinize Dashboard</a> y permitir a sí mismo o si usted es un usuario, correo electrónico su administrador y pida que permitirá.",
            description: "Message displayed to user when they are not enabled"
        },
        enterAccountHere: {
            message: "Enter Account Name",
            description: "Enter Account Name Here"
        },
        active: {
            message: "Activo",
            description: "Topbar toggle option to show the active call"
        },
        recent: {
            message: "Reciente",
            description: "Topbar toggle option to show recent calls"
        }
    },
    fr: {
        extName: {
            message: "Callinize",
            description: "extension name -- Do not translate this... this is our company name."
        },
        extDescription: {
            message: "Tenfold fournit l'identification de l'appelant et le GRC avec enregistrement des appels automatique amélioré",
            description: "Shown in chrome://extensions page and maybe in the chrome store -- Translate it to say something like CRM Telephony Integration"
        },
        extShortName: {
            message: "Couplage téléphonie GRC",
            description: "Shown in chrome://extensions page and maybe in the chrome store"
        },
        selectContact: {
            message: "Sélectionner le contact",
            description: "Shown when there are multiple matching contacts"
        },
        matches: {
            message: "Correspondances",
            description: "when there are multiple matches from the crm, this string shows - X matches"
        },
        unknownCaller: {
            message: "Appelant non reconnu",
            description: "Shown where contact name goes when phone number isn't found in CRM"
        },
        unknownNumber: {
            message: "Numéro inconnu",
            description: "Shown when the phoneNumber is empty... this happens in cases like CallerID is blocked"
        },
        addNotes: {
            message: "Cliquer ici pour ajouter des notes",
            description: "placeholder text shown in note input box"
        },
        savedSuccessfully: {
            message: "Sauvegarde effectuée",
            description: "title when call notes are saved"
        },
        outboundCall: {
            message: "Cliquer pour composer le numéro",
            description: "title when call notes are saved"
        },
        callNotesSaved: {
            message: "Notes d'appel sauvegardées",
            description: "shown in desktop notification"
        },
        noteNotSaved: {
            message: "Non sauvegardé",
            description: "title when call notes are not saved"
        },
        noteSaveError: {
            message: "Erreur. Échec de la sauvegarde",
            description: "shown in desktop notification  when notes are saved"
        },
        createRecordErrorTitle: {
            message: "Non créé",
            description: "title when create records are not saved"
        },
        createRecordErrorDescription: {
            message: "Erreur. Échec de l'enregistrement.",
            description: "shown in desktop notification  when records are not created"
        },
        taskCreatedFor: {
            message: "Tâche créée, échéance prévue le : ",
            description: "shown in desktop notification when notes are saved"
        },
        emailSentTo: {
            message: "Email envoyé à : ",
            description: "shown in desktop notification when notes are saved"
        },
        incoming: {
            message: "ENTRANT",
            description: "direction of the call, used in title bar and probably other places"
        },
        outgoing: {
            message: "SORTANT",
            description: "direction of the call, used in title bar and probably other places"
        },
        incomingCall: {
            message: "APPEL ENTRANT",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        outgoingCall: {
            message: "APPEL SORTANT",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        call: {
            message: "APPEL",
            description: "typically combined with incoming/outgoing above in title bar."
        },
        emailTo: {
            message: "Les notes seront envoyées à ",
            description: "help text shown on hover over email indicator"
        },
        createTask: {
            message: "Créer une tâche vous étant destinée pour ",
            description: "help text shown on hover over task indicator"
        },
        queue: {
            message: "Queue",
            description: "Shown on calls to an inbound call queue as a prefix"
        },
        hour: {
            message: "heure"
        },
        min: {
            message: "min",
            description: "short for minutes"
        },
        sec: {
            message: "sec",
            description: "short for seconds"
        },
        searchingForActivities: {
            message: "Recherche des activités...",
            description: "Activities box status message while the activities fetch in progress"
        },
        noActivitiesFound: {
            message: "Pas d'activités trouvées",
            description: "Activities box status message when no activities are being found"
        },
        createNewContact: {
            message: "Créer un nouveau contact",
            description: "When multiple contacts displays matching, but the caller is not one of them create new contact"
        },
        create: {
            message: "Créer",
            description: "create"
        },
        save: {
            message: "Enregistrer",
            description: "save"
        },
        noMatchEnterNameHere: {
            message: "Entrer le nom",
            description: "When no match allow user to create contact"
        },
        associateToExisting: {
            message: "Associer à un enregistrement existant",
            description: "Associate to existing record"
        },
        noMatchEnterNameHelper: {
            message: "Vous devez créer l'enregistrement avant de pouvoir accéder à tous les champs",
            description: "To access all fields you must create the record first"
        },
        createRecord: {
            message: "Créer ->",
            description: "To access all fields you must create the record first"
        },
        creatingRecord: {
            message: "Création de l'enregistrement",
            description: "Transition dialog for creating a record"
        },
        retrievingRecord: {
            message: "Récupération de l'enregistrement",
            description: "Transition dialog for retrieving a record"
        },
        savingUpdates: {
            message: "Sauvegarde des mises à jour",
            description: "Transition dialog for saving updates"
        },
        info: {
            message: "Info",
            description: "Info navigation button for different pages on top right"
        },
        dialpad: {
            message: "Pavé numérique",
            description: "Dialpad navigation button for different pages on top right"
        },
        back: {
            message: "Retour",
            description: "Back"
        },
        disabledDialpad: {
            message: "Pavé numérique désactivé pendant l'appel",
            description: "Dialpad disabled during call"
        },
        lead: {
            message: "Cible",
            description: "Lead"
        },
        contact: {
            message: "Contact",
            description: "Contact"
        },
        cancel: {
            message: "Effacer",
            description: "Cancel"
        },
        searchingRecords: {
            message: "Recherche des enregistrements...",
            description: "Searching Records..."
        },
        noMatchTitle: {
            message: "Aucune correspondance",
            description: "Displayed when no matching record is found in CRM"
        },
        createRecordType: {
            message: "Sélectionner le type d'enregistrement",
            description: "Create record type?"
        },
        name: {
            message: "Nom",
            description: "Name"
        },
        answeredBy: {
            message: "Répondu par",
            description: "Answered by"
        },
        calledBy: {
            message: "Appelé par",
            description: "Called by"
        },
        assignedTo: {
            message: "Assigné à",
            description: "Assigned to"
        },
        createdBy: {
            message: "Créé par",
            description: "'Created by' as in the call was 'Created By: John'"
        },
        loadingHistory: {
            message: "Chargement de l'historique...",
            description: "Loading History..."
        },
        noInternet: {
            message: "Pas d'internet...",
            description: "No internet..."
        },
        showCallinize: {
            message: "Afficher le popup",
            description: "Show Popup"
        },
        showTour: {
            message: "Guide d'utilisation",
            description: "Show Tour"
        },
        settings: {
            message: "Paramètres",
            description: "Settings"
        },
        allCallHistory: {
            message: "Tout l'historique des appels",
            description: "All Call History"
        },
        clickToDial: {
            message: "Cliquer pour composer",
            description: "Click to dial"
        },
        noExtension: {
            message: "Pas d'extension",
            description: "No Extension"
        },
        unknownContact: {
            message: "Contact inconnu",
            description: "Shown for unknown contacts in history view"
        },
        reportProblemCall: {
            message: "Reporter un problème d'appel",
            description: "Report Problem Call"
        },
        reload: {
            message: "Recharger l'extension",
            description: "Reload Extension"
        },
        updateStatusUpToDate: {
            message: "Dernière version",
            description: "Newest Version"
        },
        updateStatusOldVersion: {
            message: "Ancienne version",
            description: "Old Version"
        },
        switchToThisCallAndSaveExistingNotes: {
            message: "Changer et enregistrer",
            description: "Displayed to the user when a new call comes in while old call is active"
        },
        ignore: {
            message: "Ignorer",
            description: "Ignore"
        },
        extensionConfigurationErrorTitle: {
            message: "Pas d'extension configurée",
            description: "No extension configured"
        },
        extensionConfigurationErrorMessage: {
            message: "Pour configurer une extension aller à  <a href='https://dashboard.tenfold.com/profile'>Callinize Dashboard</a> and add your phone extension.",
            description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
        },
        microphonePermission: {
            message: "Lorsque vous utilisez cette application pour la première fois vous devez l'autoriser à utiliser le microphone.  Allez sur l'onglez créé et autorisez l'application.",
            description: "Ask for microphone permission"
        },
        cleanupMessage: {
            message: "Callinize: Chrome ne nous permet pas de recharger automatiquement la page nouvel onglet de Chrome lorsque les mises à jour sont en cours.  Votre popup ne fonctionnera pas correctement tant que la page ne sera pas rafraîchie.  Si vous avez des notes sur cette page, copiez-les maintenant.",
            description: "Callinize: chrome does not allow us to automatically reload the chrome newtab page when updates occur.  Until this page refreshes your popup will not work correctly.  If you have notes on this page, please copy them now."
        },
        noLoginTokenTitle: {
            message: "Tenfold déconnecté",
            description: ""
        },
        noLoginTokenMessage: {
            message: "Connectez vous à <a href='https://dashboard.tenfold.com'>Callinize</a>. Avant cela, vous ne recevrez pas les popups d'appel.",
            description: "Message when a user clears there cookie and has nothing in chrome storage"
        },
        enabledRequirementTitle: {
            message: "Vous n'êtes pas habilité pour le moment.  Les popups d'appel ne fonctionneront pas tant que vous ne serez pas habilité.",
            description: "Message displayed to user when they are not enabled"
        },
        enabledRequirementMessage: {
            message: "Si vous êtes l'administrateur, connectez vous à <a href='https://dashboard.tenfold.com/users'>Callinize Dashboard</a> et habilitez vous ou si vous êtes un utilisateur, envoyez un email à votre admin pour lui demander de vous habiliter",
            description: "Message displayed to user when they are not enabled"
        },
        enterAccountHere: {
            message: "Entrer le nom du compte",
            description: "Enter Account Name Here"
        },
        searchOrCreateNew: {
            message: "Rechercher ou Créer un nouvel utilisateur",
            description: "Search for a user not listed here or create new user."
        },
        opportunities: {
            message: "Opportunités",
            description: "Opportunities title"
        },
        opportunityRelateButBlocked: {
            message: "Une opportunité est liée à cet appel",
            description: "Text shown besides priority in activity's case number"
        },
        errorSearchingActivities: {
            message: "Pas de réponse de l'API. Contactez votre admin ou",
            description: "Activities box status message while the activities fetch in progress"
        },
        waitForDispositions: {
            message: "Recherche d'arrangements...",
            description: "Dispositions box status message while the Dispositions fetch in progress"
        },
        waitForResources: {
            message: "Recherche de ressources...",
            description: "Resources box status message while the resources fetch in progress"
        },
        createNew: {
            message: "Créer nouveau",
            description: "create"
        },
        refreshResources: {
            message: "Importer les ressources que vous avez crées dans le GRC",
            description: "Fetch resources that you just created in the CRM"
        },
        amount: {
            message: "Montant : ",
            description: "amount"
        },
        probability: {
            message: "Probabilité : ",
            description: "probability"
        },
        noDispositions: {
            message: "Pas d'arrangements pour cet enregistrement",
            description: "save"
        },
        login: {
            message: "Connexion",
            description: "Message when a user clears there cookie and has nothing in chrome storage"
        },
        created: {
            message: "crée",
            description: "Text shown besides priority in activity's cases"
        },
        case: {
            message: "Cas",
            description: "Text shown besides priority in activity's case number"
        },
        caseRelateButBlocked: {
            message: "Un cas est lié  cet appel",
            description: "Text shown besides priority in activity's case number"
        },
        cases: {
            message: "Cas",
            description: "Text shown besides priority in activity's case number"
        },
        relateResource: {
            message: "Lier / Ressource",
            description: "Text shown besides priority in activity's case number"
        },
        orCreateNew: {
            message: "Ou, créer nouveau...",
            description: "Single match create buttons"
        },
        emailTemplate: {
            message: "Modèles d'emails",
            description: "Email Templates button text"
        },
        notConnected: {
            message: "Vous n'êtes pas connecté à internet. Vérifiez vos paramètres réseau.",
            description: "You are not connected to the internet. Please check your network settings."
        },
        filterResults: {
            message: "Filtrer les résultats",
            description: "Multi-match filter input placeholder"
        },
        active: {
            message: "Actif",
            description: "Topbar toggle option to show the active call"
        },
        recent: {
            message: "Récent",
            description: "Topbar toggle option to show recent calls"
        }
    },
    it: {
        extName: {
            message: "Callinize",
            description: "extension name -- Do not translate this... this is our company name."
        },
        extDescription: {
            message: "Tenfold Integrazione avanzata tra CRM e Telefonia con Log Automatico delle Chiamate",
            description: "Shown in chrome://extensions page and maybe in the chrome store -- Translate it to say something like CRM Telephony Integration"
        },
        extShortName: {
            message: "Integrazione tra Telefonia e CRM",
            description: "Shown in chrome://extensions page and maybe in the chrome store"
        },
        selectContact: {
            message: "Scegli il contatto",
            description: "Shown when there are multiple matching contacts"
        },
        matches: {
            message: "Corrispondenze",
            description: "when there are multiple matches from the crm, this string shows - X matches"
        },
        unknownCaller: {
            message: "Chiamante non riconosciuto",
            description: "Shown where contact name goes when phone number isn't found in CRM"
        },
        unknownNumber: {
            message: "Numero sconosciuto",
            description: "Shown when the phoneNumber is empty... this happens in cases like CallerID is blocked"
        },
        addNotes: {
            message: "Click per aggiungere note",
            description: "placeholder text shown in note input box"
        },
        savedSuccessfully: {
            message: "Note salvate con successo",
            description: "title when call notes are saved"
        },
        outboundCall: {
            message: "Click per chiamare",
            description: "title when call notes are saved"
        },
        callNotesSaved: {
            message: "Note chiamata salvate",
            description: "shown in desktop notification"
        },
        noteNotSaved: {
            message: "Note non salvate",
            description: "title when call notes are not saved"
        },
        noteSaveError: {
            message: "Errore. Impossibile salvare le Note",
            description: "shown in desktop notification  when notes are saved"
        },
        createRecordErrorTitle: {
            message: "Record non creato",
            description: "title when create records are not saved"
        },
        createRecordErrorDescription: {
            message: "Errore. Impossibile creare il Record.",
            description: "shown in desktop notification  when records are not created"
        },
        taskCreatedFor: {
            message: "Task creato con scadenza il: ",
            description: "shown in desktop notification when notes are saved"
        },
        emailSentTo: {
            message: "Email inviata a: ",
            description: "shown in desktop notification when notes are saved"
        },
        incoming: {
            message: "IN ARRIVO",
            description: "direction of the call, used in title bar and probably other places"
        },
        outgoing: {
            message: "IN USCITA",
            description: "direction of the call, used in title bar and probably other places"
        },
        incomingCall: {
            message: "CHIAMATA IN INGRESSO",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        outgoingCall: {
            message: "CHIAMATA IN USCITA",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        call: {
            message: "CHIAMATA",
            description: "typically combined with incoming/outgoing above in title bar."
        },
        emailTo: {
            message: "Le note saranno inviate per email a ",
            description: "help text shown on hover over email indicator"
        },
        createTask: {
            message: "Creo task assegnato a te per ",
            description: "help text shown on hover over task indicator"
        },
        queue: {
            message: "Coda",
            description: "Shown on calls to an inbound call queue as a prefix"
        },
        hour: {
            message: "ora"
        },
        min: {
            message: "min",
            description: "short for minutes"
        },
        sec: {
            message: "sec",
            description: "short for seconds"
        },
        searchingForActivities: {
            message: "Ricerca attività...",
            description: "Activities box status message while the activities fetch in progress"
        },
        noActivitiesFound: {
            message: "Nessuna attività trovata",
            description: "Activities box status message when no activities are being found"
        },
        createNewContact: {
            message: "Crea Nuovo contatto",
            description: "When multiple contacts displays matching, but the caller is not one of them create new contact"
        },
        create: {
            message: "Crea",
            description: "create"
        },
        save: {
            message: "Salva",
            description: "save"
        },
        noMatchEnterNameHere: {
            message: "Inserisci il nome ",
            description: "When no match allow user to create contact"
        },
        noMatchEnterNameHelper: {
            message: "Per accedere a tutti i campi occorre prima un nuovo record",
            description: "To access all fields you must create the record first"
        },
        createRecord: {
            message: "Crea ->",
            description: "To access all fields you must create the record first"
        },
        creatingRecord: {
            message: "Creazione Record",
            description: "Transition dialog for creating a record"
        },
        retrievingRecord: {
            message: "Recupero del Record",
            description: "Transition dialog for retrieving a record"
        },
        savingUpdates: {
            message: "Salvataggio Modifiche ",
            description: "Transition dialog for saving updates"
        },
        info: {
            message: "Info",
            description: "Info navigation button for different pages on top right"
        },
        dialpad: {
            message: "Tastierino numerico",
            description: "Dialpad navigation button for different pages on top right"
        },
        back: {
            message: "Indietro",
            description: "Back"
        },
        disabledDialpad: {
            message: "Tastierino disabilitato durante la chiamata",
            description: "Dialpad disabled during call"
        },
        lead: {
            message: "Lead",
            description: "Lead"
        },
        contact: {
            message: "Contatto",
            description: "Contact"
        },
        cancel: {
            message: "Cancella",
            description: "Cancel"
        },
        searchingRecords: {
            message: "Ricerca Records...",
            description: "Searching Records..."
        },
        noMatchTitle: {
            message: "Nessuna corrispondenza Trovata",
            description: "Displayed when no matching record is found in CRM"
        },
        createRecordType: {
            message: "Scegli il tipo di record da creare",
            description: "Create record type?"
        },
        name: {
            message: "Nome",
            description: "Name"
        },
        answeredBy: {
            message: "Risposta da",
            description: "Answered by"
        },
        loadingHistory: {
            message: "Caricamento cronologia...",
            description: "Loading History..."
        },
        noInternet: {
            message: "No internet...",
            description: "No internet..."
        },
        showCallinize: {
            message: "Mostra Popup",
            description: "Show Popup"
        },
        showTour: {
            message: "Mostra Tour",
            description: "Show Tour"
        },
        settings: {
            message: "Impostazioni",
            description: "Settings"
        },
        allCallHistory: {
            message: "Cronologia di tutte le chiamate",
            description: "All Call History"
        },
        clickToDial: {
            message: "Click per comporre",
            description: "Click to dial"
        },
        noExtension: {
            message: "Nessun Interno",
            description: "No Extension"
        },
        unknownContact: {
            message: "Contatto sconosciuto",
            description: "Shown for unknown contacts in history view"
        },
        reportProblemCall: {
            message: "Report Problem Call",
            description: "Report Problem Call"
        },
        reload: {
            message: "Ricarica Interno",
            description: "Reload Extension"
        },
        updateStatusUpToDate: {
            message: "Versione più recente",
            description: "Newest Version"
        },
        updateStatusOldVersion: {
            message: "Vecchia versione",
            description: "Old Version"
        },
        switchToThisCallAndSaveExistingNotes: {
            message: "Commuta & Salva",
            description: "Displayed to the user when a new call comes in while old call is active"
        },
        ignore: {
            message: "Ignora",
            description: "Ignore"
        },
        extensionConfigurationErrorTitle: {
            message: "Nessun interno configurato",
            description: "No extension configured"
        },
        extensionConfigurationErrorMessage: {
            message: "Per configurare un interno vai su <a href='https://dashboard.tenfold.com/profile'>Callinize Dashboard</a> and add your phone extension.",
            description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
        },
        microphonePermission: {
            message: "Quando attivi l'applicazione devi permettere accesso al microfono. Seleziona il tab creato e concedi permesso.",
            description: "Ask for microphone permission"
        },
        cleanupMessage: {
            message: "Callinize: Chrome non permette di ricaricare automaticamente la pagina  quando si aggiorna.  Fino a quando la pagina si aggiornerà il popup non funzionerà correttamente.  Se ci sono note su questa pagina, copiale ora.",
            description: "Callinize: chrome does not allow us to automatically reload the chrome newtab page when updates occur.  Until this page refreshes your popup will not work correctly.  If you have notes on this page, please copy them now."
        },
        noLoginTokenTitle: {
            message: "Tenfold desconectó",
            description: ""
        },
        noLoginTokenMessage: {
            message: "Effettua l'accesso alle <a href='https://dashboard.tenfold.com'>Callinize</a>. Prima di farlo , non riceverai popup di chiamata.",
            description: "Message when a user clears there cookie and has nothing in chrome storage"
        },
        enabledRequirementTitle: {
            message: "Il tuo utente non è abilitato. Popup di chiamata non funzioneranno fino a quando non sono abilitati.",
            description: "Message displayed to user when they are not enabled"
        },
        enabledRequirementMessage: {
            message: "Se siete il logon a <a href='https://dashboard.tenfold.com/users'>Callinize Dashboard</a> e attivare voi stessi o se sei un utente, e-mail l'amministratore e chiedere loro di consentire.",
            description: "Message displayed to user when they are not enabled"
        },
        enterAccountHere: {
            message: "Enter Account Name",
            description: "Enter Account Name Here"
        },
        active: {
            message: "Attivo",
            description: "Topbar toggle option to show the active call"
        },
        recent: {
            message: "Recente",
            description: "Topbar toggle option to show recent calls"
        }
    },
    nl: {
        extName: {
            message: "Callinize",
            description: "extension name -- Do not translate this... this is our company name."
        },
        extDescription: {
            message: "Tenfold Enhanced CallerID & Automatic CRM Call Logging",
            description: "Shown in chrome://extensions page and maybe in the chrome store -- Translate it to say something like CRM Telephony Integration"
        },
        extShortName: {
            message: "CRM Telephonie Integratie",
            description: "Shown in chrome://extensions page and maybe in the chrome store"
        },
        selectContact: {
            message: "Selecteer contactpersoon",
            description: "Shown when there are multiple matching contacts"
        },
        matches: {
            message: "Overeenkomsten",
            description: "when there are multiple matches from the crm, this string shows - X matches"
        },
        unknownCaller: {
            message: "Onbekende beller",
            description: "Shown where contact name goes when phone number isn't found in CRM"
        },
        unknownNumber: {
            message: "Onbekend nummer",
            description: "Shown when the phoneNumber is empty... this happens in cases like CallerID is blocked"
        },
        addNotes: {
            message: "Klik hier om notities toe te voegen",
            description: "placeholder text shown in note input box"
        },
        savedSuccessfully: {
            message: "Succesvol opgeslagen",
            description: "title when call notes are saved"
        },
        callNotesSaved: {
            message: "Gespreksnotities opgeslagen",
            description: "shown in desktop notification"
        },
        noteNotSaved: {
            message: "Not Saved",
            description: "title when call notes are not saved"
        },
        noteSaveError: {
            message: "Error: Failed to save the Note",
            description: "shown in desktop notification"
        },
        createRecordErrorTitle: {
            message: "Niet Gemaakt",
            description: "title when create records are not saved"
        },
        createRecordErrorDescription: {
            message: "Fout: Mislukt om het record te creëren.",
            description: "shown in desktop notification  when records are not created"
        },
        taskCreatedFor: {
            message: "Taak aangemaakt met opleverdatum van: ",
            description: "shown in desktop notification"
        },
        emailSentTo: {
            message: "Email Verzonden Aan: ",
            description: "shown in desktop notification"
        },
        incoming: {
            message: "INKOMEND",
            description: "direction of the call, used in title bar and probably other places"
        },
        outgoing: {
            message: "UITGAAND",
            description: "direction of the call, used in title bar and probably other places"
        },
        incomingCall: {
            message: "INKOMEND GESPREK",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        outgoingCall: {
            message: "UITGAAND GESPREK",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        call: {
            message: "GESPREK",
            description: "typically combined with incoming/outgoing above in title bar."
        },
        emailTo: {
            message: "Notities worden verzonden naar",
            description: "help text shown on hover over email indicator"
        },
        createTask: {
            message: "Taak wordt voor u aangemaakt voor",
            description: "help text shown on hover over task indicator"
        },
        queue: {
            message: "Wachtrij",
            description: "Shown on calls to an inbound call queue as a prefix"
        },
        hour: {
            message: "uur"
        },
        min: {
            message: "min",
            description: "short for minutes"
        },
        sec: {
            message: "sec",
            description: "short for seconds"
        },
        searchingForActivities: {
            message: "Zoeken naar activiteiten ...",
            description: "Activiteiten doos statusbericht terwijl de actviteiten te halen in progress"
        },
        noActivitiesFound: {
            message: "Geen activiteiten gevonden",
            description: "Activiteiten box statusbericht wanneer er geen activiteiten worden gevonden"
        },
        createNewContact: {
            message: "Nieuwe contactpersoon maken",
            description: "Wanneer meerdere contactpersonen weergeeft matching, maar de beller is niet een van hen nieuwe contactpunten"
        },
        create: {
            message: "Creëren",
            description: "creëren"
        },
        save: {
            message: "Besparen",
            description: "besparen"
        },
        noMatchEnterNameHere: {
            message: "Vul hier de naam",
            description: "Als er geen match zodat de gebruiker contact te maken"
        },
        noMatchEnterNameHelper: {
            message: "Om alle velden die u moet het record eerst creëren",
            description: "Om alle velden die u moet het record eerst creëren"
        },
        createRecord: {
            message: "Creëren ->",
            description: "To access all fields you must create the record first"
        },
        creatingRecord: {
            message: "Het creëren van Record",
            description: "Utilizado como el estado de transición para la creación de registro"
        },
        retrievingRecord: {
            message: "Record Opgehaald",
            description: "Dialoog Transition voor het ophalen van een record"
        },
        savingUpdates: {
            message: "Besparing Updates",
            description: "Dialoog Transition voor het opslaan van updates"
        },
        info: {
            message: "Info",
            description: "Info navigation button for different pages on top right"
        },
        dialpad: {
            message: "Dialpad",
            description: "Dialpad navigation button for different pages on top right"
        },
        back: {
            message: "Terug",
            description: "Terug"
        },
        dialpadDisabled: {
            message: "Toetsenblok uitgeschakeld tijdens een gesprek",
            description: "Toetsenblok uitgeschakeld tijdens een gesprek"
        },
        lead: {
            message: "Lead",
            description: "Lead"
        },
        contact: {
            message: "Contact",
            description: "Contact"
        },
        searchingRecords: {
            message: "Zoeken Records ....",
            description: "Zoeken Records ..."
        },
        answeredBy: {
            message: "Beantwoord door",
            description: "Beantwoord door"
        },
        loadingHistory: {
            message: "laden van historie...",
            description: "laden van historie..."
        },
        noInternet: {
            message: "geen internet...",
            description: "geen internet..."
        },
        showCallinize: {
            message: "Toon Popup",
            description: "Toon Popup"
        },
        showTour: {
            message: "Toon Tour",
            description: "Toon Tour"
        },
        settings: {
            message: "Settings",
            description: "Settings"
        },
        allCallHistory: {
            message: "Alle Oproepen",
            description: "Alle Oproepen"
        },
        clickToDial: {
            message: "Klik om te bellen",
            description: "Klik om te bellen"
        },
        noExtension: {
            message: "geen Uitbreiding",
            description: "geen Uitbreiding"
        },
        unknownContact: {
            message: "Neem contact op",
            description: "Neem contact op"
        },
        reportProblemCall: {
            message: "Probleem Melden Call",
            description: "Probleem Melden Call"
        },
        reload: {
            message: "Reload Extension",
            description: "Reload Extension"
        },
        updateStatusUpToDate: {
            message: "De nieuwste versie",
            description: "De nieuwste versie"
        },
        updateStatusOldVersion: {
            message: "oude versie",
            description: "oude versie"
        },
        switchToThisCallAndSaveExistingNotes: {
            message: "Switch & Save",
            description: "Switch & Save"
        },
        ignore: {
            message: "Negeren",
            description: "Negeren"
        },
        extensionConfigurationErrorTitle: {
            message: "Geen uitbreiding geconfigureerd",
            description: "No extension configured"
        },
        extensionConfigurationErrorMessage: {
            message: "Voor het configureren van een uitbreiding naar<a href='https://dashboard.tenfold.com/profile'>Callinize Dashboard</a> en voeg uw toestelnummer .",
            description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
        },
        microphonePermission: {
            message: "Wanneer u voor het eerst deze toepassing te starten , moet je toestemming voor geven om je microfoon te gebruiken . Ga dan naar het tabblad gemaakt en toestemming te geven .",
            description: "Ask for microphone permission"
        },
        noLoginTokenTitle: {
            message: "Tenfold uitgelogd",
            description: ""
        },
        noLoginTokenMessage: {
            message: "Log dan in op <a href='https://dashboard.tenfold.com'>Callinize</a>.  Voordat je dat doet , zult u geen oproep popups ontvangen.",
            description: "Message when a user clears there cookie and has nothing in chrome storage"
        },
        enabledRequirementTitle: {
            message: "Uw gebruikersnaam is niet ingeschakeld. Call popups zal niet werken totdat u zijn ingeschakeld.",
            description: "Message displayed to user when they are not enabled"
        },
        enabledRequirementMessage: {
            message: "Als u de admin login op <a href='https://dashboard.tenfold.com/users'>Callinize Dashboard</a> en in staat stellen zelf of als je een gebruiker bent, mail je admin en vraag hen om u in staat",
            description: "Message displayed to user when they are not enabled"
        },
        enterAccountHere: {
            message: "Enter Account Name",
            description: "Enter Account Name Here"
        },
        active: {
            message: "Actief",
            description: "Topbar toggle option to show the active call"
        },
        recent: {
            message: "Recent",
            description: "Topbar toggle option to show recent calls"
        }
    },
    pl: {
        extName: {
            message: "Callinize",
            description: "extension name -- Do not translate this... this is our company name."
        },
        extDescription: {
            message: "Tenfold integracja telefonii z CRM",
            description: "Shown in chrome://extensions page and maybe in the chrome store -- Translate it to say something like CRM Telephony Integration"
        },
        extShortName: {
            message: "Integracja telefonii z CRM",
            description: "Shown in chrome://extensions page and maybe in the chrome store"
        },
        selectContact: {
            message: "Wybierz kontakt",
            description: "Shown when there are multiple matching contacts"
        },
        matches: {
            message: "pokrywa się",
            description: "when there are multiple matches from the crm, this string shows - X matches"
        },
        unknownCaller: {
            message: "Nierozpoznany rozmówca",
            description: "Shown where contact name goes when phone number isn't found in CRM"
        },
        unknownNumber: {
            message: "Nieznany numer",
            description: "Shown when the phoneNumber is empty... this happens in cases like CallerID is blocked"
        },
        addNotes: {
            message: "Kliknij aby dodać notatkę",
            description: "placeholder text shown in note input box"
        },
        savedSuccessfully: {
            message: "Zapisano",
            description: "title when call notes are saved"
        },
        outboundCall: {
            message: "Kliknij aby zadzwonić",
            description: "title when call notes are saved"
        },
        callNotesSaved: {
            message: "Zapisano notatkę z rozmowy",
            description: "shown in desktop notification"
        },
        noteNotSaved: {
            message: "Nie zapisano",
            description: "title when call notes are not saved"
        },
        noteSaveError: {
            message: "Błąd. Nie zapisano notatki.",
            description: "shown in desktop notification  when notes are saved"
        },
        createRecordErrorTitle: {
            message: "Nie utworzono",
            description: "title when create records are not saved"
        },
        createRecordErrorDescription: {
            message: "Błąd. Nie udało się utworzyć rekord.",
            description: "shown in desktop notification  when records are not created"
        },
        taskCreatedFor: {
            message: "Zadanie zapisano z datą: ",
            description: "shown in desktop notification when notes are saved"
        },
        emailSentTo: {
            message: "Wiadomość wysłana do: ",
            description: "shown in desktop notification when notes are saved"
        },
        incoming: {
            message: "PRZYCHODZĄCA",
            description: "direction of the call, used in title bar and probably other places"
        },
        outgoing: {
            message: "WYCHODZĄCA",
            description: "direction of the call, used in title bar and probably other places"
        },
        incomingCall: {
            message: "ROZMOWA PRZYCHODZĄCA",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        outgoingCall: {
            message: "ROZMOWA WYCHODZĄCA",
            description: "direction of the call for title bar spanish grammar is call incoming hence the redundancy"
        },
        call: {
            message: "ROZMOWA",
            description: "typically combined with incoming/outgoing above in title bar."
        },
        emailTo: {
            message: "Notatka zostanie wysłana do ",
            description: "help text shown on hover over email indicator"
        },
        createTask: {
            message: "Tworzenie zadania przypisanego do Ciebie ",
            description: "help text shown on hover over task indicator"
        },
        queue: {
            message: "Kolejka",
            description: "Shown on calls to an inbound call queue as a prefix"
        },
        hour: {
            message: "godz"
        },
        min: {
            message: "min",
            description: "short for minutes"
        },
        sec: {
            message: "sek",
            description: "short for seconds"
        },
        searchingForActivities: {
            message: "Szukam...",
            description: "Activities box status message while the activities fetch in progress"
        },
        noActivitiesFound: {
            message: "Nie znaleziono",
            description: "Activities box status message when no activities are being found"
        },
        createNewContact: {
            message: "Utwórz nowy kontakt",
            description: "When multiple contacts displays matching, but the caller is not one of them create new contact"
        },
        create: {
            message: "Utwórz",
            description: "create"
        },
        save: {
            message: "Zapisz",
            description: "save"
        },
        noMatchEnterNameHere: {
            message: "Podaj imię",
            description: "When no match allow user to create contact"
        },
        noMatchEnterNameHelper: {
            message: "Aby uzyskać dostęp do wszystkich pól, najpierw utwórz rekord",
            description: "To access all fields you must create the record first"
        },
        createRecord: {
            message: "Utwórz ->",
            description: "To access all fields you must create the record first"
        },
        creatingRecord: {
            message: "Tworzę rekord",
            description: "Transition dialog for creating a record"
        },
        retrievingRecord: {
            message: "Pobieram rekord",
            description: "Transition dialog for retrieving a record"
        },
        savingUpdates: {
            message: "Zapisuję aktualizację",
            description: "Transition dialog for saving updates"
        },
        info: {
            message: "Info",
            description: "Info navigation button for different pages on top right"
        },
        dialpad: {
            message: "Klawiatura",
            description: "Dialpad navigation button for different pages on top right"
        },
        back: {
            message: "Wstecz",
            description: "Back"
        },
        disabledDialpad: {
            message: "Klawiatura wyłączona podczas rozmowy",
            description: "Dialpad disabled during call"
        },
        lead: {
            message: "Sprawa",
            description: "Lead"
        },
        contact: {
            message: "Kontakt",
            description: "Contact"
        },
        cancel: {
            message: "Anuluj",
            description: "Cancel"
        },
        searchingRecords: {
            message: "Szukam rekordów...",
            description: "Searching Records..."
        },
        noMatchTitle: {
            message: "Nie znaleziono",
            description: "Displayed when no matching record is found in CRM"
        },
        createRecordType: {
            message: "Wybierz typ rekordu",
            description: "Create record type?"
        },
        name: {
            message: "Imię",
            description: "Name"
        },
        answeredBy: {
            message: "Odebrane przez",
            description: "Answered by"
        },
        calledBy: {
            message: "Dzwoniący przez",
            description: "Called by"
        },
        assignedTo: {
            message: "Przypisane do",
            description: "Assigned to"
        },
        createdBy: {
            message: "Utworzone przez",
            description: "'Created by' as in the call was 'Created By: John'"
        },
        loadingHistory: {
            message: "Wczytuję historię...",
            description: "Loading History..."
        },
        noInternet: {
            message: "Brak sieci internet...",
            description: "No internet..."
        },
        showCallinize: {
            message: "Pokaż Popup",
            description: "Show Popup"
        },
        showTour: {
            message: "Pokaż objaśnienia",
            description: "Show Tour"
        },
        settings: {
            message: "Ustawienia",
            description: "Settings"
        },
        allCallHistory: {
            message: "Historia wszystkich rozmów",
            description: "All Call History"
        },
        clickToDial: {
            message: "Kliknij aby zadzwonić",
            description: "Click to dial"
        },
        noExtension: {
            message: "Brak Extension",
            description: "No Extension"
        },
        unknownContact: {
            message: "Nieznany kontakt",
            description: "Shown for unknown contacts in history view"
        },
        reportProblemCall: {
            message: "Zgłoś problem",
            description: "Report Problem Call"
        },
        reload: {
            message: "Przeładuj Extension",
            description: "Reload Extension"
        },
        updateStatusUpToDate: {
            message: "Nowsza wersja",
            description: "Newest Version"
        },
        updateStatusOldVersion: {
            message: "Stara wersja",
            description: "Old Version"
        },
        switchToThisCallAndSaveExistingNotes: {
            message: "Przełącz i zapisz",
            description: "Displayed to the user when a new call comes in while old call is active"
        },
        ignore: {
            message: "Ignoruj",
            description: "Ignore"
        },
        extensionConfigurationErrorTitle: {
            message: "Przedłużenie skonfigurowany",
            description: "No extension configured"
        },
        extensionConfigurationErrorMessage: {
            message: "Aby skonfigurowaćrozszerzenie go do <a href='https://dashboard.tenfold.com/profile'>Callinize Dashboard</a> i dodaj rozszerzenie telefonu .",
            description: "Displayed on top when a user logs in but does not have an extension configured.  Nothing will work."
        },
        microphonePermission: {
            message: "When you first start this application you must give permission for it to use your microphone.  Please go to the tab created and give permission.",
            description: "Ask for microphone permission"
        },
        noLoginTokenTitle: {
            message: "Tenfold wylogowany",
            description: ""
        },
        noLoginTokenMessage: {
            message: "Zaloguj się na <a href='https://dashboard.tenfold.com'>Callinize</a>.  Zanim to zrobisz , nie będziesz otrzymywać wyskakujące okienka połączeń.",
            description: "Message when a user clears there cookie and has nothing in chrome storage"
        },
        enabledRequirementTitle: {
            message: "Twój użytkownik nie jest aktywny. Wyskakujące okienka połączeń nie będzie działać, dopóki nie zostaną włączone.",
            description: "Message displayed to user when they are not enabled"
        },
        enabledRequirementMessage: {
            message: "Jeśli jesteś logowanie administratora w <a href='https://dashboard.tenfold.com/users'>Callinize Dashboard</a> i włączyć się lub jeżeli jesteś użytkownikiem, napisz z administratorem i poproś, aby umożliwić Ci.",
            description: "Message displayed to user when they are not enabled"
        },
        enterAccountHere: {
            message: "Enter Account Name",
            description: "Enter Account Name Here"
        },
        active: {
            message: "Aktywny",
            description: "Topbar toggle option to show the active call"
        },
        recent: {
            message: "Niedawny",
            description: "Topbar toggle option to show recent calls"
        }
    }
};

Mocks.prototype.firebase = function() {
    window.Firebase = function() {}, Firebase.enableLogging = function() {}, Firebase.prototype.onAuth = function() {}, 
    Firebase.prototype.authWithCustomToken = function(token, callback) {
        callback(null, "mock data");
    }, window.Firebase = Firebase;
}, window.callinizeContextMenus = {
    init: function() {}
}, NLPDate.prototype.extract = function(message, locale) {
    var taskDate = null, self = this;
    if (!message) return null;
    if (message = message.replace(/(\r\n|\n|\r)/gm, ""), self.daysOfTheWeek.forEach(function(dayWeek) {
        message = self._replaceDayOfWeek(dayWeek.phrase, dayWeek.replace, message);
    }), self.replacements.forEach(function(phrase) {
        message = self._replaceAll(phrase.phrase, phrase.replace, message);
    }), void 0 === locale) try {
        locale = chrome.i18n.getMessage("@@ui_locale");
        var matches = locale.match(/([a-zA-Z]{2})_/);
        locale.match(/([a-zA-Z]{2})_/) && (locale = matches[1]);
    } catch (err) {}
    message = message.replace(/\./g, " "), this._regexp = new RegExp(this.pattern, "gi");
    var match = this._regexp.exec(message);
    if (match && match.length) {
        try {
            var languageDate = match[2].replace(/\./g, " ").trim();
            if (!languageDate) return;
            -1 !== languageDate.indexOf("tomorrow") && (languageDate = "tomorrow"), -1 !== languageDate.indexOf("week ") && (languageDate = languageDate.split("week ")[0] + "week"), 
            languageDate = languageDate.replace(/-/gi, "/"), "en" !== locale && (taskDate = Date.create(languageDate, locale)), 
            (!taskDate || taskDate < new Date()) && (taskDate = chrono.parseDate(languageDate));
        } catch (err) {
            console.log("ERROR: Make sure Sugar.js Date framework is loaded", err);
        }
        "Invalid Date" == taskDate && (taskDate = null);
    }
    return taskDate;
}, NLPDate.prototype._replaceAll = function(find, replace, str) {
    return "string" == typeof str ? str.replace(new RegExp(find, "gi"), replace) : str;
}, "undefined" != typeof module && (module.exports = NLPDate), NLPDate.prototype._replaceDayOfWeek = function(findDay, replace, string) {
    var str = string.toLowerCase().trim();
    if (findDay = findDay.toLowerCase().trim(), "string" != typeof str) return string;
    if (-1 === str.indexOf(findDay)) return string;
    str = str.replace(/, ?/g, " "), str = str.replace(/[0-9]?[0-9] ?/g, " ");
    var searchPhrases = [];
    [ "january", "february", "march", "april", "may", "june", "july", "august", "september", "october", "november", "december" ].forEach(function(month) {
        var thisMonth = month.substr(0, 3);
        searchPhrases.push(findDay + " " + thisMonth);
    });
    var doReturn = !1;
    return searchPhrases.some(function(phrase) {
        if (-1 !== str.indexOf(phrase)) return doReturn = !0;
    }), !0 === doReturn ? string : str.replace(new RegExp(findDay, "gi"), replace);
}, window.spinner = new Spinner(), window.spinner.show();