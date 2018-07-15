angular.module('callinize').run(['$templateCache', function($templateCache) {
  'use strict';

  $templateCache.put('../app/views/action-bottom-bar.html',
    "<div class=\"action-bottom-bar\" ng-show=\"isBarVisible()\">\n" +
    "    <div class=\"title\">Extra actions</div>\n" +
    "    <div class=\"action-buttons\">\n" +
    "        <custom-workflow ng-show=\"hasCustomWorkflowEnabled\"></custom-workflow>\n" +
    "    </div>\n" +
    "</div>"
  );


  $templateCache.put('../app/views/activeCall.html',
    "<div id=\"content\" ng-switch on=\"innerView\" class=\"fill-parent-flex\">\n" +
    "    <no-active-call ng-switch-when=\"noActiveCall\"></no-active-call>\n" +
    "    <single-match ng-switch-when=\"singleMatch\"></single-match>\n" +
    "    <searching-records ng-switch-when=\"searchingRecords\" class=\"fill-parent\"></searching-records>\n" +
    "    <multiple-matches ng-switch-when=\"multipleMatches\" class=\"fill-parent fill-parent-flex\"></multiple-matches>\n" +
    "    <no-matches ng-switch-when=\"noMatches\" class=\"fill-parent fill-parent-flex\"></no-matches>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/activities.html',
    "<div id=\"activities-container\">\n" +
    "    <div class=\"widget-label\">Recent Activities</div>\n" +
    "    <div class=\"carrousel-arrows\">\n" +
    "        <span id=\"carrousel-arrow-left\" class=\"carrousel-arrow\"\n" +
    "            ng-show=\"activities.length && activities.length > 1\">\n" +
    "            <i class=\"material-icons\">keyboard_arrow_left</i>\n" +
    "        </span>\n" +
    "        <span id=\"carrousel-arrow-right\" class=\"carrousel-arrow\"\n" +
    "            ng-show=\"activities.length && activities.length > 1\">\n" +
    "            <i class=\"material-icons\">keyboard_arrow_right</i>\n" +
    "        </span>\n" +
    "    </div>\n" +
    "    <div id=\"activities-carrousel-container\" ng-show=\"created\">\n" +
    "        <div id=\"activities-carrousel-content\">\n" +
    "            <div ng-repeat=\"activity in activities\" class=\"activity-wrapper\">\n" +
    "                <activity activity=\"activity\" open-record-link=\"openRecordLink\"></activity>\n" +
    "            </div>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "    <div id=\"activities-msg-container\">\n" +
    "        <div ng-if=\"!activities && !activitiesError\">\n" +
    "            Searching for activities\n" +
    "        </div>\n" +
    "        <div ng-if=\"activities && !activities.length\">\n" +
    "            No activities found\n" +
    "        </div>\n" +
    "        <div ng-if=\"!activities && activitiesError\">\n" +
    "            Error fetching activities. Click <a href=\"javascript:void()\" ng-click=\"retry()\">here</a> to try again\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/activity-types/cases.html',
    "<div class=\"callinize_activity_type_container\">\n" +
    "  <span>Case </span> #<a ng-click=\"openRecordLink(activity.link, activity.id, activity.casenumber)\"\n" +
    "                         class=\"case-number-label\" href=\"javascript:void(0)\">{{activity.casenumber}}</a>\n" +
    "  <span class=\"ticket_status_label\" ng-class=\"activity.status\">{{activity.status}}</span>\n" +
    "  <span class=\"ticket_status_label\" ng-class=\"activity.priority\">{{activity.priority}}</span> <span translate=\"created\"></span>\n" +
    "</div>\n" +
    "\n" +
    "<!--\n" +
    "<div class=\"callinize_activity_type_container\" feature=\"cases\" feature-disabled=\"true\">\n" +
    "  <span translate=\"caseRelateButBlocked\"></span>\n" +
    "</div>\n" +
    "\n" +
    "<span feature=\"{{activity.activity}}\" class=\"callinize_note_text\" title=\"{{activity.text}}\">{{activity.text}}</span>\n" +
    "<span feature=\"{{activity.activity}}\" feature-disabled=\"true\" class=\"callinize_note_text\" title=\"{{activity.text}}\">\n" +
    "  <a href=\"https://www.tenfold.com/pricing/\" target=\"_blank\">Upgrade</a> your plan to see it here. <a href=\"#\" ng-click=\"ignoreUpgrade($event)\">No thanks</a>\n" +
    "</span>\n" +
    "-->"
  );


  $templateCache.put('../app/views/activity-types/default.html',
    "<div class=\"callinize_activity_type_container\"><span>Created by</span> {{activity.created}}</div>\n" +
    "\n" +
    "<span feature=\"{{activity.activity}}\" class=\"callinize_note_text\" title=\"{{activity.text}}\">{{activity.text}}</span>\n"
  );


  $templateCache.put('../app/views/activity-types/inboundCall.html',
    "<div class=\"callinize_activity_type_container\"><span>Answered by</span> {{activity.created}}</div>\n" +
    "\n" +
    "<span feature=\"{{activity.activity}}\" class=\"callinize_note_text\" title=\"{{activity.text}}\">{{activity.text}}</span>\n"
  );


  $templateCache.put('../app/views/activity-types/opportunities.html',
    "<div class=\"callinize_activity_type_container\" feature=\"opportunities\">\n" +
    "    Opp: <a class=\"case-number-label main-text\"\n" +
    "            href=\"javascript:void(0)\"\n" +
    "            ng-click=\"openRecordLink(activity.link, activity.id, activity.name)\">{{activity.name}}</a>\n" +
    "    <span class=\"ticket_status_label\">{{activity.stage}}</span>\n" +
    "</div>\n" +
    "\n" +
    "<div class=\"callinize_activity_type_container\" feature=\"opportunities\" feature-disabled=\"true\">\n" +
    "    <span translate=\"opportunityRelateButBlocked\"></span>\n" +
    "</div>\n" +
    "\n" +
    "<span feature=\"{{activity.activity}}\" class=\"callinize_note_text\">\n" +
    "    <span class=\" pull-left\" translate=\"amount\" ng-show=\"activity.amount\"></span>\n" +
    "    <span class=\"ticket_status_label pull-left\" ng-bind=\"activity.amount\" ng-show=\"activity.amount\"></span>\n" +
    "\n" +
    "    <span class=\"pull-left\" translate=\"probability\" ng-show=\"activity.probability\"></span>\n" +
    "    <span class=\"ticket_status_label pull-left\" ng-bind=\"activity.probability\" ng-show=\"activity.probability\"></span>\n" +
    "</span>\n" +
    "\n" +
    "<span feature=\"{{activity.activity}}\" feature-disabled=\"true\" class=\"callinize_note_text\">\n" +
    "  <a href=\"https://www.tenfold.com/pricing/\" target=\"_blank\">Upgrade</a> your plan to see it here. <a href=\"#\" ng-click=\"ignoreUpgrade($event)\">No thanks</a>\n" +
    "</span>"
  );


  $templateCache.put('../app/views/activity-types/outboundCall.html',
    "<div class=\"callinize_activity_type_container\"><span>Called by</span> {{activity.created}}</div>\n" +
    "\n" +
    "<span feature=\"{{activity.activity}}\" class=\"callinize_note_text\" title=\"{{activity.text}}\">{{activity.text}}</span>\n"
  );


  $templateCache.put('../app/views/activity-types/question.html',
    "<div class=\"callinize_activity_type_container\" feature=\"cases\">\n" +
    "  <span>Case</span> #<a target=\"_blank\" class=\"case-number-label\" ng-href=\"{{activity.link}}\">{{activity.casenumber}}</a>\n" +
    "  <span class=\"ticket_status_label\" ng-class=\"activity.status\">{{activity.status}}</span>\n" +
    "  <span class=\"ticket_status_label\" ng-class=\"activity.priority\">{{activity.priority}}</span> <span translate=\"created\"></span>\n" +
    "</div>\n" +
    "\n" +
    "<div class=\"callinize_activity_type_container\" feature=\"cases\" feature-disabled=\"true\">\n" +
    "  <span translate=\"caseRelateButBlocked\"></span>\n" +
    "</div>\n" +
    "\n" +
    "<span feature=\"{{activity.activity}}\" class=\"callinize_note_text\" title=\"{{activity.text}}\">{{activity.text}}</span>\n" +
    "<span feature=\"{{activity.activity}}\" feature-disabled=\"true\" class=\"callinize_note_text\" title=\"{{activity.text}}\">\n" +
    "  <a href=\"https://www.tenfold.com/pricing/\" target=\"_blank\">Upgrade</a> your plan to see it here. <a href=\"#\" ng-click=\"ignoreUpgrade($event)\">No thanks</a>\n" +
    "</span>\n"
  );


  $templateCache.put('../app/views/activity-types/task.html',
    "<div class=\"callinize_activity_type_container\"><span>Created by</span> {{activity.created}} due</div>\n" +
    "\n" +
    "<span feature=\"{{activity.activity}}\" class=\"callinize_note_text\" title=\"{{activity.text}}\">{{activity.text}}</span>\n"
  );


  $templateCache.put('../app/views/activity-types/tasks.html',
    "<div class=\"callinize_activity_type_container\"><span>Created by</span> {{activity.created}} due</div>\n" +
    "\n" +
    "<span feature=\"{{activity.activity}}\" class=\"callinize_note_text\" title=\"{{activity.text}}\">{{activity.text}}</span>\n"
  );


  $templateCache.put('../app/views/activity-types/ticket.html',
    "<div class=\"callinize_activity_type_container\" feature=\"cases\">\n" +
    "  <span>Case</span> #<a target=\"_blank\" class=\"case-number-label\" ng-href=\"{{activity.link}}\">{{activity.casenumber}}</a>\n" +
    "  <span class=\"ticket_status_label\" ng-class=\"activity.status\">{{activity.status}}</span>\n" +
    "  <span class=\"ticket_status_label\" ng-class=\"activity.priority\">{{activity.priority}}</span> <span translate=\"created\"></span>\n" +
    "</div>\n" +
    "\n" +
    "<div class=\"callinize_activity_type_container\" feature=\"cases\" feature-disabled=\"true\">\n" +
    "  <span translate=\"caseRelateButBlocked\"></span>\n" +
    "</div>\n" +
    "\n" +
    "<span feature=\"{{activity.activity}}\" class=\"callinize_note_text\" title=\"{{activity.text}}\">{{activity.text}}</span>\n" +
    "<span feature=\"{{activity.activity}}\" feature-disabled=\"true\" class=\"callinize_note_text\" title=\"{{activity.text}}\">\n" +
    "  <a href=\"https://www.tenfold.com/pricing/\" target=\"_blank\">Upgrade</a> your plan to see it here. <a href=\"#\" ng-click=\"ignoreUpgrade($event)\">No thanks</a>\n" +
    "</span>\n"
  );


  $templateCache.put('../app/views/activity-types/tickets.html',
    "<div class=\"callinize_activity_type_container\" feature=\"cases\">\n" +
    "  <span translate=\"Case\"></span> #<a target=\"_blank\" class=\"case-number-label\" ng-href=\"{{activity.link}}\">{{activity.casenumber}}</a>\n" +
    "  <span class=\"ticket_status_label\" ng-class=\"activity.status\">{{activity.status}}</span>\n" +
    "  <span class=\"ticket_status_label\" ng-class=\"activity.priority\">{{activity.priority}}</span> <span translate=\"created\"></span>\n" +
    "</div>\n" +
    "\n" +
    "<div class=\"callinize_activity_type_container\" feature=\"cases\" feature-disabled=\"true\">\n" +
    "  <span translate=\"caseRelateButBlocked\"></span>\n" +
    "</div>\n" +
    "\n" +
    "<span feature=\"{{activity.activity}}\" class=\"callinize_note_text\" title=\"{{activity.text}}\">{{activity.text}}</span>\n" +
    "<span feature=\"{{activity.activity}}\" feature-disabled=\"true\" class=\"callinize_note_text\" title=\"{{activity.text}}\">\n" +
    "  <a href=\"https://www.tenfold.com/pricing/\" target=\"_blank\">Upgrade</a> your plan to see it here. <a href=\"#\" ng-click=\"ignoreUpgrade($event)\">No thanks</a>\n" +
    "</span>"
  );


  $templateCache.put('../app/views/activity.html',
    "<div class=\"activity-content\" title=\"{{activity.text}}\">\n" +
    "    <div class=\"activity-title\">\n" +
    "        <a href=\"javascript:void(0)\"\n" +
    "            class=\"activity-image material-icons\"\n" +
    "            ng-click=\"openRecordLink(activity.link, activity.id, activity.name)\">\n" +
    "                {{activity.activity | activityClass}}\n" +
    "        </a>\n" +
    "        <span class=\"activity-created-by-date\"\n" +
    "            feature=\"{{activity.activity}}\">\n" +
    "            {{activity.date|relativeDate}}\n" +
    "        </span>\n" +
    "    </div>\n" +
    "    <div class='activity-content'>\n" +
    "        <div class='activity-dynamic-content'>\n" +
    "\n" +
    "            <activity-type ng-include=\"activity.template\"></activity-type>\n" +
    "\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/agent-status.html',
    "<div id=\"user-status-container\">\n" +
    "    <span class=\"status-indicator {{currentStatus.type | lowercase}}\">\n" +
    "    </span>\n" +
    "    <span class=\"user-status\" ng-cloak>\n" +
    "        {{(currentStatus.type || 'offline') | translate}}{{currentStatus.reason ? ' - ' + currentStatus.reason : ''}}\n" +
    "    </span>\n" +
    "    <i class=\"material-icons\">arrow_drop_down</i>\n" +
    "</div>\n" +
    "<div id=\"status-modal\" class=\"modal\" trigger=\"#user-status-container\">\n" +
    "    <div class=\"modal-content\">\n" +
    "        <div class=\"modal-title\">Status</div>\n" +
    "\n" +
    "        <div class=\"modal-content\">\n" +
    "            <div id=\"status-list\" ng-if=\"!showLoginModal\">\n" +
    "                <div ng-if=\"isStatusOffline(currentStatus)\" class=\"container\">\n" +
    "                    To change your status please login to your agent status service provider\n" +
    "                </div>\n" +
    "                <div class=\"disposition-value \"\n" +
    "                     ng-click=\"selectStatus(status)\"\n" +
    "                     ng-repeat=\"status in statuses\"\n" +
    "                     ng-class=\"{selected : currentStatus.id == status.id, disabled : isStatusDisabled(status)}\">\n" +
    "                    <input id=\"agent-status-option-{{$index}}\"\n" +
    "                           name=\"dispo-checkbox-radio\"\n" +
    "                           type=\"radio\"\n" +
    "                           ng-disabled=\"isStatusDisabled(status)\"\n" +
    "                           ng-checked=\"currentStatus.id == status.id\">\n" +
    "                    <label for=\"agent-status-option-{{$index}}\" ng-cloak>\n" +
    "                        {{status.type | translate}}{{status.reason ? ' - ' + status.reason : ''}}\n" +
    "                    </label>\n" +
    "                </div>\n" +
    "            </div>\n" +
    "            <div id=\"status-login\" ng-if=\"showLoginModal\" class=\"container\">\n" +
    "                <form ng-submit=\"loginToPhoneSystem()\">\n" +
    "                    <div class=\"login-field\">\n" +
    "                        <label>Agent ID</label>\n" +
    "                        <input type=\"text\"\n" +
    "                               name=\"username\"\n" +
    "                               class=\"line\"\n" +
    "                               required\n" +
    "                               ng-model=\"login.agentId\">\n" +
    "                    </div>\n" +
    "                    <div class=\"login-field\">\n" +
    "                        <label>Password</label>\n" +
    "                        <input type=\"password\"\n" +
    "                               name=\"password\"\n" +
    "                               class=\"line\"\n" +
    "                               ng-model=\"login.password\">\n" +
    "                    </div>\n" +
    "                    <div class=\"login-field\">\n" +
    "                        <label>Extension</label>\n" +
    "                        <select required ng-model=\"login.extension\" ng-options=\"extension.extension as extension.extension for extension in extensions\"></select>\n" +
    "                    </div>\n" +
    "                </form>\n" +
    "            </div>\n" +
    "        </div>\n" +
    "\n" +
    "\n" +
    "        <div class=\"modal-footer-buttons\" style=\"padding: 0 !important;\">\n" +
    "            <button id=\"dispositions-close-button\" type=\"button\"\n" +
    "                    class=\"callinize-btn cancel-button modal-close-button\">Close</button>\n" +
    "            <button type=\"button\"\n" +
    "                    ng-if=\"showLoginModal\"\n" +
    "                    ng-click=\"loginToPhoneSystem()\"\n" +
    "                    class=\"callinize-btn save-button\">Login</button>\n" +
    "            <button type=\"button\"\n" +
    "                    ng-if=\"!showLoginModal && loginRequired\"\n" +
    "                    ng-click=\"logoutFromPhoneSystem()\"\n" +
    "                    class=\"callinize-btn save-button\">Logout</button>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>"
  );


  $templateCache.put('../app/views/assignRecordParent.html',
    "<a id=\"assign-record-parent\"\n" +
    "   ng-show=\"arpc.supported\"\n" +
    "   class=\"edit-record-link\"\n" +
    "   target=\"_blank\"\n" +
    "   href=\"javascript:void(0)\">\n" +
    "    <i class=\"material-icons\" style=\"font-size:18px;\">mode_edit</i>\n" +
    "</a>\n" +
    "\n" +
    "<div id=\"assign-record-parent-modal\" class=\"modal\" trigger=\"#assign-record-parent\">\n" +
    "    <div class=\"modal-content\">\n" +
    "        <div class=\"modal-title\">Parent Account</div>\n" +
    "        <div class=\"modal-content\">\n" +
    "\n" +
    "            <div class=\"modal-padding\">\n" +
    "                <floating-label-input placeholder=\"Type to search\"\n" +
    "                                      is-searching=\"arpc.searching\"\n" +
    "                                      input=\"arpc.searchModel\"\n" +
    "                                      search=\"remote\"\n" +
    "                                      filter-modules=\"arpc.filterModules\"\n" +
    "                                      records=\"arpc.records\">\n" +
    "                </floating-label-input>\n" +
    "            </div>\n" +
    "\n" +
    "            <div class=\"disposition-value\"\n" +
    "                 data-selectable\n" +
    "                 data-value\n" +
    "                 ng-repeat=\"record in arpc.records\"\n" +
    "                 ng-click=\"arpc.assignAccount(record)\"\n" +
    "                 ng-class=\"{selected : arpc.selectedAccount === record.bean_id}\">\n" +
    "                <div class=\"disposition-checkbox\"></div>\n" +
    "                <div class=\"disposition-label ellipsis\">{{record.bean_name}}</div>\n" +
    "            </div>\n" +
    "\n" +
    "        </div>\n" +
    "        <div class=\"modal-footer-buttons\">\n" +
    "            <button type=\"button\" class=\"callinize-btn cancel-button modal-close-button\">Close</button>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>"
  );


  $templateCache.put('../app/views/call-controls.html',
    "<div class=\"call-controls\"\n" +
    "     feature=\"callControls\"\n" +
    "     defaults-to-hide=\"true\"\n" +
    "     ng-if=\"isCallActive()\">\n" +
    "    <button ng-if=\"isIncoming() && isRinging()\"\n" +
    "            class=\"disabled\"\n" +
    "            ng-click=\"answer()\"\n" +
    "            ng-class=\"{green: isRinging(), blocked: ongoingRequest}\"\n" +
    "            title=\"Answer\">\n" +
    "        <i class=\"material-icons\">call</i>\n" +
    "    </button>\n" +
    "    <button class=\"disabled\"\n" +
    "            ng-click=\"toggleHold()\"\n" +
    "            ng-class=\"{green: (isConnected() || isOnHold()) && !isWarmTransferInProgress(), blocked: ongoingRequest}\"\n" +
    "            title=\"{{isOnHold() ? 'Retrieve' : 'Hold'}}\">\n" +
    "        <i ng-if=\"!isOnHold()\" class=\"material-icons\">pause</i>\n" +
    "        <i ng-if=\"isOnHold()\" class=\"material-icons\">play_arrow</i>\n" +
    "    </button>\n" +
    "    <button ng-if=\"!isWarmTransferInProgress()\"\n" +
    "            class=\"disabled\"\n" +
    "            ng-click=\"openTransferModal()\"\n" +
    "            ng-class=\"{green: isConnected() && !isOnHold(), blocked: ongoingRequest}\"\n" +
    "            title=\"Transfer\">\n" +
    "        <i class=\"material-icons\">compare_arrows</i>\n" +
    "    </button>\n" +
    "    <button ng-if=\"isWarmTransferInProgress()\"\n" +
    "            class=\"disabled green warm-transfer\"\n" +
    "            ng-click=\"completeWarmTransfer()\"\n" +
    "            ng-class=\"{blocked: ongoingRequest}\"\n" +
    "            title=\"Complete Transfer\">\n" +
    "        <i class=\"material-icons arrows\">compare_arrows</i>\n" +
    "        <i class=\"material-icons check\">check</i>\n" +
    "    </button>\n" +
    "    <button class=\"disabled\"\n" +
    "            ng-click=\"openConferenceModal()\"\n" +
    "            ng-class=\"{green: isConnected() && !isOnHold(), blocked: ongoingRequest}\"\n" +
    "            title=\"Conference\">\n" +
    "        <i class=\"material-icons\">people</i>\n" +
    "    </button>\n" +
    "    <button ng-if=\"!isWarmTransferInProgress()\"\n" +
    "            class=\"disabled\"\n" +
    "            ng-click=\"hangup()\"\n" +
    "            ng-class=\"{red: isConnected() || isOnHold(), blocked: ongoingRequest}\"\n" +
    "            title=\"Hangup\">\n" +
    "        <i class=\"material-icons\">call_end</i>\n" +
    "    </button>\n" +
    "    <button ng-if=\"isWarmTransferInProgress()\"\n" +
    "            class=\"disabled red\"\n" +
    "            ng-click=\"cancelTransfer()\"\n" +
    "            ng-class=\"{blocked: ongoingRequest}\"\n" +
    "            title=\"Cancel\">\n" +
    "        <i class=\"material-icons\">close</i>\n" +
    "    </button>\n" +
    "\n" +
    "    <div id=\"transfer-modal\" class=\"modal\">\n" +
    "        <div id=\"transfer-panel\" class=\"modal-content\">\n" +
    "            <div class=\"modal-title\">Transfer call</div>\n" +
    "            <div style=\"padding:0 10px;\">\n" +
    "                <floating-label-input placeholder=\"Search for user\"\n" +
    "                                      input=\"query\">\n" +
    "                </floating-label-input>\n" +
    "            </div>\n" +
    "            <div id=\"transfer-content\">\n" +
    "                <div ng-repeat=\"user in users | filter:{name:query}\">\n" +
    "                    <div ng-bind=\"user.name\" class=\"ellipsis transfer-user\"></div>\n" +
    "                    <div ng-repeat=\"extension in user.extensions\"\n" +
    "                         ng-click=\"selectExtension(extension)\"\n" +
    "                         ng-class=\"{active: selectedTransferExtension === extension}\"\n" +
    "                         class=\"transfer-extension\">\n" +
    "                        <input id=\"transfer-extension-option-{{$index}}\"\n" +
    "                               name=\"transfer-radio\"\n" +
    "                               type=\"radio\"\n" +
    "                               ng-checked=\"selectedTransferExtension === extension\">\n" +
    "                        <span ng-bind=\"extension\"></span>\n" +
    "                    </div>\n" +
    "                </div>\n" +
    "            </div>\n" +
    "            <div class=\"modal-footer-buttons transfer-buttons\" style=\"padding: 0 !important;\">\n" +
    "                <button type=\"button\"\n" +
    "                        ng-click=\"warmTransfer()\"\n" +
    "                        ng-disabled=\"!selectedTransferExtension\"\n" +
    "                        class=\"callinize-btn button-error modal-close-button\">\n" +
    "                    Warm\n" +
    "                </button>\n" +
    "\n" +
    "                <button type=\"button\"\n" +
    "                        ng-click=\"blindTransfer()\"\n" +
    "                        ng-disabled=\"!selectedTransferExtension\"\n" +
    "                        class=\"callinize-btn button-primary modal-close-button\">\n" +
    "                    Transfer\n" +
    "                </button>\n" +
    "\n" +
    "                <button type=\"button\"\n" +
    "                        class=\"callinize-btn cancel-button modal-close-button\">\n" +
    "                    Cancel\n" +
    "                </button>\n" +
    "            </div>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "\n" +
    "    <div id=\"conference-modal\" class=\"modal\">\n" +
    "        <div id=\"conference-panel\" class=\"modal-content\">\n" +
    "            <div class=\"modal-title\">Conference call</div>\n" +
    "            <div style=\"padding:0 10px;\">\n" +
    "                <floating-label-input placeholder=\"Search for user\"\n" +
    "                                      input=\"query\">\n" +
    "                </floating-label-input>\n" +
    "            </div>\n" +
    "            <div id=\"conference-content\">\n" +
    "                <div ng-repeat=\"user in users | filter:{name:query}\">\n" +
    "                    <div ng-bind=\"user.name\" class=\"ellipsis transfer-user\"></div>\n" +
    "                    <div ng-repeat=\"extension in user.extensions\"\n" +
    "                         ng-click=\"selectExtension(extension)\"\n" +
    "                         ng-class=\"{active: selectedTransferExtension === extension}\"\n" +
    "                         class=\"transfer-extension\">\n" +
    "                        <input id=\"conference-extension-option-{{$index}}\"\n" +
    "                               name=\"conf--radio\"\n" +
    "                               type=\"radio\"\n" +
    "                               ng-checked=\"selectedTransferExtension === extension\">\n" +
    "                        <span ng-bind=\"extension\"></span>\n" +
    "                    </div>\n" +
    "                </div>\n" +
    "            </div>\n" +
    "            <div class=\"modal-footer-buttons transfer-buttons\" style=\"padding: 0 !important;\">\n" +
    "                <button type=\"button\"\n" +
    "                        ng-click=\"conference()\"\n" +
    "                        ng-disabled=\"!selectedTransferExtension\"\n" +
    "                        class=\"callinize-btn button-primary modal-close-button\">\n" +
    "                    Conference\n" +
    "                </button>\n" +
    "                <button type=\"button\"\n" +
    "                        class=\"callinize-btn cancel-button modal-close-button\">\n" +
    "                    Cancel\n" +
    "                </button>\n" +
    "            </div>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>"
  );


  $templateCache.put('../app/views/call-info.html',
    "<div ng-if=\"call.direction.toLowerCase() === 'inbound'\">\n" +
    "    <div class=\"flex-space-between\">\n" +
    "        <div>Caller ID</div>\n" +
    "        <a href=\"javascript:void(0)\"\n" +
    "           title=\"Click to dial\"\n" +
    "           class=\"number\"\n" +
    "           ng-click=\"originateCall({activeCall: call.phoneNumber, record: call.matchedCrmRecords[0]})\">\n" +
    "            <span ng-bind=\"call.phoneNumber\"></span>\n" +
    "            <i class=\"material-icons\" style=\"font-size:18px;margin-left:5px\">phone</i>\n" +
    "        </a>\n" +
    "    </div>\n" +
    "    <div ng-if=\"call.calledNumber\" class=\"flex-space-between\">\n" +
    "        <div>Dialed Number</div>\n" +
    "        <span ng-bind=\"call.calledNumber\"></span>\n" +
    "    </div>\n" +
    "    <div ng-if=\"call.isQueue\" class=\"flex-space-between\">\n" +
    "        <div>Queue</div>\n" +
    "        <span ng-bind=\"call.queue\"></span>\n" +
    "    </div>\n" +
    "</div>\n" +
    "<div ng-if=\"call.direction.toLowerCase() === 'outbound'\">\n" +
    "    <div class=\"flex-space-between\">\n" +
    "        <div>Dialed Number</div>\n" +
    "        <a href=\"javascript:void(0)\"\n" +
    "           title=\"Click to dial\"\n" +
    "           class=\"number\"\n" +
    "           ng-click=\"originateCall({activeCall: call.phoneNumber, record: call.matchedCrmRecords[0]})\">\n" +
    "            <span ng-bind=\"call.calledNumber || call.phoneNumber\"></span>\n" +
    "            <i class=\"material-icons\" style=\"font-size:18px;margin-left:5px\">phone</i>\n" +
    "        </a>\n" +
    "    </div>\n" +
    "</div>"
  );


  $templateCache.put('../app/views/call-recorder.html',
    "<button id=\"call-recorder\"\n" +
    "        ng-if=\"recordingEnabled\"\n" +
    "        ng-click=\"toggleRecording()\"\n" +
    "        ng-attr-title=\"buttonState.title\"\n" +
    "        ng-class=\"currentState\"\n" +
    "        type=\"button\"\n" +
    "		class=\"feature-btn\">\n" +
    "	<div class=\"rec-icon\"></div>\n" +
    "	<div ng-bind=\"buttonState.message\"></div>\n" +
    "</button>\n"
  );


  $templateCache.put('../app/views/contactSearch.html',
    "<div id=\"contact-search-container\" class=\"fill-parent fill-parent-flex\">\n" +
    "    <floating-label-input placeholder=\"Add number to record\"\n" +
    "                          is-searching=\"isSearching\"\n" +
    "                          input=\"contactName\"\n" +
    "                          search=\"remote\"\n" +
    "                          records=\"records\">\n" +
    "    </floating-label-input>\n" +
    "    <div id=\"cancel-create-record\" ng-show=\"activeCall._matchedCrmRecords.length\">\n" +
    "        <a href=\"javascript:void(0);\" ng-click=\"cancel()\">Cancel</a>\n" +
    "    </div>\n" +
    "    <div ng-show=\"contactName.length\">\n" +
    "        <div id=\"no-results-msg\" ng-show=\"!isSearching && !records.length\">No results</div>\n" +
    "    </div>\n" +
    "    <record-list\n" +
    "            active-call='activeCall'\n" +
    "            filter=\"contactName\"\n" +
    "            select-record=\"addNumberToRecord(record)\"\n" +
    "            records=\"records\"\n" +
    "            ng-show=\"records.length\"\n" +
    "            class=\"grow overflow\"></record-list>\n" +
    "    <create-record ng-show=\"contactName.length\"></create-record>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/createRecord.html',
    "<div class=\"create-record-container\" ng-controller=\"CreateRecordController\">\n" +
    "	<div class=\"title\">Or create new</div>\n" +
    "	<div class=\"create-record-actions\">\n" +
    "	    <button class=\"callinize-btn create-record-button\" ng-click=\"createRecord(recordType, contactName)\"\n" +
    "	            ng-repeat=\"recordType in recordTypes\" ng-bind=\"recordType | limitTo:2\" title=\"{{recordType}}\">\n" +
    "	    </button>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/cti-header.html',
    "<div id=\"logo-container\"\n" +
    "     class=\"container flex-space-between\"\n" +
    "     ng-class=\"{loggedIn: outterView !== 'notLoggedIn'}\"\n" +
    "     style=\"padding: 0;\">\n" +
    "    <img src=\"/resource/1514310885956/dev_tenfold__logo_svg\" ng-if=\"!agentStatusAvailable\" class=\"align-logo-left\"/>\n" +
    "    <agent-status ng-show=\"outterView !== 'notLoggedIn' && agentStatusAvailable\"></agent-status>\n" +
    "    <cti-settings ng-if=\"outterView !== 'notLoggedIn'\"></cti-settings>\n" +
    "</div>\n" +
    "\n" +
    "<custom-caller-settings ng-if=\"outterView !== 'notLoggedIn'\"\n" +
    "                        class=\"custom-caller-header\"\n" +
    "                        feature=\"customCallerId\"\n" +
    "                        defaults-to-hide=\"true\"\n" +
    "                        feature-preference=\"customCallerInMainView\">\n" +
    "</custom-caller-settings>"
  );


  $templateCache.put('../app/views/cti-settings.html',
    "<button id=\"cti-settings\"\n" +
    "        title=\"Settings\"\n" +
    "        type=\"button\"\n" +
    "        class=\"feature-btn\">\n" +
    "    <i class=\"material-icons\" ng-cloak>settings</i>\n" +
    "</button>\n" +
    "\n" +
    "<div id=\"cti-settings-modal\" class=\"modal\" trigger=\"#cti-settings\">\n" +
    "    <div class=\"modal-content\">\n" +
    "        <div class=\"modal-title\">Settings</div>\n" +
    "\n" +
    "        <div id=\"settings-content\" class=\"modal-content\">\n" +
    "            <primary-extension-toggle feature=\"advancedClickToDial\" defaults-to-hide=\"true\" callinize=\"callinize\"></primary-extension-toggle>\n" +
    "            <custom-caller-settings feature=\"customCallerId\" defaults-to-hide=\"true\"></custom-caller-settings>\n" +
    "        </div>\n" +
    "\n" +
    "        <div class=\"modal-footer-buttons\">\n" +
    "            <button type=\"button\" class=\"callinize-btn cancel-button modal-close-button\">Close</button>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>"
  );


  $templateCache.put('../app/views/custom-caller-settings.html',
    "<div class=\"form-group\">\n" +
    "    <div class=\"label\">Custom Caller ID:</div>\n" +
    "    <select ng-model=\"localNumber\"\n" +
    "            ng-options=\"item as item.label for item in localNumbers\"\n" +
    "            ng-change=\"changeCustomCallerId(localNumber)\">\n" +
    "    </select>\n" +
    "</div>"
  );


  $templateCache.put('../app/views/customWorkflow.html',
    "<button id=\"custom-workflow\"\n" +
    "        title=\"{{feature.preferences.buttonTooltip || 'Custom workflow'}}\"\n" +
    "        type=\"button\"\n" +
    "        class=\"feature-btn\"\n" +
    "        ng-class=\"{'custom-img-icon': feature.preferences.imgIcon}\"\n" +
    "        ng-click=\"openModuleWorkflow()\">\n" +
    "    <i ng-if=\"!feature.preferences.imgIcon\" class=\"material-icons\" ng-cloak>{{feature.preferences.fontIcon || 'pageview'}}</i>\n" +
    "    <img ng-if=\"feature.preferences.imgIcon\" ng-src=\"/resource/1514310885956/dev_tenfold__{{feature.preferences.imgIcon}}\"/>\n" +
    "</button>\n" +
    "<div class=\"action-name\">Wkfl</div>"
  );


  $templateCache.put('../app/views/datetime-picker.html',
    "<button id=\"datetime-picker\"\n" +
    "        title=\"Add a Reminder\"\n" +
    "        type=\"button\"\n" +
    "        class=\"feature-btn\">\n" +
    "    <i class=\"material-icons\" ng-cloak>date_range</i>\n" +
    "</button>\n" +
    "<div class=\"action-name\">Task</div>\n" +
    "\n" +
    "<div id=\"datetime-picker-modal\" class=\"modal\" trigger=\"#datetime-picker\">\n" +
    "    <div class=\"modal-content\">\n" +
    "        <div class=\"modal-title\">Add a Reminder</div>\n" +
    "        <div class=\"modal-content\">\n" +
    "            <div id=\"followup-datetime-picker\"\n" +
    "                 ng-if=\"showDatetimePicker\"\n" +
    "                 date-picker=\"followUpDate\"\n" +
    "                 watch-direct-changes\n" +
    "                 class=\"follow-up-picker open-cti\"\n" +
    "                 date-change=\"selectFollowUp\"\n" +
    "                 partial=\"true\"\n" +
    "                 view=\"date\"\n" +
    "                 min-date=\"minDate\">\n" +
    "            </div>\n" +
    "        </div>\n" +
    "        <div class=\"modal-footer-buttons\">\n" +
    "            <button type=\"button\" class=\"callinize-btn cancel-button modal-close-button\">Close</button>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>"
  );


  $templateCache.put('../app/views/dialer.html',
    "<div class=\"fill-parent-flex\">\n" +
    "    <div id=\"dialer-number\">\n" +
    "        <input type=\"text\" ng-model=\"number\" class=\"line\"/>\n" +
    "        <i id=\"dialer-backspace-button\" class=\"material-icons\"\n" +
    "            ng-class=\"{disabled: !number.length}\"\n" +
    "            ng-click=\"clearNumber()\">backspace</i>\n" +
    "    </div>\n" +
    "    <div id=\"dial-pad\">\n" +
    "        <table>\n" +
    "            <tbody>\n" +
    "                <tr>\n" +
    "                    <td>\n" +
    "                        <div class=\"aspect-ratio-wrapper aspect-ratio-1-1\">\n" +
    "                            <div class=\"aspect-ratio-content\">\n" +
    "                                <div class=\"dial-pad-number\">1</div>\n" +
    "                            </div>\n" +
    "                        </div>\n" +
    "                    </td>\n" +
    "                    <td>\n" +
    "                        <div class=\"aspect-ratio-wrapper aspect-ratio-1-1\">\n" +
    "                            <div class=\"aspect-ratio-content\">\n" +
    "                                <div class=\"dial-pad-number\">2</div>\n" +
    "                                <div class=\"dial-pad-characters\">abc</div>\n" +
    "                            </div>\n" +
    "                        </div>\n" +
    "                    </td>\n" +
    "                    <td>\n" +
    "                        <div class=\"aspect-ratio-wrapper aspect-ratio-1-1\">\n" +
    "                            <div class=\"aspect-ratio-content\">\n" +
    "                                <div class=\"dial-pad-number\">3</div>\n" +
    "                                <div class=\"dial-pad-characters\">def</div>\n" +
    "                            </div>\n" +
    "                        </div>\n" +
    "                    </td>\n" +
    "                </tr>\n" +
    "                <tr>\n" +
    "                    <td>\n" +
    "                        <div class=\"aspect-ratio-wrapper aspect-ratio-1-1\">\n" +
    "                            <div class=\"aspect-ratio-content\">\n" +
    "                                <div class=\"dial-pad-number\">4</div>\n" +
    "                                <div class=\"dial-pad-characters\">ghi</div>\n" +
    "                            </div>\n" +
    "                        </div>\n" +
    "                    </td>\n" +
    "                    <td>\n" +
    "                        <div class=\"aspect-ratio-wrapper aspect-ratio-1-1\">\n" +
    "                            <div class=\"aspect-ratio-content\">\n" +
    "                                <div class=\"dial-pad-number\">5</div>\n" +
    "                                <div class=\"dial-pad-characters\">jkl</div>\n" +
    "                            </div>\n" +
    "                        </div>\n" +
    "                    </td>\n" +
    "                    <td>\n" +
    "                        <div class=\"aspect-ratio-wrapper aspect-ratio-1-1\">\n" +
    "                            <div class=\"aspect-ratio-content\">\n" +
    "                                <div class=\"dial-pad-number\">6</div>\n" +
    "                                <div class=\"dial-pad-characters\">mno</div>\n" +
    "                            </div>\n" +
    "                        </div>\n" +
    "                    </td>\n" +
    "                </tr>\n" +
    "                <tr>\n" +
    "                    <td>\n" +
    "                        <div class=\"aspect-ratio-wrapper aspect-ratio-1-1\">\n" +
    "                            <div class=\"aspect-ratio-content\">\n" +
    "                                <div class=\"dial-pad-number\">7</div>\n" +
    "                                <div class=\"dial-pad-characters\">pqrs</div>\n" +
    "                            </div>\n" +
    "                        </div>\n" +
    "                    </td>\n" +
    "                    <td>\n" +
    "                        <div class=\"aspect-ratio-wrapper aspect-ratio-1-1\">\n" +
    "                            <div class=\"aspect-ratio-content\">\n" +
    "                                <div class=\"dial-pad-number\">8</div>\n" +
    "                                <div class=\"dial-pad-characters\">tuv</div>\n" +
    "                            </div>\n" +
    "                        </div>\n" +
    "                    </td>\n" +
    "                    <td>\n" +
    "                        <div class=\"aspect-ratio-wrapper aspect-ratio-1-1\">\n" +
    "                            <div class=\"aspect-ratio-content\">\n" +
    "                                <div class=\"dial-pad-number\">9</div>\n" +
    "                                <div class=\"dial-pad-characters\">wxyz</div>\n" +
    "                            </div>\n" +
    "                        </div>\n" +
    "                    </td>\n" +
    "                </tr>\n" +
    "                <tr>\n" +
    "                    <td>\n" +
    "                        <div class=\"aspect-ratio-wrapper aspect-ratio-1-1\">\n" +
    "                            <div class=\"aspect-ratio-content\">\n" +
    "                                <div class=\"dial-pad-number\">*</div>\n" +
    "                            </div>\n" +
    "                        </div>\n" +
    "                    </td>\n" +
    "                    <td>\n" +
    "                        <div class=\"aspect-ratio-wrapper aspect-ratio-1-1\">\n" +
    "                            <div class=\"aspect-ratio-content\">\n" +
    "                                <div class=\"dial-pad-number\">0</div>\n" +
    "                                <div class=\"dial-pad-characters\">+</div>\n" +
    "                            </div>\n" +
    "                        </div>\n" +
    "                    </td>\n" +
    "                    <td>\n" +
    "                        <div class=\"aspect-ratio-wrapper aspect-ratio-1-1\">\n" +
    "                            <div class=\"aspect-ratio-content\">\n" +
    "                                <div class=\"dial-pad-number\">#</div>\n" +
    "                            </div>\n" +
    "                        </div>\n" +
    "                    </td>\n" +
    "                </tr>\n" +
    "            </tbody>\n" +
    "        </table>\n" +
    "    </div>\n" +
    "    <div id=\"dial-button\" class=\"container\">\n" +
    "        <button class=\"callinize-btn save-button {{buttonStatus}}\"\n" +
    "            ng-click=\"onDialButtonPressed(number)\">{{buttonStates[buttonStatus].text}}</button>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/dialling.html',
    "<div class=\"spinner progressbar-container active\" style=\"display:flex !important;\">\n" +
    "    <div class=\"progressbar\">\n" +
    "        <svg viewBox=\"25 25 50 50\">\n" +
    "            <circle cx=\"50\" cy=\"50\" r=\"20\" fill=\"none\" stroke-width=\"3\" stroke-miterlimit=\"10\"/>\n" +
    "        </svg>\n" +
    "    </div>\n" +
    "    <div class=\"progressbar-message\">\n" +
    "        <div>Calling</div>\n" +
    "        <div style=\"font-size:20px; margin-top:5px;\">{{ctdNumber}}</div>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/dispositions.html',
    "<button id=\"dispositions-trigger\" type=\"button\" class=\"feature-btn\" title=\"Call dispositions\">\n" +
    "    <i class=\"material-icons\">local_offer</i>\n" +
    "</button>\n" +
    "<div class=\"action-name\">Dispo</div>\n" +
    "\n" +
    "<div id=\"dispositions-modal\" class=\"modal\" trigger=\"#dispositions-trigger\">\n" +
    "    <div id=\"dispositions-panel\" class=\"modal-content\">\n" +
    "        <div id=\"dispositions-title\" class=\"modal-title\">Dispositions</div>\n" +
    "        <div id=\"dispositions-content\">\n" +
    "            <div id=\"dispositions-list\" ng-show=\"!dispositionsError\">\n" +
    "                <div class=\"disposition-group\" ng-repeat=\"(module, dispositions) in dispositionsGrouped\">\n" +
    "                    <div class=\"disposition-group-header\">\n" +
    "                        <span class=\"module\">{{module | limitTo:2}}</span>\n" +
    "                        <span class=\"module_field\" ng-bind=\"module\"></span>\n" +
    "                    </div>\n" +
    "\n" +
    "                    <div class=\"disposition-field\" ng-repeat=\"field in dispositions\">\n" +
    "                        <div class=\"disposition-field-header\" ng-bind=\"field.label\"></div>\n" +
    "                        <div ng-if=\"dc.noDependencies(field) || (dc.dependentFieldIsSelected(field) && !dc.allValuesHidden(field))\">\n" +
    "                            <div\n" +
    "                                class=\"disposition-value\"\n" +
    "                                ng-click=\"select(value.value, field)\"\n" +
    "                                ng-repeat=\"value in field.values\"\n" +
    "                                ng-hide=\"value.hide\"\n" +
    "                                ng-class=\"{selected : isSelected(field, value.value)}\">\n" +
    "                                    <div class=\"disposition-checkbox\"></div>\n" +
    "                                    <div class=\"disposition-label\" title=\"{{value.label || value.value}}\">{{value.label || value.value}}</div>\n" +
    "                            </div>\n" +
    "                        </div>\n" +
    "                        <div ng-if=\"!dc.dependentFieldIsSelected(field)\" class=\"disposition-dependent-field-not-select\">\n" +
    "                            Please select a value for <span ng-bind=\"field.dependsOn.label\"></span>\n" +
    "                        </div>\n" +
    "                        <div ng-if=\"dc.dependentFieldIsSelected(field) && dc.allValuesHidden(field)\" class=\"disposition-dependent-field-not-select\">\n" +
    "                            No values associated with the current value of <span ng-bind=\"field.dependsOn.label\"></span>\n" +
    "                        </div>\n" +
    "                    </div>\n" +
    "                </div>\n" +
    "            </div>\n" +
    "            <div id=\"dispositions-error\" ng-show=\"dispositionsError\">{{dispositionsError}}</div>\n" +
    "        </div>\n" +
    "        <div class=\"modal-footer-buttons\" style=\"padding: 0 !important;\">\n" +
    "            <button id=\"dispositions-close-button\" type=\"button\"\n" +
    "                class=\"callinize-btn cancel-button modal-close-button\">Close</button>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/emailTemplates.html',
    "<button id=\"email-templates\"\n" +
    "        title=\"Follow Up Emails\"\n" +
    "        type=\"button\"\n" +
    "        class=\"feature-btn\">\n" +
    "    <i class=\"material-icons\">email</i>\n" +
    "</button>\n" +
    "<div class=\"action-name\">Email</div>\n" +
    "\n" +
    "<div id=\"email-templates-modal\" class=\"modal\" trigger=\"#email-templates\">\n" +
    "    <div class=\"modal-content\">\n" +
    "        <div class=\"modal-title\">Follow Up Emails</div>\n" +
    "        <div class=\"modal-content\">\n" +
    "            <div class=\"switch-call-options\">\n" +
    "                <div class=\"switch-call-option\" ng-repeat=\"template in templates\">\n" +
    "                    <a class=\"template-option\"\n" +
    "                       ng-href=\"{{getMailToLink(template)}}\"\n" +
    "                       target=\"_blank\"\n" +
    "                       ng-bind=\"emailTemplateLabel(template,$index)\">\n" +
    "                    </a>\n" +
    "                </div>\n" +
    "            </div>\n" +
    "        </div>\n" +
    "        <div class=\"modal-footer-buttons\">\n" +
    "            <button type=\"button\" class=\"callinize-btn cancel-button modal-close-button\">Close</button>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/floatingLabelInput.html',
    "<div class=\"material-design-input matches-filter\"\n" +
    "    ng-class=\"{'active': isActive()}\"\n" +
    "    style=\"margin-bottom:10px;\">\n" +
    "    <loading class=\"searching-gif\" ng-show=\"isSearching\"></loading>\n" +
    "    <label></label>\n" +
    "    <input data-search=\"{{search}}\"\n" +
    "           filter-modules=\"filterModules\"\n" +
    "           class=\"typeahead line\"\n" +
    "           ng-model=\"input\"/>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/history.html',
    "<div id=\"call-history\" ng-controller=\"HistoryController\"\n" +
    "    class=\"fill-parent fill-parent-flex\" style=\"padding-top:0;\">\n" +
    "    <div class=\"calls grow overflow\">\n" +
    "        <div class=\"call\" ng-repeat=\"call in history | orderBy:'-startTime'\"\n" +
    "        ng-class=\"{active : call.id === currentCall}\"\n" +
    "        ng-click=\"selectCall(call)\">\n" +
    "            <div class=\"flex-space-between\">\n" +
    "                <div class=\"ellipsis\">{{getTitle(call)}}</div>\n" +
    "                <i title=\"Outbound call\" ng-if=\"call.direction=='Outbound'\" class=\"material-icons\">call_made</i>\n" +
    "                <i title=\"Inbound call\" ng-if=\"call.direction=='Inbound'\" class=\"material-icons\">call_received</i>\n" +
    "            </div>\n" +
    "            <div class=\"flex-space-between number\">\n" +
    "                <a href=\"javascript:void(0)\"\n" +
    "                   title=\"Click to dial\"\n" +
    "                   class=\"number\"\n" +
    "                   ng-click=\"originateCall(call.phoneNumber, call.matchedCrmRecords[0])\">\n" +
    "                    <span ng-bind=\"call.phoneNumber\"></span>\n" +
    "                    <i class=\"material-icons\" style=\"font-size:16px;margin-left:5px\">phone</i>\n" +
    "                </a>\n" +
    "                <div class=\"call-status\" ng-class=\"{hangup:call.status=='Hangup',connected:call.status=='Connected',ringing:call.status=='Ringing'}\"></div>\n" +
    "            </div>\n" +
    "            <div class=\"time\">\n" +
    "                <span am-time-ago=\"call.startTime\"></span>\n" +
    "            </div>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/loading.html',
    "<svg class=\"loading\" width=\"16px\" height=\"16px\" viewBox=\"0 0 66 66\" xmlns=\"http://www.w3.org/2000/svg\">\n" +
    "    <circle class=\"path\" fill=\"none\" stroke-width=\"6\" stroke-linecap=\"round\" cx=\"33\" cy=\"33\" r=\"30\"></circle>\n" +
    "</svg>\n"
  );


  $templateCache.put('../app/views/login.html',
    "<div id=\"login-panel\">\n" +
    "    <div id=\"login-container\">\n" +
    "        <form id=\"login-form\">\n" +
    "            <div class=\"login-field\">\n" +
    "                <input type=\"text\" name=\"username\" class=\"line\">\n" +
    "            </div>\n" +
    "            <div class=\"login-field\">\n" +
    "                <input type=\"password\" name=\"password\" class=\"line\">\n" +
    "            </div>\n" +
    "            <div id=\"login-button\" type=\"submit\">\n" +
    "                <button class=\"callinize-btn save-button\">Sign in</button>\n" +
    "            </div>\n" +
    "        </form>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/multipleMatches.html',
    "<div id=\"multiple-matches\" ng-controller=\"MultipleMatchesController\"\n" +
    "    class=\"container fill-parent fill-parent-flex\" style=\"padding-top:0px;\">\n" +
    "    <div id=\"call-controls\" ng-if=\"activeCall.status !== 'Hangup'\">\n" +
    "        <call-controls call=\"activeCall\"></call-controls>\n" +
    "    </div>\n" +
    "    <div class=\"widget-label\">Multiple matches</div>\n" +
    "    <call-info call=\"activeCall\" originate-call=\"originateCall(activeCall, record)\"></call-info>\n" +
    "    <floating-label-input\n" +
    "            placeholder=\"Filter matches\"\n" +
    "            input=\"filter\"\n" +
    "            records=\"records\"\n" +
    "            search=\"local\"\n" +
    "            is-searching=\"isSearching\">\n" +
    "    </floating-label-input>\n" +
    "    <record-list\n" +
    "            filter=\"filter\"\n" +
    "            records=\"records\"\n" +
    "            active-call=\"activeCall\"\n" +
    "            select-record=\"selectRecord(record)\"\n" +
    "            class=\"grow overflow\">\n" +
    "    </record-list>\n" +
    "    <div class=\"create-record-container\">\n" +
    "        <span>Not here?</span>\n" +
    "        <button class=\"callinize-btn create-record-button\" type=\"button\"\n" +
    "            ng-click=\"goToNoMatchView()\" style=\"margin-top:5px;margin-right:0;width:100%;\">Search or add new</button>\n" +
    "    </div>\n" +
    "    <action-bottom-bar></action-bottom-bar>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/nextRecord.html',
    "<div id=\"next-record\" class=\"container\" style=\"padding-top:0;\">\n" +
    "    <div class=\"title\">Next record</div>\n" +
    "    <div class=\"record-details\">\n" +
    "        <div class=\"flex-space-between\">\n" +
    "            <div class=\"record-name ellipsis\">\n" +
    "                {{nextRecord.name}}\n" +
    "            </div>\n" +
    "            <div class=\"modules\">\n" +
    "                <div class=\"module\">{{nextRecord.module | capitalizeFirst | limitTo:2}}</div>\n" +
    "            </div>\n" +
    "        </div>\n" +
    "        <div class=\"record-parent-name ellipsis\" ng-if=\"nextRecord.email\">\n" +
    "            {{nextRecord.email}}\n" +
    "        </div>\n" +
    "        <div class=\"number\">{{nextRecord.phoneNumber}}</div>\n" +
    "\n" +
    "    </div>\n" +
    "    <div class=\"action-buttons\">\n" +
    "        <button type=\"button\" class=\"callinize-btn cancel-button\" ng-click=\"backToPreviousView()\">Back</button>\n" +
    "        <button type=\"button\" class=\"callinize-btn save-button\" ng-click=\"triggerNextCall()\">Dial</button>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/noActiveCall.html',
    "<img id=\"no-active-call\" src=\"/resource/1514310885956/dev_tenfold__noActiveCalls\">\n"
  );


  $templateCache.put('../app/views/noMatches.html',
    "<div id=\"no-matches-container\" class=\"container matches-details fill-parent-flex\" style=\"padding-top:0;\">\n" +
    "    <div id=\"call-controls\">\n" +
    "        <call-controls call=\"activeCall\"></call-controls>\n" +
    "    </div>\n" +
    "    <div class=\"widget-label\">No matches</div>\n" +
    "    <call-info call=\"activeCall\" originate-call=\"originateCall(activeCall, record)\"></call-info>\n" +
    "    <div class=\"fill-parent-flex\" style=\"position: relative;\">\n" +
    "        <contact-search class=\"fill-parent fill-parent-flex\"></contact-search>\n" +
    "    </div>\n" +
    "    <action-bottom-bar></action-bottom-bar>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/notes.html',
    "<form ng-submit=\"saveNotes()\">\n" +
    "    <div class=\"separator\"></div>\n" +
    "    <div class=\"widget-label\">Call log</div>\n" +
    "    <input id=\"notes-subject\"\n" +
    "           type=\"text\"\n" +
    "           placeholder=\"Subject\"\n" +
    "           ng-show=\"subjectEnabled\"\n" +
    "           ng-model=\"callSubject\"\n" +
    "           ng-model-options=\"{ debounce: 250 }\"/>\n" +
    "    <div id=\"notes\">\n" +
    "        <textarea\n" +
    "            mentions\n" +
    "            ng-model=\"notes\"\n" +
    "            ng-model-options=\"{ debounce: 250 }\"\n" +
    "            ng-disabled=\"notesDisabled\"\n" +
    "            ng-keydown=\"handleKeyEvent($event)\"\n" +
    "            ng-keyup=\"handleKeyEvent($event)\"\n" +
    "            ng-class=\"{'notes-padding': 'ui.taskDate || ui.users.length'}\"\n" +
    "            placeholder=\"{{notesPlaceholder}}\">\n" +
    "        </textarea>\n" +
    "        <div id=\"notes-icons\" ng-if=\"ui.taskDate  || followUpDate || ui.users.length\">\n" +
    "            <i class=\"material-icons\"\n" +
    "               title=\"Creating task assigned to you for {{(ui.taskDate || followUpDate.toDate()) | date:'M/d/yyyy'}}\"\n" +
    "               ng-if=\"(ui.taskDate  || followUpDate)\">date_range</i>\n" +
    "            <i class=\"material-icons\"\n" +
    "               title=\"Notes will be emailed to {{getUsers(ui.users)}}\"\n" +
    "               ng-if=\"ui.users.length\">email</i>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "    <div class=\"widget-label\">Quick actions</div>\n" +
    "    <div id=\"action-buttons\">\n" +
    "        <call-recorder class=\"quick-action\"></call-recorder>\n" +
    "        <custom-workflow class=\"quick-action\" ng-show=\"hasCustomWorkflowEnabled\"></custom-workflow>\n" +
    "        <relate-resource class=\"quick-action\" ng-show=\"hasRelateResourceEnabled\"></relate-resource>\n" +
    "        <sms feature=\"sms\" class=\"quick-action\" defaults-to-hide=\"true\"></sms>\n" +
    "        <email-templates class=\"quick-action\" feature=\"emailTemplates\" defaults-to-hide=\"true\"></email-templates>\n" +
    "        <datetime-picker class=\"quick-action\" feature=\"nlpFollowup\" defaults-to-hide=\"true\" feature-preference=\"datePicker\"></datetime-picker>\n" +
    "        <dispositions class=\"quick-action\" ng-show=\"dispositionsEnabled\" get-selected-dispositions=\"getSelectedDispositions\"></dispositions>\n" +
    "    </div>\n" +
    "    <div class=\"separator\"></div>\n" +
    "    <div id=\"save-button-container\">\n" +
    "        <button id=\"save-button\" type=\"submit\" class=\"callinize-btn save-button\">Save</button>\n" +
    "        <button id=\"next-record-trigger\" type=\"button\" ng-if=\"nextBurnMode\"\n" +
    "            ng-click=\"showNextRecord()\" class=\"callinize-btn save-button\">Next</button>\n" +
    "    </div>\n" +
    "</form>\n"
  );


  $templateCache.put('../app/views/notLoggedIn.html',
    "<div id=\"login-panel\">\n" +
    "    <div id=\"login-container\">\n" +
    "        <div style=\"margin-bottom:15px;\">You must be logged in to access softphone</div>\n" +
    "        <form id=\"login-form\" ng-submit=\"performLogin()\">\n" +
    "            <div class=\"login-field\">\n" +
    "                <input type=\"text\" name=\"username\" placeholder=\"Username\" ng-model=\"loginForm.username\" class=\"line\">\n" +
    "            </div>\n" +
    "            <div class=\"login-field\">\n" +
    "                <input type=\"password\" name=\"password\" placeholder=\"Password\" ng-model=\"loginForm.password\" class=\"line\">\n" +
    "            </div>\n" +
    "            <div id=\"login-button\" type=\"submit\">\n" +
    "                <button class=\"callinize-btn save-button\">Sign in</button>\n" +
    "            </div>\n" +
    "        </form>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/primary-extension-toggle.html',
    "<div class=\"form-group\">\n" +
    "    <div class=\"label\">Primary Extension:</div>\n" +
    "    <select ng-model=\"primaryExtension\"\n" +
    "            ng-options=\"item as (item.displayExtension || item.extension) for item in extensions\"\n" +
    "            ng-change=\"updatePrimaryExtension(primaryExtension)\">\n" +
    "    </select>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/recordList.html',
    "<div class=\"contacts\">\n" +
    "    <div class=\"contact\" ng-repeat=\"record in filteredRecords\" ng-click=\"selectRecord({record: record})\">\n" +
    "        <div class=\"radio-button\"></div>\n" +
    "        <div class=\"record-type {{record.bean_module.toLowerCase()}}\" ng-bind=\"record.bean_module | capitalizeFirst\"></div>\n" +
    "        <div class=\"record-name ellipsis\" ng-bind=\"record.bean_name\" title=\"{{record.bean_name}}\"></div>\n" +
    "        <div class=\"record-parent-name ellipsis\" ng-if=\"record.parent_name\" ng-bind=\"record.parent_name\" title=\"{{record.parent_name}}\"></div>\n" +
    "\n" +
    "        <div class=\"record-parent-name\" ng-if=\"popupCustomFieldEnabled && getPopupCustomFieldValue(record)\">\n" +
    "            <span ng-bind=\"popupCustomField.preferences.label + ': '\" ng-if=\"popupCustomField.preferences.showLabel\"></span>\n" +
    "            <span ng-bind=\"getPopupCustomFieldValue(record)\"></span>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/relateResource.html',
    "<button id=\"show-relate-opportunity\"\n" +
    "        title=\"Relate resources\"\n" +
    "        type=\"button\"\n" +
    "        class=\"feature-btn\"\n" +
    "        feature-class=\"emailTemplates\">\n" +
    "        <i class=\"material-icons\">work</i>\n" +
    "    <div\n" +
    "        id=\"relate-resource-image\"\n" +
    "        ng-class=\"{'has-selection':hasSelected, 'has-selected':selectedResource}\"\n" +
    "        data-number=\"{{count}}\"></div>\n" +
    "</button>\n" +
    "<div class=\"action-name\">Relate</div>\n" +
    "\n" +
    "<div id=\"relate-resource-modal\" class=\"modal\" trigger=\"#show-relate-opportunity\">\n" +
    "    <div class=\"modal-content\">\n" +
    "        <div class=\"switch-call-title-container flex-space-between\">\n" +
    "            <div class=\"switch-call-title\">Create new</div>\n" +
    "            <i ng-click=\"rr.refresh()\" class=\"material-icons action-icon\" style=\"padding-right:6px;\">sync</i>\n" +
    "        </div>\n" +
    "        <div class=\"switch-call-options\">\n" +
    "            <div class=\"switch-call-option\"\n" +
    "                feature=\"opportunities\"\n" +
    "                ng-show=\"rr.isCrmSupported()\"\n" +
    "                ng-click=\"rr.createResource('opportunity')\">\n" +
    "                <span class=\"option-title\">Opportunity</span>\n" +
    "            </div>\n" +
    "            <div class=\"switch-call-option\"\n" +
    "                ng-click=\"rr.createResource('case')\"\n" +
    "                feature=\"cases\">\n" +
    "                <span class=\"option-title\">Case</span>\n" +
    "            </div>\n" +
    "            <div\n" +
    "                class=\"switch-call-option\"\n" +
    "                ng-show=\"customResources.status === 'active' && !_.empty(customResources.modules)\"\n" +
    "                ng-repeat=\"module in customResources.modules\"\n" +
    "                ng-click=\"rr.createResource(module.name)\"\n" +
    "                feature=\"customResources\">\n" +
    "                <span ng-bind=\"module.label\"></span>\n" +
    "            </div>\n" +
    "        </div>\n" +
    "        <div class=\"modal-stretch-area\">\n" +
    "            <div class=\"optgroup\" data-group ng-show=\"opportunities.length\" feature=\"opportunities\">\n" +
    "                <div class=\"optgroup-header\" data-opt>\n" +
    "                    <div class=\"callinize_record_identifier identifier-opportunities module\">Op</div>\n" +
    "                    <div class=\"module_field ellipsis\">Opportunities</div>\n" +
    "                </div>\n" +
    "                <div\n" +
    "                    class=\"disposition-value\"\n" +
    "                    data-selectable\n" +
    "                    data-value\n" +
    "                    ng-click=\"rr.relate(opportunity)\"\n" +
    "                    ng-repeat=\"opportunity in opportunities\"\n" +
    "                    ng-class=\"{selected : selectedResource.id === opportunity.id}\">\n" +
    "                        <div class=\"disposition-checkbox\"></div>\n" +
    "                        <div class=\"disposition-label\">{{opportunity.name}}</div>\n" +
    "                </div>\n" +
    "            </div>\n" +
    "            <div class=\"optgroup\" data-group ng-show=\"cases.length\" feature=\"cases\">\n" +
    "                <div class=\"optgroup-header\" data-opt>\n" +
    "                    <div class=\"callinize_record_identifier identifier-case module\">Ca</div>\n" +
    "                    <div class=\"module_field ellipsis\" translate=\"cases\"></div>\n" +
    "                </div>\n" +
    "                <div\n" +
    "                    class=\"disposition-value\"\n" +
    "                    data-selectable\n" +
    "                    data-value\n" +
    "                    ng-repeat=\"case in cases\"\n" +
    "                    ng-click=\"rr.relate(case)\"\n" +
    "                    ng-class=\"{selected : selectedResource.id === case.id}\"\n" +
    "                    title=\"{{case.text}}\">\n" +
    "                        <div class=\"disposition-checkbox\"></div>\n" +
    "                        <div class=\"disposition-label ellipsis\">#{{case.casenumber}} - {{case.text}}</div>\n" +
    "                </div>\n" +
    "            </div>\n" +
    "            <div class=\"optgroup\"\n" +
    "                 data-group\n" +
    "                 ng-if=\"module.activities.length\"\n" +
    "                 ng-repeat=\"module in customResources.modules\"\n" +
    "                 feature=\"customResources\">\n" +
    "                <div class=\"optgroup-header\" data-opt>\n" +
    "                    <div class=\"callinize_record_identifier identifier-{{module.name}} module\">\n" +
    "                        <span ng-bind=\"module.abbr\"></span>\n" +
    "                    </div>\n" +
    "                    <div class=\"module_field\" translate=\"{{module.label}}\"></div>\n" +
    "                </div>\n" +
    "                <div\n" +
    "                    class=\"disposition-value\"\n" +
    "                    data-selectable\n" +
    "                    data-value\n" +
    "                    ng-repeat=\"record in module.activities\"\n" +
    "                    ng-click=\"rr.relate(record)\"\n" +
    "                    ng-class=\"{selected : selectedResource.id === record.id}\">\n" +
    "                        <div class=\"disposition-checkbox\"></div>\n" +
    "                        <div class=\"disposition-label ellipsis\">{{record.text}}</div>\n" +
    "                </div>\n" +
    "            </div>\n" +
    "            <div class=\"optgroup\" data-group ng-show=\"resourcesError\" id=\"resources-error\">\n" +
    "                <div\n" +
    "                    class=\"option\"\n" +
    "                    data-selectable\n" +
    "                    data-value\n" +
    "                    ng-bind=\"resourcesError\">\n" +
    "                </div>\n" +
    "            </div>\n" +
    "            <div class=\"optgroup\" data-group ng-show=\"!resourcesError && !cases && !opportunities\" id=\"resources-wait\">\n" +
    "                <div class=\"option container\"\n" +
    "                    style=\"padding-bottom:0px\"\n" +
    "                    data-selectable\n" +
    "                    data-value>Searching for resources\n" +
    "                </div>\n" +
    "            </div>\n" +
    "        </div>\n" +
    "        <div class=\"modal-footer-buttons\">\n" +
    "            <button type=\"button\"\n" +
    "                class=\"callinize-btn cancel-button modal-close-button\">Close</button>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/searchingRecords.html',
    "<div class=\"spinner active\" style=\"display:flex !important; position:absolute;\">\n" +
    "    <div class=\"progressbar\">\n" +
    "        <svg viewBox=\"25 25 50 50\">\n" +
    "            <circle cx=\"50\" cy=\"50\" r=\"20\" fill=\"none\" stroke-width=\"3\" stroke-miterlimit=\"10\"/>\n" +
    "        </svg>\n" +
    "    </div>\n" +
    "    <div class=\"progressbar-message\">\n" +
    "        Searching for records...\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/singleMatch.html',
    "<div id=\"active-call\" class=\"container\" style=\"padding-top:0\">\n" +
    "    <!--\n" +
    "    <div id=\"call-type\">\n" +
    "        {{activeCall.direction | uppercase}} call\n" +
    "        <social-profile></social-profile>\n" +
    "    </div>\n" +
    "    -->\n" +
    "    <timer call=\"activeCall\"></timer>\n" +
    "    <div id=\"record-details\" class=\"record-details\">\n" +
    "        <div class=\"widget-label\">Name</div>\n" +
    "        <div class=\"flex-space-between record-name\">\n" +
    "            <a href=\"javascript:void(0)\"\n" +
    "                target=\"_parent\"\n" +
    "                class=\"ellipsis\"\n" +
    "                title=\"{{activeCall.matchedCrmRecords[0].bean_name}}\"\n" +
    "                ng-click=\"openRecordLink(activeCall.matchedCrmRecords[0].bean_link, activeCall.matchedCrmRecords[0].bean_id, activeCall.matchedCrmRecords[0].bean_name)\">\n" +
    "                <div class=\"modules\" style=\"display: inline-block; margin-right:5px;\">\n" +
    "                    <div class=\"module\"\n" +
    "                         title=\"{{activeCall.matchedCrmRecords[0].bean_module | capitalizeFirst}}\"\n" +
    "                         ng-bind=\"activeCall.matchedCrmRecords[0].bean_module | capitalizeFirst | limitTo:2\">\n" +
    "                    </div>\n" +
    "                </div>\n" +
    "                <span ng-bind=\"activeCall.matchedCrmRecords[0].bean_name\"></span>\n" +
    "            </a>\n" +
    "\n" +
    "            <div class=\"actions-wrapper\">\n" +
    "                <a class=\"edit-record-link\"\n" +
    "                   target=\"_blank\"\n" +
    "                   href=\"javascript:void(0)\"\n" +
    "                   ng-if=\"activeCall.matchedCrmRecords[0].bean_edit_link\"\n" +
    "                   ng-click=\"openRecordEditLink(activeCall.matchedCrmRecords[0].bean_edit_link, activeCall.matchedCrmRecords[0].bean_id, activeCall.matchedCrmRecords[0].bean_name)\">\n" +
    "                    <i class=\"material-icons\" style=\"font-size:18px;\">mode_edit</i>\n" +
    "               </a>\n" +
    "\n" +
    "                <a class=\"edit-record-link\"\n" +
    "                   href=\"javascript:void(0)\"\n" +
    "                   ng-if=\"(!activeCall._matchedCrmRecords || activeCall._matchedCrmRecords.length < 2) || (activeCall._matchedCrmRecords.length > 1 && !smc.isHangup(activeCall))\"\n" +
    "                   ng-click=\"smc.reassignCall()\"\n" +
    "                   title=\"Reassign Call\">\n" +
    "                    <i class=\"material-icons\" style=\"font-size:18px;\">undo</i>\n" +
    "                </a>\n" +
    "\n" +
    "                <a class=\"edit-record-link\"\n" +
    "                   href=\"javascript:void(0)\"\n" +
    "                   ng-click=\"smc.unassociateCall()\"\n" +
    "                   title=\"Unassociate phone number\">\n" +
    "                    <i class=\"material-icons\" style=\"font-size:18px;\">phonelink_erase</i>\n" +
    "                </a>\n" +
    "            </div>\n" +
    "        </div>\n" +
    "\n" +
    "        <div class=\"record-parent-name ellipsis\"\n" +
    "             ng-if=\"activeCall.matchedCrmRecords[0].parent_name || assignRecordParentEnabled\">\n" +
    "            <div class=\"widget-label\">Parent</div>\n" +
    "            <a href=\"javascript:void(0)\"\n" +
    "               title=\"{{activeCall.matchedCrmRecords[0].parent_name || (activeCall.matchedCrmRecords[0].bean_module === 'Account' ? 'No Parent Account' : 'No Account')}}\"\n" +
    "               target=\"_parent\"\n" +
    "               ng-click=\"activeCall.matchedCrmRecords[0].parent_id && openRecordLink(activeCall.matchedCrmRecords[0].parent_link, activeCall.matchedCrmRecords[0].parent_id, activeCall.matchedCrmRecords[0].parent_name)\"\n" +
    "               ng-class=\"{'no-account': !activeCall.matchedCrmRecords[0].parent_name}\">\n" +
    "                <div class=\"modules\" style=\"display: inline-block; margin-right:5px;\">\n" +
    "                    <div class=\"module\"\n" +
    "                         title=\"{{activeCall.matchedCrmRecords[0].parent_module | capitalizeFirst}}\"\n" +
    "                         ng-bind=\"activeCall.matchedCrmRecords[0].parent_module | capitalizeFirst | limitTo:2\">\n" +
    "                    </div>\n" +
    "                </div>\n" +
    "                <span ng-bind=\"activeCall.matchedCrmRecords[0].parent_name || (activeCall.matchedCrmRecords[0].bean_module === 'Account' ? 'No Parent Account' : 'No Account')\"></span>\n" +
    "            </a>\n" +
    "\n" +
    "            <assign-record-parent ng-if=\"assignRecordParentEnabled\"></assign-record-parent>\n" +
    "        </div>\n" +
    "\n" +
    "        <div>\n" +
    "            <call-info call=\"activeCall\" originate-call=\"originateCall(activeCall, record)\"></call-info>\n" +
    "        </div>\n" +
    "\n" +
    "        <social-profile></social-profile>\n" +
    "    </div>\n" +
    "    <div class=\"separator\"></div>\n" +
    "    <activities call=\"activeCall\" open-record-link=\"openRecordLink\"></activities>\n" +
    "    <notes ng-controller=\"NotesController\"></notes>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/sms.html',
    "<button id=\"sms-send-button\"\n" +
    "        title=\"Send SMS\"\n" +
    "        type=\"button\"\n" +
    "        class=\"feature-btn\">\n" +
    "    <i class=\"material-icons\" style=\"position:relative; bottom:-2px;\">sms</i>\n" +
    "</button>\n" +
    "<div class=\"action-name\">Sms</div>\n" +
    "\n" +
    "<div id=\"sms-modal\" class=\"modal\" trigger=\"#sms-send-button\">\n" +
    "    <div id=\"sms-panel\" class=\"modal-content\">\n" +
    "        <div id=\"sms-title\" class=\"modal-title\">Send SMS</div>\n" +
    "        <div id=\"sms-content\" style=\"padding:0 10px;\">\n" +
    "            <textarea placeholder=\"Content\" rows=\"10\" ng-model=\"newText\" maxlength=\"1000\"></textarea>\n" +
    "        </div>\n" +
    "        <div class=\"modal-footer-buttons\" style=\"padding: 0 !important;\">\n" +
    "            <button id=\"sms-close-button\" type=\"button\"\n" +
    "                class=\"callinize-btn cancel-button modal-close-button\">Close</button>\n" +
    "            <button id=\"sms-close-button\" type=\"button\" ng-click=\"sendSMSMessage(newText)\"\n" +
    "                class=\"callinize-btn save-button\">Send</button>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/socialProfile.html',
    "<div id=\"social-icons\" feature=\"socialProfile\">\n" +
    "    <a id=\"callinize_{{profile.typeId}}_url\"\n" +
    "       title=\"{{getTitle(profile)}}\"\n" +
    "       class=\"social {{profile.typeId}}\"\n" +
    "       ng-repeat=\"profile in profiles\"\n" +
    "       ng-href=\"{{profile.url}}\" target=\"_blank\">\n" +
    "    </a>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/softphone.html',
    "<div ng-controller=\"NextController\" class=\"fill-parent-flex\">\n" +
    "    <div id=\"btn-group\" ng-show=\"view != 'next'\">\n" +
    "        <button type=\"button\" ng-click=\"setView('active')\"\n" +
    "            ng-class=\"{active: view == 'active'}\">Active</button><!--\n" +
    "        --><button type=\"button\" ng-click=\"setView('history')\"\n" +
    "            ng-class=\"{active: view == 'history'}\">Recents</button><!--\n" +
    "        --><button type=\"button\" ng-click=\"setView('dialer')\"\n" +
    "            ng-class=\"{active: view == 'dialer'}\">Dialer</button>\n" +
    "    </div>\n" +
    "    <div id=\"content\" ng-switch on=\"view\" ng-controller=\"CallController\" class=\"grow\" style=\"position:relative;\">\n" +
    "        <active-call ng-switch-when=\"active\" class=\"fill-parent fill-parent-flex\"></active-call>\n" +
    "        <history ng-switch-when=\"history\" class=\"fill-parent fill-parent-flex\"></history>\n" +
    "        <dialer ng-switch-when=\"dialer\" class=\"fill-parent fill-parent-flex\"></dialer>\n" +
    "        <next-record ng-switch-when=\"next\"></next-record>\n" +
    "    </div>\n" +
    "    <switch-call></switch-call>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/switchCall.html',
    "<div id=\"switch-call-modal\" class=\"modal\" dismissable=\"false\">\n" +
    "    <div class=\"modal-content\">\n" +
    "        <div class=\"switch-call-title-container\">\n" +
    "            <div class=\"switch-call-title\">New call from {{call.phoneNumber}}</div>\n" +
    "        </div>\n" +
    "        <div class=\"switch-call-options\">\n" +
    "            <div class=\"switch-call-option\" ng-click=\"scc.switch(call)\">\n" +
    "                <span class=\"option-title\">Save changes and switch to new call</span>\n" +
    "                <span class=\"option-icon\">✓</span>\n" +
    "            </div>\n" +
    "            <div class=\"switch-call-option\" ng-click=\"scc.close()\">\n" +
    "                <span class=\"option-title\">Stay in current call</span>\n" +
    "                <span class=\"option-icon\">✕</span>\n" +
    "            </div>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>\n"
  );


  $templateCache.put('../app/views/timer.html',
    "<div id=\"call-duration-container\">\n" +
    "    <div class=\"call-direction-image\">\n" +
    "        <i title=\"Outbound call\" ng-if=\"call.direction=='Outbound'\" class=\"material-icons\">call_made</i>\n" +
    "        <i title=\"Inbound call\" ng-if=\"call.direction=='Inbound'\" class=\"material-icons\">call_received</i>\n" +
    "    </div>\n" +
    "    <div id=\"call-time-container\" style=\"margin-left:-10px;\">\n" +
    "        <div id=\"call-duration\" ng-bind=\"duration\"></div>\n" +
    "    </div>\n" +
    "    <div class=\"call-status\" ng-class=\"{hangup:call.status=='Hangup', connected:call.status=='Connected'}\"></div>\n" +
    "    <div id=\"stop-timer-container\" ng-click=\"toggleTimer(call)\" ng-class=\"{'enabled' : stopEnabled}\">\n" +
    "        <div ng-show=\"!isStopped\">\n" +
    "            <i class=\"material-icons\">stop</i>\n" +
    "            <div>Stop Timer</div>\n" +
    "        </div>\n" +
    "        <div ng-show=\"isStopped\">\n" +
    "            <i class=\"material-icons\">play_arrow</i>\n" +
    "            <div>Resume Timer</div>\n" +
    "        </div>\n" +
    "    </div>\n" +
    "</div>\n" +
    "<div id=\"single-match-call-controls\">\n" +
    "    <call-controls call=\"call\"></call-controls>\n" +
    "</div>\n" +
    "<div class=\"separator\"></div>\n"
  );

}]);
