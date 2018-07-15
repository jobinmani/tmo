var IS_LOCAL_DASHBOARD = false;
var IS_LOCAL_API = false;

var SOFTPHONE_HEIGHT = 555;
var SOFTPHONE_WIDTH = 250;

var API_TUNNEL_URL =  'https://1c62db51.ngrok.io';
var API_LOCAL_URL = IS_LOCAL_API ? (API_TUNNEL_URL || 'http://localhost:3020') : false;
var API_BASE_URL = IS_LOCAL_API ? API_LOCAL_URL : 'https://api.tenfold.com';

var DASHBOARD_TUNNEL_URL = 'https://0a636b70.ngrok.io';
var DASHBOARD_LOCAL_URL = IS_LOCAL_DASHBOARD ? (DASHBOARD_TUNNEL_URL || 'http://localhost:3000') : false;
var DASHBOARD_BASE_URL = IS_LOCAL_DASHBOARD ? DASHBOARD_LOCAL_URL : 'https://dashboard.tenfold.com';

window.mocks = new Mocks();
window.chrome = new ChromeMock();

$.ajaxSetup({
    xhrFields: {
       withCredentials: true
    },
    crossDomain: true
});

localStorage.removeItem('fb_tenfold_user');
localStorage.removeItem('fb_tenfold_organization');

/*Firebase.enableLogging(function(logMessage) {
    var message = '****** FIREBASE MESSAGE: ' + new Date().toISOString() + '\n\n' + logMessage;
    console.log(message);
});*/

var app = angular.module('callinize', ['angularMoment', 'firebase', 'logger', 'utils', 'ngAudio', 'datePicker']);

app.config(function($httpProvider) {
    //Enable cross domain calls
    $httpProvider.defaults.useXDomain = true;
    $httpProvider.defaults.withCredentials = true;
});

app.run(function (OpenCTIService, $rootScope) {
    $rootScope.lightningView = OpenCTIService.isLightningView();
});

app
    .constant('isDevMode', true)
    .constant('CACHE_NAME', 'OpenCtiCache')
    .constant('DASHBOARD_LOCAL_URL', DASHBOARD_LOCAL_URL)
    .constant('API_LOCAL_URL', API_LOCAL_URL)
    .constant('DASHBOARD_URL', DASHBOARD_BASE_URL)
    .constant('FIREBASE_URL', 'https://incandescent-inferno-925.firebaseio.com/');

app.filter('capitalizeFirst', function() {
    return function(input) {
        return (!!input) ? input.charAt(0).toUpperCase() + input.substr(1).toLowerCase() : '';
    }
});
