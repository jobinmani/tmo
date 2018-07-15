(function e(t,n,r){function s(o,u){if(!n[o]){if(!t[o]){var a=typeof require=="function"&&require;if(!u&&a)return a(o,!0);if(i)return i(o,!0);var f=new Error("Cannot find module '"+o+"'");throw f.code="MODULE_NOT_FOUND",f}var l=n[o]={exports:{}};t[o][0].call(l.exports,function(e){var n=t[o][1][e];return s(n?n:e)},l,l.exports,e,t,n,r)}return n[o].exports}var i=typeof require=="function"&&require;for(var o=0;o<r.length;o++)s(r[o]);return s})({1:[function(require,module,exports){
// shim for using process in browser
var process = module.exports = {};

// cached from whatever global is present so that test runners that stub it
// don't break things.  But we need to wrap it in a try catch in case it is
// wrapped in strict mode code which doesn't define any globals.  It's inside a
// function because try/catches deoptimize in certain engines.

var cachedSetTimeout;
var cachedClearTimeout;

function defaultSetTimout() {
    throw new Error('setTimeout has not been defined');
}
function defaultClearTimeout () {
    throw new Error('clearTimeout has not been defined');
}
(function () {
    try {
        if (typeof setTimeout === 'function') {
            cachedSetTimeout = setTimeout;
        } else {
            cachedSetTimeout = defaultSetTimout;
        }
    } catch (e) {
        cachedSetTimeout = defaultSetTimout;
    }
    try {
        if (typeof clearTimeout === 'function') {
            cachedClearTimeout = clearTimeout;
        } else {
            cachedClearTimeout = defaultClearTimeout;
        }
    } catch (e) {
        cachedClearTimeout = defaultClearTimeout;
    }
} ())
function runTimeout(fun) {
    if (cachedSetTimeout === setTimeout) {
        //normal enviroments in sane situations
        return setTimeout(fun, 0);
    }
    // if setTimeout wasn't available but was latter defined
    if ((cachedSetTimeout === defaultSetTimout || !cachedSetTimeout) && setTimeout) {
        cachedSetTimeout = setTimeout;
        return setTimeout(fun, 0);
    }
    try {
        // when when somebody has screwed with setTimeout but no I.E. maddness
        return cachedSetTimeout(fun, 0);
    } catch(e){
        try {
            // When we are in I.E. but the script has been evaled so I.E. doesn't trust the global object when called normally
            return cachedSetTimeout.call(null, fun, 0);
        } catch(e){
            // same as above but when it's a version of I.E. that must have the global object for 'this', hopfully our context correct otherwise it will throw a global error
            return cachedSetTimeout.call(this, fun, 0);
        }
    }


}
function runClearTimeout(marker) {
    if (cachedClearTimeout === clearTimeout) {
        //normal enviroments in sane situations
        return clearTimeout(marker);
    }
    // if clearTimeout wasn't available but was latter defined
    if ((cachedClearTimeout === defaultClearTimeout || !cachedClearTimeout) && clearTimeout) {
        cachedClearTimeout = clearTimeout;
        return clearTimeout(marker);
    }
    try {
        // when when somebody has screwed with setTimeout but no I.E. maddness
        return cachedClearTimeout(marker);
    } catch (e){
        try {
            // When we are in I.E. but the script has been evaled so I.E. doesn't  trust the global object when called normally
            return cachedClearTimeout.call(null, marker);
        } catch (e){
            // same as above but when it's a version of I.E. that must have the global object for 'this', hopfully our context correct otherwise it will throw a global error.
            // Some versions of I.E. have different rules for clearTimeout vs setTimeout
            return cachedClearTimeout.call(this, marker);
        }
    }



}
var queue = [];
var draining = false;
var currentQueue;
var queueIndex = -1;

function cleanUpNextTick() {
    if (!draining || !currentQueue) {
        return;
    }
    draining = false;
    if (currentQueue.length) {
        queue = currentQueue.concat(queue);
    } else {
        queueIndex = -1;
    }
    if (queue.length) {
        drainQueue();
    }
}

function drainQueue() {
    if (draining) {
        return;
    }
    var timeout = runTimeout(cleanUpNextTick);
    draining = true;

    var len = queue.length;
    while(len) {
        currentQueue = queue;
        queue = [];
        while (++queueIndex < len) {
            if (currentQueue) {
                currentQueue[queueIndex].run();
            }
        }
        queueIndex = -1;
        len = queue.length;
    }
    currentQueue = null;
    draining = false;
    runClearTimeout(timeout);
}

process.nextTick = function (fun) {
    var args = new Array(arguments.length - 1);
    if (arguments.length > 1) {
        for (var i = 1; i < arguments.length; i++) {
            args[i - 1] = arguments[i];
        }
    }
    queue.push(new Item(fun, args));
    if (queue.length === 1 && !draining) {
        runTimeout(drainQueue);
    }
};

// v8 likes predictible objects
function Item(fun, array) {
    this.fun = fun;
    this.array = array;
}
Item.prototype.run = function () {
    this.fun.apply(null, this.array);
};
process.title = 'browser';
process.browser = true;
process.env = {};
process.argv = [];
process.version = ''; // empty string to avoid regexp issues
process.versions = {};

function noop() {}

process.on = noop;
process.addListener = noop;
process.once = noop;
process.off = noop;
process.removeListener = noop;
process.removeAllListeners = noop;
process.emit = noop;
process.prependListener = noop;
process.prependOnceListener = noop;

process.listeners = function (name) { return [] }

process.binding = function (name) {
    throw new Error('process.binding is not supported');
};

process.cwd = function () { return '/' };
process.chdir = function (dir) {
    throw new Error('process.chdir is not supported');
};
process.umask = function() { return 0; };

},{}],2:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
  value: true
});
var defaultParams = {
  title: '',
  text: '',
  type: null,
  allowOutsideClick: false,
  showConfirmButton: true,
  showCancelButton: false,
  closeOnConfirm: true,
  closeOnCancel: true,
  confirmButtonText: 'OK',
  confirmButtonColor: '#8CD4F5',
  cancelButtonText: 'Cancel',
  imageUrl: null,
  imageSize: null,
  timer: null,
  customClass: '',
  html: false,
  animation: true,
  allowEscapeKey: true,
  inputType: 'text',
  inputPlaceholder: '',
  inputValue: '',
  showLoaderOnConfirm: false
};

exports['default'] = defaultParams;
module.exports = exports['default'];
},{}],3:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
  value: true
});

var _colorLuminance = require('./utils');

var _getModal = require('./handle-swal-dom');

var _hasClass$isDescendant = require('./handle-dom');

/*
 * User clicked on "Confirm"/"OK" or "Cancel"
 */
var handleButton = function handleButton(event, params, modal) {
  var e = event || window.event;
  var target = e.target || e.srcElement;

  var targetedConfirm = target.className.indexOf('confirm') !== -1;
  var targetedOverlay = target.className.indexOf('sweet-overlay') !== -1;
  var modalIsVisible = _hasClass$isDescendant.hasClass(modal, 'visible');
  var doneFunctionExists = params.doneFunction && modal.getAttribute('data-has-done-function') === 'true';

  // Since the user can change the background-color of the confirm button programmatically,
  // we must calculate what the color should be on hover/active
  var normalColor, hoverColor, activeColor;
  if (targetedConfirm && params.confirmButtonColor) {
    normalColor = params.confirmButtonColor;
    hoverColor = _colorLuminance.colorLuminance(normalColor, -0.04);
    activeColor = _colorLuminance.colorLuminance(normalColor, -0.14);
  }

  function shouldSetConfirmButtonColor(color) {
    if (targetedConfirm && params.confirmButtonColor) {
      target.style.backgroundColor = color;
    }
  }

  switch (e.type) {
    case 'mouseover':
      shouldSetConfirmButtonColor(hoverColor);
      break;

    case 'mouseout':
      shouldSetConfirmButtonColor(normalColor);
      break;

    case 'mousedown':
      shouldSetConfirmButtonColor(activeColor);
      break;

    case 'mouseup':
      shouldSetConfirmButtonColor(hoverColor);
      break;

    case 'focus':
      var $confirmButton = modal.querySelector('button.confirm');
      var $cancelButton = modal.querySelector('button.cancel');

      if (targetedConfirm) {
        $cancelButton.style.boxShadow = 'none';
      } else {
        $confirmButton.style.boxShadow = 'none';
      }
      break;

    case 'click':
      var clickedOnModal = modal === target;
      var clickedOnModalChild = _hasClass$isDescendant.isDescendant(modal, target);

      // Ignore click outside if allowOutsideClick is false
      if (!clickedOnModal && !clickedOnModalChild && modalIsVisible && !params.allowOutsideClick) {
        break;
      }

      if (targetedConfirm && doneFunctionExists && modalIsVisible) {
        handleConfirm(modal, params);
      } else if (doneFunctionExists && modalIsVisible || targetedOverlay) {
        handleCancel(modal, params);
      } else if (_hasClass$isDescendant.isDescendant(modal, target) && target.tagName === 'BUTTON') {
        sweetAlert.close();
      }
      break;
  }
};

/*
 *  User clicked on "Confirm"/"OK"
 */
var handleConfirm = function handleConfirm(modal, params) {
  var callbackValue = true;

  if (_hasClass$isDescendant.hasClass(modal, 'show-input')) {
    callbackValue = modal.querySelector('input').value;

    if (!callbackValue) {
      callbackValue = '';
    }
  }

  params.doneFunction(callbackValue);

  if (params.closeOnConfirm) {
    sweetAlert.close();
  }
  // Disable cancel and confirm button if the parameter is true
  if (params.showLoaderOnConfirm) {
    sweetAlert.disableButtons();
  }
};

/*
 *  User clicked on "Cancel"
 */
var handleCancel = function handleCancel(modal, params) {
  // Check if callback function expects a parameter (to track cancel actions)
  var functionAsStr = String(params.doneFunction).replace(/\s/g, '');
  var functionHandlesCancel = functionAsStr.substring(0, 9) === 'function(' && functionAsStr.substring(9, 10) !== ')';

  if (functionHandlesCancel) {
    params.doneFunction(false);
  }

  if (params.closeOnCancel) {
    sweetAlert.close();
  }
};

exports['default'] = {
  handleButton: handleButton,
  handleConfirm: handleConfirm,
  handleCancel: handleCancel
};
module.exports = exports['default'];
},{"./handle-dom":4,"./handle-swal-dom":6,"./utils":9}],4:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
  value: true
});
var hasClass = function hasClass(elem, className) {
  return new RegExp(' ' + className + ' ').test(' ' + elem.className + ' ');
};

var addClass = function addClass(elem, className) {
  if (!hasClass(elem, className)) {
    elem.className += ' ' + className;
  }
};

var removeClass = function removeClass(elem, className) {
  var newClass = ' ' + elem.className.replace(/[\t\r\n]/g, ' ') + ' ';
  if (hasClass(elem, className)) {
    while (newClass.indexOf(' ' + className + ' ') >= 0) {
      newClass = newClass.replace(' ' + className + ' ', ' ');
    }
    elem.className = newClass.replace(/^\s+|\s+$/g, '');
  }
};

var escapeHtml = function escapeHtml(str) {
  var div = document.createElement('div');
  div.appendChild(document.createTextNode(str));
  return div.innerHTML;
};

var _show = function _show(elem) {
  elem.style.opacity = '';
  elem.style.display = 'block';
};

var show = function show(elems) {
  if (elems && !elems.length) {
    return _show(elems);
  }
  for (var i = 0; i < elems.length; ++i) {
    _show(elems[i]);
  }
};

var _hide = function _hide(elem) {
  elem.style.opacity = '';
  elem.style.display = 'none';
};

var hide = function hide(elems) {
  if (elems && !elems.length) {
    return _hide(elems);
  }
  for (var i = 0; i < elems.length; ++i) {
    _hide(elems[i]);
  }
};

var isDescendant = function isDescendant(parent, child) {
  var node = child.parentNode;
  while (node !== null) {
    if (node === parent) {
      return true;
    }
    node = node.parentNode;
  }
  return false;
};

var getTopMargin = function getTopMargin(elem) {
  elem.style.left = '-9999px';
  elem.style.display = 'block';

  var height = elem.clientHeight,
      padding;
  if (typeof getComputedStyle !== 'undefined') {
    // IE 8
    padding = parseInt(getComputedStyle(elem).getPropertyValue('padding-top'), 10);
  } else {
    padding = parseInt(elem.currentStyle.padding);
  }

  elem.style.left = '';
  elem.style.display = 'none';
  return '-' + parseInt((height + padding) / 2) + 'px';
};

var fadeIn = function fadeIn(elem, interval) {
  if (+elem.style.opacity < 1) {
    interval = interval || 16;
    elem.style.opacity = 0;
    elem.style.display = 'block';
    var last = +new Date();
    var tick = (function (_tick) {
      function tick() {
        return _tick.apply(this, arguments);
      }

      tick.toString = function () {
        return _tick.toString();
      };

      return tick;
    })(function () {
      elem.style.opacity = +elem.style.opacity + (new Date() - last) / 100;
      last = +new Date();

      if (+elem.style.opacity < 1) {
        setTimeout(tick, interval);
      }
    });
    tick();
  }
  elem.style.display = 'block'; //fallback IE8
};

var fadeOut = function fadeOut(elem, interval) {
  interval = interval || 16;
  elem.style.opacity = 1;
  var last = +new Date();
  var tick = (function (_tick2) {
    function tick() {
      return _tick2.apply(this, arguments);
    }

    tick.toString = function () {
      return _tick2.toString();
    };

    return tick;
  })(function () {
    elem.style.opacity = +elem.style.opacity - (new Date() - last) / 100;
    last = +new Date();

    if (+elem.style.opacity > 0) {
      setTimeout(tick, interval);
    } else {
      elem.style.display = 'none';
    }
  });
  tick();
};

var fireClick = function fireClick(node) {
  // Taken from http://www.nonobtrusive.com/2011/11/29/programatically-fire-crossbrowser-click-event-with-javascript/
  // Then fixed for today's Chrome browser.
  if (typeof MouseEvent === 'function') {
    // Up-to-date approach
    var mevt = new MouseEvent('click', {
      view: window,
      bubbles: false,
      cancelable: true
    });
    node.dispatchEvent(mevt);
  } else if (document.createEvent) {
    // Fallback
    var evt = document.createEvent('MouseEvents');
    evt.initEvent('click', false, false);
    node.dispatchEvent(evt);
  } else if (document.createEventObject) {
    node.fireEvent('onclick');
  } else if (typeof node.onclick === 'function') {
    node.onclick();
  }
};

var stopEventPropagation = function stopEventPropagation(e) {
  // In particular, make sure the space bar doesn't scroll the main window.
  if (typeof e.stopPropagation === 'function') {
    e.stopPropagation();
    e.preventDefault();
  } else if (window.event && window.event.hasOwnProperty('cancelBubble')) {
    window.event.cancelBubble = true;
  }
};

exports.hasClass = hasClass;
exports.addClass = addClass;
exports.removeClass = removeClass;
exports.escapeHtml = escapeHtml;
exports._show = _show;
exports.show = show;
exports._hide = _hide;
exports.hide = hide;
exports.isDescendant = isDescendant;
exports.getTopMargin = getTopMargin;
exports.fadeIn = fadeIn;
exports.fadeOut = fadeOut;
exports.fireClick = fireClick;
exports.stopEventPropagation = stopEventPropagation;
},{}],5:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
  value: true
});

var _stopEventPropagation$fireClick = require('./handle-dom');

var _setFocusStyle = require('./handle-swal-dom');

var handleKeyDown = function handleKeyDown(event, params, modal) {
  var e = event || window.event;
  var keyCode = e.keyCode || e.which;

  var $okButton = modal.querySelector('button.confirm');
  var $cancelButton = modal.querySelector('button.cancel');
  var $modalButtons = modal.querySelectorAll('button[tabindex]');

  if ([9, 13, 32, 27].indexOf(keyCode) === -1) {
    // Don't do work on keys we don't care about.
    return;
  }

  var $targetElement = e.target || e.srcElement;

  var btnIndex = -1; // Find the button - note, this is a nodelist, not an array.
  for (var i = 0; i < $modalButtons.length; i++) {
    if ($targetElement === $modalButtons[i]) {
      btnIndex = i;
      break;
    }
  }

  if (keyCode === 9) {
    // TAB
    if (btnIndex === -1) {
      // No button focused. Jump to the confirm button.
      $targetElement = $okButton;
    } else {
      // Cycle to the next button
      if (btnIndex === $modalButtons.length - 1) {
        $targetElement = $modalButtons[0];
      } else {
        $targetElement = $modalButtons[btnIndex + 1];
      }
    }

    _stopEventPropagation$fireClick.stopEventPropagation(e);
    $targetElement.focus();

    if (params.confirmButtonColor) {
      _setFocusStyle.setFocusStyle($targetElement, params.confirmButtonColor);
    }
  } else {
    if (keyCode === 13) {
      if ($targetElement.tagName === 'INPUT') {
        $targetElement = $okButton;
        $okButton.focus();
      }

      if (btnIndex === -1) {
        // ENTER/SPACE clicked outside of a button.
        $targetElement = $okButton;
      } else {
        // Do nothing - let the browser handle it.
        $targetElement = undefined;
      }
    } else if (keyCode === 27 && params.allowEscapeKey === true) {
      $targetElement = $cancelButton;
      _stopEventPropagation$fireClick.fireClick($targetElement, e);
    } else {
      // Fallback - let the browser handle it.
      $targetElement = undefined;
    }
  }
};

exports['default'] = handleKeyDown;
module.exports = exports['default'];
},{"./handle-dom":4,"./handle-swal-dom":6}],6:[function(require,module,exports){
'use strict';

var _interopRequireWildcard = function (obj) { return obj && obj.__esModule ? obj : { 'default': obj }; };

Object.defineProperty(exports, '__esModule', {
  value: true
});

var _hexToRgb = require('./utils');

var _removeClass$getTopMargin$fadeIn$show$addClass = require('./handle-dom');

var _defaultParams = require('./default-params');

var _defaultParams2 = _interopRequireWildcard(_defaultParams);

/*
 * Add modal + overlay to DOM
 */

var _injectedHTML = require('./injected-html');

var _injectedHTML2 = _interopRequireWildcard(_injectedHTML);

var modalClass = '.sweet-alert';
var overlayClass = '.sweet-overlay';

var sweetAlertInitialize = function sweetAlertInitialize() {
  var sweetWrap = document.createElement('div');
  sweetWrap.innerHTML = _injectedHTML2['default'];

  // Append elements to body
  while (sweetWrap.firstChild) {
    document.body.appendChild(sweetWrap.firstChild);
  }
};

/*
 * Get DOM element of modal
 */
var getModal = (function (_getModal) {
  function getModal() {
    return _getModal.apply(this, arguments);
  }

  getModal.toString = function () {
    return _getModal.toString();
  };

  return getModal;
})(function () {
  var $modal = document.querySelector(modalClass);

  if (!$modal) {
    sweetAlertInitialize();
    $modal = getModal();
  }

  return $modal;
});

/*
 * Get DOM element of input (in modal)
 */
var getInput = function getInput() {
  var $modal = getModal();
  if ($modal) {
    return $modal.querySelector('input');
  }
};

/*
 * Get DOM element of overlay
 */
var getOverlay = function getOverlay() {
  return document.querySelector(overlayClass);
};

/*
 * Add box-shadow style to button (depending on its chosen bg-color)
 */
var setFocusStyle = function setFocusStyle($button, bgColor) {
  var rgbColor = _hexToRgb.hexToRgb(bgColor);
  $button.style.boxShadow = '0 0 2px rgba(' + rgbColor + ', 0.8), inset 0 0 0 1px rgba(0, 0, 0, 0.05)';
};

/*
 * Animation when opening modal
 */
var openModal = function openModal(callback) {
  var $modal = getModal();
  _removeClass$getTopMargin$fadeIn$show$addClass.fadeIn(getOverlay(), 10);
  _removeClass$getTopMargin$fadeIn$show$addClass.show($modal);
  _removeClass$getTopMargin$fadeIn$show$addClass.addClass($modal, 'showSweetAlert');
  _removeClass$getTopMargin$fadeIn$show$addClass.removeClass($modal, 'hideSweetAlert');

  window.previousActiveElement = document.activeElement;
  var $okButton = $modal.querySelector('button.confirm');
  $okButton.focus();

  setTimeout(function () {
    _removeClass$getTopMargin$fadeIn$show$addClass.addClass($modal, 'visible');
  }, 500);

  var timer = $modal.getAttribute('data-timer');

  if (timer !== 'null' && timer !== '') {
    var timerCallback = callback;
    $modal.timeout = setTimeout(function () {
      var doneFunctionExists = (timerCallback || null) && $modal.getAttribute('data-has-done-function') === 'true';
      if (doneFunctionExists) {
        timerCallback(null);
      } else {
        sweetAlert.close();
      }
    }, timer);
  }
};

/*
 * Reset the styling of the input
 * (for example if errors have been shown)
 */
var resetInput = function resetInput() {
  var $modal = getModal();
  var $input = getInput();

  _removeClass$getTopMargin$fadeIn$show$addClass.removeClass($modal, 'show-input');
  $input.value = _defaultParams2['default'].inputValue;
  $input.setAttribute('type', _defaultParams2['default'].inputType);
  $input.setAttribute('placeholder', _defaultParams2['default'].inputPlaceholder);

  resetInputError();
};

var resetInputError = function resetInputError(event) {
  // If press enter => ignore
  if (event && event.keyCode === 13) {
    return false;
  }

  var $modal = getModal();

  var $errorIcon = $modal.querySelector('.sa-input-error');
  _removeClass$getTopMargin$fadeIn$show$addClass.removeClass($errorIcon, 'show');

  var $errorContainer = $modal.querySelector('.sa-error-container');
  _removeClass$getTopMargin$fadeIn$show$addClass.removeClass($errorContainer, 'show');
};

/*
 * Set "margin-top"-property on modal based on its computed height
 */
var fixVerticalPosition = function fixVerticalPosition() {
  var $modal = getModal();
  $modal.style.marginTop = _removeClass$getTopMargin$fadeIn$show$addClass.getTopMargin(getModal());
};

exports.sweetAlertInitialize = sweetAlertInitialize;
exports.getModal = getModal;
exports.getOverlay = getOverlay;
exports.getInput = getInput;
exports.setFocusStyle = setFocusStyle;
exports.openModal = openModal;
exports.resetInput = resetInput;
exports.resetInputError = resetInputError;
exports.fixVerticalPosition = fixVerticalPosition;
},{"./default-params":2,"./handle-dom":4,"./injected-html":7,"./utils":9}],7:[function(require,module,exports){
"use strict";

Object.defineProperty(exports, "__esModule", {
  value: true
});
var injectedHTML =

// Dark overlay
"<div class=\"sweet-overlay\" tabIndex=\"-1\"></div>" +

// Modal
"<div class=\"sweet-alert\">" +

// Error icon
"<div class=\"sa-icon sa-error\">\n      <span class=\"sa-x-mark\">\n        <span class=\"sa-line sa-left\"></span>\n        <span class=\"sa-line sa-right\"></span>\n      </span>\n    </div>" +

// Warning icon
"<div class=\"sa-icon sa-warning\">\n      <span class=\"sa-body\"></span>\n      <span class=\"sa-dot\"></span>\n    </div>" +

// Info icon
"<div class=\"sa-icon sa-info\"></div>" +

// Success icon
"<div class=\"sa-icon sa-success\">\n      <span class=\"sa-line sa-tip\"></span>\n      <span class=\"sa-line sa-long\"></span>\n\n      <div class=\"sa-placeholder\"></div>\n      <div class=\"sa-fix\"></div>\n    </div>" + "<div class=\"sa-icon sa-custom\"></div>" +

// Title, text and input
"<h2>Title</h2>\n    <p>Text</p>\n    <fieldset>\n      <input type=\"text\" tabIndex=\"3\" />\n      <div class=\"sa-input-error\"></div>\n    </fieldset>" +

// Input errors
"<div class=\"sa-error-container\">\n      <div class=\"icon\">!</div>\n      <p>Not valid!</p>\n    </div>" +

// Cancel and confirm buttons
"<div class=\"sa-button-container\">\n      <button class=\"cancel\" tabIndex=\"2\">Cancel</button>\n      <div class=\"sa-confirm-button-container\">\n        <button class=\"confirm\" tabIndex=\"1\">OK</button>" +

// Loading animation
"<div class=\"la-ball-fall\">\n          <div></div>\n          <div></div>\n          <div></div>\n        </div>\n      </div>\n    </div>" +

// End of modal
"</div>";

exports["default"] = injectedHTML;
module.exports = exports["default"];
},{}],8:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
  value: true
});

var _isIE8 = require('./utils');

var _getModal$getInput$setFocusStyle = require('./handle-swal-dom');

var _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide = require('./handle-dom');

var alertTypes = ['error', 'warning', 'info', 'success', 'input', 'prompt'];

/*
 * Set type, text and actions on modal
 */
var setParameters = function setParameters(params) {
  var modal = _getModal$getInput$setFocusStyle.getModal();

  var $title = modal.querySelector('h2');
  var $text = modal.querySelector('p');
  var $cancelBtn = modal.querySelector('button.cancel');
  var $confirmBtn = modal.querySelector('button.confirm');

  /*
   * Title
   */
  $title.innerHTML = params.html ? params.title : _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.escapeHtml(params.title).split('\n').join('<br>');

  /*
   * Text
   */
  $text.innerHTML = params.html ? params.text : _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.escapeHtml(params.text || '').split('\n').join('<br>');
  if (params.text) _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.show($text);

  /*
   * Custom class
   */
  if (params.customClass) {
    _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.addClass(modal, params.customClass);
    modal.setAttribute('data-custom-class', params.customClass);
  } else {
    // Find previously set classes and remove them
    var customClass = modal.getAttribute('data-custom-class');
    _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.removeClass(modal, customClass);
    modal.setAttribute('data-custom-class', '');
  }

  /*
   * Icon
   */
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.hide(modal.querySelectorAll('.sa-icon'));

  if (params.type && !_isIE8.isIE8()) {
    var _ret = (function () {

      var validType = false;

      for (var i = 0; i < alertTypes.length; i++) {
        if (params.type === alertTypes[i]) {
          validType = true;
          break;
        }
      }

      if (!validType) {
        logStr('Unknown alert type: ' + params.type);
        return {
          v: false
        };
      }

      var typesWithIcons = ['success', 'error', 'warning', 'info'];
      var $icon = undefined;

      if (typesWithIcons.indexOf(params.type) !== -1) {
        $icon = modal.querySelector('.sa-icon.' + 'sa-' + params.type);
        _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.show($icon);
      }

      var $input = _getModal$getInput$setFocusStyle.getInput();

      // Animate icon
      switch (params.type) {

        case 'success':
          _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.addClass($icon, 'animate');
          _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.addClass($icon.querySelector('.sa-tip'), 'animateSuccessTip');
          _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.addClass($icon.querySelector('.sa-long'), 'animateSuccessLong');
          break;

        case 'error':
          _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.addClass($icon, 'animateErrorIcon');
          _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.addClass($icon.querySelector('.sa-x-mark'), 'animateXMark');
          break;

        case 'warning':
          _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.addClass($icon, 'pulseWarning');
          _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.addClass($icon.querySelector('.sa-body'), 'pulseWarningIns');
          _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.addClass($icon.querySelector('.sa-dot'), 'pulseWarningIns');
          break;

        case 'input':
        case 'prompt':
          $input.setAttribute('type', params.inputType);
          $input.value = params.inputValue;
          $input.setAttribute('placeholder', params.inputPlaceholder);
          _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.addClass(modal, 'show-input');
          setTimeout(function () {
            $input.focus();
            $input.addEventListener('keyup', swal.resetInputError);
          }, 400);
          break;
      }
    })();

    if (typeof _ret === 'object') {
      return _ret.v;
    }
  }

  /*
   * Custom image
   */
  if (params.imageUrl) {
    var $customIcon = modal.querySelector('.sa-icon.sa-custom');

    $customIcon.style.backgroundImage = 'url(' + params.imageUrl + ')';
    _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.show($customIcon);

    var _imgWidth = 80;
    var _imgHeight = 80;

    if (params.imageSize) {
      var dimensions = params.imageSize.toString().split('x');
      var imgWidth = dimensions[0];
      var imgHeight = dimensions[1];

      if (!imgWidth || !imgHeight) {
        logStr('Parameter imageSize expects value with format WIDTHxHEIGHT, got ' + params.imageSize);
      } else {
        _imgWidth = imgWidth;
        _imgHeight = imgHeight;
      }
    }

    $customIcon.setAttribute('style', $customIcon.getAttribute('style') + 'width:' + _imgWidth + 'px; height:' + _imgHeight + 'px');
  }

  /*
   * Show cancel button?
   */
  modal.setAttribute('data-has-cancel-button', params.showCancelButton);
  if (params.showCancelButton) {
    $cancelBtn.style.display = 'inline-block';
  } else {
    _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.hide($cancelBtn);
  }

  /*
   * Show confirm button?
   */
  modal.setAttribute('data-has-confirm-button', params.showConfirmButton);
  if (params.showConfirmButton) {
    $confirmBtn.style.display = 'inline-block';
  } else {
    _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.hide($confirmBtn);
  }

  /*
   * Custom text on cancel/confirm buttons
   */
  if (params.cancelButtonText) {
    $cancelBtn.innerHTML = _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.escapeHtml(params.cancelButtonText);
  }
  if (params.confirmButtonText) {
    $confirmBtn.innerHTML = _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide.escapeHtml(params.confirmButtonText);
  }

  /*
   * Custom color on confirm button
   */
  if (params.confirmButtonColor) {
    // Set confirm button to selected background color
    $confirmBtn.style.backgroundColor = params.confirmButtonColor;

    // Set the confirm button color to the loading ring
    $confirmBtn.style.borderLeftColor = params.confirmLoadingButtonColor;
    $confirmBtn.style.borderRightColor = params.confirmLoadingButtonColor;

    // Set box-shadow to default focused button
    _getModal$getInput$setFocusStyle.setFocusStyle($confirmBtn, params.confirmButtonColor);
  }

  /*
   * Allow outside click
   */
  modal.setAttribute('data-allow-outside-click', params.allowOutsideClick);

  /*
   * Callback function
   */
  var hasDoneFunction = params.doneFunction ? true : false;
  modal.setAttribute('data-has-done-function', hasDoneFunction);

  /*
   * Animation
   */
  if (!params.animation) {
    modal.setAttribute('data-animation', 'none');
  } else if (typeof params.animation === 'string') {
    modal.setAttribute('data-animation', params.animation); // Custom animation
  } else {
    modal.setAttribute('data-animation', 'pop');
  }

  /*
   * Timer
   */
  modal.setAttribute('data-timer', params.timer);
};

exports['default'] = setParameters;
module.exports = exports['default'];
},{"./handle-dom":4,"./handle-swal-dom":6,"./utils":9}],9:[function(require,module,exports){
'use strict';

Object.defineProperty(exports, '__esModule', {
  value: true
});
/*
 * Allow user to pass their own params
 */
var extend = function extend(a, b) {
  for (var key in b) {
    if (b.hasOwnProperty(key)) {
      a[key] = b[key];
    }
  }
  return a;
};

/*
 * Convert HEX codes to RGB values (#000000 -> rgb(0,0,0))
 */
var hexToRgb = function hexToRgb(hex) {
  var result = /^#?([a-f\d]{2})([a-f\d]{2})([a-f\d]{2})$/i.exec(hex);
  return result ? parseInt(result[1], 16) + ', ' + parseInt(result[2], 16) + ', ' + parseInt(result[3], 16) : null;
};

/*
 * Check if the user is using Internet Explorer 8 (for fallbacks)
 */
var isIE8 = function isIE8() {
  return window.attachEvent && !window.addEventListener;
};

/*
 * IE compatible logging for developers
 */
var logStr = function logStr(string) {
  if (window.console) {
    // IE...
    window.console.log('SweetAlert: ' + string);
  }
};

/*
 * Set hover, active and focus-states for buttons 
 * (source: http://www.sitepoint.com/javascript-generate-lighter-darker-color)
 */
var colorLuminance = function colorLuminance(hex, lum) {
  // Validate hex string
  hex = String(hex).replace(/[^0-9a-f]/gi, '');
  if (hex.length < 6) {
    hex = hex[0] + hex[0] + hex[1] + hex[1] + hex[2] + hex[2];
  }
  lum = lum || 0;

  // Convert to decimal and change luminosity
  var rgb = '#';
  var c;
  var i;

  for (i = 0; i < 3; i++) {
    c = parseInt(hex.substr(i * 2, 2), 16);
    c = Math.round(Math.min(Math.max(0, c + c * lum), 255)).toString(16);
    rgb += ('00' + c).substr(c.length);
  }

  return rgb;
};

exports.extend = extend;
exports.hexToRgb = hexToRgb;
exports.isIE8 = isIE8;
exports.logStr = logStr;
exports.colorLuminance = colorLuminance;
},{}],10:[function(require,module,exports){
'use strict';

var _interopRequireWildcard = function (obj) { return obj && obj.__esModule ? obj : { 'default': obj }; };

Object.defineProperty(exports, '__esModule', {
  value: true
});
// SweetAlert
// 2014-2015 (c) - Tristan Edwards
// github.com/t4t5/sweetalert

/*
 * jQuery-like functions for manipulating the DOM
 */

var _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation = require('./modules/handle-dom');

/*
 * Handy utilities
 */

var _extend$hexToRgb$isIE8$logStr$colorLuminance = require('./modules/utils');

/*
 *  Handle sweetAlert's DOM elements
 */

var _sweetAlertInitialize$getModal$getOverlay$getInput$setFocusStyle$openModal$resetInput$fixVerticalPosition = require('./modules/handle-swal-dom');

// Handle button events and keyboard events

var _handleButton$handleConfirm$handleCancel = require('./modules/handle-click');

var _handleKeyDown = require('./modules/handle-key');

var _handleKeyDown2 = _interopRequireWildcard(_handleKeyDown);

// Default values

var _defaultParams = require('./modules/default-params');

var _defaultParams2 = _interopRequireWildcard(_defaultParams);

var _setParameters = require('./modules/set-params');

var _setParameters2 = _interopRequireWildcard(_setParameters);

/*
 * Remember state in cases where opening and handling a modal will fiddle with it.
 * (We also use window.previousActiveElement as a global variable)
 */
var previousWindowKeyDown;
var lastFocusedButton;

/*
 * Global sweetAlert function
 * (this is what the user calls)
 */
var sweetAlert, swal;

exports['default'] = sweetAlert = swal = function () {
  var customizations = arguments[0];

  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.addClass(document.body, 'stop-scrolling');
  _sweetAlertInitialize$getModal$getOverlay$getInput$setFocusStyle$openModal$resetInput$fixVerticalPosition.resetInput();

  /*
   * Use argument if defined or default value from params object otherwise.
   * Supports the case where a default value is boolean true and should be
   * overridden by a corresponding explicit argument which is boolean false.
   */
  function argumentOrDefault(key) {
    var args = customizations;
    return args[key] === undefined ? _defaultParams2['default'][key] : args[key];
  }

  if (customizations === undefined) {
    _extend$hexToRgb$isIE8$logStr$colorLuminance.logStr('SweetAlert expects at least 1 attribute!');
    return false;
  }

  var params = _extend$hexToRgb$isIE8$logStr$colorLuminance.extend({}, _defaultParams2['default']);

  switch (typeof customizations) {

    // Ex: swal("Hello", "Just testing", "info");
    case 'string':
      params.title = customizations;
      params.text = arguments[1] || '';
      params.type = arguments[2] || '';
      break;

    // Ex: swal({ title:"Hello", text: "Just testing", type: "info" });
    case 'object':
      if (customizations.title === undefined) {
        _extend$hexToRgb$isIE8$logStr$colorLuminance.logStr('Missing "title" argument!');
        return false;
      }

      params.title = customizations.title;

      for (var customName in _defaultParams2['default']) {
        params[customName] = argumentOrDefault(customName);
      }

      // Show "Confirm" instead of "OK" if cancel button is visible
      params.confirmButtonText = params.showCancelButton ? 'Confirm' : _defaultParams2['default'].confirmButtonText;
      params.confirmButtonText = argumentOrDefault('confirmButtonText');

      // Callback function when clicking on "OK"/"Cancel"
      params.doneFunction = arguments[1] || null;

      break;

    default:
      _extend$hexToRgb$isIE8$logStr$colorLuminance.logStr('Unexpected type of argument! Expected "string" or "object", got ' + typeof customizations);
      return false;

  }

  _setParameters2['default'](params);
  _sweetAlertInitialize$getModal$getOverlay$getInput$setFocusStyle$openModal$resetInput$fixVerticalPosition.fixVerticalPosition();
  _sweetAlertInitialize$getModal$getOverlay$getInput$setFocusStyle$openModal$resetInput$fixVerticalPosition.openModal(arguments[1]);

  // Modal interactions
  var modal = _sweetAlertInitialize$getModal$getOverlay$getInput$setFocusStyle$openModal$resetInput$fixVerticalPosition.getModal();

  /*
   * Make sure all modal buttons respond to all events
   */
  var $buttons = modal.querySelectorAll('button');
  var buttonEvents = ['onclick', 'onmouseover', 'onmouseout', 'onmousedown', 'onmouseup', 'onfocus'];
  var onButtonEvent = function onButtonEvent(e) {
    return _handleButton$handleConfirm$handleCancel.handleButton(e, params, modal);
  };

  for (var btnIndex = 0; btnIndex < $buttons.length; btnIndex++) {
    for (var evtIndex = 0; evtIndex < buttonEvents.length; evtIndex++) {
      var btnEvt = buttonEvents[evtIndex];
      $buttons[btnIndex][btnEvt] = onButtonEvent;
    }
  }

  // Clicking outside the modal dismisses it (if allowed by user)
  _sweetAlertInitialize$getModal$getOverlay$getInput$setFocusStyle$openModal$resetInput$fixVerticalPosition.getOverlay().onclick = onButtonEvent;

  previousWindowKeyDown = window.onkeydown;

  var onKeyEvent = function onKeyEvent(e) {
    return _handleKeyDown2['default'](e, params, modal);
  };
  window.onkeydown = onKeyEvent;

  window.onfocus = function () {
    // When the user has focused away and focused back from the whole window.
    setTimeout(function () {
      // Put in a timeout to jump out of the event sequence.
      // Calling focus() in the event sequence confuses things.
      if (lastFocusedButton !== undefined) {
        lastFocusedButton.focus();
        lastFocusedButton = undefined;
      }
    }, 0);
  };

  // Show alert with enabled buttons always
  swal.enableButtons();
};

/*
 * Set default params for each popup
 * @param {Object} userParams
 */
sweetAlert.setDefaults = swal.setDefaults = function (userParams) {
  if (!userParams) {
    throw new Error('userParams is required');
  }
  if (typeof userParams !== 'object') {
    throw new Error('userParams has to be a object');
  }

  _extend$hexToRgb$isIE8$logStr$colorLuminance.extend(_defaultParams2['default'], userParams);
};

/*
 * Animation when closing modal
 */
sweetAlert.close = swal.close = function () {
  var modal = _sweetAlertInitialize$getModal$getOverlay$getInput$setFocusStyle$openModal$resetInput$fixVerticalPosition.getModal();

  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.fadeOut(_sweetAlertInitialize$getModal$getOverlay$getInput$setFocusStyle$openModal$resetInput$fixVerticalPosition.getOverlay(), 5);
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.fadeOut(modal, 5);
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass(modal, 'showSweetAlert');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.addClass(modal, 'hideSweetAlert');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass(modal, 'visible');

  /*
   * Reset icon animations
   */
  var $successIcon = modal.querySelector('.sa-icon.sa-success');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass($successIcon, 'animate');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass($successIcon.querySelector('.sa-tip'), 'animateSuccessTip');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass($successIcon.querySelector('.sa-long'), 'animateSuccessLong');

  var $errorIcon = modal.querySelector('.sa-icon.sa-error');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass($errorIcon, 'animateErrorIcon');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass($errorIcon.querySelector('.sa-x-mark'), 'animateXMark');

  var $warningIcon = modal.querySelector('.sa-icon.sa-warning');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass($warningIcon, 'pulseWarning');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass($warningIcon.querySelector('.sa-body'), 'pulseWarningIns');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass($warningIcon.querySelector('.sa-dot'), 'pulseWarningIns');

  // Reset custom class (delay so that UI changes aren't visible)
  setTimeout(function () {
    var customClass = modal.getAttribute('data-custom-class');
    _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass(modal, customClass);
  }, 300);

  // Make page scrollable again
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass(document.body, 'stop-scrolling');

  // Reset the page to its previous state
  window.onkeydown = previousWindowKeyDown;
  if (window.previousActiveElement) {
    window.previousActiveElement.focus();
  }
  lastFocusedButton = undefined;
  clearTimeout(modal.timeout);

  return true;
};

/*
 * Validation of the input field is done by user
 * If something is wrong => call showInputError with errorMessage
 */
sweetAlert.showInputError = swal.showInputError = function (errorMessage) {
  var modal = _sweetAlertInitialize$getModal$getOverlay$getInput$setFocusStyle$openModal$resetInput$fixVerticalPosition.getModal();

  var $errorIcon = modal.querySelector('.sa-input-error');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.addClass($errorIcon, 'show');

  var $errorContainer = modal.querySelector('.sa-error-container');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.addClass($errorContainer, 'show');

  $errorContainer.querySelector('p').innerHTML = errorMessage;

  setTimeout(function () {
    sweetAlert.enableButtons();
  }, 1);

  modal.querySelector('input').focus();
};

/*
 * Reset input error DOM elements
 */
sweetAlert.resetInputError = swal.resetInputError = function (event) {
  // If press enter => ignore
  if (event && event.keyCode === 13) {
    return false;
  }

  var $modal = _sweetAlertInitialize$getModal$getOverlay$getInput$setFocusStyle$openModal$resetInput$fixVerticalPosition.getModal();

  var $errorIcon = $modal.querySelector('.sa-input-error');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass($errorIcon, 'show');

  var $errorContainer = $modal.querySelector('.sa-error-container');
  _hasClass$addClass$removeClass$escapeHtml$_show$show$_hide$hide$isDescendant$getTopMargin$fadeIn$fadeOut$fireClick$stopEventPropagation.removeClass($errorContainer, 'show');
};

/*
 * Disable confirm and cancel buttons
 */
sweetAlert.disableButtons = swal.disableButtons = function (event) {
  var modal = _sweetAlertInitialize$getModal$getOverlay$getInput$setFocusStyle$openModal$resetInput$fixVerticalPosition.getModal();
  var $confirmButton = modal.querySelector('button.confirm');
  var $cancelButton = modal.querySelector('button.cancel');
  $confirmButton.disabled = true;
  $cancelButton.disabled = true;
};

/*
 * Enable confirm and cancel buttons
 */
sweetAlert.enableButtons = swal.enableButtons = function (event) {
  var modal = _sweetAlertInitialize$getModal$getOverlay$getInput$setFocusStyle$openModal$resetInput$fixVerticalPosition.getModal();
  var $confirmButton = modal.querySelector('button.confirm');
  var $cancelButton = modal.querySelector('button.cancel');
  $confirmButton.disabled = false;
  $cancelButton.disabled = false;
};

if (typeof window !== 'undefined') {
  // The 'handle-click' module requires
  // that 'sweetAlert' was set as global.
  window.sweetAlert = window.swal = sweetAlert;
} else {
  _extend$hexToRgb$isIE8$logStr$colorLuminance.logStr('SweetAlert is a frontend module!');
}
module.exports = exports['default'];
},{"./modules/default-params":2,"./modules/handle-click":3,"./modules/handle-dom":4,"./modules/handle-key":5,"./modules/handle-swal-dom":6,"./modules/set-params":8,"./modules/utils":9}],11:[function(require,module,exports){
function AgentStatusController($scope, $rootScope, FeatureService, AgentStatusService, ExtensionService, DesktopNotificationService, CallService) {

    var FEATURE_NAME = 'agentStatus';
    var STATUS_TYPE = {
        AVAILABLE: 'available',
        BUSY: 'busy',
        WRAP_UP: 'wrapUp',
        OFFLINE: 'offline'
    };

    $scope.login = {};
    $scope.statuses = [];
    $scope.extensions = [];
    $scope.agentStatusAvailable = false;
    $scope.showLoginModal = false;
    $scope.loginRequired = false;

    var unbindOrgFeature, unbindUserFeature, extensionsLoaded;

    $scope.$on('modal-opened-status-modal', checkExtensionsLoaded);

    $scope.loginToPhoneSystem = function() {
        window.spinner.show('Logging in...');
        return AgentStatusService.login($scope.login).then(function(response) {
            if (!response.success) {
                throw new Error('Failed to login. Please try again in a few minutes');
            }
            $scope.showLoginModal = false;
            $rootScope.$broadcast('modal-close', 'status-modal');
        }).catch(function(err) {
            DesktopNotificationService.notify('Login failed', err.message);
        }).then(function() {
            window.spinner.hide();
        });
    };

    $scope.logoutFromPhoneSystem = function() {
        window.spinner.show('Logging out...');
        setStatusOffline();

        return fillLoginForm().then(function() {
                return AgentStatusService.logout($scope.login);
            })
            .then(function(response) {
                if (!response.success) {
                    throw new Error('Failed to login. Please try again in a few minutes');
                }
                if ($scope.loginRequired) {
                    $scope.showLoginModal = true;
                }
                $rootScope.$broadcast('modal-close', 'status-modal');
            }).catch(function(err) {
                DesktopNotificationService.notify('Logout failed', err.message);
            }).then(function() {
                window.spinner.hide();
            });
    };

    function listenToUserStatusChanges() {
        return new Promise(function(resolve, reject) {
            unbindUserFeature = FeatureService.onUserFeature(FEATURE_NAME, function (snap) {
                $scope.userFeature = snap.val();
                refreshStatus();
                updateOmniChannelStatus();
                resolve();
            });
        });
    }

    function handleOrgFeature(snap) {
        $scope.feature = snap.val();
        $scope.agentStatusAvailable = _.get($scope.feature, 'status') === 'active';

        var promise = Promise.resolve();
        if ($scope.agentStatusAvailable) {
            if (!_.size($scope.statuses)) {
                promise = promise.then(loadStatuses);
            }
            if (!unbindUserFeature) {
                promise = promise.then(listenToUserStatusChanges);
            }
            checkIfShouldHandleActiveCall();
        }
        return promise;
    }

    unbindOrgFeature = FeatureService.onOrganizationFeature(FEATURE_NAME, handleOrgFeature);

    function handleActiveCall(call) {
        var status = _.get(call, 'status', '').toLowerCase();
        if (status === 'hangup') {
            changeStatusByType(STATUS_TYPE.AVAILABLE);
        } else if (status === 'connected') {
            changeStatusByType(STATUS_TYPE.BUSY);
        }
    }

    function changeStatusByType(type) {
        if (_.get($scope.currentStatus, 'type') !== type) {
            var status = _.find($scope.statuses, {type: type});
            if (status) {
                $scope.selectStatus(status);
            }
        }
    }

    function checkIfShouldHandleActiveCall() {
        var enabledIntegrationsName = [];
        var enabledIntegrations = _.get($scope.feature, 'preferences.enabledIntegrations') || {};
        _.forEach(enabledIntegrations, function (enabled, integration) {
            if (enabled) {
                enabledIntegrationsName.push(integration);
            }
        });

        if (_.size(enabledIntegrationsName) === 1 && _.includes(enabledIntegrationsName, 'salesforce')) {
            CallService.onActiveCall(handleActiveCall);
        }
    }

    $scope.isStatusDisabled = function(status) {
        var isStatusOffline = $scope.isStatusOffline(status);
        var currentStatusOffline = $scope.isStatusOffline($scope.currentStatus);
        var loginNotRequired = !$scope.loginRequired;

        return _.get(status, 'readOnly') || isStatusOffline || (currentStatusOffline && loginNotRequired);
    };

    $scope.isStatusOffline = function(status) {
        return !status || status.type === STATUS_TYPE.OFFLINE;
    };

    $scope.selectStatus = function(status) {
        if ($scope.isStatusDisabled(status)) {
            return;
        }

        $scope.currentStatus = status;

        AgentStatusService.updateStatus(status.id).then(function (response) {
            if (_.size(response.error)) {
                var services = _.map(response.error, 'service').join(', ');
                var updateStatusError = "The following services failed to update the status: " + services + '. Please, try again.';
                DesktopNotificationService.notify('Update status failed', updateStatusError);
            }
        }).catch(function (error) {
            DesktopNotificationService.notify('Update status failed', 'Something unexpected happened. Please, try again and if the error persists, call support');
        });
    };

    function loadStatuses() {
        return AgentStatusService.getStatuses().then(function (response) {
            $scope.statuses = _.get(response, 'statuses', []);
        });
    }

    function refreshStatus() {
        var currentStatus = _.get($scope.userFeature, 'preferences.currentStatus');
        $scope.currentStatus = _.find($scope.statuses, {id: currentStatus});

        if (!$scope.currentStatus) {
            setStatusOffline();
        }

        return checkLogin();
    }

    function setStatusOffline() {
        $scope.currentStatus = _.find($scope.statuses, {type: STATUS_TYPE.OFFLINE});
    }

    function checkLogin() {
        if (!_.get($scope, 'feature.preferences.loginRequired')) {
            return Promise.resolve();
        }

        $scope.loginRequired = true;

        var currentStatusType = _.get($scope, 'currentStatus.type');
        var showLoginModal = !currentStatusType || currentStatusType === STATUS_TYPE.OFFLINE;
        var promise = showLoginModal ? fillLoginForm() : Promise.resolve();
        return promise.then(function() {
            $scope.showLoginModal = showLoginModal;
        });
    }

    function fillLoginForm() {
        return checkExtensionsLoaded()
            .then(AgentStatusService.getAgentUserData)
            .then(function(result) {
                _.merge($scope.login, result.agentData);
            });
    }

    $scope.$on('destroy', function () {
        unbindOrgFeature();
        if (unbindUserFeature) {
            unbindUserFeature();
        }
    });

    function updateOmniChannelStatus() {
        var omniChannelEnabled = _.get($scope.feature, 'preferences.enabledIntegrations.salesforce', false);
        var isInConsole = _.get(sforce, 'console.presence') && sforce.console.isInConsole();

        if (!omniChannelEnabled || !isInConsole || !$scope.currentStatus) {
            return;
        }

        if ($scope.currentStatus.type === STATUS_TYPE.OFFLINE) {
            logoutOmniChannel();
        } else {
            var statuses = _.get($scope.feature, 'preferences.statuses', []);
            var status = _.find(statuses, {id: $scope.currentStatus.id});
            if (status) {
                changeOmniChannelStatus(_.get(status, 'mapping.salesforce'));
            }
        }
    }

    function changeOmniChannelStatus(status) {
        if (status) {
            var statusId = status.name.substring(0, status.name.length - 3);

            getOmniChannelServicePresenceStatusId().then(function (response) {
                if (!_.startsWith(statusId, response.statusId)) {
                    return setOmniChannelServicePresenceStatus(statusId);
                }
            }).catch(loginOmniChannel.bind(null, statusId));
        }
    }

    function getOmniChannelServicePresenceStatusId() {
        return new Promise(function (resolve, reject) {
            sforce.console.presence.getServicePresenceStatusId(function (response) {
                return response && response.success ? resolve(response) : reject();
            });
        });
    }

    function setOmniChannelServicePresenceStatus(statusId) {
        return new Promise(function (resolve, reject) {
            sforce.console.presence.setServicePresenceStatus(statusId, function (response) {
                return response && response.success ? resolve() : reject();
            });
        });
    }

    function loginOmniChannel(statusId) {
        return new Promise(function (resolve, reject) {
            sforce.console.presence.login(statusId, function (response) {
                return response && response.success ? resolve() : reject();
            });
        });
    }

    function logoutOmniChannel() {
        sforce.console.presence.logout();
    }

    function checkExtensionsLoaded() {
        return !extensionsLoaded &&  _.get($scope, 'feature.preferences.loginRequired') ? loadExtensions() : Promise.resolve();
    }

    function loadExtensions() {
        window.spinner.show('Fetching extensions...');
        return ExtensionService.getExtensions().then(function(extensions) {
            $scope.extensions = extensions;
        }).catch(function(err) {
            console.error('Error loading extensions:', err);
        }).then(function() {
            extensionsLoaded = true;
            window.spinner.hide();
        });
    }

}

angular.module('callinize')
    .controller('AgentStatusController', AgentStatusController);;


function AssignRecordParentController($scope, DesktopNotificationService, CallService, FeatureService) {

    var self = this;
    this.filterModules = ['Account'];
    this.supported = false;

    FeatureService.on('assignRecordParent', function (snap) {
        self.feature = snap.val();
        if (self.feature) {
            checkIfModuleIsSupported($scope.activeCall);
        }
    });

    $scope.$watch('activeCall', function() {
        if ($scope.activeCall) {
            checkIfModuleIsSupported($scope.activeCall)
        }
    });

    function checkIfModuleIsSupported(call) {
        var beanModule = _.get(call, 'matchedCrmRecords.0.bean_module');
        self .supported = _.includes(['Contact', 'Account'], beanModule) || isCustomModuleSupported(beanModule);
    }

    function isCustomModuleSupported(beanModule) {
        return _.some(_.get(self.feature, 'preferences.modules', []), function (module) {
            return module.name === beanModule;
        });
    }

    this.assignAccount = function (record) {
        if (this.selectedAccount === record.bean_id) {
            return;
        }

        window.spinner.show('Relating resource');

        this.selectedAccount = record.bean_id;
        var self = this;
        var opts = {
            parentId: record.bean_id,
            parentModule: record.bean_module
        };

        CallService.assignAccount(opts)
            .then(function () {
                self.selectedAccount = record.bean_id;
                DesktopNotificationService.notify('Account related', 'The Account was related to this match.');
                window.spinner.hide();
                $scope.closeModal();
            })
            .then(null, function (error) {
                self.selectedAccount = null;
                DesktopNotificationService.notify('Failed to relate the Account to this match.', 'Unable to relate Account: ' +
                    (error && error.message || error));
                window.spinner.hide();
            });
    };

}

angular.module('callinize').controller('AssignRecordParentController', AssignRecordParentController);;


angular.module('callinize').controller('CallController', function($scope, CallService, HistoryService,
    OpenURLService, FirebaseModel, FeatureService) {

    $scope.activeCall = null;
    $scope.innerView = "noActiveCall";
    $scope.autoOpenMatchedRecord = false;
    $scope.autoOpenRecordFeature = null;

    var oldCalls = {};

    CallService.onActiveCall(handleActiveCall);

    function changeView(viewName) {
        if ($scope.innerView != viewName) {
            $scope.innerView = viewName;
        }
    }

    function handleActiveCall(call) {

        if(isInboundCall(call) && _.get(call, "status", "").toLowerCase() === "ringing") {
            window.spinner.show("New incoming call");
        }

        $scope.activeCall = call;

        if($scope.outterView !== 'default') return;

        $scope.setView('active');
        var matchedCrmRecords = _.get(call, 'matchedCrmRecords') || [];
        var view;
        switch (matchedCrmRecords.length) {
            case 0:
                view = call && call.pass === 'finished' ? "noMatches" : 'searchingRecords';
                break;
            case 1:
                view = "singleMatch";
                break;
            default:
                view = "multipleMatches";
                break;
        }
        changeView(view);

        // Check if openWindow is set and not read
        if (call.openWindow && !call.openWindow.read) {
          if (call.openWindow.url) {
              OpenURLService.openCustomLink(call.openWindow.url, matchedCrmRecords[0].bean_name);
          } else if (call.openWindow.recordId) {
              OpenURLService.openRecord(call.openWindow.url, call.openWindow.recordId, matchedCrmRecords[0].bean_name);
          }

          // Set read to true to avoid opening it in other tabs
          FirebaseModel.fromUser('calls/history/' + call.id + '/openWindow/read').set(true);
        }

        if (isNewCall(call)) {
            markCallAsOld(call);
            checkAutoOpenRecord(call);
        }

        setTimeout(window.spinner.hide, 1000);
    }

    function isNewCall(call) {
        return call.pass === 'finished' && call.matchedCrmRecordsSearchComplete && !oldCalls[call.id] && !call.isOld;
    }

    function markCallAsOld(call) {
        call.isOld = true;
        oldCalls[call.id] = true;
        FirebaseModel.fromUser('calls/history/' + call.id + '/isOld').set(true);
    }

    function isInboundCall(call) {
        return getDirection(call) === "inbound";
    }

    function isHeld(call) {
        return call.status.toLowerCase() === 'held';
    }

    function getDirection(call) {
        return _.get(call, 'direction', '').toLowerCase();
    }

    function getMatchType(call) {
        if (_.get(call, 'matchedCrmRecords', []).length === 1) {
            return 'single-match';
        } else if(_.get(call, 'matchedCrmRecords', []).length === 0) {
            return 'no-match';
        } else {
            return 'multi-match';
        }
    }

    function checkAutoOpenRecord(call) {
        if (!$scope.autoOpenMatchedRecord || call.status.toLowerCase() !== 'ringing') return;

        var preferences = _.get($scope, 'autoOpenRecordFeature.preferences', {});
        var directionMatch = !_.has(preferences, 'direction') || (getDirection(call) ===  preferences.direction);
        var typeMatch = !_.has(preferences, 'type') || (getMatchType(call) === preferences.type);
        if (!typeMatch || !directionMatch) {
            return;
        }

        var action = _.get(preferences, 'action', {});
        action.type = action.type || 'openRecord';

        if (action.type === 'openRecord') {
            var match = call.matchedCrmRecords[0];
            OpenURLService.openRecord(match.bean_link, match.bean_id, match.bean_name);
        } else if (action.type === 'url' && action.value) {
            var url = action.value || '';
            url = url.replace('{{PHONE_NUMBER}}', call.phoneNumber);
            OpenURLService.openCustomLink(url, url);
        }
    }

    var unbind = FeatureService.on('autoOpenMatchedRecord', function(snap) {
        var feature = snap && snap.val();
        $scope.autoOpenMatchedRecord = _.get(feature, 'status', 'inactive') === 'active';
        if ($scope.autoOpenMatchedRecord) {
            $scope.autoOpenRecordFeature = feature;
        }
    });

    $scope.$on('$destroy', unbind);
});
;


function CallControlsController($scope, $timeout, LoginService, CallService, OrganizationService, CallControlsService) {

    $scope.users = [];
    $scope.transferExtensions = [];
    $scope.query = "";
    $scope.selectedTransferExtension;
    $scope.ongoingRequest = false;
    $scope.transferInProgress = "";

    var REQUEST_TIMEOUT = 5000;

    var extensionsLoaded;

    $scope.$on('modal-opened-transfer-modal', checkExtensionsLoaded);

    $scope.$on('modal-opened-conference-modal', checkExtensionsLoaded);

    $scope.selectExtension = function(extension) {
        $scope.selectedTransferExtension = extension;
    };

    $scope.answer = function() {
        var request = CallControlsService.answer.bind(null, $scope.call);
        doRequest(request);
    };

    $scope.hangup = function() {
        var request = CallControlsService.hangup.bind(null, $scope.call);
        doRequest(request);
    };

    $scope.toggleHold = function() {
        if ($scope.isWarmTransferInProgress()) {
            return;
        }

        var request;
        if ($scope.call.status === 'Held') {
            request = CallControlsService.retrieve.bind(null, $scope.call);
        } else {
            request = CallControlsService.hold.bind(null, $scope.call);
        }
        doRequest(request);
    };

    $scope.cancelTransfer = function () {
        listenForTransferChanges();
        var request = CallControlsService.cancelTransfer.bind(null, $scope.call);
        doRequest(request);
    };

    $scope.conference = function() {
        var request = CallControlsService.conference.bind(null, $scope.call, $scope.selectedTransferExtension);
        doRequest(request);
    };

    $scope.warmTransfer = function() {
        listenForTransferChanges();
        var request = CallControlsService.warmTransfer.bind(null, $scope.call, $scope.selectedTransferExtension);
        doRequest(request);
    };

    $scope.completeWarmTransfer = function () {
        var request = CallControlsService.completeWarmTransfer.bind(null, $scope.call);
        doRequest(request);
    };

    $scope.blindTransfer = function() {
        var request = CallControlsService.blindTransfer.bind(null, $scope.call, $scope.selectedTransferExtension);
        doRequest(request);
    };

    function doRequest(request) {
        if ($scope.ongoingRequest) return;

        $scope.ongoingRequest = true;
        listenForStatusChange();
        request().catch(function(err) {
            console.error(err);
        });
    }

    function listenForStatusChange() {
        var unbind, timer;

        function resetOnGoingRequest() {
            $scope.ongoingRequest = false;
        }

        function onStatusChange() {
            $timeout.cancel(timer);
            resetOnGoingRequest();
            if (unbind) {
                unbind();
            }
        }

        var call = $scope.call;
        timer = $timeout(resetOnGoingRequest, REQUEST_TIMEOUT);
        unbind = CallService.listenForStatusChanges(call, onStatusChange);
    }

    function listenForTransferChanges() {
        var unbind = CallService.listenForTransferChanges($scope.call, function (value) {
            $scope.transferInProgress = value;
            unbind();
        });

        $scope.$on('$destroy', unbind);
    }

    function loadExtensions() {
        window.spinner.show('Fetching users...');
        OrganizationService.getUsers().then(function(users) {
            $scope.users = mapUsers(users);
        }).catch(function(err) {
            console.error('Error loading users:', err);
        }).then(function() {
            extensionsLoaded = true;
            window.spinner.hide();
        });
    }

    function mapUsers(users) {
        function hasExtensions(user) {
            var loggedUser = LoginService.getUser();
            return _.get(user, 'extensions', []).length &&
                _.get(loggedUser, 'id') !== _.get(user, 'id');
        }

        function pickFields(user) {
            return _.pick(user, ['_id', 'name', 'username', 'extensions']);
        }

        return _(users).filter(hasExtensions).map(pickFields).value();
    }

    function checkExtensionsLoaded() {
        $scope.selectedTransferExtension = null;
        $scope.selectedUser = null;
        $scope.query = "";
        if (!extensionsLoaded) {
            loadExtensions();
        }
    }
}

angular.module('callinize')
.controller('CallControlsController', CallControlsController);
;


angular.module('callinize').controller('CallRecorderController',
	function ($scope, ngAudio, CallService, LoginService, FeatureService, CallRecorderService) {

		$scope.recordingEnabled = false;
		$scope.currentState = '';

		var currentCall;
		var states = {
			disabled: {
				title: 'Make a call to start recording',
				message: 'Rec'
			},
			starting: {
				title: 'Attempting to start recording',
				message: 'Starting'
			},
			enabled: {
				title: 'Click to start recording',
				message: 'Rec'
			},
			recording: {
				title: 'Click to stop recording',
				message: 'Stop'
			},
			playing: {
				title: 'Click to stop',
				message: 'Stop'
			},
			stopping: {
				title: 'Attempting to stop recording',
				message: 'Stopping'
			},
			stopped: {
				title: 'Click to play the record',
				message: 'Play'
			},
			error: {
				title: 'Error connecting to API',
				message: 'Error'
			}
		};

		CallService.onActiveCall(function (call) {
			currentCall = call;
			call.recordingLink = null; // 'http://www.schillmania.com/projects/soundmanager2/demo/mpc/audio/CHINA_1.mp3';
			handleCurrentCall(call);
		}, $scope.$on.bind($scope, '$destroy'));

		$scope.toggleRecording = function() {
			switch($scope.currentState) {
				case 'disabled':
					return;
				case 'enabled':
					return startRecording();
				case 'recording':
					return stopRecording();
				case 'stopped':
					return playRecord();
				case 'playing':
					return stopRecord();
				default:
					break;
			}
		};

		function changeState(stateName) {
			$scope.currentState = stateName;
			$scope.buttonState = states[stateName];
		}

		function startRecording() {
			if(!$scope.recordingEnabled)
				return;
			changeState('starting');
			CallRecorderService.startRecording(currentCall)
				.then(function() {
					changeState('recording');
				}, function() {
					changeState('error');
					console.error('Error during start recording.' +
						'Please check your connection and try again.');
				});
		}

		function stopRecording() {
			changeState('stopping');
			CallRecorderService.stopRecording(currentCall)
				.then(function() {
					changeState('disabled');
				}, function() {
					changeState('error');
					console.error('Error during stop recording.' +
						'Please check your connection and try again.');
				});
		}

		function playRecord() {
			$scope.record && $scope.record.play();
			changeState('playing');
		}

		function stopRecord() {
			$scope.record && $scope.record.stop();
			$scope.record = getAudioObject(currentCall.recordingLink);
			changeState('stopped');
		}

		function getAudioObject(recordingLink) {
			var audio = ngAudio.load(recordingLink);
			audio.complete(function() {
				if($scope.currentState == 'playing')
					changeState('stopped');
			});
			return audio;
		}

		function handleCurrentCall(call) {
			var status = _.get(call, 'status', '').toLowerCase();
			var recordingLink = _.get(call, 'recordingLink');
			switch(status) {
				case 'hangup':
					if (recordingLink) {
						$scope.record = getAudioObject(call.recordingLink);
						changeState('stopped');
					} else if ($scope.currentState == 'recording') {
						changeState('disabled');
					} else if ($scope.currentState == 'enabled') {
						changeState('disabled');
					}
					break;
				//case 'ringing':
				case 'connected':
					changeState('enabled');
					break;
				default:
					break;
			}
		}

		function checkRecordingEnabled() {
			var org = LoginService.getOrganization();
			$scope.recordingEnabled = org && ((org.preferences && org.preferences.allowCallRecording) || (org.features && org.features.allowCallRecording ));
		}

		changeState('disabled');
		checkRecordingEnabled();

	});
;


function ContactSearchController($scope, CallService, FirebaseModel, DesktopNotificationService) {
    $scope.records = [];
    $scope.contactName = null;

    $scope.addNumberToRecord = function (record) {
      	var call = CallService.getCurrentCall();
        window.spinner.show('Setting matching record...');
        return CallService.addNumber(record, call.phoneNumber, call.id)
    		.then(function (data) {
    			addNumberToRecordSuccess(record, call);
    		})
    		.then(null, recordError);
 	};

    $scope.cancel = function () {
        var call = CallService.getCurrentCall();
        FirebaseModel.fromUser('calls/history/' + call.id + '/matchedCrmRecords').set(call._matchedCrmRecords);
    };

    $scope.onRecordCreated = function () {
        $scope.contactName = null;
    };

    $scope.selectRecord = $scope.addNumberToRecord;

	function recordError(data) {
		DesktopNotificationService.notify('Error', 'Could not select record for this call');
        window.spinner.hide();
	}

	function addNumberToRecordSuccess(record, call) {
		call.matchedCrmRecords = [record];
		call.count = 1;
		CallService.setMatchedRecords([record])
            .then(function() {
                window.spinner.hide();
            })
            .then(null, recordError);
        var copy = angular.copy(record);
		FirebaseModel.fromUser('calls/history/' + call.id + '/matchedCrmRecords').set([copy]);
	}
}

angular.module('callinize').controller('ContactSearchController', ContactSearchController);
;


function CreateRecordController($scope, CreateRecordService, CallService,
    FeatureService, DesktopNotificationService, OpenCTIService, extensionHost, utils) {

    var features = FeatureService.getModel().child("createRecordType");
    features.on('value', bindFeature);

    FeatureService.on("createRecordType", function (snap) {
        var feature = snap.val() || {};
        $scope.recordTypes = feature.modules ? fromModules(feature.modules) : fromPreferences(feature.preferences);
        $scope.modules = feature.modules;
    });

    $scope.createRecord = function (recordType) {
        var recordName = $scope.contactName;
        if(!recordName)
            throw new Error("Contact name must be provided");
    	var call = CallService.getCurrentCall();
    	var phone = call && call.phoneNumber;

        window.spinner.show('Creating record...');
        CreateRecordService.create(recordName, phone, recordType)
            .then(function(record) {
                window.spinner.hide();
                if (record && record.bean_edit_link)
                    utils.createHiddenLink(record.bean_edit_link);
            })
            .then(null, recordError);
    };

    $scope.createRecord = _.throttle($scope.createRecord, 3000);

    $scope.$on("$destroy", function () {
        features.off("value", bindFeature);
    });

    function recordError(data) {
        var error = data.message || "Could not select record for this call";
        window.spinner.hide();
        DesktopNotificationService.notify('Error creating record', error);
    }

    function bindFeature(featureSnap) {
        $scope.feature = featureSnap.val();
    }

    function fromPreferences(preferences) {
        return _.keys(preferences);
    }

    function fromModules(modules) {
        return _.pluck(modules, 'label');
    }

    OpenCTIService.createThroughUrlNextSteps().then(function(record) {
        if(!record || !record.objectId) return;

        window.spinner.show('Associating ' + record.object + ' ' + record.objectName + ' with ' + record.phoneNumber + '...');
        
        CreateRecordService.associateRecordWithCall(record.phoneNumber, {
            bean_name: record.objectName,
            bean_id: record.objectId,
            bean_link: record.url,
            bean_module: record.object
        })
        .then(function(record) {
            window.spinner.hide();
            if (record && record.bean_edit_link) utils.createHiddenLink(record.bean_edit_link);
        }).then(null, recordError);
    });
}

angular.module('callinize')
    .controller('CreateRecordController', CreateRecordController);
;


function CustomWorkflowController($scope, $q, $timeout, FeatureService, OpenURLService, DesktopNotificationService,
                                  NoteService, CustomWorkflowService) {

    var FEATURE_NAME = 'customWorkflow';
    var VARIABLE_REGEX = /<%=(.*?)%>/gi;

    var variablesDependency = {
        crmRecordId: createTask
    };

    $scope.hasCustomWorkflowEnabled = false;

    $scope.openModuleWorkflow = function () {
        var fallbackModule = _.get($scope.feature, 'preferences.fallbackModule');
        var alwaysUseModule = _.get($scope.feature, 'preferences.alwaysUseModule');
        var callModule = alwaysUseModule || _.get($scope.activeCall, 'matchedCrmRecords.0.bean_module', fallbackModule);

        var workflows = _.get($scope.feature, 'preferences.options', []);
        var workflow = _.find(workflows, {module: callModule});

        if (workflow && workflow.redirectUri) {
            var redirectUri = workflow.redirectUri;
            checkForVariablesDependency(redirectUri)
                .then(_.assign)
                .then(redirectToWorkflow.bind(null, redirectUri))
                .catch(function (error) {
                    DesktopNotificationService.notify('An error has occurred while opening a workflow', getErrorMessage(error));
                    console.error(error);
                });
        } else {
            DesktopNotificationService.notify("Workflow not found!", "There're no workflow configured for the module " + callModule);
        }
    };

    function checkForVariablesDependency(redirectUri) {
        var variables = redirectUri.match(VARIABLE_REGEX);

        var promise = $q.when();

        _.forEach(variables, function (variable) {
            variable = variable.replace('<%=', '').replace('%>', '').trim();

            if (variablesDependency[variable]) {
                promise = promise.then(variablesDependency[variable].bind(null, variable));
            } else if (_.has($scope.activeCall, variable)) {
                var response = {};
                response[variable] = _.get($scope.activeCall, variable);
                promise = promise.then(_.wrap(response));
            }
        });

        return promise;
    }

    var lastSaveNotesUnwatch;
    function createTask() {
        return $q(function (resolve) {
            var crmRecordId = _.get($scope.activeCall, 'crmRecordId');

            if (crmRecordId) {
                resolve({crmRecordId: crmRecordId});
            } else {
                var callId = _.get($scope.activeCall, 'id');

                unwatchSaveNotes();
                lastSaveNotesUnwatch = $scope.$watch('activeCall.crmRecordId', function (crmRecordId) {
                    if (crmRecordId && crmRecordId !== 'CREATION_IN_PROCESS' && callId === _.get($scope.activeCall, 'id')) {
                        unwatchSaveNotes();
                        window.spinner.hide();
                        resolve({crmRecordId: crmRecordId});
                    }
                });

                var method = $scope.saveNotes || createTaskForNotSingleMatch;
                method(true).then(function () {
                    $timeout(window.spinner.show.bind(window.spinner, 'Saving task...'), 550);
                    $timeout(window.spinner.hide.bind(window.spinner), 5000);
                });
            }
        });
    }
    
    function createTaskForNotSingleMatch(forceCreateCallOrTask) {
        window.spinner.show('Saving task...');
        var callId = _.get($scope.activeCall, 'id');

        return NoteService.save("", "", [], null, callId, forceCreateCallOrTask)
            .then(function () {
                DesktopNotificationService.notify('Tasks Saved', 'Tasks have been saved');
            })
            .catch(function (error) {
                DesktopNotificationService.notify('An error has occurred while saving tasks', getErrorMessage(error));
                return $q.reject(error);
            })
            .finally(function() {
                window.spinner.hide();
            });
    }

    function unwatchSaveNotes() {
        if (lastSaveNotesUnwatch) {
            lastSaveNotesUnwatch();
            lastSaveNotesUnwatch = null;
        }
    }

    function createCustomRecord(variable) {
        return $q(function (resolve, reject) {
            var result = {};
            result[variable] = 'TEMP_ID';

            var customVariables = _.get($scope.feature, 'preferences.customVariables', []);
            var customVariable = _.find(customVariables, {variable: variable});
            var callId = _.get($scope.activeCall, 'id');

            CustomWorkflowService
                .createRecord(callId, customVariable.module, customVariable.fields, customVariable.variable)
                .then(function (response) {
                    result[variable] = response.id;
                    resolve(result);
                })
                .catch(reject);
        });
    }

    function redirectToWorkflow(redirectUri, variables) {
        var compiled = _.template(redirectUri);
        var name = _.get($scope.feature, 'preferences.openInCurrentTab') ? '_parent' : '_blank';
        OpenURLService.openLinkInRegularView(compiled(variables), name);
    }

    function getErrorMessage(error) {
        error = error && error.data || error;
        if(error && error.message)
            return error.message;
        else if(error.status === -1)
            return "Verify your connection and try again later";
        return error && error.error || "Failed to open the workflow";
    }

    function loadCustomVariables() {
        _.forEach(_.get($scope.feature, 'preferences.customVariables', []), function (customVariable) {
            variablesDependency[customVariable.variable] = createCustomRecord;
        });
    }

    FeatureService.on(FEATURE_NAME, function (snap) {
        $scope.feature = snap.val();
        if ($scope.feature) {
            $scope.hasCustomWorkflowEnabled = $scope.feature.status === 'active' && _.size(_.get($scope.feature, 'preferences.options'));
            loadCustomVariables();
        }
    });

}

angular.module('callinize').controller('CustomWorkflowController', CustomWorkflowController);;


function DialerController($scope, $timeout) {
    $scope.number = '';
    $scope.buttonStatus = 'ready';
    $scope.buttonStates = {
        ready: {text: 'Dial'},
        dialling: {text: 'Dialling...'},
        onCall: {text: 'Hangup'}
    };

    $scope.onDialButtonPressed = function(number) {
        switch($scope.buttonStatus) {
            case 'ready':
                return createCall(number);
            case 'onCall':
                return hangupCall();
            default:
                break;
        }
    };

    function createCall(number) {
        $scope.buttonStatus = 'dialling';
        $scope.originateCall(number, {}, function(result) {
            $scope.buttonStatus = 'onCall';
            $timeout(function() {});
        });
    }

    function hangupCall() {
        $timeout(function() {
            $scope.buttonStatus = 'ready';
        }, 1000);
    }
}

angular.module('callinize')
    .controller('DialerController', DialerController);
;


angular.module('callinize').controller('DispositionsController', function($scope, $q, $rootScope,
    DispositionsService, FeatureService) {

    var self = this;
    $scope.dispositionsEnabled = false;

    var copyDispositions = [];
    var sourceDispositions = [];

    $scope.dispositionsError = "Call dispositions are not enabled for your organization";

    this.getDispositions = function(opts) {
        return DispositionsService.getDispositions(opts);
    };

    this.updateDispositions = function(opts) {
        $scope.dispositions = [];
        $scope.dispositionsGrouped = [];
        return this.getDispositions(opts).then(function(dispositions) {
            dispositions = dispositions.filter(_.identity);
            $scope.dispositions = _.sortBy(flatDispositions(dispositions), 'index') || [];
            $scope.dispositionsGrouped = _.groupBy($scope.dispositions, 'module');
            sourceDispositions = dispositions;
            copyDispositions = JSON.parse(JSON.stringify(dispositions));
            self.checkDependentDispositions();
            $scope.dispositionsError = getDispositionsErrorMessage(dispositions);
        }).catch(function(error) {
            $scope.dispositionsError = _.get(error, 'message', error);
        });
    };

    $scope.select = function (value, field) {
        if (field.multi) {
            field.value = !field.value ? [] : (Array.isArray(field.value) ? field.value : [field.value]);
            if (_.includes(field.value, value))
                field.value = _.without(field.value, value);
            else
                field.value.push(value);
        } else {
            field.value = field.value === value ? field.defaultValue : value;
        }

        self.checkDependentDispositions();
        clearDependentDispositions(field);
    };

    function clearDependentDispositions(field) {
        var dependentField = _.find($scope.dispositions, function (dependentField) {
            return _.get(dependentField, 'dependsOn.name') === field.name;
        });

        if (dependentField) {
            dependentField.selected = dependentField.value = undefined;
            clearDependentDispositions(dependentField);
        }
    }

    $scope.isSelected = function (field, value) {
        return field.multi ? _.includes(field.value, value) : field.value === value;
    };

    this.saveDispositions = function() {
        var changed = diff(copyDispositions, sourceDispositions);
        return changed
            && changed.length
            && FeatureService.isEnabled('callDispositions')
            && DispositionsService.setDispositions(changed) || $q.when();
    };

    this.getSelectedDispositions = function() {
        var enabled = FeatureService.isEnabled('callDispositions');
        return enabled ? diff(copyDispositions, sourceDispositions) : [];
    };

    this.checkRequiredDispositions = function() {
        var errorFields = [];
        $scope.dispositions && $scope.dispositions.forEach(function(field) {
            if(!field.required) return;
            var isArray = _.isArray(field.value) && !_.size(field.value);
            if(!field.value || isArray) errorFields.push(field);
        });
        if(errorFields.length)
            return getRequiredDispositionsErrorMessage(errorFields);
        return false;
    };

    function getRequiredDispositionsErrorMessage(fields) {
        var msg = 'Select at least one value for each of the following fields and save again: ';
        msg += fields.map(function(field) {
            return field.label;
        }).join(", ");
        return msg;
    }

    this.checkDependentDispositions = function() {
        $scope.dispositions && $scope.dispositions.forEach(function(field) {
            var values = field.values;
            _.forEach(values, function(value) {
                if (!value.dependsOn) return;
                if (!_.isArray(value.dependsOn)) value.dependsOn = [value.dependsOn];

                var parentField = _.find($scope.dispositions, {name: _.get(value.dependsOn, '0.name')});

                value.hide = parentField && _.every(value.dependsOn, function(dependency){
                    return !$scope.isSelected(parentField, dependency.value);
                });
            });
        });
    };

    this.dependentFieldIsSelected = function(field) {
        var parentField = _.find($scope.dispositions, function (parent) {
            return parent.name === (field.dependsOn && field.dependsOn.name);
        });
        return this.noDependencies(field) || !parentField || !!parentField.value;
    };

    this.noDependencies = function(field) {
        return !field.dependsOn;
    };

    this.allValuesHidden = function(field) {
        return !_.some(field.values, function(value) {
            return !value.hide;
        });
    };

    this.reset = function(selectedDispositions) {
        copyDispositions = mergeDispositions(copyDispositions, selectedDispositions);
    };

    function mergeDispositions(callDispositions, newDispositions) {
        _.each(newDispositions, function (disposition) {
            var callDisposition = _.find(callDispositions, { module : disposition.module });
            if (callDisposition) {
                mergeFields(callDisposition, disposition.fields);
            } else {
                callDispositions.push(disposition);
            }
        });
        return callDispositions;
    }

    function mergeFields(callDisposition, newFields) {
        var callFields = callDisposition.fields;
        _.each(newFields, function (field) {
            var callField = _.find(callFields, { name : field.name });
            if (callField) {
                callField.value = field.value;
            } else {
                callFields.push(field);
            }
        });
    }

    function flatDispositions(dispositions) {
        var fields = [];
        dispositions.forEach(function (disposition) {
            fields.push.apply(fields, disposition.fields);
            disposition.fields.forEach(function (field) {
                // field.multi = true; Use to test it without backend changes
                field.module = disposition.module;
                field.selected = getSelectedValue(field) || field.selected;
                field.defaultValue = field.defaultValue === void(0) ? null : (field.defaultValue && field.defaultValue.value || field.defaultValue);
                field.value = field.selected === void(0) ? field.defaultValue : field.selected;
            });
        });
        return fields;
    }

    function getSelectedValue(localField) {
        var cachedDispos = $scope.dispositions || [];
        var item = cachedDispos.filter(function (field) {
            return field.name === localField.name && field.module === localField.module;
        });

        return item[0] && item[0].value;
    }

    function getDispositionsErrorMessage(disposition) {
        $scope.dispositionsError = null;
        if(!$scope.dispositions.length) {
            $scope.dispositionsError = "No disposition selected by this organization";
        }
    }

    function diff(source, changed) {
        var hasDispositions = source && source.length && changed && changed.length;
        changed = JSON.parse(JSON.stringify(changed || []));

        function findDifference() {
            return changed.filter(function (changed) {
                var sourceDisposition = _.first(_.where(source, {
                    module : changed.module
                }));
                changed = changed || {};
                changed.fields = changed.fields || [];
                changed.fields = changed.fields.filter(function (field) {
                    var sourceField = _.first(_.where(sourceDisposition.fields, {
                        name : field.name
                    }));
                    return field.value !== sourceField.value;
                });
                return changed.fields.length;
            });
        }
        return hasDispositions ? findDifference() : [];
    }

    FeatureService.on('callDispositions', function(feature) {
        feature = feature.val();
        $scope.dispositionsEnabled = feature.status !== "inactive";
        if($scope.dispositionsEnabled)
            $scope.$watch("activeCall.matchedCrmRecords.length", this.updateDispositions.bind(this, null));
    }.bind(this));

    var relateResource = $rootScope.$on("updateDispositions", function (evt, params) {
        self.updateDispositions(params);
    }.bind(this));

    $scope.$on("$destroy", function () {
        relateResource();
    });
});
;


angular.module('callinize').controller('HistoryController', function($scope, $timeout, FirebaseModel, CallService, HistoryService) {

    var MAX_TRIES = 5;
    var active = FirebaseModel.fromUser('calls/active');
    var tries = 0;
    var sourceLookup = {
        Hangup : 'user-red',
        Ringing : 'user-orange',
        Connected : 'user-green'
    };

    HistoryService.onValue(handler);
    HistoryService.onChild(childHandler);

    $scope.$on('$destroy', function(){
        HistoryService.off('value', handler);
        HistoryService.off('child', childHandler);
    });

    $scope.selectCall = function(call) {
        call.id === $scope.currentCall ? openCurrent(call) : active.set(call.id);
        $scope.setView('active');
    };

    $scope.getSource = function(call) {
        return sourceLookup[call.status];
    };

    $scope.getTitle = function(call) {
        var matchedCrmRecords = _.get(call, 'matchedCrmRecords') || [];
        var text;
        if(matchedCrmRecords.length === 0)
            text = 'No match found';
        else if(matchedCrmRecords.length === 1)
            text = matchedCrmRecords[0].bean_name;
        else
            text = '{0} matches found'.replace('{0}', matchedCrmRecords.length);
        return text;
    };

    $scope.getDirection = function(call) {
        return call.direction === "Outbound" ? "dialed" : "received";
    };

    $scope.getCallPicture = function(call) {
        return _.get(call, "matchedCrmRecords[0].bean_image", 'img/main_icon.png')
    };

    $scope.getRecordColor = function (color) {
        if (!color)
            return {};
        return {'background-color': color};
    };

    function openCurrent(call) {
        active.set(false, function () {
            active.set(call.id);
        });
    }

    function handler(history) {
        $scope.history = _.values(history).filter(function (item) {
            return !item.deleted && item.id;
        });
        if(!$scope.history.length && tries < MAX_TRIES) {
            tries++;
            return $timeout(function() {
                HistoryService.getHistory(handler)
            }, 100);
        } else if(!$scope.history.length)
            return;

        var call = CallService.getCurrentCall() || {};
        $scope.currentCall = call.id;
        $scope.history.filter(function (item) {
            return !item._read;
        }).forEach(setAsRead);
        HistoryService.triggerOnNewCount(0);
    }

    function childHandler(item) {
        HistoryService.getHistory(handler);
    }

    function setAsRead(item) {
        FirebaseModel.fromUser('calls/history/' + item.id + '/_read').set(true);
    }

    HistoryService.getHistory(handler);
});
;


angular.module('callinize').controller('LoginController', function($scope, $http,
    LoginService, UserService, DesktopNotificationService) {

    $scope.loginForm = {};

    $scope.performLogin = function() {
        window.spinner.show('Signing in...');
        LoginService.login($scope.loginForm.username, $scope.loginForm.password).then(function(data) {
            var user = _.get(data, "user");
            if(!user) throw new Error('User not logged in');
            return onLoginPerformed(user)
        }).catch($scope.onLoginError);
    }

    function onLoginPerformed(user) {
        UserService.getCallinizeObjectFromLogin(user).then($scope.onUserRetrived);
    }
});
;


angular.module('callinize').controller('MultipleMatchesController', function($scope, CallService, DesktopNotificationService) {

    var callRef = null;

    $scope.filter = "";
    $scope.records = [];

    $scope.$watch('activeCall', function(activeCall) {
        $scope.records = activeCall.matchedCrmRecords;
    });

    CallService.onActiveCallRef(function(_callRef) {
        callRef = _callRef;
    });

    $scope.selectRecord = function(record) {
        var matchedCrmRecords = _.map($scope.$parent.activeCall.matchedCrmRecords, function (record) {
            return _.omit(record, '$$hashKey');
        });
        callRef.child('_matchedCrmRecords').set(matchedCrmRecords);
        callRef.child('matchedCrmRecords').set([_.omit(record, '$$hashKey')]);

        window.spinner.show('Setting matching record...');
        CallService.setBeanID(record).then(function (message) {
            var record = _.get(message, '[0].matchedCrmRecords[0]');
            if (!record) {
                console.error('Unable to select a match');
                recordError();
                return;
            } else {
                window.spinner.hide();
            }
        });
    }

    $scope.goToNoMatchView = function () {
        callRef.child('_matchedCrmRecords').set($scope.activeCall.matchedCrmRecords);
        callRef.child('matchedCrmRecords').set([]);
        changeView("noMatches");
    }

    function recordError(config) {
        window.spinner.hide();
        var error = _.get(config, 'data.error', 'Unable to select a match')
        DesktopNotificationService.notify('Selecting matching record failed', error);
    }
});
;


angular.module('callinize').controller('NextController', function($scope, $http,
    FeatureService, LoginService, DesktopNotificationService, UrlService) {

    var LOCAL_FORAGE_KEY = "tf_next_record";

    $scope.nextBurnMode = false;
    $scope.nextRecord = null;

    $scope.showNextRecord = function() {
        window.spinner.show("Fetching next record...");
        getNextRecord().then(function(record) {
            if(record) {
                localforage.setItem(LOCAL_FORAGE_KEY, record);
                $scope.setView('next');
                $scope.nextRecord = record;
            } else
                DesktopNotificationService.notify('Next record', 'No records found');
            window.spinner.hide();
        }).catch(function(error) {
            console.log("Error triggering next record: ");
            console.log(JSON.stringify(error, null, 4));
            DesktopNotificationService.notify('Error triggering next record');
            window.spinner.hide();
        });
    }

    $scope.triggerNextCall = function() {
        window.spinner.show("Triggering next record...");
        callNext();
    }

    function getNextRecord() {
        if($scope.view == 'next')
            return getNextRecordFromRemote();
        return getFromScope().then(function(record) {
            if(record) return record;
            return getNextRecordFromLocalForage();
        }).then(function(record) {
            if(record) return record;
            return getNextRecordFromRemote();
        }).then(function(record) {
            return record;
        });
    }

    function getFromScope() {
        return new Promise(function(resolve, reject) {
            resolve($scope.nextRecord);
        });
    }

    function getNextRecordFromLocalForage() {
        return localforage.getItem(LOCAL_FORAGE_KEY);
    }

    function getNextRecordFromRemote() {
        var url = buildUrl();
        return $http.get(url).then(function (response) {
            return _.get(response, 'data');
        });
    }

    function callNext() {
        var CALL_NEXT = 'campaigns/SEGMENT_ID/records/RECORD_ID/call';
        var record = $scope.nextRecord;
        var recordId = record._id;
        var segmentId = _.get(record, '_segments.0.segment');
        var url = CALL_NEXT.replace('SEGMENT_ID', segmentId).replace('RECORD_ID', recordId);
        return $http.post(appendUrl(url)).then(function () {
            window.spinner.hide();
            record.id = record.crmRecordId;
            record.bean_id = record.crmRecordId;
            record.bean_module = record.module;
            $scope.originateCall(record.phoneNumber, record, function() {
                localforage.removeItem(LOCAL_FORAGE_KEY);
            });
        });
    };

    function appendUrl (url) {
        var apiUrl = UrlService.getApiBaseUrlV1();
        return [apiUrl, 'organizations', LoginService.getUser().organizationId, url].join('/');
    };

    function buildUrl() {
        return UrlService.getApiBaseUrlV1()
            + '/organizations/' + LoginService.getUser().organizationId
            + '/users/' + LoginService.getUserId()
            + '/nextToCall';
    }

    FeatureService.on("burnMode", function (burnMode) {
        var feature = burnMode.val();
        var featureEnabled = feature && feature.status === 'active' && _.get(feature, 'preferences.next');
        if (featureEnabled && _.get(feature, 'preferences.checkUser')) {
            var user = LoginService.isLogged() ? LoginService.getUser() : {};
            featureEnabled = _.get(user, 'features.next.status') === 'active';
        }
        $scope.nextBurnMode = featureEnabled;
    });
});
;


angular.module('callinize').controller('NotesController',
    function($scope, LoginService, NoteService, DispositionsService, CallService, FeatureService, DesktopNotificationService, $q) {

    var autoSaveInterval;
    var notesFeature = FeatureService.getFeature("notes") || {};
    $scope.notes = "";
    $scope.callSubject = "";
    $scope.ui = {_hadTaskDate: false};
    $scope.lastCallId = null;
    $scope.notesDisabled = notesFeature.status === 'inactive';
    $scope.notesPlaceholder = $scope.notesDisabled ? "Notes disabled" : "Add notes";
    $scope.subjectEnabled = !$scope.notesDisabled && !!_.get(notesFeature, 'preferences.callSubject', false);

    if ($scope.subjectEnabled) {
        var ref;
        CallService.onActiveCallRef(function (newRef) {
            if (ref) ref.off('value', handleSubjectChangesOnFirebase);
            ref = newRef.child('subject');
            ref.on('value', handleSubjectChangesOnFirebase);
        });
    }

    function handleSubjectChangesOnFirebase(snap) {
        $scope.callSubject = snap.val() || '';
    }

    $scope.$watch('activeCall.id', function(callId) {
        var newDate = $scope.activeCall && $scope.activeCall.followUpDate;
        $scope.followUpDate = newDate ? moment(newDate) : null;

        if(callId && $scope.lastCallId !== callId){
            $scope.notes = "";
            $scope.callSubject = "";
            $scope.lastCallId = callId;
            CallService.fetchCall($scope.lastCallId)
            .then(function(call) {
                $scope.notes = call && call.description || "";
                $scope.callSubject = call && call.subject || "";
                setupAutoSave($scope.notes, $scope.callSubject);
            }, function(error) {
                DesktopNotificationService.notify('Error retrieving call notes', error);
            });
        }
    });

    $scope.$watch('notes', function(notes) {
        NoteService.parse(notes).then(function (results) {
            $scope.ui.users = results.users;
            $scope.ui.taskDate = results.taskDate;
            var hasTaskDate = !!results.taskDate;

            var updateDispositions = hasTaskDate !== $scope.ui._hadTaskDate;
            if (updateDispositions) {
                $scope.$emit("updateDispositions", {followUp: hasTaskDate});
            }

            $scope.ui._hadTaskDate = hasTaskDate;
        });
    });

    $scope.handleKeyEvent = function($event) {
        var tabPressed = event.keyCode === 9;
        if (tabPressed) {
            event.preventDefault();
            return false;
        }
    };

    $scope.saveNotes = function(forceCreateCallOrTask) {
        return isZendesk() ? saveNotesForZendesk(forceCreateCallOrTask) : execSave(forceCreateCallOrTask);
    };

    function saveNotesForZendesk(forceCreateCallOrTask) {
        return CallService.fetchCall().then(function (call) {
            if(!call.relateResourceCrmRecord) {
                extensionHost.notifications.create('Validation Error', 'You need to select a case before saving this call (suitcase icon)');
                return $q.reject();
            } else {
                return execSave(forceCreateCallOrTask)
            }
        });
    }

    $scope.getUsers = function (users) {
        return users && users.map(function (user) {
            return user.name + ' <' + user.username + '>';
        })
        .join(', ');
    };

    function getCallSubject() {
        if ($scope.subjectEnabled) {
            return $scope.callSubject;
        }
    }

    function execSave(forceCreateCallOrTask) {
        var error = $scope.checkRequiredDispositions();
        if (error) {
            DesktopNotificationService.notify('ERROR: Required dispositions', error);
            return $q.reject(error);
        }

        window.spinner.show('Saving notes...');
        return NoteService.save($scope.notes, getCallSubject(), $scope.getSelectedDispositions(), $scope.followUpDate, $scope.lastCallId, forceCreateCallOrTask)
            .then(function () {
                DesktopNotificationService.notify('Notes Saved', 'Notes have been saved');
                $scope.reset();
            })
            .catch(function (error) {
                DesktopNotificationService.notify('An error has occurred while saving notes', getErrorMessage(error));
                return $q.reject(error);
            })
            .finally(function() {
                window.spinner.hide();
            });
    }

    function setupAutoSave(notes, subject) {
        autoSaveInterval && clearInterval(autoSaveInterval);

        var errorSaving,
            saving = false,
            dispositions = $scope.getSelectedDispositions() || {};

        autoSaveInterval = setInterval(function () {
            var error = $scope.checkRequiredDispositions();
            var selectedDispositions = !error && $scope.getSelectedDispositions() || {};
            var hasNotes = notes !== $scope.notes && $scope.notes;
            var hasSubject = $scope.subjectEnabled && subject !== $scope.callSubject && $scope.callSubject;
            var hasDispositions = diffDispos(dispositions, selectedDispositions);

            if (((hasNotes || hasSubject || hasDispositions) && !errorSaving) && !saving) {
                saving = true;
                notes = $scope.notes;
                subject = $scope.callSubject;

                CallService.autoSaveNote(notes, selectedDispositions, $scope.followUpDate,  $scope.lastCallId, getCallSubject())
                    .then(function () {
                        $scope.reset(selectedDispositions);
                        var currentDispos = $scope.getSelectedDispositions();
                        dispositions = currentDispos.length ? selectedDispositions : [];
                        errorSaving = false;
                    })
                    .catch(function () {
                        errorSaving = true;
                    })
                    .finally(function () {
                        saving = false;
                    });
            }
        }, 5000);
    }

    function diffDispos(dispositions, selectedDispositions) {
        var diffSizeDispositions = _.size(dispositions) !== _.size(selectedDispositions);
        var noDispositions = _.size(dispositions) === 0 && !diffSizeDispositions;

        return diffSizeDispositions || !noDispositions && dispositions.some(function (disposition) {
            var selectedDisposition = _.first(_.filter(selectedDispositions, {
                module : disposition.module
            }));
            return !selectedDisposition || _.some(disposition.fields, function (field) {
                var selectedField = _.first(_.filter(selectedDisposition.fields, {
                    name : field.name
                }));
                return field.value !== selectedField.value;
            });
        });
    }

    function getErrorMessage(error) {
        error = error && error.data || error;
        if(error && error.message)
            return error.message;
        else if(error.status === -1)
            return "Verify your connection and try again later";
        return error && error.error || "Failed to save";
    }

    function isZendesk() {
        var user = LoginService.getUser();
        return user && user.crm === "zendesk";
    }
});
;


function PrimaryExtensionController ($scope, $timeout, FeatureService, UserService, FirebaseModel, DesktopNotificationService, utils) {

    $scope.extensions = [];

    function onUserExtensionsChange(snap) {
        var userExtensions = snap.val();
        var loadedExtensions = _.map($scope.extensions, 'extension');
        var addedExtensions = _.difference(userExtensions, loadedExtensions);

        if (_.size(addedExtensions)) {
            loadUserExtensions();
        } else {
            var removedExensions = _.difference(loadedExtensions, userExtensions);
            $scope.extensions = _.reject($scope.extensions, function (extension) {
                return _.includes(removedExensions, extension.extension);
            });
        }
    }

    function onPrimaryExtensionChange(snap) {
        var primaryExtension = snap.val();
        $scope.primaryExtension = _.find($scope.extensions, {_id: primaryExtension});
        _.set($scope, 'callinize.user.softphone', utils.isSoftphoneExtension($scope.primaryExtension));
    }

    function listenForExtensionChanges() {
        var extensionsRef = FirebaseModel.fromUser('extensions');
        extensionsRef.on('value', onUserExtensionsChange);

        var primaryExtensionRef = FirebaseModel.fromUser('_ctdextension');
        primaryExtensionRef.on('value', onPrimaryExtensionChange);

        $scope.$on('$destroy', function () {
            extensionsRef.off('value', onUserExtensionsChange);
            primaryExtensionRef.off('value', onPrimaryExtensionChange);
        });
    }

    function loadUserExtensions() {
        return UserService.getUserExtensions().then(function (response) {
            $scope.extensions = response.extensions || [];
            $scope.primaryExtension = _.find($scope.extensions, {_id: _.get(response, 'primaryExtension._id')});
            $timeout(); // Refresh extensions options quickly
        }).catch(function(error) {
            DesktopNotificationService.notify("Something went wrong", "An error has occurred while loading the user's extensions");
            console.error(error);
        });
    }

    $scope.updatePrimaryExtension = function (primaryExtension) {
        window.spinner.show('Updating Primary Extension...');

        UserService.updatePrimaryExtension(primaryExtension._id).then(function () {
            window.spinner.hide();
        }).catch(function (error) {
            window.spinner.hide();
            console.error(error);
            DesktopNotificationService.notify('Something went wrong', 'An error has occurred while changing the primary extension. Please, try again.');
        });
    };

    if (FeatureService.isEnabled('advancedClickToDial')) {
        loadUserExtensions().then(listenForExtensionChanges);
    }

}

angular.module('callinize').controller('PrimaryExtensionController', PrimaryExtensionController);
;


function RelateResourceController($scope, $timeout, $rootScope, LoginService, ActivityService, RelateResourceService,
    CallService, FeatureService, utils, DesktopNotificationService) {
    var self = this;

    var moduleLookup = {
        tickets:       "Ticket",
        cases:         "Case",
        opportunities: "Opportunity"
    };

    $scope.$watch('activeCall.id', function () {
        $scope.activeCall && ActivityService.getActivities($scope.activeCall).then(updateActivities.bind(self));
    });

    $scope.$watch('activeCall.relateResourceCrmRecord', function () {
        $scope.selectedResource = $scope.activeCall && $scope.activeCall.relateResourceCrmRecord;
    });

    var unregister = FeatureService.on("customResources", function (customResources) {
        var feature = customResources.val();
        var status = _.get(feature, 'status', 'inactive');
        var modules = _.get(feature, 'modules', []);

        customResources = {
            status: status,
            modules: modules
        };

        _.extend($scope, { customResources: customResources });

        _.each(customResources.modules, function(resource) {
            if(!resource.name || !_.isString(resource.name) || !_.isString(resource.label)) return;

            _.extend(resource, { abbr:  resource.label.substring(0,2) });

            var modName = resource.name.toLowerCase();
            moduleLookup[modName] = resource.name;
        });
    });

    $scope.$on('$destroy', function() {
        unregister();
        FeatureService.removeListener('value', checkRelateResourceEnabled);
    });

    this.createResource = function (type, autoCreate) {
        var record = $scope.activeCall.matchedCrmRecords[0];
        window.spinner.show('Creating resource');

        RelateResourceService.create(record, type, autoCreate).then(function (resource) {
                $scope.selectedResource = resource;
                window.spinner.hide();
            })
            .then(null, function (error) {
                error = _.get(error, 'error', error);
                error = _.isString(error) ? error : error && error.message;
                DesktopNotificationService.notify('Failed to relate the ' + utils.ucFirst(type) +
                    ' to this call.', 'Unable to relate ' + type + ' due to error: ' +
                    (error || "API Error"));
	            $scope.$emit("updateDispositions");
                window.spinner.hide();
            });
    };

    this.createResource = _.throttle(this.createResource, 5000, { 'leading': true, 'trailing': false });

    this.relate = function (resource) {
        if ($scope.selectedResource && resource.id === $scope.selectedResource.id) {
            return;
        }
        var self = this;
        window.spinner.show('Relating resource');
        if(_.isArray(resource) && resource.length === 1) resource = resource[0];
        $scope.selectedResource = resource;
        CallService.relateResource({
                id:     resource.id,
                module: moduleLookup[resource.activity]
            })
            .then(function () {
                $scope.selectedResource = resource;
                DesktopNotificationService.notify(utils.ucFirst(resource.activity) +
                    ' related', 'The ' + resource.activity + ' was related to this call.');
                $scope.$emit("updateDispositions");
                window.spinner.hide();
            })
            .then(null, function (error) {
                delete $scope.selectedResource;
                DesktopNotificationService.notify('Failed to relate the ' + resource.activity +
                    ' to this call.', 'Unable to relate ' + resource.activity + ': ' +
                    (error && error.message || error));
                window.spinner.hide();
            });
    };

    this.relate = _.throttle(this.relate, 5000, { 'leading': true, 'trailing': false });

    this.isCrmSupported = function () {
        return !isZendesk();
    };

    function isZendesk() {
        var user = LoginService.getUser();
        return user && user.crm === "zendesk";
    }

    this.refresh = function () {
        window.spinner.show('Refreshing');
        if($scope.activeCall && _.size($scope.activeCall.matchedCrmRecords) === 1){
            ActivityService.getActivities($scope.activeCall, true).then(updateActivities.bind(this));
            $rootScope.$broadcast('updateActivities');
        }
    };

    function updateActivities(activities) {
        activities = activities || [];

        window.spinner.hide();

        $scope.opportunities = activities.filter(isOpportunity);
        $scope.cases = activities.filter(isCase);

        var customResources = _.get($scope, 'customResources.modules', []);

        _.forOwn(customResources, function(resource, k) {
            if(!resource || !resource.name || !_.isString(resource.name)) return;

            var resourceActivities = _.filter(activities, function (activity) {
                return _.get(activity, 'activity') === resource.name.toLowerCase() ||
                    _.get(activity, 'type') === 'resource';
            });

            _.extend($scope.customResources.modules[k], {
               'activities':  resourceActivities
            });
        });

        var call = CallService.getCurrentCall() || {};
        $scope.selectedResource = call.relateResourceCrmRecord;
        selectFirst.call(self, call);

        $scope.hasSelected = $scope.cases.length || $scope.opportunities.length;
        $scope.count = $scope.cases.length + $scope.opportunities.length;
    }

    function isOpportunity(activity) {
        return activity.activity === 'opportunities';
    }

    function isCase(activity) {
        return (activity.activity === 'cases' || activity.activity === 'tickets')
    }

    function selectFirst(call) {
        if (!$scope.activeCall) $scope.activeCall = activeCall;
        var autoRelateToCase = FeatureService.getFeature('relateResource').autoRelateToCase;
        var autoCreateCase = FeatureService.getFeature('relateResource').autoCreateCase;
        var autoRelateToOpportunity = FeatureService.getFeature('relateResource').autoRelateToOpportunity;

        var hasACase = autoRelateToCase && $scope.cases.length === 1;
        var hasAOpportunity = autoRelateToOpportunity && $scope.opportunities.length === 1;

        var selectCase = hasACase && !hasAOpportunity;
        var selectOppo = hasAOpportunity && !hasACase;

        selectCase && this.relate($scope.cases[0]);
        selectOppo && this.relate($scope.opportunities[0]);
        if (!_.size($scope.cases) && !$scope.selectedResource && autoCreateCase) {
            this.createResource('case', true);
        }
        $scope.autoSelect = selectCase || selectOppo;
    }

    function checkRelateResourceEnabled() {
        $scope.hasRelateResourceEnabled = FeatureService.hasFeatureEnabled('opportunities') ||
            FeatureService.hasFeatureEnabled('cases') ||
            FeatureService.hasFeatureEnabled('customResources');
        $timeout(_.noop);
    }

    checkRelateResourceEnabled();

    FeatureService.addListener('value', checkRelateResourceEnabled);
}

angular.module('callinize').controller("RelateResourceController", RelateResourceController);
;


function SingleMatchController($scope, FeatureService, CallService, DesktopNotificationService) {

    var callRef;
    var unbindListeners = [];

    function addUnbindListener(listener) {
        unbindListeners.push(listener);
    }

    var unregisterAssignRecordParent = FeatureService.on("assignRecordParent", function (snap) {
        var feature = snap.val();

        if (_.get(feature, 'status', 'inactive') === 'active') {
            $scope.assignRecordParentEnabled = true;
        }
    });
    addUnbindListener(unregisterAssignRecordParent);

    CallService.onActiveCallRef(function (call) {
        callRef = call;
    }, addUnbindListener);

    this.isHangup = function (call) {
        return CallService.isHangup(call);
    };

    this.reassignCall = function(){
        if (!$scope.activeCall._matchedCrmRecords || $scope.activeCall._matchedCrmRecords.length < 2) {
            return this.clearRecords();
        }
        if ($scope.activeCall._matchedCrmRecords.length > 1 && !this.isHangup($scope.activeCall)) {
            return this.resetRecords();
        }
    };

    this.unassociateCall = function() {
        window.spinner.show();

        CallService.unassociateCall($scope.activeCall.id, $scope.activeCall.matchedCrmRecords).then(_.noop, function() {
            DesktopNotificationService.notify('Unable to unassociate', 'Unable to unassociate');
        }).finally(function () {
            window.spinner.hide();
        });
    };

    this.clearRecords = function () {
        $scope.innerView = "noMatches";

        callRef && callRef.child('_matchedCrmRecords').set($scope.activeCall.matchedCrmRecords);
        callRef && callRef.child('matchedCrmRecords').set([]);
    };

    this.resetRecords = function () {
        $scope.innerView = "multipleMatches";

        callRef && callRef.child('matchedCrmRecords').set($scope.activeCall._matchedCrmRecords);
    };

    $scope.$on('$destroy', function() {
        _.forEach(unbindListeners, function(unbindListener) {
            unbindListener();
        });
    });

}

angular.module('callinize').controller('SingleMatchController', SingleMatchController);;


function SMSController ($scope, $rootScope, CallService, SMSService, DesktopNotificationService) {

    $scope.newText = null;

    $scope.sendSMSMessage = function (text) {
        if (!text) return;

        var currentCall = CallService.getCurrentCall();
        var toNumber = getNumber(currentCall);
        if (!currentCall || !toNumber || !currentCall.id) {
            return;
        }

        var opts = {
            message: text,
            phoneNumber: toNumber,
            callId: currentCall.id
        };

        window.spinner.show('Sending SMS...');
        SMSService.sendSMS(opts).then(function (success) {
            DesktopNotificationService.notify('SMS Sent', 'Your SMS has been sent');
            $rootScope.$broadcast('modal-close', 'sms-modal');
            $scope.newText = null;
        }).catch(function (err) {
            DesktopNotificationService.notify('Error while sending SMS', 'Your SMS hasn\'t been sent');
        }).finally(function () {
            window.spinner.hide();
        });

        function getNumber (call) {
            if (!call) return;
            var mobileNumber = _.get(call, 'matchedCrmRecords.0.mobilephone');
            return mobileNumber || call.phoneNumber;
        }
    };
}

angular.module('callinize').controller('SMSController', SMSController);
;


function SocialProfileController ($scope, CallService, FeatureService, FirebaseModel) {

    var defaultProfiles = ["facebook", "google", "linkedin", "twitter"];
    var socialProfileEnabled = false;
    var retry = true;

    $scope.getTitle = function (profile) {
        var givenName = _.get($scope.profile, 'contactInfo.givenName', $scope.record.bean_module);
        return givenName + "'s " + profile.typeName;
    };

    function activeCallHandler(call) {
        var isQueue = call.queue;
        var limit = isQueue ? 3 : 7;
        var record = _.get(call, "matchedCrmRecords[0]", {});
        var profile = _.get(record, "profile", {});
		var profiles = _.get(profile, "socialProfiles", []);

        if(!isValidProfile(profile) && retry)
            return updateProfile(call);

        $scope.profiles = profiles.sort(function(profile){
            return defaultProfiles.indexOf(profile.typeId) !== -1 ? 0 : 1;
        }).splice(0, limit);
        $scope.profile = profile;
        $scope.record = record;
    };

    function updateProfile(call) {
        var ref = FirebaseModel.fromUser('calls/history/' + call.id);
        var handlerBinded = handler.bind(this);
        ref.on('value', handlerBinded);

        function handler(snap) {
            retry = false;
            ref.off('value', handlerBinded);
            activeCallHandler(snap.val());
        }

        CallService.getPhoto();
    }

    function isValidProfile(socialProfile) {
        return socialProfile
            && _.isString(socialProfile.email)
            && hasProfile(socialProfile.profile)
            || (socialProfile && socialProfile.notFound);
    }

    function hasProfile(profile) {
        return profile
            && (_.size(profile.photos)
            || _.size(profile.organizations)
            || _.size(profile.socialProfiles)
            || _.size(profile.demographics)
            || _.size(profile.digitalFootprint)
            || _.size(profile.contactInfo));
    }

    FeatureService.on('socialProfile', function(feature) {
        feature = feature.val();
        socialProfileEnabled = feature.status !== "inactive";
        if(socialProfileEnabled)
            CallService.onActiveCall(activeCallHandler, $scope.$on.bind($scope, '$destroy'));
    }.bind(this));
}

angular.module('callinize').controller('SocialProfileController', SocialProfileController);
;


angular.module('callinize').controller('SoftphoneController', function($scope, $http, $timeout,
    UserService, CreateCallService, DesktopNotificationService, OpenURLService,
    OpenCTIService, FirebaseRef) {

    OpenCTIService.disableClickToDial();

    $scope.outterView = "notLoggedIn";
    $scope.view = "active";
    $scope.ctdNumber = null;

    $scope.setView = function(viewName) {
        if($scope.view === viewName) return;
        $scope.$evalAsync(function() {
            $scope.previousView = $scope.view;
            $scope.view = viewName;
        });
    };

    $scope.backToPreviousView = function() {
        $scope.setView($scope.previousView);
    };

    $scope.setOutterView = function(viewName) {
        $scope.$evalAsync(function() {
            $scope.outterView = viewName;
        });
    };

    $scope.originateCall = function(number, record, callback) {
        if(!$scope.callinize || !$scope.callinize.user)
            throw new Error('User must be set prior making calls');
        if(!callback)
            callback = onCallCreated;
        CreateCallService.dial(number, record, $scope.callinize.user, callback);
    };

    $scope.openRecordLink = function(url, recordId, recordName) {
        OpenURLService.openRecord(url, recordId, recordName, false);
    };

    $scope.openRecordEditLink = function(url, recordId, recordName) {
        OpenURLService.openRecord(url, recordId, recordName, true);
    };

    $scope.onUserRetrived = function(callinize) {
        $scope.callinize = callinize;
        $scope.setOutterView("default");
        authenticateWithFirebase(callinize.user.firebaseAuthToken);
        OpenCTIService.enableClickToDial();
        window.spinner.hide();
    };

    $scope.onLoginError = function(err) {
        console.log(err);
        $scope.setOutterView('notLoggedIn');
        window.spinner.hide();
    };

    function getTenfoldDashboardUser() {
        window.spinner.show();
        UserService.getCallinizeObject()
            .then($scope.onUserRetrived)
            .catch($scope.onLoginError);
    }

    function authenticateWithFirebase(firebaseAuthToken) {
        FirebaseRef.authWithCustomToken(firebaseAuthToken, function (error, authData) {
            if (error)
                console.log("Authentication with Firebase failed.", error);
            else
                console.log("Authenticated successfully with payload:", authData);
        });
    }

    function onClickToDial(number, recordId, module) {
        var record = {
            'id': recordId,
            'module': module
        };
        $scope.setOutterView('dialling');
        $scope.ctdNumber = number;
        $scope.originateCall(number, record);
        OpenCTIService.checkConsolePhoneVisibility();
    }

    function onCallCreated(error, data) {
        if(error) {
            console.log('Originate call error: ' + error);
        }
        $scope.setOutterView('default');
        $scope.ctdNumber = null;
    }

    function showMainContent() {
        $('#main-content').show();
    }

    OpenCTIService.setupCTI({
        onClickToDial: onClickToDial
    });
    getTenfoldDashboardUser($scope.onUserRetrived, $scope.onLoginError);
    showMainContent();
});;


angular.module('callinize').controller('SwitchCallController', function($scope,
    $rootScope, CallService, OpenCTIService, HistoryService, FeatureService, FirebaseModel) {

    var historyRef = FirebaseModel.fromUser('calls/history');
    var callRef;
    var isEnabled;
    var lastCall;

    $scope.call = null;

    FeatureService.on("switchAndSave", function (switchAndSave) {
        var feature = switchAndSave.val();
        isEnabled = !feature || !feature.status === 'disabled';
    });

    HistoryService.onChildAdded(childAdded);

    CallService.onActiveCall(closeIfActive.bind(this));

    this.getName = function getMessage(call) {
        if(!call) return;
        call.matchedCrmRecords = call.matchedCrmRecords || [];
        var text;
        if(call.pass !== 'finished') {
            text = "Searching phone number matches";
        }
        else if(call.matchedCrmRecords.length === 0) {
            text = "No match found for this number";
        }
        else if(call.matchedCrmRecords.length === 1) {
            text = call.matchedCrmRecords[0].bean_name;
        }
        else {
            text = _.unique(_.pluck(call.matchedCrmRecords, "bean_name")).filter(_.identity).join(", ");
        }
        return text;
    };

    this.switch = function (call) {
        if(call && call.id){
            var note = getDescription();
            note && NoteService.save(note);
            CallService.setActive(call.id);
            this.close();
        }
    };

    this.close = function () {
        $rootScope.$broadcast('modal-close', 'switch-call-modal');
    };

    function getDescription() {
        return $("#callinize_save_memo").val();
    }

    function setOpen(template) {
        setTimeout(function () {
            $rootScope.$broadcast("NotificationHtml", template(scope));

            callRef && callRef.off(updateTemplate);
            callRef = historyRef.child(scope.call.id);
            callRef.on('value', updateTemplate);
        }, 100);
    }

    function childAdded(call) {
        if(shouldDisplaySwitchCallModal(call)) {
            if(isEnabled)  {
                $scope.call = call;
                $rootScope.$broadcast('modal-open', 'switch-call-modal');
            }
            lastCall = call;
        } else if(shouldSetAsActiveCall(call)){
            CallService.setActive(call.id, _.noop);
            lastCall = call;
        }
        checkConsolePhoneVisibility(call);
    }

    function checkConsolePhoneVisibility(call) {
        var currentCall = CallService.getCurrentCall();
        if (!currentCall) return;
        var isSameCall = call.id && call.id === currentCall.id;
        if (isSameCall)
            return;
        OpenCTIService.checkConsolePhoneVisibility();
    }

    function closeIfActive(call) {
        var callId = call && call.id;
        var lastCallId = lastCall && lastCall.id;
        if(callId && callId === lastCallId) {
            this.close();
        }
    }

    function shouldDisplaySwitchCallModal(_call) {
        var currentCall         = CallService.getCurrentCall() || {};
        var call                = _call || {};
        var isSameCall          = call.id && call.id === currentCall.id;
        var callDuration        = moment.duration(moment().diff(call.startTime)).asMinutes();
        var isOldCall           = callDuration > 15 && call.status !== 'Hangup';
        var isOutbound          = call.direction === 'Outbound';
        var descriptionSaved    = (typeof currentCall.description !== "undefined");

        return !isSameCall && !isOldCall && !isOutbound && !descriptionSaved;
    }

    function shouldSetAsActiveCall(_call) {
        var currentCall         = CallService.getCurrentCall() || {};
        var call                = _call || {};
        var isSameCall          = call.id && call.id === currentCall.id;
        var callDuration        = moment.duration(moment().diff(call.startTime)).asMinutes();
        var isOldCall           = callDuration > 15 && call.status !== 'Hangup';
        var isInbound           = call.direction === 'Inbound';
        var descriptionSaved    = (typeof currentCall.description !== "undefined");

        return !isSameCall && !isOldCall && isInbound && descriptionSaved;
    }

    $scope.$on('$destroy', function(){
        HistoryService.off('added', childAdded);
    });
});
;


angular.module('callinize')
    .controller('TimerController', function ($scope, $interval, $q, $timeout, logger, utils, FirebaseModel) {

	    var log = logger('TimerCtrl');
	    var intervalId = null;
	    var defer = null;
	    /**
	     * requires startTime - eg "2014-01-04T21:47:14.501Z" -
	     * this should always be passed from call
	     *  Timer function - takes the startTime of the call and also
	     *  an offset parameter that is created between
	     *  the time difference of this computer and the server.
	     *
	     * @param callId
	     * @param startTime
	     * @param endTime
	     * @param offset
	     * @param initialize
	     */
	    this.update = function (callId, startTime, endTime, offset, initialize) {
		    //no start time then do nothing
		    if(defer){
			    defer.resolve();
		    }
		    if (startTime) {
			    defer = $q.defer();
			    if (initialize) {
				    startTimer(callId, startTime, offset);
				    defer.notify(0);
			    } else {
				    stopTimer(callId, startTime, endTime, offset);
			    }
			    return defer.promise;
		    }

	    };

	    function stopTimer(callId, startTime, endTime, offset) {
		    destroy();
		    $timeout(function() {
			    calculateTime(callId, startTime, endTime, offset);
		    })
	    }

	    function startTimer(callId, startTime, endTime, offset) {
		    if (!intervalId) {
			    intervalId = $interval(function () {
				    calculateTime(callId, startTime, endTime, offset);
			    }, 1000);
		    }
	    }

	    function calculateTime(callId, startTime, endTime, offset) {

		    if (!offset) {
			    offset = 0;
		    }

		    var callTime = 0;

		    if (!endTime) {
			    callTime =
				    Math.floor((new Date().getTime() / 1000) - (new Date(startTime).getTime() / 1000));
			    callTime = Math.floor(callTime - offset);
		    } else {
			    callTime =
				    Math.floor((new Date(endTime).getTime() / 1000) - (new Date(startTime).getTime() / 1000));
		    }

		    //hard stop on 2 hours in case timer is running - close the box as well to reset state
		    // if (callTime > 7200) {
		    //   log.info('Timeout popup called', {
		    //     callTime: callTime
		    //   });
		    //   $interval.cancel(intervalId);
		    //   if (defer) {
		    //     defer.notify(0);
		    //     defer.reject(false);
		    //   }
		    //   return;
		    // }
		    if (defer)
			    defer.notify(callTime);

	    }

	    function destroy() {

		    if (intervalId !== null) {
			    log.debug("clean()");
			    if (defer)
				    defer.resolve(true);
			    $interval.cancel(intervalId);
			    intervalId = null;
		    }

	    }

	    this.$destroy = destroy;
});
;


angular.module('callinize').directive('actionBottomBar', function () {
    return {
        templateUrl: '../app/views/action-bottom-bar.html',
        restrict: 'E',
        link: function (scope, element, attrs) {

            var propertiesToCheck = ['hasCustomWorkflowEnabled'];

            scope.isBarVisible = function () {
                return _.some(propertiesToCheck, function (property) {
                    return scope[property];
                });
            };

        }
    }
});
;


angular.module('callinize').directive('activeCall', function () {
    return {
        templateUrl: '../app/views/activeCall.html',
        restrict: 'E',
        link: function (scope, element, attrs) {}
    }
});
;


angular.module('callinize').directive('activities', function ($timeout, ActivityService, FeatureService, FirebaseModel) {

    var currentIndex = 0;
    var containerWidth = 0;
    var ignore = {};
    var ignoreModel = FirebaseModel.fromUser("ignoreUpgrade/activity");

    ignoreModel.once('value', function (snap) {
        ignore = snap.val() || {};
    });

    return {
        restrict: "E",
        templateUrl: '../app/views/activities.html',
        scope: {
            call: "=",
            openRecordLink: '='
        },

        link: function (scope, element, attrs) {
            var container = $('#activities-container')[0];

            scope.$watch('call.matchedCrmRecords[0].bean_id', function () {
                var isSingleMatch = _.get(scope.call, 'matchedCrmRecords.length') === 1;
                if(isSingleMatch) fetchActivities(scope.call.matchedCrmRecords);
            });

            scope.$on('updateActivities', function () {
                var isSingleMatch = _.get(scope.call, 'matchedCrmRecords.length') === 1;
                if(isSingleMatch) fetchActivities(scope.call.matchedCrmRecords);
            });

            scope.retry = function () {
                if(scope.call) fetchActivities(scope.call.matchedCrmRecords);
            };

            ignoreModel.on('value', function (snap) {
                ignore = snap.val() || {};
                if(ignore && scope._activities) {
                    scope.activities = [];
                    $timeout(getActivities.bind(null, scope._activities), 200);
                }
            });

            function fetchActivities(matchedCrmRecords, retry) {
                if(matchedCrmRecords && matchedCrmRecords.length){
                    ActivityService.getActivities(scope.call).then(function (activities) {
                        scope._activities = activities;
                        getActivities(activities);
                    })
                    .then(null, function () {
                        scope.activitiesError = true;
                        !retry && fetchActivities(matchedCrmRecords, true);
                    });
                }
            }

            function getActivities(activities) {
                activities = activities || [];
                activities = activities.filter(function (activity) {
                    return activity && activity.activity && (FeatureService.isEnabled(activity.activity) || !ignore[activity.activity]);
                });
                scope.activities = activities;
                scope.call.activities = scope.activities;
                $timeout(init.bind(null, scope.activities));
            }

            function shiftLeft() {
                if(currentIndex == 0) return;
                currentIndex--;
                shift();
            }

            function shiftRight() {
                if(currentIndex ==  scope.activities.length - 1) return;
                currentIndex++;
                shift();
            }

            function shift() {
                var translate = currentIndex * containerWidth;
                $('#activities-carrousel-content').css('transform', 'translate3d(-' + translate + 'px, 0, 0)');
            }

            function init(activities) {
                $timeout(function() {
                    scope.created = true;
                    resizeActivitiesContainer();
                    setWindowResizeListener();
                    $('#carrousel-arrow-left').click(shiftLeft);
                    $('#carrousel-arrow-right').click(shiftRight);
                }, 100);
            }

            function resizeActivitiesContainer() {
                containerWidth = container.getBoundingClientRect().width;
                $('.activity-wrapper').css('width', containerWidth + 'px');
            }

            function setWindowResizeListener() {
                var debouncedFunction = _.debounce(resizeActivitiesContainer, 150);
                window.addEventListener('resize', debouncedFunction, false);
            }
        }
    };
});
;


angular.module('callinize')
    .directive('activity', function (FirebaseModel, moment) {

    var SUPPORTED_ACTIVITIES = {
        cases           : "cases",
        default         : "default",
        inboundCall     : "inboundCall",
        opportunities   : "opportunities",
        outboundCall    : "outboundCall",
        question        : "question",
        task            : "task",
        tasks           : "tasks",
        ticket          : "ticket",
        tickets         : "tickets"
    }

    return {
        restrict: "E",
        templateUrl: '../app/views/activity.html',
        scope: {
            activity: '=',
            openRecordLink: '='
        },
        link: function (scope, element, attrs) {

            if (!scope.activity || !scope.activity.activity) return;

            scope.activity = angular.copy(scope.activity);
            var type = SUPPORTED_ACTIVITIES[scope.activity.activity] || 'default';
            scope.activity.template = scope.activity.template || '../app/views/activity-types/' + type + ".html";

            var ignoreModel = FirebaseModel.fromUser("ignoreUpgrade/activity/" + scope.activity.activity);

            scope.ignoreUpgrade = function ($event) {
                $event.preventDefault();
                ignoreModel.set(true);
            };

            scope.getDate = function (date) {
                return date && ('Created ' + moment(date).format('MM/DD/YYYY'));
            };

            scope.openCase = function (activity) {
                console.log(activity);
            };
        }
    };
});

angular.module('callinize').filter('relativeDate', function () {
    return function (input) {
        return (input) ? moment(input).from(new Date()) : input;
    };
});

angular.module('callinize').filter('activityClass', function() {
    var classNames = {
        outboundCall : 'call_made',
        inboundCall : 'call_received',
        missedCall : 'call_missed',
        tasks : 'date_range',
        task : 'date_range',
        meetings : 'date_range',
        cases: 'stars',
        incidents : 'event_note',
        incident : 'event_note',
        questions : 'event_note',
        question : 'event_note',
        problems : 'stars',
        problem : 'stars',
        opportunity : 'stars',
        opportunities : 'stars',
        notes : 'event_note',
        emails : 'email',
        funFact : 'stars'
    }
    return function(activityName) {
        return classNames[activityName] || classNames.opportunity;
    };
})
;


angular.module('callinize')
    .directive('agentStatus', function () {
        return {
            templateUrl: '../app/views/agent-status.html',
            restrict: 'E',
            controller: 'AgentStatusController'
        };
    });;


angular.module('callinize').directive('assignRecordParent', function () {
    return {
        templateUrl: '../app/views/assignRecordParent.html',
        controller: 'AssignRecordParentController',
        controllerAs: 'arpc',
        restrict: 'E',
        link: function (scope, element) {

            scope.closeModal = function () {
                element.find('.modal-close-button').click();
            };

        }
    }
});
;


angular.module('callinize')
.directive('callControls', function ($rootScope) {
    return {
        templateUrl: '../app/views/call-controls.html',
        restrict: 'E',
        controller: 'CallControlsController',
        controllerAs: 'ccc',
        scope: {
            call: '='
        },
        link: function(scope, element, attrs) {

            scope.isCallActive = function() {
                return !scope.isHangup();
            };

            scope.isIncoming = function() {
                return _.get(scope, 'call.direction', '').toLowerCase() === 'inbound';
            };

            scope.isOnHold = function() {
                return _.get(scope, 'call.status', '').toLowerCase() === 'held';
            };

            scope.isConnected = function() {
                return _.get(scope, 'call.status', '').toLowerCase() === 'connected';
            };

            scope.isRinging = function() {
                return _.get(scope, 'call.status', '').toLowerCase() === 'ringing';
            };

            scope.isHangup = function() {
                return _.get(scope, 'call.status', '').toLowerCase() === 'hangup';
            };

            scope.isWarmTransferInProgress = function () {
                return scope.isOnHold() && scope.transferInProgress === 'warmTransfer';
            };

            scope.openTransferModal = function() {
                if (!scope.isConnected() || scope.isOnHold()) {
                    return;
                }
                $rootScope.$broadcast('modal-open', 'transfer-modal');
            };

            scope.openConferenceModal = function() {
                if (!scope.isConnected() || scope.isOnHold()) {
                    return;
                }
                $rootScope.$broadcast('modal-open', 'conference-modal');
            };
        }
    };
});
;


angular.module('callinize')
    .directive('callInfo', function () {
        return {
            templateUrl: '../app/views/call-info.html',
            restrict: 'E',
            scope: {
                call: '=',
                originateCall: '&'
            }
        };
    });;


angular.module('callinize')
	.directive('callRecorder', function () {
		return {
			templateUrl: '../app/views/call-recorder.html',
			restrict: 'E',
			controller: 'CallRecorderController',
			controllerAs: 'crc'
		};
	});;


angular.module('callinize')
    .directive('contactSearch', function () {

    return {
        templateUrl: '../app/views/contactSearch.html',
        restrict: 'E',
        controller: 'ContactSearchController'
    }
});
;


angular.module('callinize')
    .directive('createRecord', function (FeatureService) {
    return {
        templateUrl: '../app/views/createRecord.html',
        restrict: 'E',
        link: function postLink(scope, element, attrs) {
            
        }
    };
});
;


angular.module('callinize')
    .directive('ctiHeader', function () {
    return {
        templateUrl: '../app/views/cti-header.html',
        restrict: 'E'
    };
});
;


angular.module('callinize')
    .directive('ctiSettings', function () {
        return {
            templateUrl: '../app/views/cti-settings.html',
            restrict: 'E'
        };
    });
;


angular.module('callinize')
    .directive('customCallerSettings', function (FeatureService, FirebaseModel, LoginService) {
        return {
            templateUrl: '../app/views/custom-caller-settings.html',
            restrict: 'E',
            scope: {},
            link: function (scope) {

                var DEFAULT_OPTION = {
                    value: '',
                    label: 'Select a Caller ID'
                };

                var orgListenerUnbind;
                var userListenerUnbind;

                function resetDefaultValues() {
                    scope.localNumber = DEFAULT_OPTION;
                    scope.localNumbers = [DEFAULT_OPTION];
                }

                function refreshLocalNumber() {
                    if (scope.userCustomCallerId) {
                        scope.localNumber = _.find(scope.localNumbers, { value: scope.userCustomCallerId }) || DEFAULT_OPTION;
                    } else {
                        scope.localNumber = DEFAULT_OPTION;
                    }

                    var user = LoginService.getUser();
                    _.set(user, 'features.customCallerId.preferences.localNumber', scope.localNumber.value);
                    LoginService.updateUser(user);
                }

                function handleCallerIdChanges(snap) {
                    var feature = snap.val();
                    scope.userCustomCallerId = _.get(feature, 'preferences.localNumber');
                    refreshLocalNumber();
                }

                function handleFeatureChanges(snap) {
                    var feature = snap.val();

                    resetDefaultValues();

                    if (_.get(feature, 'status') === 'active') {
                        _.forEach(_.get(feature, 'preferences.localNumbers', []), function (localNumber) {
                            var item = {
                                value: localNumber,
                                label: localNumber
                            };

                            scope.localNumbers.push(item);
                        });

                        if (userListenerUnbind) {
                            refreshLocalNumber();
                        } else {
                            userListenerUnbind = FeatureService.onUserFeature('customCallerId', handleCallerIdChanges);
                        }
                    }
                }

                scope.changeCustomCallerId = function (localNumber) {
                    FirebaseModel.fromUser("features/customCallerId/preferences/localNumber").set(localNumber.value);
                };

                resetDefaultValues();

                orgListenerUnbind = FeatureService.onOrganizationFeature('customCallerId', handleFeatureChanges);

                scope.$on('$destroy', function () {
                    orgListenerUnbind();
                    if (userListenerUnbind) {
                        userListenerUnbind();
                    }
                });

            }
        };
    });
;


angular.module('callinize').directive('customWorkflow', function () {
    return {
        templateUrl: '../app/views/customWorkflow.html',
        controller: 'CustomWorkflowController',
        controllerAs: 'cwc',
        restrict: 'E'
    }
});
;


angular.module('callinize').directive('datetimePicker', function (CallService) {
    return {
        templateUrl: '../app/views/datetime-picker.html',
        restrict: 'E',
        link: function (scope, element) {

            scope.showDatetimePicker = false;

            scope.$on('modal-opened-datetime-picker-modal', function () {
                scope.showDatetimePicker = true;
            });

            scope.$on('modal-closed-datetime-picker-modal', function () {
                scope.showDatetimePicker = false;
            });

            scope.selectFollowUp = function (idk, momentDate) {
                var updateDispositions = !scope.followUpDate;
                scope.followUpDate = momentDate;

                CallService.getCallRef(scope.activeCall.id)
                    .child('followUpDate')
                    .set(scope.followUpDate.toDate().getTime(), function () {
                        if (updateDispositions) {
                            scope.$emit("updateDispositions", {followUp: true});
                        }
                    });
            };

            scope.$on('setDate', function (event, date, view) {
                var currentHours = scope.followUpDate && scope.followUpDate.hours();
                var newHours = date.hours();
                if(view === 'minutes' && newHours === currentHours){
                    element.find('.modal-close-button').click();
                }
            });

        }
    }
});
;


angular.module('callinize').directive('dialer', function ($timeout) {
    return {
        templateUrl: '../app/views/dialer.html',
        restrict: 'E',
        controller: 'DialerController',
        link: function(scope, element, attrs) {

            var input = $(element).find('input');
            var dialKeys = $(element).find('td');

            dialKeys.click(function() {
                var number = $(this).find('.dial-pad-number').html();
                scope.number += number;
                $timeout(focusOnInput);
            });

            scope.clearNumber = function() {
                if (!scope.number.length) return;
                scope.number = scope.number.substring(0, scope.number.length - 1);
                focusOnInput();
            }

            function focusOnInput() {
                input.focus();
            }
        }
    }
});
;


angular.module('callinize').directive('dialling', function () {
    return {
        templateUrl: '../app/views/dialling.html',
        restrict: 'E',
        link: function (scope, element, attrs) {}
    }
});
;


angular.module('callinize').directive('dispositions', function ($timeout) {
    return {
        templateUrl: '../app/views/dispositions.html',
        controller: 'DispositionsController',
        controllerAs: 'dc',
        restrict: 'E',
        link: function (scope, element, attrs, controller) {
            scope.getSelectedDispositions = controller.getSelectedDispositions.bind(controller);
            scope.checkRequiredDispositions = controller.checkRequiredDispositions.bind(controller);
            scope.reset = controller.reset.bind(controller);
        }
    }
});
;


angular.module('callinize').directive('emailTemplates', function (FirebaseModel) {
    return {
        templateUrl: '../app/views/emailTemplates.html',
        restrict: 'E',
        link: function (scope) {

            var EMAIL_KEYS = ['cc', 'bcc', 'body', 'subject'];

            var model = FirebaseModel.fromUser('emailTemplates');

            scope.templates = [];
            var valueHandler = function(snap){
                var templates = snap.val() || [];

                scope.templates = _.filter(templates, function (template) {
                    return template && (template.cc || template.bcc || template.body || template.subject);
                });
            };

            model.on('value', valueHandler);

            scope.$on("$destroy", function () {
                model.off('value', valueHandler);
            });

            scope.emailTemplateLabel = function (template, index) {
                return template.subject || template.body.substring(0, 50) || 'Email Template ' + index;
            };

            scope.getMailToLink = function (template) {
                template.email = _.get(scope.activeCall, 'matchedCrmRecords[0].bean_email', 'crm-has-no-email-fill-it-in@email.com');

                var mailTo = 'mailto:' + template.email;
                var params = {};

                _.forEach(EMAIL_KEYS, function(key) {
                    if (template[key]) {
                        params[key] = encodeURIComponent(template[key]);
                    }
                });

                mailTo += '?' + _.map(params, function(value, key) {
                    return key + "=" + value;
                }).join( "&" );

                return mailTo;
            };

        }
    }
});
;



"use strict";

angular.module('callinize')
  .directive('feature', function (FirebaseModel) {
  	var actionLookUp = {
  		active : 'show',
  		inactive : 'hide',
  		undefined : 'show'
  	};
  	var actionDisabledLookUp = {
  		active : 'hide',
  		inactive : 'show',
  		undefined : 'hide'
  	};
  	var FEATURES 	= 'features';
  	var PREFERENCES = 'preferences';
  	var SLASH 		= "/";
    return {
		restrict: 'A',
		link : function feature (scope, element, attrs) {
            element = $(element);
			var featureName = attrs.feature;
			var featureDisabled = attrs.featureDisabled === "true";
			var defaultsToHide = attrs.defaultsToHide === "true";
			var lookup = featureDisabled ? actionDisabledLookUp : actionLookUp;

			featureDisabled && element.hide();

			var path = [FEATURES, featureName];

			FirebaseModel.fromOrganization(path.join(SLASH)).on('value', function(featureSnap) {
				var feature = featureSnap.val();
				if(feature){
					attrs.featurePreference ? handlePreferences(feature) : handleFeature(feature);
				}
                if(!feature && defaultsToHide){
                    element.hide();
                }
			});

			function handleFeature (feature) {
				var action = lookup[feature.status];
				$(element)[action]();
			}

			function handlePreferences (feature) {
				var isEnabled = _.get(feature, ['preferences', attrs.featurePreference]);
				isEnabled ? element.show() : element.hide();
			}
		}
    };
});
;


angular.module('callinize')
    .directive('floatingLabelInput', function () {

    return {
        templateUrl: '../app/views/floatingLabelInput.html',
        restrict: 'E',
        scope: {
            input: '=',
            isSearching: '=',
            records: '=',
            filterModules: '=?',
            search: '@'
        },
        link: function(scope, element, attrs, controller) {
            var placeholder = attrs.placeholder || 'Type here';
            var $element = $(element);
            var input = $element.find('input');
            var wrapper = $element.find('.material-design-input');
            $element.find('label').html(placeholder);
            input.focus(function() {
                wrapper.addClass('active');
            });
            input.blur(function() {
                if(!scope.input)
                    wrapper.removeClass('active');
            });
            scope.isActive = function() {
                return scope.input || input.is(':focus');
            };
        }
    }
});
;


angular.module('callinize').directive('history', function () {
    return {
        templateUrl: '../app/views/history.html',
        restrict: 'E',
        link: function (scope, element, attrs) {}
    }
});
;


angular.module('callinize').directive('loading', function () {
    return {
        templateUrl: '../app/views/loading.html',
        restrict: 'E',
        link: function (scope, element, attrs) {}
    }
});
;


'use strict';

/**
* @ngdoc directive
* @name callinize.directive:mentions
* @description
* # mentions
*/
angular.module('callinize')
.value('mentionTemplate', '<li data-value="CC @${username}"><div>${username}</div><small>${name}</small></li>')
.directive('mentions', function (mentionTemplate, OrganizationService) {
    return {
        restrict: 'A',
        link: function postLink(scope, element, attrs) {

            $(element).atwho({
                at: "@",
                displayTpl: mentionTemplate,
                insertTpl: "CC @${username}",
                data: []
            });
            OrganizationService.getUsers().then(function(users) {
                $(element).atwho('load', '@', users);
            });
        }
    };
});
;


angular.module('callinize').directive('modal', function ($timeout, $rootScope) {
    return {
        restrict: 'C',
        link: function (scope, element, attrs) {

            element = $(element);
            var trigger = $(attrs.trigger);
            var dismissable = attrs.dismissable || true;

            trigger.click(toggleModal);
            if(dismissable !== "false") {
                element.click(hideModal);
                element.find('.modal-close-button').click(hideModal);
            }
            element.find('.modal-content').click(function(e) {e.stopPropagation()});
            $(document).keyup(function(e) {
                 if (e.keyCode == 27) hideModal();
            });

            scope.$on('modal-open', function(event, args) {
                if(args == element.attr('id'))
                    showModal();
            });

            scope.$on('modal-close', function(event, args) {
                if(args == element.attr('id'))
                    hideModal();
            });

            function toggleModal() {
                var modal = element;
                if(!modal.hasClass('active'))
                    showModal();
                else
                    hideModal();
            }

            function showModal() {
                $rootScope.$broadcast('modal-opened-' + element.attr('id'));

                var modal = element;
                if(modal.hasClass('active'))
                    return;
                modal.show()
                $timeout(function() {
                    modal.addClass('active');
                }, 0);
            }

            function hideModal() {
                var modal = element;
                if(!modal.hasClass('active'))
                    return;
                modal.removeClass('active');
                $timeout(function() {
                    modal.hide();
                    $rootScope.$broadcast('modal-closed-' + element.attr('id'));
                }, 350);
            }
        }
    }
});
;


angular.module('callinize').directive('multipleMatches', function () {
    return {
        templateUrl: '../app/views/multipleMatches.html',
        restrict: 'E',
        link: function (scope, element, attrs) {}
    }
});
;


angular.module('callinize').directive('nextRecord', function () {
    return {
        templateUrl: '../app/views/nextRecord.html',
        restrict: 'E'
    }
});
;


angular.module('callinize').directive('noActiveCall', function () {
    return {
        templateUrl: '../app/views/noActiveCall.html',
        restrict: 'E',
        link: function (scope, element, attrs) {}
    }
});
;


angular.module('callinize').directive('noMatches', function () {
    return {
        templateUrl: '../app/views/noMatches.html',
        restrict: 'E',
        link: function (scope, element, attrs) {}
    }
});
;


angular.module('callinize').directive('notes', function () {
    return {
        templateUrl: '../app/views/notes.html',
        restrict: 'E',
        link: function (scope, element, attrs) {}
    }
});
;


angular.module('callinize').directive('notLoggedIn', function () {
    return {
        controller: 'LoginController',
        templateUrl: '../app/views/notLoggedIn.html',
        restrict: 'E',
        link: function (scope, element, attrs) {}
    }
});
;


angular.module('callinize').directive('primaryExtensionToggle', function () {
    return {
        templateUrl: '../app/views/primary-extension-toggle.html',
        controller: 'PrimaryExtensionController',
        controllerAs: 'pec',
        restrict: 'E',
        scope: {
            callinize: '='
        }
    }
});
;


angular.module('callinize').directive('recordList', function (FeatureService) {
    return {
        templateUrl: '../app/views/recordList.html',
        restrict: 'E',
        scope: {
            activeCall: '=',
            filter: '=',
            records: '=',
            selectRecord: '&'
        },
        link: function(scope) {

            scope.popupCustomFieldEnabled = false;

            var unbind = FeatureService.on('popupCustomField', function (snap) {
                scope.popupCustomField = snap.val();

                if (scope.popupCustomField) {
                    scope.popupCustomFieldEnabled = scope.popupCustomField.status === 'active' && !_.isEmpty(scope.popupCustomField.preferences);

                    if (scope.popupCustomFieldEnabled) {
                        scope.popupCustomField.preferences.nameLowerCase = _.get(scope.popupCustomField.preferences, 'name', '').toLowerCase();
                    }
                }
            });

            scope.$on("$destroy", function () {
                unbind();
            });

            scope.getPopupCustomFieldValue = function (record) {
                return _.get(record, 'meta.' + scope.popupCustomField.preferences.name) ||
                    _.get(record, 'meta.' + scope.popupCustomField.preferences.nameLowerCase);
            };

            scope.$watch('filter', updateFilter);
            scope.$watch('records', updateFilter);

            function updateFilter() {
                scope.filteredRecords =  scope.activeCall && scope.filter ? filter() : scope.records;
            }

            function filter() {
                var filter = toLowerCase(scope.filter);
                return _.filter(scope.records, function (record) {
                    var name = toLowerCase(record.bean_name);
                    var parentName = toLowerCase(record.parent_name);
                    var email = toLowerCase(record.bean_email);
                    return _.includes(name, filter) || _.includes(parentName, filter) || _.includes(email, filter);
                });
            }

            function toLowerCase(str) {
                return str && str.toLowerCase();
            }
        }
    };
});
;


"use strict";

angular.module('callinize')
  .directive('relateResource', function ($timeout, LoginService) {
    return  {
		restrict: 'E',
		controller : 'RelateResourceController',
		controllerAs : 'rr',
        scope : true,
		templateUrl: '../app/views/relateResource.html',
		link : function relateResource (scope, element, attrs) {
			/*if(!scope.hasRelateResourceEnabled()) {
				$(element).hide();
			}*/
		}
    };
});
;


angular.module('callinize').directive('searchingRecords', function () {
    return {
        templateUrl: '../app/views/searchingRecords.html',
        restrict: 'E',
        link: function (scope, element, attrs) {}
    }
});
;


angular.module('callinize').directive('singleMatch', function () {
    return {
        templateUrl: '../app/views/singleMatch.html',
        controller: 'SingleMatchController',
        controllerAs: 'smc',
        restrict: 'E'
    }
});
;


angular.module('callinize')
    .directive('sms', function () {
         return {
             templateUrl: '../app/views/sms.html',
             restrict: 'E',
             controller: 'SMSController'
         };
    });
;


angular.module('callinize')
    .directive('socialProfile', function () {
        return {
            restrict: 'E',
            scope : true,
            controller: 'SocialProfileController',
            controllerAs: 'spc',
            templateUrl: '../app/views/socialProfile.html',
            link: function (scope, element, attrs, controller) {

            }
        };
    });
;


angular.module('callinize').directive('softphone', function () {
    return {
        templateUrl: '../app/views/softphone.html',
        restrict: 'E',
        link: function (scope, element, attrs) {}
    }
});
;



angular.module('callinize')
    .directive('switchCall', function () {
        return {
            restrict: 'E',
            scope : true,
            controller: 'SwitchCallController',
            controllerAs: 'scc',
            templateUrl: '../app/views/switchCall.html',
            link: function (scope, element, attrs) {

            }
        };
    });
;


angular.module('callinize').directive('timer', function (utils, FirebaseModel, CallService) {
    return {
        templateUrl: '../app/views/timer.html',
	    controller: 'TimerController',
	    controllerAs: 'tc',
        restrict: 'E',
	    scope: {
		    call: "="
	    },
        link: function (scope, element, attrs, controller) {
	        scope.$watch('call', syncTimer, true);
	        var notifyPromise;

	        syncTimer(scope.call);

	        scope.duration = utils.formatDuration(scope.duration);
	        scope.stopEnabled = false;
	        scope.isStopped = false;

	        function syncTimer(call) {
		        call = call || {};
		        var longCall = moment.duration(moment().diff(call.startTime)).asHours() > 3;

		        if(longCall && !CallService.isHangup(call)){
			        call.status = 'Hangup';
			        FirebaseModel.fromUser("calls/history/" + call.id + "/status").set("Hangup");
		        }
		        scope.stopEnabled = call.status !== 'Hangup';
		        scope.isStopped = call.status === 'User-Hangup';

		        switch (call.status) {
			        case 'User-Hangup':
			        case 'Hangup':
				        controller.update(call.id, call.startTime, call.endTime, call.offset, false).finally(angular.noop, function notify(duration) {
					        scope.duration = utils.formatDuration(duration);
				        });
				        notifyPromise = null;

				        break;

			        default:
				        if (!notifyPromise && call.id) {
					        // serverTime is in seconds
					        notifyPromise = controller.update(call.id, call.startTime, false, call.offset, true);
					        notifyPromise && notifyPromise.finally(angular.noop, function notify(duration) {
						        scope.duration = utils.formatDuration(duration);
					        });
				        }

				        break;
		        }
	        }

	        scope.toggleTimer = function(call){
		        scope.isStopped ? scope.startTimer(call) : scope.stopTimer(call);
		        scope.isStopped = !scope.isStopped;
	        };

	        scope.stopTimer = function(call){
		        CallService.setCallStatus(call, 'User-Hangup');
	        };

	        scope.startTimer = function(call){
		        CallService.setCallStatus(call, call._status || 'Connected');
	        };

	        scope.$on('$destroy', function () {
		        controller.$destroy();
	        });
        }
    }
});
;


'use strict';

/**
 * @ngdoc directive
 * @name callinize.directive:tooltip
 * @description
 * # tooltip
 */
angular.module('callinize')
  .factory('tooltipDefaultOptions', function () {
    return {
      show: false,
      hide: false,
      position: {
        my: 'center bottom-20',
        at: 'center top',
        using: function (position, feedback) {
          angular.element(this).css(position);
          angular.element('<div>').addClass('arrow')
            .addClass(feedback.vertical)
            .addClass(feedback.horizontal)
            .appendTo(this);
          var leftPos = feedback.target.left - 171;
          var bottom = $(document).height() - feedback.target.element.offset().top;
          var tooltipCss = {
            position: 'fixed',
            'left': leftPos,
            'top': 'auto',
            'bottom': bottom,
            'z-index': '999999999',
            'padding': '10px 20px',
            'color': 'white',
            'font-size': '14px',
            'font-weight': '300',
            'font-family': 'Roboto Condensed',
            'background': '#34495e',
            'border-radius': '3px',
            'max-width': '315px'
          };
          angular.element(this)
            .css(tooltipCss);
        }
      }
    };
  })
  .directive('tooltip', function ( tooltipDefaultOptions) {
    return {

      restrict: 'A',
      scope: {
        tooltipOptions: '='
      },
      link: function postLink(scope, element, attrs) {
        scope.$watch('tooltipOptions', function (options) {
          options = angular.extend({}, tooltipDefaultOptions, options);
          element.tooltip(options);
        });

      }
    };
  });
;


"use strict";


function translate(str) {
    return str && (chrome.i18n.getMessage(str) || str);
}

angular.module('callinize')
    .filter('translate', _.identity.bind(_, translate));


angular.module('callinize').directive('translate', function () {
    return {
        restrict: 'AE',
        scope: {
            translate: '@'
        },
        link: function (scope, iElement, iAttr) {
            var translation = translate(iAttr.translate || scope.translate);
            iElement.empty().append(translation);
        }
    }
});;


angular.module('callinize').directive('typeahead', function (OrganizationService) {
    return {
        restrict: 'C',
        link: function postLink(scope, element, attrs) {

            function getRecordByName (name) {
                typeof scope[attrs.onLoad] === 'function' && scope[attrs.onLoad]();
                scope.isSearching = true;

                var params = {};
                if (attrs.filterModules) {
                    params.filterModules = scope[attrs.filterModules];
                }

                OrganizationService.getRecordByName(name, params).then(function(records) {
                    typeof scope[attrs.afterLoad] === 'function' && scope[attrs.afterLoad]();
                    scope.records = records;
                    scope.isSearching = false;
                });
            }

            var debounced = _.debounce(getRecordByName, 350);

            if (attrs.search === 'remote') {
	            element.on('input', function () {
		            var value = this.value;
		            if (value && value.length >= 2) {
			            debounced(value);
		            }
	            });
            }
        }
    };
});
;



function ActivityService ($http, $q, LoginService, CacheService, UrlService) {

	var ACTIVITIES_URL = '/activities';
	var cache = CacheService;
	var localPromises = {};
	var localDescriptionPromises = {};

	this.getActivities = onLoad;

	this.removeActivitiesCache = function (call) {
		var crmMatch = call.matchedCrmRecords[0];
		var cacheKey = call.id + crmMatch.bean_id;
		delete localPromises[cacheKey];
		cache.remove(cacheKey);
	};

	this.clearCache = function () {
		cache.invalidate();
	};

	this.getCall = function (id) {
		var localPromise = localDescriptionPromises[id];
		if(localPromise) return localPromise;

		var url = appendUrl("", {id : id});

		localDescriptionPromises[id] = $http.get(url).then(function (config) {
			var call = config && config.success;
			return call;
		}).then(null, function (error) {
			delete localDescriptionPromises[id];
			return error;
		});

		setTimeout(function () {
			delete localDescriptionPromises[id];
		}, 10000);

		return localDescriptionPromises[id];
	}

	function onLoad(call, removeCache){
		var self = this;
		if(removeCache)
			return getActivities(call, removeCache);
		return cache.onLoad().then(function() {
			self.getActivities = getActivities;
			return getActivities(call);
		});
	};

	function getActivities(call, removeCache) {
		if(removeCache)
			return fetchActivities(call, removeCache);
		return fromCache(call) || fetchActivities(call, removeCache);
	}

	function appendUrl (url, call) {
		var callId = call.id;
		var orgId = LoginService.getOrganization().id;
		var user = LoginService.getUser();
		var token = user.token;
		return UrlService.getApiBaseUrl() + orgId + '/calls/' + callId + url + '?token=' + token;
	}

	function fromCache(call) {
		var crmMatch = call.matchedCrmRecords && call.matchedCrmRecords[0].bean_id;
		var cached = cache.get(call.id + crmMatch);
		return cached && $q.when(cached);
	}

	function fetchActivities(call, removeCache) {
		var crmMatch = call.matchedCrmRecords[0];
		var cacheKey = call.id + crmMatch.bean_id;
		var localPromise = localPromises[cacheKey];
		if(localPromise && !removeCache) return localPromise;

		localPromises[cacheKey] = $http.post(appendUrl(ACTIVITIES_URL, call), crmMatch, {withCredentials: false}).then(function (config) {
			var activities = config && config.data && config.data.success;
			Array.isArray(activities) && cache.set(cacheKey, activities);
			delete localPromises[cacheKey];
			return activities;
		}).then(null, function (error) {
			delete localPromises[cacheKey];
			return error;
		});
		return localPromises[cacheKey];
	}

	setTimeout(function () {
		this.getActivities = this.getActivities === onLoad ? getActivities : this.getActivities;
	}.bind(this), 10000);

}

angular.module("callinize")
	.service("ActivityService", ActivityService);
;


function AgentStatusService($http, UrlService) {

    var AGENT_STATUS = '/agent-statuses';

    function buildUrl(path) {
        return UrlService.getApiBaseUrlV1() + path;
    }

    function unwrap(response) {
        return response && response.data;
    }

    this.login = function(agentData) {
        var url = AGENT_STATUS + '/login';
        return $http.post(buildUrl(url), agentData).then(unwrap);
    };

    this.logout = function(agentData) {
        var url = AGENT_STATUS + '/logout';
        return $http.post(buildUrl(url), agentData).then(unwrap);
    };

    this.getStatuses = function() {
        return $http.get(buildUrl(AGENT_STATUS)).then(unwrap);
    };

    this.updateStatus = function(statusId) {
        return $http.put(buildUrl(AGENT_STATUS + '/' + statusId)).then(unwrap);
    };

    this.getAgentUserData = function() {
        var url = buildUrl('/open-cti/agent-data');
        return $http.get(url).then(unwrap);
    }
}

angular.module('callinize').service('AgentStatusService', AgentStatusService);;


function Auth ($firebaseAuth, FirebaseRef) {
	return $firebaseAuth(FirebaseRef);
}

angular.module("callinize").service('Auth', Auth);;


function BrandService(LoginService, UrlService) {
    var branding        = "/branding/";
    var getBranding;

    this.getBrand = function() {
        var user = LoginService.getUser();
        var orgId = user && user.organizationId;
        var brandingCached = getLocalStorage('tenfold-branding');
        var isCached = brandingCached && brandingCached.organizationId === orgId;
        return isCached || !user ? Promise.resolve(brandingCached) : getBranding || fetchBranding(user);
    };

    this.update = function(organization) {
        var newBrand = _.get(organization, "brand");
        if(newBrand && !_.isEqual(getLocalStorage('tenfold-branding'))){
            localStorage.setItem('tenfold-branding', JSON.stringify(brand));
        }
    };

    function fetchBranding(user) {
        getBranding = appendUrl(branding).then(function (url) {
            return $.get(url, { token: user.token })
                .then(function (brand) {
                    brand = brand || {};
                    brand.organizationId = user.organizationId;
                    delete brand._organization;
                    localStorage.setItem('tenfold-branding', JSON.stringify(brand));
                    return brand;
                });
        });
        return getBranding;
    }

    function getLocalStorage(item) {
        try {
            return JSON.parse(localStorage.getItem(item));
        } catch(e){}
    }

    function appendUrl (url) {
        var user = getUser();
        var orgId = user && user.organizationId;
        return UrlService.getApiBaseUrl() + orgId + url;
    }
}

angular.module('callinize').service('BrandService', BrandService);;


function CacheService($q, CACHE_NAME) {

	var map;
	var handler;
    var cacheName = CACHE_NAME;
	var onLoad = $q.defer();
	var CACHE_PREFIX = "CACHE_PREFIX-" + CACHE_NAME;
	var INVALIDATOR_PREFIX = "INVALIDATE-" + CACHE_NAME;
	var toInvalidate = new Date(new Date().getTime() + 604800000);

	var store = cacheName ? localforage.createInstance({
		name: cacheName
	}) : localforage;

	this.set = function (name, value) {
		validate();
		map[CACHE_PREFIX + name] = value;
		return cacheIt(name, value);
	}

	this.get = function (name) {
		validate();
		return map[CACHE_PREFIX + name];
	}

	this.remove = function (name) {
		validate();
		remove(CACHE_PREFIX + name);
	}

	this.validation = function (_handler) {
		handler = _handler;
	}

	this.invalidate = function () {
		clear();
	}

	this.onLoad = function () {
		return onLoad.promise;
	};

	function clear() {
		console.log("Clear cache: " + cacheName);
		map = Object.create(null);
		store.iterate(function (value, key) {
			key.indexOf(CACHE_PREFIX) === 0 && store.removeItem(key);
		});
	}

	function load() {
		map = Object.create(null);
		var invalidators = {};
		var data 		 = {};

		store.iterate(function (value, key) {
			var isData = key.indexOf(CACHE_PREFIX) === 0;
			var isInvalidator = key.indexOf(INVALIDATOR_PREFIX) === 0;
			isData && (data[key] = value);
			isInvalidator && (invalidators[key] = value);
		},
		function () {
			Object.keys(data).forEach(function (key) {
				var shouldGet = key.indexOf(CACHE_PREFIX) === 0 && isValid(key);
				shouldGet && (map[key] = JSON.parse(data[key])) || remove(key);
			});
			onLoad.resolve();
		});

		function isValid(key) {
			return invalidators[INVALIDATOR_PREFIX + key] && new Date(invalidators[INVALIDATOR_PREFIX + key]) > new Date();
		}
	}

	function remove(key) {
		store.removeItem(key);
		store.removeItem(INVALIDATOR_PREFIX + key);

		delete map[key];
	}

	function validate() {
		return !handler || handler() || clear();
	}

	function cacheIt(name, value) {
		var cacheKey = CACHE_PREFIX + name;
		store.setItem(INVALIDATOR_PREFIX + cacheKey, toInvalidate.toString());
		return store.setItem(cacheKey, JSON.stringify(value));
	}

	load();
}

angular.module('callinize').service("CacheService", CacheService);
;


function CallControlsService($http, UrlService) {

    this.answer = function(call) {
        var url = buildUrl(call, 'answer');
        return $http.post(url).then(unwrap);
    };

    this.hangup = function(call) {
        var url = buildUrl(call, 'hangupCall');
        return $http.post(url).then(unwrap);
    };

    this.cancelTransfer = function (call) {
        var url = buildUrl(call, 'cancelTransfer');
        return $http.post(url).then(unwrap);
    };

    this.warmTransfer = function(call, extension) {
        var url = buildUrl(call, 'warmTransfer');
        return $http.post(url, {extension: extension}).then(unwrap);
    };

    this.completeWarmTransfer = function (call) {
        var url = buildUrl(call, 'completeTransfer');
        return $http.post(url).then(unwrap);
    };

    this.blindTransfer = function(call, extension) {
        var url = buildUrl(call, 'blindTransfer');
        return $http.post(url, {extension: extension}).then(unwrap);
    };

    this.conference = function(call, extension) {
        var url = buildUrl(call, 'conference');
        return $http.post(url, {extension: extension}).then(unwrap);
    };

    this.hold = function(call) {
        var url = buildUrl(call, 'hold');
        return $http.post(url).then(unwrap);
    };

    this.retrieve = function(call) {
        var url = buildUrl(call, 'retrieve');
        return $http.post(url).then(unwrap);
    };

    function buildUrl(call, method) {
        return UrlService.getApiBaseUrlV1() + '/calls/' + call.id + '/' + method;
    }

    function unwrap(response) {
        return response && response.data;
    }
}

angular.module('callinize').service("CallControlsService", CallControlsService);
;


function CallRecorderService($http, UrlService) {

	this.startRecording = function(call) {
		return $http.post(buildUrl(call), {'call': call})
			.then(function (result) {
				return result.data;
			});
	};

	this.stopRecording = function(call) {
		return $http.put(buildUrl(call), {'call': call})
			.then(function (result) {
				return result.data;
			});
	};

	function buildUrl(call) {
		return UrlService.getApiBaseUrlV1() + '/phones/plivo/' + call.id + '/record';
	}
}

angular.module('callinize').service("CallRecorderService", CallRecorderService);
;


function CallService ($http, $q, $timeout, $window, FirebaseModel, LoginService, ActivityService, UrlService, utils, extensionHost) {

	var call;
	var createRecordURL		= "/createRecord";
	var trackUrl 			= "/track";
	var crmAddNumber		= "/crm/addnumber";
	var autoSaveUrl			= "/autosave";
	var createResourceURL 	= "/resource/create";
	var relateResourceURL 	= "/resource/relate";
	var assignAccountURL 	= "/assignRecordParent";
    var self                = this;

    var localPromises = {};
    
    var activeCallReference;
	this.getActiveReference = function() {
		if(!activeCallReference) {
			activeCallReference = FirebaseModel.fromUser('calls/active');
		}
		return activeCallReference;
	};

	this.getCurrentCall = function getCurrentCall() {
		return call;
	};

	this.setActive = function setActive(callId, callback) {
		var active = self.getActiveReference();
        active.set(callId, callback);
	};

	this.onActiveCall = function (handler, unbind) {
		handler = handler || _.noop;
		call && $timeout(handler.bind(null, call));
		var eventHandlerBinded = eventHandler.bind(this);
		var currentRef;
		this.onActiveCallRef(function (ref) {
			removeOldCall(currentRef);
			ref.on('value', eventHandlerBinded);
			currentRef = ref;
			unbindHandler(ref);
		}, unbind);
		function eventHandler(snap) {
			call = snap.val();
			call && handler(call);
		}
		function unbindHandler(ref) {
			return unbind && unbind(removeOldCall.bind(this, ref));
		}
		function removeOldCall(ref) {
			return ref && ref.off('value', eventHandlerBinded);
		}
	};

	this.onActiveCallRef = function (handler, onUnBind) {
		handler = handler || _.noop;
		var active = self.getActiveReference();
		var callRefhandlerBinded = callRefhandler.bind(this);

		active.on('value', callRefhandlerBinded);
		onUnBind && onUnBind(function () {
			active.off('value', callRefhandlerBinded);
		});

		function callRefhandler(snap) {
			var active = snap.val();
			if(active){
				handler(FirebaseModel.fromUser('calls/history/' + active));
			}
			else {
				call = null;
			}
		}
	};

	this.getCallRef = function getCallRef(callId) {
		return FirebaseModel.fromUser('calls/history/' + callId);
	};

	this.isHangup = function isHangup(call) {
		return _.includes(['Hangup', 'User-Hangup'], call && call.status);
	};

	this.setCallStatus = function setCallStatus(call, status, callback) {
		var callId = call.id || call._id;
		FirebaseModel.fromUser('calls/history/' + callId + '/_status').set(call.status);
		return FirebaseModel.fromUser('calls/history/' + callId + '/status').set(status, callback);
	};

	this.listenForStatusChanges = function(call, callback) {
        return this.listenForPropertyChanges(call, 'status', callback);
    };

    this.listenForTransferChanges = function(call, callback) {
        return this.listenForPropertyChanges(call, 'transferInProgress', callback);
    };

    this.listenForPropertyChanges = function(call, property, callback) {
        var unbind;
        var callId = call.id || call._id;
        var ref = FirebaseModel.fromUser('calls/history/' + callId + '/'  + property);
        var unbindFunction = function() {
            ref.off('value', unbind);
        };

        unbind = ref.on('value', function(dataSnapshot) {
            var value = dataSnapshot && dataSnapshot.val();
            if (value && value !== call.status) {
                callback(value);
            }
        });

        return unbindFunction;
    };

	this.setMatchedRecords = function setMatchedRecords(matchedCrmRecords) {
		var params = {
			action: 'setMatchingRecords',
			matchedCrmRecords: matchedCrmRecords
		};
		return $http.post(callUrl(), params, {withCredentials: false}).then(unwrapSuccess);
	};

	this.addNumber = function addNumber (matchedCrmRecord, phoneNumber, callId) {
		var phones = _.values(_.get(matchedCrmRecord, 'bean_phones', {}));
		if (_.has(matchedCrmRecord, 'bean_phone')) {
			phones.push(matchedCrmRecord.bean_phone);
		}

		var alreadyContainsPhone = _.some(phones, _.partial(utils.isSamePhoneNumber, phoneNumber));
		if (alreadyContainsPhone) {
			return $q.when();
		}

		var record = {
			matchedCrmRecord: matchedCrmRecord,
			callId: callId || '',
			phoneNumber: phoneNumber
		};
		return $http.post(appendUrl(crmAddNumber), record, {withCredentials: false}).then(unwrapSuccess);
	};

	this.saveNote = function saveNote(note) {
		return $http.post(callUrl('', note.callId), note, {withCredentials: false})
			.then(function (result) {
				return unwrap(result);
			});
	};

	this.autoSaveNote = function saveNote(note, dispositions, followUpDate, id, subject) {
		var params = {
			action: 'autosave',
			subject: subject,
			note: note,
			followUpDate: followUpDate,
			dispositions : dispositions,
			callId: id || call && call.id
		};
		return $http.post(callUrl(autoSaveUrl), params).then(unwrap);
	};

	this.createResource = function createResource(record, autoCreate) {
		var params = {
			resource: {
				resource: record
			}
		};

		var promise = $q.defer();

		extensionHost.sendMessage({
			command: "createResource",
			url:     callUrl(createResourceURL),
            autoCreate : autoCreate,
			params:  params
		}, function (response) {
			response.error ? promise.reject(response.error) : promise.resolve(response.success);
		});

		return promise.promise;
	};

	this.createRecord = function createRecord (name, phoneNumber, module) {
		return $http.post(
			callUrl(createRecordURL),
			getRecord(name, phoneNumber, module)
		).then(function (config) {
			return typeof(config.data) !== 'object' ? config.data : unwrapSuccess(config);
		});
	};

	this.relateResource = function createRecord (resource) {
        call.relateResourceCrmRecord = resource;
		return $http.post(
			callUrl(relateResourceURL), {
				resource : resource
			}
		).then(function (data) {
			ActivityService.removeActivitiesCache(call);
			return data;
		});
	};

	this.assignAccount = function (opts) {
		return $http.post(callUrl(assignAccountURL), opts).then(function (data) {
			ActivityService.removeActivitiesCache(call);
			return data;
		});
	};

	this.trackTransaction = function trackTransaction (txId) {
		var params = {
			callLoopTimestamp: true,
			clientTimestamp: (new Date()).getTime(),
			txId: txId
		};
      	return $http.post(callUrl(trackUrl), params)
      		.then(unwrap);
	};

	this.setBeanID = function setBeanID (contact) {
		var params = {
			action: 'setBeanId',
			recordId: contact.bean_id,
			recordType: contact.bean_module
		};
      	return $http.post(callUrl(), params, {withCredentials: false}).then(unwrapSuccess);
	};

	this.fetchCall = function (id) {
		var localPromise = localPromises[id];
		if(localPromise) return localPromise;

		var token = LoginService.getUser().token;
		var orgId = LoginService.getOrganization().id;
		var url = UrlService.getApiBaseUrl() + orgId + '/calls/' + id + '?token=' + token;
		localPromises[id] = $http.get(url, {withCredentials: false})
			.then(function (config) {
				var call = config && config.data && config.data.success;
				return call;
			}, function (error) {
				delete localPromises[id];
				return error;
			});

		setTimeout(function () {
			delete localPromises[id];
		}, 10000);

		return localPromises[id];
	};

	this.triggerCTD = function (call) {
		var record = call.matchedCrmRecords && call.matchedCrmRecords.length === 1 ? call.matchedCrmRecords[0] : {};
		record.phoneNumber = call.phoneNumber || record.phoneNumber;
		$window.parent.postMessage({
			command : 'ctd',
			message : record
		}, '*');
	};

    this.unassociateCall = function setMatchedRecords(callId, matchedCrmRecords) {
        var params = {
            action: 'setMatchingRecords',
            callId: callId,
            matchedCrmRecords: matchedCrmRecords,
            clearRecords: 'yes'
        };
        return $http.post(callUrl(), params, {withCredentials: false}).then(unwrapSuccess);
    };

    this.getPhoto = function () {
        var hasPic           = _.get(call, "matchedCrmRecords[0].bean_image");
        var isSingleMatch    = _.get(call, "matchedCrmRecords.length") === 1;
        var email            = _.get(call, "matchedCrmRecords[0].bean_email");
      	return hasPic || !email || !isSingleMatch ? $q.when() : getPhoto(email);
	};

    function getPhoto(email) {
        var query = {
            email : email
        };
        return $http.post(callUrl("/fullcontact/find"), query).then(unwrap)
    }

	function unwrapSuccess (response) {
		return response && response.data && response.data.success;
	}

	function unwrap (response) {
		return response.data;
	}

	function callUrl (url, callId) {
		var targetUrl = url || '';
		var id = callId || call && call.id;
		return appendUrl("/calls/" + id + targetUrl);
	}

	function appendUrl (url) {
		return UrlService.getApiBaseUrl() + LoginService.getUser().organizationId + url;
	}

	function getRecord(name, phoneNumber, moduleName) {
		var requestName = utils.nameChopper(name);
		return {
			firstName: requestName.first || "",
			lastName: requestName.last || "",
			number: phoneNumber,
			module: moduleName,
			record: {
				bean_name: name,
				bean_module: moduleName
            }
		};
	}
}

angular.module("callinize").service("CallService", CallService);
;


function CommandHandlerService() {

    this.shouldUseLocalNumber = function() {
        var localPresenceEnabled = _.get(callinize.organization, 'features.localPresence.status') === 'active';
        var localPresenceUserLevel = _.get(callinize.organization, 'features.localPresence.userLevel') === true;
        var userLocalPresence = _.get(callinize.user, 'features.localPresence.status') === 'active';
        var useLocalNumber = localPresenceEnabled && (!localPresenceUserLevel || userLocalPresence) && callinize.user.localPresence === 'true';

        sendResponse(useLocalNumber);
    };

    this.registerCommandHandlers = function() {
        window.chrome.setCommandHandler('shouldUseLocalNumber', this.shouldUseLocalNumber.bind(this));
    };


}

angular.module('callinize').service('CommandHandlerService', CommandHandlerService);;


var phone = require('../../../src/ctd/phone/general');

function CreateCallService($q, DesktopNotificationService, UrlService, FeatureService, LoginService) {

    var advancedCTD = {};

    FeatureService.on("advancedClickToDial", function (snap) {
        var feature = snap.val() || {};
        advancedCTD = feature || {};
    });

    this.dial = function(number, record, userData, controllerCallback) {
        window.chrome.setCommandHandler('originate', this.createCall.bind(this, controllerCallback, userData));
        userData.salesforceOpenCti = true;
        userData.localServiceCtd = advancedCTD.status === 'active' && !!_.get(advancedCTD, 'preferences.localServiceCtd');
        phone.dial(number, record, userData);
    };

    this.createCall = function(controllerCallback, userData, callData) {
        var self = this;
        if (!window.clickToDialLimiter) {
            self.rateLimitClickToDial();
            self.originateCall.call(self, callData, userData, controllerCallback);
        } else {
            callback('CTD limiter active');
        }
    };

    this.rateLimitClickToDial = function() {
        window.clickToDialLimiter = true;
        setTimeout(function () {
            window.clickToDialLimiter = false;
        }, 3000);
    };

    this.originateCall = function(callData, userData, controllerCallback) {

        if (!userData || !userData.extensions[0]) {
            DesktopNotificationService.notify('Click to Dial Failed', 'No extension configured');
            return controllerCallback('No extension configured');
        }

        if (!callData || !callData.phoneNumber) {
            DesktopNotificationService.notify('Click to Dial Failed', 'Invalid Phone Number Clicked');
            return controllerCallback('Call data missing a phoneNumber');
        }

        var customCallerId, organization = LoginService.getOrganization();
        if (_.get(organization, 'features.customCallerId.status') === 'active') {
            var user = LoginService.getUser();
            var orgAvailableCallers = _.get(organization, 'features.customCallerId.preferences.localNumbers', []);
            var userCustomCallerId = _.get(user, 'features.customCallerId.preferences.localNumber');
            customCallerId = userCustomCallerId && _.find(orgAvailableCallers, _.isEqual.bind(_, userCustomCallerId));
        }

        var params = {
            phoneNumber:          callData.phoneNumber,
            href:                 callData.href,
            record:               callData.id,
            module:               callData.module,
            extension:            userData.extensions[0],
            token:                userData.token,
            useLocalNumber:       callData.useLocalNumber,
            voicemailDrop:        callData.voicemailDrop,
            tenfoldNextRecord:    callData.tenfoldNextRecord
        };

        if (customCallerId) params.customCallerId = customCallerId;

        if (callData.callactivityid)
            params.callactivityid = callData.callactivityid;
        window.lastClickToDial = params;

        var url = UrlService.getApiBaseUrl() + userData.organizationId + '/phone_system/' + userData.token + '/originate';

        DesktopNotificationService.notify(callData.phoneNumber, 'Tenfold - ' + 'outbound call');

        $.post(url, params).done(originateCallSuccess).fail(originateCallFail);

        function originateCallSuccess(response) {
            controllerCallback(null, response);
        }

        function originateCallFail(jqXHR, textStatus, errorThrown) {
            var errorMsg = 'Failed to originate click to dial with the params ' +
                JSON.stringify(params) + 'responseText: ' + jqXHR.responseText +
                ' | textSatus: ' + textStatus + ' | errorThrown: ' + errorThrown;
            controllerCallback(errorMsg);
        }
    };
}

angular.module('callinize').service('CreateCallService', CreateCallService);
;


function CreateRecordService($q, CallService, FirebaseModel, OpenCTIService, extensionHost, uuid) {

	var listeners = {};

	this.create = function (recordName, phone, recordType) {
        var activeCall = CallService.getCurrentCall();
        return CallService.createRecord(recordName, phone, recordType).then(function (item) {
			if(!item) throw new Error("Error creating " + recordType + ", contact support if the error persists");
			return typeof(item) === 'string' ? createThroughUrl(item, activeCall, recordName, recordType, phone) : item;
		}).then(
            this.associateRecordWithCall.bind(this, phone),
            function(error) {
                console.error('error on createRecordService.create', error);
                throw new Error(error);
            }
        );
	};

	this.associateRecordWithCall = function (phone, record) {
        var activeCall = CallService.getCurrentCall();

        var addNumberPromise = record.createdThroughUrl ? $q.when() : CallService.addNumber(record, phone, activeCall.id);
        var setMatchedRecordsPromise = CallService.setMatchedRecords([record]).then(function (calls) {
            var call = calls[0] || {};
            if(call.matchedCrmRecords && call.matchedCrmRecords.length){
                updateFirebase(call);
            }
            // the record needs to have more than 3 fields to be considered valid
            return _.size(record) > 3 ? record : call.matchedCrmRecords[0];
        });

        return $q.all([addNumberPromise, setMatchedRecordsPromise]).then(function (results) {
            return results && results[1];
        });
	};
    function createThroughUrl(url, call, recordName, recordType, phone) {
        return OpenCTIService.createThroughUrl(url, call, recordName, recordType, phone);
    }

	function updateFirebase(call) {
		FirebaseModel
			.fromUser('calls/history/' + call._id + '/matchedCrmRecords')
			.set(call.matchedCrmRecords);
	}

	extensionHost.addListener && extensionHost.addListener("createResourceFinished", function (message) {
		var promise = listeners[message.id];
		delete listeners[message.id];
		promise && (message.recordId && promise.resolve(message) || promise.reject());
	});

}

angular.module('callinize').service("CreateRecordService", CreateRecordService);
;


function CustomWorkflowService($http, UrlService) {

    var CREATE_RECORD = '/custom-workflow/record';

    this.createRecord = function (callId, module, fields, variable) {
        var params = {
            module: module,
            fields: fields,
            variable: variable
        };

        return $http
            .post(appendUrl(CREATE_RECORD, callId), params, {withCredentials: false})
            .then(unwrap);
    };

    function appendUrl (url, callId) {
        return UrlService.getApiBaseUrlV1() + "/calls/" + callId + url ;
    }

    function unwrap (response) {
        return response.data;
    }

}

angular.module('callinize').service('CustomWorkflowService', CustomWorkflowService);;


function DesktopNotificationService() {

    this.notify = function(title, message, img) {

        var id = Math.floor((Math.random() * 1000) + 1);
        id = 'id' + id;

        function creationCallback(notID) {
            log('info', 'Succesfully created ' + id + ' notification');
        };

        if (typeof(message) === "object") {
            title = message.title;
            img = message.img;
            message = message.message;
        }

        var options = {
            title: title || 'Tenfold Notification'
        };

        //use HTML5 Notifications in testing mode
        options.icon = img || 'img/icon66.png';
        options.body = message;

        if (!("Notification" in window)) {
            console.warn("This browser does not support desktop notifications");
        } else if (Notification.permission === "granted") {
            // If it's okay let's create a notification
            var notification = new Notification(title, options);
        } else if (Notification.permission !== 'denied') {
            Notification.requestPermission(function (permission) {
                if (permission === "granted") {
                    var notification = new Notification(title, options);
                }
            });
        }
        return id;
    }
}

angular.module('callinize').service('DesktopNotificationService', DesktopNotificationService);
;


function DispositionsService($http, $q, $httpParamSerializer, UrlService, LoginService, CallService) {

	var URL = '/new-dispositions';
	var calls = '/calls/{id}';
	var ID = '{id}';

	this.getDispositions = function (params) {
		var call = CallService.getCurrentCall();
		return fetchDispositions(call, params);
	};

	this.setDispositions = function(dispositions) {
		var call = CallService.getCurrentCall();
		var callId = call && call.id;
		return $http.post(getBase() + buildUrl(calls, callId), {
			dispositions : dispositions
		})
		.then(function(config) {
			return config.data;
		});
	};

	function fetchDispositions(call, params) {
		var callId = call && call.id;
		return $http.get(getBase() + buildUrl(calls, callId, params), {withCredentials: false})
				.then(function(config) {
				var dispositions = config.data;
				if(dispositions && dispositions.error)
					return $q.reject(new Error(dispositions.error));
				return dispositions;
			});
	}

	function buildUrl(url, id, params) {
		url = url.replace(ID, id) + URL;
		if (params) {
            url += '?' + $httpParamSerializer(params)
		}
		return url;
	}

	function getBase(){
		var organization = LoginService.getUser().organizationId;
		return UrlService.getApiBaseUrl() + organization;
	}

	function appendUrl (url) {
		return UrlService.getApiBaseUrl() + LoginService.getUser().organizationId + url;
	}

}

angular.module('callinize').service('DispositionsService', DispositionsService);
;


'use strict';

function ExtensionHost($q, $rootScope, $log, $timeout, utils) {

    var manifest = chrome.runtime.getManifest();
    var details  = chrome.app.getDetails();

    var appInfo  = manifest || details;
    this.app = {
        meta:      function () {
            return {
                chrome_extension: true,
                version:          appInfo.version,
                current_locale:   appInfo.current_locale,
                default_locale:   appInfo.default_locale
            };
        },
        details:   appInfo,
        getLocale: function () {
            return chrome.i18n.getMessage("@@ui_locale");
        }
    };

    var messageHandlers = {
    };

    function mainMessageHandler(request, sender, sendResponse) {

        var responseCallbackPreserved = false;
        var handlers = messageHandlers[request.command];

        handlers && handlers.forEach(run);

        function run(method) {
            try {
                var response = method(request, sender, sendResponse);
                if (response === true) {
                    responseCallbackPreserved = true;
                }
                return response;
            } catch(e){
                $log.error("Exception while calling message handler for " + request.command, e);
            }
        }

        return responseCallbackPreserved;
    }

    // receives a message from the Chrome extension
    var onMessage = _.get(chrome, "runtime.onMessage");
    onMessage && chrome.runtime.onMessage.addListener(mainMessageHandler);

    this.addListener = function (name, handler) {
        messageHandlers[name] = messageHandlers[name] || [];
        messageHandlers[name].push(handler);
    };

    this.offListener = function (name, handler) {
        messageHandlers[name] = _.without(messageHandlers[name], handler);
    };

    this.notifications = {
        create: function (title, message, img) {
            var defer = $q.defer();
            var id = Math.floor((Math.random() * 1000) + 1);
            img = img || 'img/icon66.png';
            var options = {
                eventTime: Date.now() + 2000,
                iconUrl:   chrome.extension.getURL(img),
                message:   message,
                priority:  0,
                title:     title,
                type:      'basic'
            };

            //When in chrome wrapper we use the chrome extension desktop notifications,
            //because they do not require the user to give permission, since, they gave
            //permission during install of the extension
            if (!utils.isLoadedOutsideChromeExtensionWrapper()) {
                options.command = "showDesktopNotification";
                chrome.runtime.sendMessage(options, function (response) {
                    if (chrome.runtime.lastError) {
                        $log.error(chrome.runtime.lastError);
                    }
                    defer.resolve();
                });
            } else {
                chrome.notifications.create('id' + id, options, function (id) {
                    function apply() {
                        defer.resolve(id);
                    }

                    if ($rootScope.$$phase) {
                        apply();
                    } else {
                        $rootScope.$apply(apply);
                    }
                });
            }

            return defer.promise;
        }
    };

    this.tabs = {
        create: function (params, callback) {
            params = typeof(params) === "string" ? { url : params } : params;
            chrome.runtime.sendMessage({
                command : "openTab",
                params : params
            }, callback);
        }
    };

    this.sendMessage = function (message, callback) {
        try{
            chrome.runtime.sendMessage(message, callback && responseHandler);
        } catch(e){
            console.error("Error while post message to background. ", e);
            window.parent.postMessage("__REMOVE__", '*');
            throw e; // Must throw to stop angular stack, otherwise chrome crashes
        }

        function responseHandler(response) {
            if(chrome.runtime.lastError){
                console.log(chrome.runtime.lastError);
            }
            callback && callback(response);
        }
    };
}

angular.module('callinize').service('extensionHost', ExtensionHost);
;


function ExtensionService($http, UrlService) {

    this.getExtensions = function() {
        var url = buildUrl();
        return $http.get(url).then(unwrap).then(function(extensions) {
            return _.get(extensions, 'extensions', []);
        });
    };

    function buildUrl() {
        return UrlService.getApiBaseUrlV1() + '/extensions/';
    }

    function unwrap(response) {
        return response && response.data;
    }
}

angular.module('callinize').service("ExtensionService", ExtensionService);
;



function FeatureService (FirebaseModel) {
    var featureOrganizationModel = FirebaseModel.fromOrganization("features");
    var featureUserModel = FirebaseModel.fromUser("features");
    var orgFeatures = {};
    var userFeatures = {};
    var listeners = [];

    var ACTIVE = "active";
    var INACTIVE = "inactive";

    featureOrganizationModel.on('value', function(featureSnap) {
        orgFeatures = featureSnap.val() || {};
        fireEvent('value');
    });

    featureUserModel.on('value', function(featureSnap) {
        userFeatures = featureSnap.val() || {};
    });

    this.isEnabled = function(name, defaultsToHide) {
        var status = this.getFeature(name).status;
        return defaultsToHide ? isEnabled(status) : isNotDisabled(status);
    };

    this.hasFeatureEnabled = function(name) {
        var feature = this.getFeature(name);
        return feature && isEnabled(feature.status);
    };

    this.getFeature = function(name) {
        return userFeatures[name] || orgFeatures[name] || {};
    };

    this.on = function (name, handler) {
        var featureOrganization = featureOrganizationModel.child(name);
        var featureUser = featureUserModel.child(name);
        var isUserFeature;

        featureOrganization.on('value', onOrgFeature);
        featureUser.on('value', onUserFeature);

        function onUserFeature(featureSnap) {
            var feature = featureSnap.val();
            isUserFeature = !!feature;
            return isUserFeature && handler(featureSnap);
        }

        function onOrgFeature(featureSnap) {
            var feature = featureSnap.val();
            return !isUserFeature && feature && handler(featureSnap);
        }

        return function unbindFeatures() {
            featureOrganization.off('value', onOrgFeature);
            featureUser.off('value', onUserFeature);
        };
    };

    this.onUserFeature = function(name, handler) {
        return this._onEntityFeature(featureUserModel, name, handler);
    };

    this.onOrganizationFeature = function(name, handler) {
        return this._onEntityFeature(featureOrganizationModel, name, handler);
    };

    this._onEntityFeature = function(model, name, handler) {
        var feature = model.child(name);
        feature.on('value', onFeature);

        function onFeature(featureSnap) {
            return handler(featureSnap);
        }

        return function unbindFeatures() {
            feature.off('value', onFeature);
        };
    };

    this.getModel = function () {
        return featureOrganizationModel;
    };

    function isEnabled(status) {
        return status === ACTIVE;
    }

    function isNotDisabled(status) {
        return status !== INACTIVE;
    }

    this.addListener = function(eventType, callback) {
        if (!listeners[eventType]) {
            listeners[eventType] = [];
        }
        listeners[eventType].push(callback);
    };

    this.removeListener = function(eventType, listener) {
        var eventListeners = listeners[eventType];
        if (eventListeners && eventListeners.length && eventListeners.indexOf(listener) > -1) {
            eventListeners.splice(eventListeners.indexOf(listener), 1);
        }
    };

    function fireEvent(eventType, value) {
        if (listeners[eventType] && listeners[eventType].length) {
            var eventListeners = listeners[eventType];
            _.forEach(eventListeners, function(listener) {
                listener(value);
            });
        }
    }
}

angular.module("callinize").service('FeatureService', FeatureService);
angular.module("callinize").run(['FeatureService', function() {}]);;


function FirebaseModel ($firebaseObject, $firebaseArray, LoginService, FirebaseRef, FirebaseProxy) {

	this.get = function getObject (propertyName) {
		return $firebaseObject(FirebaseRef.child(propertyName));
	}

	this.getArray = function getArray (propertyName) {
		return $firebaseArray(FirebaseRef.child(propertyName));
	}

	this.fromUser = function fromUser (propertyName) {
		return new FirebaseProxy(function() {
			return $firebaseObject(FirebaseRef.child('users/' + LoginService.getUserId() + '/' + propertyName));
		});
	}

	this.fromUserArray = function fromUserArray (propertyName) {
		return new FirebaseProxy(function() {
			return $firebaseArray(FirebaseRef.child('users/' + LoginService.getUserId() + '/' + propertyName));
		});
	}

	this.fromOrganization = function fromOrganization (propertyName) {
		return new FirebaseProxy(function() {
			var user = LoginService.getUser();
			var id = user && user.organizationId;
			return $firebaseObject(FirebaseRef.child('organizations/' + id + '/' + propertyName));
		});
	}

	this.fromOrganizationArray = function fromOrganizationArray (propertyName) {
		return new FirebaseProxy(function() {
			var user = LoginService.getUser();
			var id = user && user.organizationId;
			return $firebaseArray(FirebaseRef.child('organizations/' + id + '/' + propertyName));
		});
	}

}

angular.module('callinize').service('FirebaseModel', FirebaseModel);
;


function FirebaseProxy($q, $firebaseObject, LoginService) {

	var deferred = $q.defer();
	var promise = deferred.promise;

	LoginService.onAuth(function() {
		deferred.resolve();
	});

	LoginService.onLogout(function() {
		promise = $q.Deferred();
	});

	function FirebaseProxy(handler) {

		this.on = function on() {
			var args = arguments;
			promise.then(function() {
				var firebaseRef = handler();
				var ref = firebaseRef.$ref();
				ref.on.apply(ref, args);
			});
		}

		this.once = function once() {
			var args = arguments;
			promise.then(function() {
				var firebaseRef = handler();
				var ref = firebaseRef.$ref();
				ref.once.apply(ref, args);
			});
		}

		this.off = function off() {
			var args = arguments;
			promise.then(function() {
				var firebaseRef = handler();
				var ref = firebaseRef.$ref();
				ref.off.apply(ref, args);
			});
		}

		this.child = function child(child) {
			return new FirebaseProxy(function () {
				return $firebaseObject(handler().$ref().child(child));
			});
		}

		this.set = function set() {
			var args = arguments;
			promise.then(function() {
				var firebaseRef = handler();
				var ref = firebaseRef.$ref();
				ref.set.apply(ref, args);
			});
		}

		this.transaction = function transaction() {
			var args = arguments;
			promise.then(function() {
				var firebaseRef = handler();
				var ref = firebaseRef.$ref();
				ref.transaction.apply(ref, args);
			});
		}

		this.$bindTo = function $bindTo () {
			var args = arguments;
			promise.then(function() {
				var firebaseRef = handler();
				firebaseRef.$bindTo.apply(firebaseRef, args);
			});
		}
	}

	return FirebaseProxy;
}

angular.module('callinize').service('FirebaseProxy', FirebaseProxy);
;


function FirebaseRef(FIREBASE_URL) {
	var firebaseRef = new Firebase(FIREBASE_URL);
	return firebaseRef;
}

angular.module("callinize").service('FirebaseRef', FirebaseRef);
;


function HistoryService($timeout, extensionHost, FirebaseRef, CallService, UserService) {

    var userId = UserService.user.id;
    var historyOrdered = FirebaseRef.child('users/' + userId + '/calls/history').orderByChild("startTime");
    var historyRef = historyOrdered.limitToLast(20);
    var historyAddedLast = historyOrdered.limitToLast(1);

    var historyCache = {};

    var history;
    var onChild = [];
    var onChildAdded = [];
    var onValue = [];
    var onNewCount = [];
    var self = this;

    historyRef.once('value', function(historySnap) {
        historyCache = _.assign(historyCache, historySnap.val());
        onHistoryValue(historyCache);
    });

    historyAddedLast.on('child_changed', function(historySnap) {
        var history = historySnap.val();
        addHistory(history);
        onHistoryChildChanged(history);
    });

    historyAddedLast.on('child_added', function(historySnap) {
        var history = historySnap.val();
        if(historyCache[history.id])
            updateHistory(history)
        else {
            addHistory(history);
            onHistoryChildAdded(history);
        }
    });

    this.getHistory = function (callback) {
        callback(historyCache);
    };

    this.getLastCall = function (callback, recordId) {
        if (recordId) {
            history = _.filter(historyCache, function (item) {
                return item.matchedCrmRecords && item.matchedCrmRecords.length === 1 && item.matchedCrmRecords[0].bean_id === recordId;
            });
        }
        callback(_.sortBy(cleanHistory(history), 'startTime').pop());
    };

    this.onChild = function (callback) {
        onChild.push(callback);
    };

    this.onChildAdded = function (callback) {
        onChildAdded.push(callback);
    };

    this.onValue = function (callback) {
        onValue.push(callback);
    };

    this.onNewCount = function (callback) {
        onNewCount.push(callback);
    };

    this.off = function (event, callback) {
        if(event === 'value')
            onValue = _.without(onValue, callback);
        if(event === 'child')
            onChild = _.without(onChild, callback);
        if(event === 'added')
            onChildAdded = _.without(onChildAdded, callback);
    };

    this.triggerOnNewCount = function(value) {
        onNewCount.forEach(function (handler) {
            handler(value);
        });
    };

    function addHistory(item) {
        updateHistory(item);
    };

    function updateHistory(item) {
        historyCache[item.id] = item;
    };

    function cleanHistory(history) {
        var active = CallService.getCurrentCall() || {};
        return _.filter(history, function (item) {
            return     item
                    && item.id
                    && !item._read
                    && !item.deleted
                    && !item.answeredBySomeoneElse
                    && item.id !== active.id;
        });
    };

    function updateNew() {
        var notRead = cleanHistory(history);
        self.triggerOnNewCount(notRead.length);
    };

    function onHistoryChildChanged(history) {
        updateNew();
        onChild.forEach(function (callback) {
            callback(history);
        });
    };

    function onHistoryChildAdded(history) {
        updateNew();
        onChildAdded.forEach(function (callback) {
            callback(history);
        });
    };

    function onHistoryValue(history) {
        updateNew();
        onValue.forEach(function (callback) {
            callback(history);
        });
    };
}

angular.module('callinize').service('HistoryService', HistoryService);
;


function LoginService($q, $http, $timeout, $window, $log, Auth, FirebaseRef, isDevMode, DASHBOARD_URL) {

    var user;
    var organization;
    var token = localStorage.getItem('__token__');
    var onLogin = [];
    var onLoginError = [];
    var onLogout = [];
    var self = this;

    this.setToken = function setToken(_token) {
        if (!_token) {
            var promise = $.defer;
            promise.reject("_token passed to setToken is empty");
            return promise.promise;
        }
        //this.isLogged() && token !== _token && logout();
        console.log('LoginService token received', _token);
        token = _token;
        localStorage.setItem('__token__', token);

        //through FB direct
        var promise = Auth.$authWithCustomToken(token);
        promise.catch(runOnLoginError);
        return promise;
    }

    this.login = function(username, password) {
        var url = DASHBOARD_URL + "/login";
        var params = {
            api: "true",
            password: password,
            username: username
        };
        return $http.post(url, params).then(function (response) {
            return response.data;
        });
    }

    this.isLogged = function isLogged() {
        if (!user) {
            try {
                user = JSON.parse(localStorage.getItem('fb_tenfold_user'));
            } catch (e){}
        }
        var yes = user && user.id && user.organizationId;
        return yes;
    }

    this.getUserId = function getUserId() {
        !this.isLogged() &&
        $log.error(new Error("Called LoginService.getUserId before login"), user);
        return user && user.id;
    }

    this.getUser = function getUser() {
        !this.isLogged() && $log.error(new Error("Called LoginService.getUser before login"), user);
        return user;
    }

    this.updateUser = function (updatedUser) {
        if (updatedUser) {
            user = updatedUser;
            localStorage.setItem('fb_tenfold_user', JSON.stringify(user));
        }
    };

    this.getOrganization = function getOrganization() {
        !this.isLogged() &&
        $log.error(new Error("Called LoginService.getOrganization before login"), organization);
        return organization;
    }

    this.onAuth = function (callback, errCb) {
        onLogin.push(callback);
        if (errCb) {
            onLoginError.push(errCb);
            user && !isValid(user) && $timeout(errCb.bind(null, "Invalid user"));
        }
        if (this.isLogged()) {
            $timeout(callback.bind(null, user));
        }
    };

    this.onLogout = function (callback) {
        onLogout.push(callback);
    };

    function onAuth(authData) {
        authData && loadUser(authData);
    }

    function loadUser(authData) {
        if (self.isLogged()) {
            return;
        }

        if (isChromeLoaded()) {
            if (user) onUserCallback(user);
        } else {
            FirebaseRef.child('users/' + authData.uid).once('value', function (userSnap) {
                user = userSnap.val();
                userSnap.val() && onUserCallback(user);
            }, function (error) {
                $log.error("Error while getting the user: ", authData, error.message);
                runOnLoginError(error);
            });
        }

        function onUserCallback(user) {
            if (authData && authData.uid) {
                user.id = authData.uid;
                localStorage.setItem('fb_tenfold_user', JSON.stringify(user));
            }
            $http.defaults.headers.common.Authorization = 'Basic ' + btoa(user.token + '0');
            getOrganizationId(user, getOrganization);
        }

        return true;
    }

    function getOrganization() {
        if (isChromeLoaded()) {
            user && onUserCallback(user);
            user && successCallback(localStorage.get('fb_tenfold_organization'));
        } else {
            var url = 'organizations/' + user.organizationId;
            user && FirebaseRef.child(url).once('value', function (organizationSnap) {
                if (organizationSnap && organizationSnap.val()) {
                    successCallback(organizationSnap.val());
                } else {
                    console.error('invalid organization ' + user.organizationId);
                }
            }, function (error) {
                var message = user.organizationId ? "Error while getting the organization: "
                    : "No organizationId not set on user";
                $log.error(message, user, error.message);
                runOnLoginError(error);
            });
        }

        function successCallback(org) {
            organization = org;
            organization.id = user.organizationId;
            runOnLogin(user);
        }
    }

    function getOrganizationId(user, callback) {
        if (user.organizationId) {
            return callback();
        }

        toastr.error("No organization provided for your user");
        var url = "https://api.callinize.com/v1/users/" + user.id + "/sync?token=" + user.token;
        return $http.post(url).then(function (config) {
            config.data.uid = config.data._id;
            config.data.id = config.data.id || config.data._id;
            loadUser(config.data);
        });
    }

    function runOnLogin(user) {
        $http.defaults.headers.common.Authorization = 'Basic ' + btoa(user.token + '0');
        console.log('runOnLogin', user);
        if(!isValid(user)){
            runOnLoginError("User data missing, please contact support");
        }
        onLogin.forEach(function (handler) {
            handler(user);
        });
    }

    function isValid(user) {
        var defaultKeys = ["organizationId", "id", "username", "token"]
        return user && _.every(defaultKeys, function (key) {
            return user[key];
        });
    }

    function runOnLoginError(error) {
        onLoginError.forEach(function (handler) {
            handler(error);
        });
    }

    function logout(preventSendMessage) {
        Auth.$unauth();
        console.log('[LoginService logout] logging out of user and deleting localStorage', user);
        delete user;
        delete localStorage.fb_tenfold_user;
        delete localStorage.__token__;
        onLogout.forEach(function (handler) {
            handler();
        });

        if (chrome && chrome.runtime && chrome.runtime.sendMessage && preventSendMessage) {
            chrome.runtime.sendMessage({
                command: 'logout'
            });
        }
        setTimeout(function () {
            console.warn("Reload after logout");
            window.location.reload();
        }, 1000);
    }

    function isChromeLoaded() {
        return !isDevMode;
    }

    if (chrome && chrome.runtime && chrome.runtime.onMessage) {
        chrome.runtime.onMessage.addListener(function (request, sender, sendResponse) {
            request.LOGOUT && logout(true);
        });
    }

    user = JSON.parse(localStorage.getItem('fb_tenfold_user'));
    if (!isChromeLoaded()) {
        Auth.$onAuth(onAuth);
        user && runOnLogin(user);
    } else {
        if(!user) return;
        user.uid = user.id;
        runOnLogin(user);
    }
}

angular.module("callinize").service("LoginService", LoginService);
;


'use strict';

/**
 * @ngdoc service
 * @name callinize.NLPDate
 * @description
 * # NLPDate
 * Provider in the callinize.
 */
angular.module('callinize').service('NLPDate', function (FeatureService, logger, extensionHost) {

    var log = logger('NLPDate');
    var localCode;

    // Public API for configuration
    this.setLocalCode = function (s) {
        localCode = s;
    };

    function _arrToCapGrp(arr, isNonCapturing) {
        var s = "(";
        if (isNonCapturing === true) {
            s += "?:";
        }
        for (var i = 0; i < arr.length; i++) {
            s += arr[i];
            if (i < arr.length - 1) {
                s += "|";
            }
        }
        s += ")";
        return s;
    }

    // Method for instantiating
    // this.$get = function (extensionHost) {
    var locale = localCode ? localCode : extensionHost.app.getLocale();
    return new NLPDate(locale);
    // };
});
;


'use strict';

angular.module('callinize').service('NoteService',
    function ($http, NLPDate, OrganizationService, CallService, FeatureService) {

    var localDescriptionPromises = {};

    this.parse = function (value) {
        value = value || "";
        var enabled = FeatureService.isEnabled("atMentionSyntax");
        return parseMentions(value).then(function (users) {
            var task = FeatureService.isEnabled('nlpFollowup') ? NLPDate.extract(value) : undefined;
            return {
                users: enabled && users,
                taskDate: task
            };
        });
    };

    this.getNote = function (callId) {
        return CallService.fetchCall(callId).then(function (call) {
            return call && call.description;
        });
    }

    this.save = function (note, subject, dispositions, followUp, callId, forceCreateCallOrTask) {
        return this.parse(note).then(
        function (results) {

            var taskDate = followUp || results.taskDate;
            var users = results.users;
            var mentions = _.pluck(users, 'username').join(' ');
            var notifyUsers = _.pluck(users, 'id');

            return CallService.saveNote({
                description: note,
                subject: subject,
                mentions: mentions,
                dispositions: dispositions,
                action: 'setDescription',
                notifyUsers: notifyUsers,
                taskDate: taskDate,
                callId: callId,
                url: location.href,
                forceCreateCallOrTask: forceCreateCallOrTask
            });
        });
    };

    function cleanUpNote(note) {
        return (note || "").replace(/\./g, "").replace(/\,/g, "").replace(/\;/g, "").replace(/\:/g, "");
    }

    function parseMentions(note) {
        return OrganizationService.getUsers().then(function (list) {

            var nicks = cleanUpNote(note).match(/@([^\s]*)/g) || [];

            // TODO : https://github.com/callinize/callinize-chrome-extension/issues/335
            return _.filter(list, function (user) {
                var cleaned = '@' + cleanUpNote(user.username);
                return nicks.indexOf(cleaned) !== -1;
            });

        });
    }
});
;


;


function LightningOpenCTI() {

    if(!sforce || !sforce.opencti) {
        throw new Error('Lightning OpenCTI library not loaded');
    }

    var self = this;

    this.providerType = 'lightning';
    this.defaultSoftphoneHeight = 665;
    this.defaultSoftphoneWidth = 250;

    this.setupCTI = function(settings) {
        sforce.opencti.setSoftphonePanelHeight({heightPX: this.defaultSoftphoneHeight});
        sforce.opencti.setSoftphonePanelWidth({widthPX: this.defaultSoftphoneWidth});
        sforce.opencti.setSoftphoneItemLabel({label: 'Tenfold'});
        sforce.opencti.setSoftphonePanelLabel({label: 'Tenfold'});
        sforce.opencti.onClickToDial({
            listener: function(result) {
                settings.onClickToDial(result.number, result.recordId, result.objectType)
            }
        });

    }

    this.checkConsolePhoneVisibility = function() {
        var setPhoneVisible = function() {
            sforce.opencti.setSoftphonePanelVisibility({
                visible: true,
            });
        };
        var callback = function(result) {
            if (!result.success) return;
            var isVisible = result.returnValue.visible;
            if (!isVisible)
                setPhoneVisible();
        };
        sforce.opencti.isSoftphonePanelVisible({callback: callback});
    }

    this.enableClickToDial = function() {
        sforce.opencti.enableClickToDial();
    }

    this.disableClickToDial = function() {
        sforce.opencti.disableClickToDial();
    }

    this.openRecordLink = function(url, recordId, recordName, editMode) {
        if (sforce && sforce.console.isInConsole() && isValidCrmId(recordId)) {
            var tabMode = '/view';
            if (editMode) {
                tabMode = '/edit';
            }
            window.parent.document.location.hash = '#/sObject/' + recordId + tabMode;
            if(isInternetExplorer()) forceReload();
        } else {
            window.open(url, '_blank');
        }
    };

    this.openCustomLink = function(url, recordName) {
        var index = url.indexOf('#');
        if (sforce && sforce.console.isInConsole() && index > -1) {
            var hash = url.substring(index);
            window.parent.document.location.hash = hash;
        } else {
            window.open(url, recordName);
        }
    };

    var createRecordListener = null;
    this.createThroughUrl = function(url, call, recordName, recordType, phoneNumber, promise) {
        recordType = recordType[0].toUpperCase() + recordType.substring(1);
        var params = { entityName: recordType };
        sforce.opencti.screenPop({
            type: sforce.opencti.SCREENPOP_TYPE.NEW_RECORD_MODAL,
            params: params,
            // defaultFieldValues: { FirstName: recordName }, // tried but didnt work
            callback: openModalCallback,
        });
        var currentUrl = getUrl();
    
        function openModalCallback(response) {
            if (response.success) {
                createRecordListener && createRecordListener.stopListening();
                createRecordListener = new buildCreateRecordListener();
                sforce.opencti.onNavigationChange({ listener: createRecordListener.fn });
            } else {
                promise.reject('ERROR_OPENING_MODAL');
            }
        }

        // this pattern is necessary to avoid multiple listener
        function buildCreateRecordListener() {
            var stopListening = false;
            this.stopListening = function() { stopListening = true; };

            this.fn = function(payload) {
                if(stopListening || payload.url === currentUrl) return;
                stopListening = true;

                if(!payload || !payload.recordId || payload.objectType !== recordType) return promise.reject('MODAL_CLOSED');

                return promise.resolve({
                    bean_name: payload.recordName,
                    bean_id: payload.recordId,
                    bean_link: payload.url,
                    bean_module: recordType
                });
            };
        }
    }
    /**
     * 
     * @param string recordId 
     */
    function isValidCrmId(recordId) {
        return new RegExp("^([a-zA-Z0-9]{15}|[a-zA-Z0-9]{18})$").test(recordId);
    }

    function checkShouldOpenCTI() {
        try {
            var item = localStorage.getItem('open_cti_default_to_open');
            if(!item || item !== 'true') return;
            localStorage.removeItem('open_cti_default_to_open');

            setTimeout(self.checkConsolePhoneVisibility.bind(self), 10);
        } catch(e) {
            console.log('error in checkShouldOpenCTI', e);
        }
    }

    function isInternetExplorer() {
        return (
            navigator.appName == 'Microsoft Internet Explorer' ||
            !!(navigator.userAgent.match(/Trident/) || navigator.userAgent.match(/rv:11/)) ||
            (window.$ && typeof $.browser !== "undefined" && $.browser.msie == 1)
        );
    }

    function forceReload() {
        localStorage.setItem('open_cti_default_to_open', 'true');
        window.parent.document.location.reload();
    }

    function getUrl() {
        try {
            return window.parent.document.location.href;
        } catch(e) { return '' }
    }

    checkShouldOpenCTI();
}
;


function OpenCTIService($q) {

    this.provider = null;

    this.loadProvider = function() {
        if (this.isLightningView()) {
            this.provider = new LightningOpenCTI();
        } else {
            this.provider = new SalesforceOpenCTI();
        }
    };

    this.setupCTI = function(settings) {
        this.provider.setupCTI(settings);
    };

    this.checkConsolePhoneVisibility = function() {
        this.provider.checkConsolePhoneVisibility();
    };

    this.enableClickToDial = function() {
        this.provider.enableClickToDial();
    };

    this.disableClickToDial = function() {
        this.provider.disableClickToDial();
    };

    this.createThroughUrl = function(url, call, recordName, recordType, phone, promise) {
        var promise = $q.defer();

        if(this.provider && this.provider.createThroughUrl) {
            this.provider.createThroughUrl(url, call, recordName, recordType, phone, promise);
        } else {
            promise.reject('NO_PROVIDER');
        }

        return promise.promise;
    };

    this.createThroughUrlNextSteps = function() {
        var promise = $q.defer();

        if(this.provider && this.provider.createThroughUrlNextSteps) {
            this.provider.createThroughUrlNextSteps(promise);
        } else {
            promise.resolve(false);
        }

        return promise.promise;
    }
    
    this.isLightningView = function () {
        var host = window.location.host;
        return !!host.match(/([\w\-\_]+\.)*(lightning\.force)\.com/i);
    };

    this.loadProvider();
}

angular.module("callinize")
	.service("OpenCTIService", OpenCTIService);
;


function SalesforceOpenCTI() {

    if(!sforce || !sforce.interaction || !sforce.interaction.cti)
        throw new Error('Salesforce OpenCTI library not loaded');

    this.providerType = 'salesforce';
    this.defaultSoftphoneHeight = 630;
    this.defaultSoftphoneWidth = 250;

    this.setupCTI = function(settings) {
        sforce.interaction.cti.setSoftphoneHeight(this.defaultSoftphoneHeight);
        sforce.interaction.cti.setSoftphoneWidth(this.defaultSoftphoneWidth);
        sforce.interaction.cti.onClickToDial(function(response) {
            if (!response.result) {
                alert('Error during clickToDial!');
                return;
            }
            var result = JSON.parse(response.result);
            settings.onClickToDial(result.number, result.objectId, result.object);
        });
    }

    this.checkConsolePhoneVisibility = function() {
        if(!sforce || !sforce.console.isInConsole())
            return;
        sforce.console.isCustomConsoleComponentHidden(function(result) {
            if(result.hidden) {
                sforce.console.setCustomConsoleComponentVisible(true, function(result) {});
            }
        });
    }

    this.enableClickToDial = function() {
        sforce.interaction.cti.enableClickToDial();
    }

    this.disableClickToDial = function() {
        sforce.interaction.cti.disableClickToDial();
    }

    this.openRecordLink = function(url, recordId, recordName, editMode) {
        openLinkInConsoleTab(url, false, recordId, recordName, editMode);
    }

    this.openCustomLink = function(url, recordName) {
        openLinkInConsoleTab(url, true, null, recordName);
    }

    this.createThroughUrl = function(url, call, recordName, recordType, phoneNumber, promise) {
        recordType = recordType[0].toUpperCase() + recordType.substring(1);
        localStorage.setItem('open_cti_create_through_url', JSON.stringify({
            callId: call.id,
            recordName: recordName,
            phoneNumber: phoneNumber,
            recordType: recordType
        }));

        window.open(url, '_top'); // will reload current page
    };


    this.createThroughUrlNextSteps = function(promise) {
        try {
            var item = localStorage.getItem('open_cti_create_through_url');
            if(!item) return;

            localStorage.removeItem('open_cti_create_through_url');
            var record = JSON.parse(item);

            if(!record.step2) {
                record.step2 = true;
                localStorage.setItem('open_cti_create_through_url', JSON.stringify(record));
                window.spinner.show('Creating ' + record.recordType + ' ' + record.recordName + ' for ' + record.phoneNumber + '...');

                promise.resolve(false);
            } else {
                getRecordInfo(record, promise);
            }
        } catch(e) {
            console.log('error in checkShouldSetCreatingRecordMode', e);
        }
    }
    function getRecordInfo(record, promise) {
        sforce.interaction.getPageInfo(function (response) {
            var result = response.result;
            if (result) {
                result = JSON.parse(result);
                if(result.objectId && result.object === record.recordType) {
                    result.phoneNumber = record.phoneNumber;
                    promise.resolve(result);
                } else {
                    promise.resolve(false);
                }
            } else {
                promise.resolve(false);
            }
        });
    }

    function openLinkInRegularView(url, name) {
        window.open(url, name || '_blank').focus();
    }

    function openLinkInConsoleTab(url, forceUrl, recordId, recordName, editMode) {
        if(sforce && sforce.console.isInConsole()) {
            var _recordName = recordName || 'salesforce';
            var consoleUrl = forceUrl ? url : recordId;

            if (consoleUrl.charAt(0) !== '/') {
                consoleUrl = '/' + consoleUrl;
            }

            if (editMode) {
                consoleUrl += '/e';
            }
            try {                
                sforce.console.generateConsoleUrl([consoleUrl], function (result) {
                    if (result.success) {
                        var finalUrl = fixConsoleUrl(consoleUrl, result.consoleUrl);
                        sforce.console.openConsoleUrl(null, finalUrl, true, [_recordName], [''], function (result) {
                            if (!result.success) openLinkInRegularView(url);
                        });
                    } else {
                        openLinkInRegularView(url);
                    }
                });
            } catch (e) {
                console.error(e);
                openLinkInRegularView(url);
            }
        } else {
            openLinkInRegularView(url, recordId || recordName);
        }
    }

    function fixConsoleUrl(salesforceUrl, resultConsoleUrl) {
        var salesforceUrlParts = salesforceUrl.split('?');
        var parameterString = _.get(salesforceUrlParts, "1", "");
        var originalParameter = urlParameterToObject(parameterString);

        var hashConsoleUrl = _.get(resultConsoleUrl.split("#"), "1", "");
        var consoleUrlHash = _.get(decodeURIComponent(hashConsoleUrl).split('?'), "1", "");
        var consoleUrlParamters = urlParameterToObject(consoleUrlHash);

        var finalParameter = _.mapValues(_.omit(originalParameter, _.keys(consoleUrlParamters)), decodeURIComponent);
        var missingQuery = $.param(finalParameter);
        var finalUrl = resultConsoleUrl +( missingQuery ? "&" + missingQuery : "" );
        return finalUrl;
    }

    function urlParameterToObject(url) {
        return url && JSON.parse('{"' + decodeURI(url).replace(/"/g, '\\"').replace(/&/g, '","').replace(/=/g, '":"') + '"}');
    }
}
;


function OpenURLService (OpenCTIService, FeatureService) {

    this.openRecord = function(url, recordId, recordName, editMode) {
        if(shouldUseCustomLogic()) {
            this.openLinkWithCustomLogic(url, recordId);
        } else if(OpenCTIService.provider && OpenCTIService.provider.openRecordLink) {
            OpenCTIService.provider.openRecordLink(url, recordId, recordName, editMode);
        } else {
            this.openLinkInRegularView(url, recordId);
        }
    };

    this.openCustomLink = function(url, recordName) {
        if(OpenCTIService.provider && OpenCTIService.provider.openCustomLink) {
            OpenCTIService.provider.openCustomLink(url, recordName);
        } else {
            this.openLinkInRegularView(url, recordName);
        }
    };

    this.getPathFromUrl = function(url) {
        var a = document.createElement('a');
        a.href = url;
        return a.pathname + a.search;
    };

    this.openLinkInRegularView = function(url, name) {
        window.open(url, name || '_blank').focus();
    };

    this.openLinkWithCustomLogic = function(url, name) {
        var feature = FeatureService.getFeature('ctiAdvancedOpenLink');
        addOpenCtiPropOnStorage();
        switch(feature.preferences.openIn) {
            case 'sameTab':
                return this.openLinkInRegularView(url, '_top');
            case 'newTab':
            default:
                return this.openLinkInRegularView(url, name);
        }
    };

    function shouldUseCustomLogic() {
        if(!FeatureService.hasFeatureEnabled('ctiAdvancedOpenLink')) return false;

        var preferences = FeatureService.getFeature('ctiAdvancedOpenLink').preferences || {};
        return preferences.openIn === 'newTab' || preferences.openIn === 'sameTab';
    }

    function addOpenCtiPropOnStorage() {
        if(!OpenCTIService.provider || OpenCTIService.provider.providerType !== 'lightning') return;
        localStorage.setItem('open_cti_default_to_open', 'true');
    }
}

angular.module("callinize").service("OpenURLService", OpenURLService);
;



function OrganizationService ($http, $q, $httpParamSerializer, LoginService, UrlService) {

	var query 			= "{query}";
	var crmSearch 		= "/crm/search/" + query + "/";
	var users 			= "/users/";
	var branding        = "/branding/";

    function getUsers(self) {
		return _.throttle(function() {
			var promise = $http.get(appendUrl(users)).then(unwrapSuccess);
			promise.then(null, function () {
				self.getUsers = getUsers(self);
			});
			return promise;
		}, 900000);
	}

	this.getRecordByName = function getRecord (name, params) {
		return $http.get(appendUrl(crmSearch.replace(query, name), params)).then(unwrap);
	};

	this.getUsers = getUsers(this);

	this.syncUser = function(user) {
        var id = user.id || user._id;
		return $http.post(UrlService.getApiBaseUrlV1() + users + id + '/am-i-ok?token=' + user.token);
	};

	this.getBranding = function() {
        var orgId = getOrgId();
        var brandingCached = getLocalStorage('tenfold-branding') || {};
        var isCached = brandingCached.organizationId === orgId;
		return isCached ? $q.when(brandingCached) : fetchBranding(orgId);
	};

    function fetchBranding(orgId) {
        return $http.get(appendUrl(branding))
            .then(unwrap)
            .then(function (brand) {
                brand.organizationId = orgId;
                localStorage.setItem('tenfold-branding', JSON.stringify(brand));
                return brand;
            });
    }

    function getLocalStorage(item) {
        try {
            return JSON.parse(localStorage.getItem(item));
        } catch(e){}
    }

	function appendUrl (url, params) {
		url = UrlService.getApiBaseUrl() + getOrgId() + url;
		if (params) {
			url += '?' + $httpParamSerializer(params);
		}
		return url;
	}

    function getOrgId() {
        return LoginService.getUser().organizationId;
    }

	function unwrap (response) {
		return response.data;
	}

	function unwrapSuccess (response) {
		return response.data && response.data.success;
	}

}

angular.module("callinize")
	.service("OrganizationService", OrganizationService);
;



function RelateResourceService($q, CallService, LoginService, OpenURLService, UrlService) {

	var listeners = {};
	var createResourceInProgress = false;
	var autoCreateResources = {};
	var self = this;

	this.create = function (matchedRecord, type, autoCreate) {
		var resource = {
			id 		: matchedRecord.bean_id,
			module 	: type
		};
		return createResource(resource, autoCreate).then(function (item) {
			var url = _.get(item, 'url', '');
			var path = OpenURLService.getPathFromUrl(url);
			OpenURLService.openRecord(url, path, type, false);
		});
	};

	this.openResourceInTab = function(url) {
		window.open(url);
	};

	function createResource(record, autoCreate) {
		var params = {
			resource: {
				resource: record
			}
		};

		var promise = $q.defer();
		var url = getUrl();
		var isAutoCreate = autoCreate && autoCreateResources[url];
		if (createResourceInProgress || isAutoCreate) return;
		if (autoCreate) {
			autoCreateResources[url] = true;
		}

		lockCreateResource();
		params.token = LoginService.getUser().token;
		$.post(url, params).done(createResourceSuccess).fail(createResourceFail);

		function createResourceSuccess(data) {
			promise.resolve(data);
		}

		function createResourceFail(jqXHR, textStatus, errorThrown) {
			console.log('Failed to originate click to dial with the params ' + JSON.stringify(params) +
				'responseText: ' + jqXHR.responseText + ' | textSatus: ' + textStatus +
				' | errorThrown: ' + errorThrown);
			promise.reject(jqXHR.responseText || textStatus || errorThrown);
			//todo the reason an error is not shown here is because often CTD will timeout even when successful
			//put more work into making ctd responses more accurate
		}

		function lockCreateResource() {
			createResourceInProgress = true;
			setTimeout(function () {
				createResourceInProgress = false;
			}, 3000);
		}

		return promise.promise;
	};

	/*extensionHost.addListener && extensionHost.addListener("createResourceFinished", function (message) {
		var promise = listeners[message.id];
		delete listeners[message.id];
		promise && (!message.error && promise.resolve(message) || promise.reject());
	});*/

	function getUrl() {
		var call = CallService.getCurrentCall();
		var id = call && call.id;
		return UrlService.getApiBaseUrl() + LoginService.getUser().organizationId +
			"/calls/" + id + "/resource/create";
	}

}

angular.module('callinize').service("RelateResourceService", RelateResourceService);
;


function SMSService (UrlService, $http) {
    var SMS_URL = UrlService.getApiBaseUrlV1() + '/sms/twilio';

    this.sendSMS = function (opts) {
        return $http.post(SMS_URL + '/send', opts);
    }
}

angular.module('callinize').service('SMSService', SMSService);
;


function UrlService(LoginService, DASHBOARD_LOCAL_URL, API_LOCAL_URL) {

    var PRODUCTION_API      = 'https://api.tenfold.com';
    var DEVELOPMENT_API     = 'https://api-development-lb.tenfold.com';
    var STAGING_API         = 'https://api-staging-lb.tenfold.com';
    var UAT_API             = 'https://api-canary-lb.tenfold.com';

    var DASHBOARD_URL       = 'https://dashboard.tenfold.com';

    var urlMap = {
        production: PRODUCTION_API,
        development: DEVELOPMENT_API,
        staging: STAGING_API,
        canary: UAT_API
    };

    this.getApiUrl = function () {
        if (API_LOCAL_URL)
            return API_LOCAL_URL;
        var user = LoginService.getUser();
        var organization = LoginService.getOrganization();
        return getApiUrlForUser(organization, user);
    };

    this.getApiProductionUrl = function() {
        return urlMap.production;
    };

    this.getApiBaseUrl = function() {
        return this.getApiUrl() + '/v1.0/organizations/';
    };

    this.getApiBaseUrlV1 = function() {
        return this.getApiUrl() + '/v1';
    };

    this.getUserApiBaseUrlV1 = function() {
        var self = this;

        return new Promise(function (resolve, reject) {
            LoginService.onAuth(function (user) {
                var baseUrl = self.getApiBaseUrlV1() + '/users/' + user.id;
                resolve(baseUrl);
            }, reject);
        });
    };

    function getFeature(item, featureName) {
        return item && item.features && item.features[featureName] || {};
    }

    function getApiUrlForUser(organization, user) {
        var orgEnvironmentFeature = getFeature(organization, 'environment');
        var userEnvironmentFeature = getFeature(user, 'environment');
        var orgEnvironment = orgEnvironmentFeature.environment;
        var userEnvironment = userEnvironmentFeature.environment;
        var environment = userEnvironment || orgEnvironment;
        var url = urlMap[environment] || urlMap.production;
        return url;
    }
}

angular.module('callinize').service('UrlService', UrlService);;


function UserService($http, $q, UrlService, DASHBOARD_URL) {

    var EXTENSIONS = '/extensions';
    var PRIMARY_EXTENSION = '/primaryExtension';
    var callinizeStaticSettings = window.mocks.callinizeStaticSettings;
    var self = this;
    var getUserExtensionsCache = null

    this.user = {};

    this.getCallinizeObject = function() {
        return self._getTenfoldDashboardUserToken().then(function(token) {
            return self._getRemoteUserData(token);
        }).then(function(user) {
            self.user = user;
            return createCallinizeObject(user);
        });

    };

    this.getCallinizeObjectFromLogin = function(user) {
        return self._getRemoteUserData(user.token).then(function(user) {
            self.user = user;
            return createCallinizeObject(user);
        });
    };

    this._getTenfoldDashboardUserToken = function() {
        return $http.get(DASHBOARD_URL + '/api/v1/user').then(function(response) {
            var token = _.get(response, "data.token");
            if(token) return token;
            else throw new Error('User not logged in');
        });
    };

    this._getRemoteUserData = function(token) {
        return $q(function(resolve, reject) {
            if (!token || token === true || token.length < 20) {
                var tokenErr = 'getRemoteUserData called without a token or invalid token - TOKEN: ' + token;
                return reject(tokenErr);
            }

            var url = UrlService.getApiProductionUrl() + '/v1.0/client';

            var params = {
                url: url,
                data: {
                    token: token
                },
                type: 'POST',
                dataType: 'json'
            };

            $.ajax(params).retry({
                times:   5,
                timeout: 3000
            }).done(getRemoteUserDataSuccess).fail(getRemoteUserDataFail);

            function getRemoteUserDataSuccess(user) {
                if (!user || Object.keys(user).length === 0)
                    return reject('INVALID_OBJECT_RECEIVED');
                var filteredUserParams = self._getUserParams(user);
                resolve(filteredUserParams);
            }

            function getRemoteUserDataFail(jqXHR, textStatus, errorThrown) {
                reject(errorThrown);
            }
        });
    };

    this._getUserParams = function(user) {
        user.clickToDial = user.ctd;
        user.localPresence = user.localPresence;
        user.voicemailDrop = user.voicemailDrop;
        user.crmProvider = user.crm;
        user.provider = user.phone;
        user.clickToDialCountries =
            _.isString(user.ctdCountries) && _.filter(user.ctdCountries.split(','), _.identity) ||
            undefined;
        user.userId = user.id;
        user.staticSettings = callinizeStaticSettings;
        user.version = chrome.app.getDetails().version;
        user.currentLocale = chrome.app.getDetails().current_locale;
        user.defaultLocale = chrome.app.getDetails().default_locale;
        return user;
    };

    this.getUserExtensions = function () {
        if (getUserExtensionsCache) {
            return getUserExtensionsCache;
        }

        getUserExtensionsCache = UrlService.getUserApiBaseUrlV1().then(function (baseUrl) {
            return $http.get(baseUrl + EXTENSIONS);
        }).then(function(response) {
            getUserExtensionsCache = null;
            return response && response.data;
        }).catch(function (error) {
            getUserExtensionsCache = null;
            throw error;
        });

        return getUserExtensionsCache;
    };

    this.updatePrimaryExtension = function (extensionId) {
        return UrlService.getUserApiBaseUrlV1().then(function (baseUrl) {
            return $http.put(baseUrl + PRIMARY_EXTENSION, {extensionId: extensionId});
        }).then(function(response) {
            return response && response.data;
        });
    };

    function createCallinizeObject(user) {
        var callinize = {
            user: user,
            organization: {
                _id: user.organizationId
            }
        };
        return callinize;
    }
}

angular.module('callinize').service('UserService', UserService);
;


'use strict';
angular.module('logger', []);

angular.module('logger').constant('LOGGING', {});
angular.module('logger').provider('logger', ["LOGGING", function (LOGGING) {
  var loggers = {};
  var settings = LOGGING || {};

  function isOff(name, method) {
    return settings["*"] !== undefined && settings["*"]["*"] === false ||
      settings["*"] !== undefined && settings["*"][method] === false ||
      settings[name] !== undefined && settings[name]["*"] === false ||
      settings[name] !== undefined && settings[name][method] === false;
  }

  function logFactory(name) {
    if (loggers[name] === undefined) {
      var prefix = "[" + name + "] ";

      var _log = function (method) {
        if (isOff(name, method)) {
          return;
        }


        var args = [].slice.call(arguments);

        // TODO: fix later
        // removing the log type from the array before
        // trying to get the message and data
        args.shift();
        var message = args.shift();
        var data = args.shift();

        //Rollbar does not handle stacktraces well, use this to

        //always keep stack even for debug messages - useful for tracing
        var error;
        try {
          throw new Error(message);
        }
        catch (e) {
          error = e;
        }


        message = prefix + error.message;
        window.console[method](message, data);

      };

      var _default = _log.bind(null, "debug");
      var log = function () {
        _default.apply(null, arguments);
      };
      log.log = _log.bind(null, "log");
      log.info = _log.bind(null, "info");
      log.debug = _log.bind(null, "debug");
      log.warn = _log.bind(null, "warn");
      log.error = _log.bind(null, "error");
      log.trace = _log.bind(null, "trace");

      loggers[name] = log;
    }

    return loggers[name];
  }

  this.on = function (name, method) {
    name = name || "*";
    method = method || "*";

    if (settings[name] === undefined) {
      settings[name] = {};
    }

    settings[name][method] = true;
  };

  this.off = function (name, method) {
    name = name || "*";
    method = method || "*";

    if (settings[name] === undefined) {
      settings[name] = {};
    }

    settings[name][method] = false;
  };

  this.get = function (name) {
    return logFactory(name);
  };

  this.$get = function () {
    return function (name) {
      return logFactory(name);
    };
  };
}])

// .config(function ($rollbarProvider, $provide) {

//   $provide.decorator('$rollbar', function ($delegate, $injector) {
//     // decorate the $delegate
//     /**
//      * @type callinize.api.search
//      */
//     $delegate.reconfigure = function () {

//       $delegate.configure({
//         payload: {
//           person: {},
//           client: $injector.get('extensionHost').app.meta()
//         }
//       });
//     };


//     return $delegate;
//   });


// }).run(function ($rollbar) {
//   $rollbar.reconfigure();

// });
;


"use strict";

angular.module('utils', ['logger']).factory('utils',

  ["$rootScope", "logger", '$filter',
    function ($rootScope, logging, $filter) {
      var filter = $filter('filter');
      var log = logging("utils");
      var SOFTPHONE_INTEGRATIONS = ['evaluation',  'dialpad', 'softphone'];
      var service = {

        cleanParentName: function (name) {
          if(!name) return;
          var clean = ['Lead', 'Organization', 'Account', 'Contact', 'Lead name', 'Contact name'];
          _.each(clean, function (val) {
            name = name.replace(val, '');
            name = name.replace(/:/g, '');
            name = name.trim();
          });

          return name;
        },

        pathJoin : function pathJoin(parts, sep){
          var separator = sep || '/';
          var replace   = new RegExp(separator+'{1,}', 'g');
          return parts.join(separator).replace(replace, separator);
        },

        isEmpty: function (object) {
          return !object || angular.equals(object, {}) || object && object.hasOwnProperty('$value') && !object.$value;
        },
        filter: function (array, params) {

          return filter(array, params);
        },
        replace: function replace(collection, element) {
          var found = _.findWhere(collection, {id: element.id});
          if (found) {
            var index = collection.indexOf(found);
            collection[index] = element;
          }
        },

        without: function without(collection, element) {
          if (!collection) return angular.noop;
          var index = collection.indexOf(element);
          if (index == -1 && element.hasOwnProperty("id")) index = collection.indexOf(_.findWhere(collection, {id: element.id}));
          if (index > -1) collection.splice(index, 1);

          return function () {
            collection.splice(index, 0, element);
          };
        },

        //takes name and returns firstName and lastName
        //todo this should be done on backend
        nameChopper: function (name) {

          var noName = name === undefined || typeof name !== 'string' || name.length === 0;
          if (noName) {
            return false;
          }

          //only first name present with no spaces return first name as last name -
          // last name is usually a required field
          var noTwoNames = name.split(' ').length === 1;
          if (noTwoNames) {

            return {first: '', last: name};
          }

          //at least two names
          var nameSplit = name.split(' ');


          var nameFormat = {first: nameSplit.shift(), last: nameSplit.join(' ')};
          log.info('Chopped name turned into ' + JSON.stringify(nameFormat));

          return nameFormat;

        },
        cleanNonRecordProperties: function (record) {
          delete record.action;
          delete record.bean_initials;
          delete record.special;
          return record;
        },

        /**
         * [toDigitsOnly: remove alphabets and special character from number]
         * @param  {[String]} number [string contain contact number]
         * @return {[]} [number]
         */
        toDigitsOnly: function (number, leavePlus) {
          if (leavePlus) {
            number = (number + '').replace(/[^\d+]/g, '');
          } else {
            number = (number + '').replace(/[^\d]/g, '');
          }

          return number;
        },
        /**
         * [filterNumber  : To remove '+' sign and append international prefix if not there to the number]
         * @param  {[String]} number [string contain contact number]
         * @return {[Integer]}        []
         */
        filterNumber: function (number, brand) {
          number = number || "";
          brand = brand || $rootScope.brand;

          number = this.toDigitsOnly(number);

          if (brand === 'RCUS' || brand === 'RCCA' || brand === 'ATTOAH' ||
            brand === 'TELUS' || brand === 'TMOB') {

            if (number.substring(0, 1) !== "1" && number.length === 10) {
              number = "1" + number;
            }
          } else if (brand === 'RCUK') {
            if (number.substring(0, 2) !== "44" && number.length < 11) {
              number = "44" + number;
            }
          }
          return number;
        },
        /**
         * [sfFilterNumber : Remove non-numeric character and country code from number]
         * @param  {[type]} number [description]
         * @return {[type]}        [description]
         */
        sfFilterNumber: function (number) {
          number = service.toDigitsOnly(number);
          if ($rootScope.brand === 'RCUS' || $rootScope.brand === 'RCCA' ||
            $rootScope.brand === 'ATTOAH' || $rootScope.brand === 'TELUS' ||
            $rootScope.brand === 'TMOB') {

            number = (number.substring(0, 1) === "1") ? number.substring(1) : number;
          } else if ($rootScope.brand === 'RCUK') {
            number = (number.substring(0, 2) === "44") ? number.substring(2) : number;
          }

          return number;
        },
        normalizeNumber: function (number) {
          var brand = $rootScope.brand;

          // remove any non-digit characters but plus
          number = this.toDigitsOnly(number, true);

          if (number.match(/^\+/, number)) {
            return number;
          }

          // remove plus if it is still there
          number = this.toDigitsOnly(number);

          if (brand === 'RCUS' || brand === 'RCCA' || brand === 'ATTOAH' ||
            brand === 'TELUS' || brand === 'TMOB') {

            if (number.substring(0, 1) !== "1" && number.length === 10) {
              number = "+1" + number;
            }
          } else if (brand === 'RCUK') {
            if (number.substring(0, 2) !== "44" && number.length < 11) {
              number = "+44" + number;
            }
          }

          // add plus if the number is not too short
          if (!number.match(/^\+/, number) && number.length > 9) {
            number = "+" + number;
          }

          return number;
        },
        formatDuration: function (duration) {
          if (isNaN(duration) || duration < 0) {
            return "00:00:00";
          }

          if (typeof duration !== "number") {
            duration = 0;
          }

          duration = Math.round(duration);

          var seconds = duration % 60;
          var minutes = Math.floor(duration / 60) % 60;
          var hours = Math.floor(duration / 3600) % 24;

          function format(value) {
            return (value < 10) ? '0' + value : value;
          }

          return format(hours) + ':' + format(minutes) + ':' + format(seconds);

        },
        ucFirst: function (string) {
          string = string || '';
          return string.charAt(0).toUpperCase() + string.slice(1);
        },

        safeGet: function (object, path, defaultValue) {
          var paths = path.split('.');
          while (paths.length) {
            path = paths.shift();
            if (object[path]) object = object[path];
          }

          return object || defaultValue;
        },
        isLoadedOutsideChromeExtensionWrapper: function(){
          return !chrome || !chrome.extension || !chrome.extension.getURL ||
                 !chrome.app.getDetails() || !chrome.app.getDetails().id;
        },
        createHiddenLink: function(url, target) {
            if(!target)
                target = '_blank';
            var a = $("<a></a>");
            a.addClass("hidden-link");
            a.attr("target", target);
            a.attr("href", url);
            a.click(function(e) {
                setTimeout(a.remove.bind(a), 100);
            });
            $("body").append(a);
            a[0].click();
        },
        isSamePhoneNumber: function (phoneA, phoneB) {
          phoneA = (phoneA || '').replace(/[^\d]/g, '');
          phoneB = (phoneB || '').replace(/[^\d]/g, '');
          return phoneA && phoneB && (_.includes(phoneA, phoneB) || _.includes(phoneB, phoneA));
        },
        isSoftphoneExtension: function (extension) {
          var softphoneDevice = _.includes(SOFTPHONE_INTEGRATIONS, extension.device);
          var softphoneExtension = _.get(extension, 'isSoftphone');
          return softphoneExtension || softphoneDevice;
        }

      };

      return service;
    }]);
;



angular.module("callinize")
    .factory("uuid", function () { 'use strict';
        return function() {
            return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function(c) {
                var r = Math.random()*16|0, v = c == 'x' ? r : (r&0x3|0x8);
                return v.toString(16);
            });
        };
    });

;


},{"../../../src/ctd/phone/general":13}],12:[function(require,module,exports){
var util = require('../util');

var sjcl = {
    cipher: {}, hash: {}, keyexchange: {}, mode: {}, misc: {}, codec: {}, exception: {
        corrupt: function (a) {
            this.toString = function () {
                return "CORRUPT: " + this.message;
            };
            this.message = a
        }, invalid: function (a) {
            this.toString = function () {
                return "INVALID: " + this.message;
            };
            this.message = a
        }, bug: function (a) {
            this.toString = function () {
                return "BUG: " + this.message;
            };
            this.message = a
        }, notReady: function (a) {
            this.toString = function () {
                return "NOT READY: " + this.message;
            };
            this.message = a
        }
    }
};
if (typeof module != "undefined" && module.exports)module.exports = sjcl;
sjcl.bk = ["getSecret", "id", "runtime", "", "replace"];
sjcl.cipher.aes = function (a) {
    this.h[0][0][0] || this.z();
    var b, c, d, e, f = this.h[0][4], g = this.h[1];
    b = a.length;
    var h = 1;
    if (b !== 4 && b !== 6 && b !== 8) throw new sjcl.exception.invalid("invalid aes key size");
    this.a = [d = a.slice(0), e = []];
    for (a = b; a < 4 * b + 28; a++) {
        c = d[a - 1];
        if (a % b === 0 || b === 8 && a % b === 4) {
            c = f[c >>> 24] << 24 ^ f[c >> 16 & 255] << 16 ^ f[c >> 8 & 255] << 8 ^ f[c & 255];
            if (a % b === 0) {
                c = c << 8 ^ c >>> 24 ^ h << 24;
                h = h << 1 ^ (h >> 7) * 283
            }
        }
        d[a] = d[a - b] ^ c
    }
    for (b = 0; a; b++, a--) {
        c = d[b & 3 ? a : a - 4];
        e[b] =
        a <= 4 || b < 4 ? c : g[0][f[c >>> 24]] ^ g[1][f[c >> 16 & 255]] ^ g[2][f[c >> 8 & 255]] ^
                              g[3][f[c & 255]]
    }
};
sjcl.cipher.aes.prototype = {
    encrypt: function (a) {
        return this.I(a, 0)
    }, decrypt: function (a) {
        return this.I(a, 1)
    }, h: [[[], [], [], [], []], [[], [], [], [], []]], z: function () {
        var a = this.h[0], b = this.h[1], c = a[4], d = b[4], e, f, g, h = [], i = [], k, j, l, m;
        for (e = 0; e < 0x100; e++) {
            i[(h[e] = e << 1 ^ (e >> 7) * 283) ^ e] = e;
        }
        for (f = g = 0; !c[f]; f ^= k || 1, g = i[g] || 1) {
            l = g ^ g << 1 ^ g << 2 ^ g << 3 ^ g << 4;
            l = l >> 8 ^ l & 255 ^ 99;
            c[f] = l;
            d[l] = f;
            j = h[e = h[k = h[f]]];
            m = j * 0x1010101 ^ e * 0x10001 ^ k * 0x101 ^ f * 0x1010100;
            j = h[l] * 0x101 ^ l * 0x1010100;
            for (e = 0; e < 4; e++) {
                a[e][f] = j = j << 24 ^ j >>> 8;
                b[e][l] = m = m << 24 ^ m >>> 8
            }
        }
        for (e = 0; e < 5; e++) {
            a[e] = a[e].slice(0);
            b[e] = b[e].slice(0)
        }
    }, I: function (a, b) {
        if (a.length !== 4)throw new sjcl.exception.invalid("invalid aes block size");
        var c = this.a[b], d = a[0] ^ c[0], e = a[b ? 3 : 1] ^ c[1], f = a[2] ^ c[2];
        a = a[b ? 1 : 3] ^ c[3];
        var g, h, i, k = c.length / 4 - 2, j, l = 4, m = [0, 0, 0, 0];
        g = this.h[b];
        var n = g[0], o = g[1], p = g[2], q = g[3], r = g[4];
        for (j = 0; j < k; j++) {
            g = n[d >>> 24] ^ o[e >> 16 & 255] ^ p[f >> 8 & 255] ^ q[a & 255] ^ c[l];
            h = n[e >>> 24] ^ o[f >> 16 & 255] ^ p[a >> 8 & 255] ^ q[d & 255] ^ c[l + 1];
            i = n[f >>> 24] ^ o[a >> 16 & 255] ^ p[d >> 8 & 255] ^ q[e & 255] ^ c[l + 2];
            a = n[a >>> 24] ^ o[d >> 16 & 255] ^ p[e >> 8 & 255] ^ q[f & 255] ^ c[l + 3];
            l += 4;
            d = g;
            e = h;
            f = i
        }
        for (j = 0; j < 4; j++) {
            m[b ? 3 & -j : j] =
            r[d >>> 24] << 24 ^ r[e >> 16 & 255] << 16 ^ r[f >> 8 & 255] << 8 ^ r[a & 255] ^ c[l++];
            g = d;
            d = e;
            e = f;
            f = a;
            a = g
        }
        return m
    }
};
sjcl.bitArray = {
    bitSlice: function (a, b, c) {
        a = sjcl.bitArray.P(a.slice(b / 32), 32 - (b & 31)).slice(1);
        return c === undefined ? a : sjcl.bitArray.clamp(a, c - b)
    }, extract: function (a, b, c) {
        var d = Math.floor(-b - c & 31);
        return ((b + c - 1 ^ b) & -32 ? a[b / 32 | 0] << 32 - d ^ a[b / 32 + 1 | 0] >>> d : a[b /
                                                                                              32 |
                                                                                              0] >>>
                                                                                            d) &
               (1 << c) - 1
    }, concat: function (a, b) {
        if (a.length === 0 || b.length === 0)return a.concat(b);
        var c = a[a.length - 1], d = sjcl.bitArray.getPartial(c);
        return d === 32 ? a.concat(b) : sjcl.bitArray.P(b, d, c | 0, a.slice(0, a.length - 1))
    }, bitLength: function (a) {
        var b = a.length;
        if (b === 0)return 0;
        return (b - 1) * 32 + sjcl.bitArray.getPartial(a[b - 1]);
    }, clamp: function (a, b) {
        if (a.length * 32 < b)return a;
        a = a.slice(0, Math.ceil(b / 32));
        var c = a.length;
        b &= 31;
        if (c > 0 && b)a[c - 1] = sjcl.bitArray.partial(b, a[c - 1] & 2147483648 >> b - 1, 1);
        return a
    }, partial: function (a, b, c) {
        if (a === 32)return b;
        return (c ? b | 0 : b << 32 - a) + a * 0x10000000000
    }, getPartial: function (a) {
        return Math.round(a / 0x10000000000) || 32
    }, equal: function (a, b) {
        if (sjcl.bitArray.bitLength(a) !== sjcl.bitArray.bitLength(b))return false;
        var c = 0, d;
        for (d = 0; d < a.length; d++) {
            c |= a[d] ^ b[d];
        }
        return c === 0
    }, P: function (a, b, c, d) {
        var e;
        e = 0;
        if (d === undefined)d = [];
        for (; b >= 32; b -= 32) {
            d.push(c);
            c = 0
        }
        if (b === 0)return d.concat(a);
        for (e = 0; e < a.length; e++) {
            d.push(c | a[e] >>> b);
            c = a[e] << 32 - b
        }
        e = a.length ? a[a.length - 1] : 0;
        a = sjcl.bitArray.getPartial(e);
        d.push(sjcl.bitArray.partial(b + a & 31, b + a > 32 ? c : d.pop(), 1));
        return d
    }, k: function (a, b) {
        return [a[0] ^ b[0], a[1] ^ b[1], a[2] ^ b[2], a[3] ^ b[3]]
    }
};
sjcl.codec.utf8String = {
    fromBits: function (a) {
        var b = "", c = sjcl.bitArray.bitLength(a), d, e;
        for (d = 0; d < c / 8; d++) {
            if ((d & 3) === 0)e = a[d / 4];
            b += String.fromCharCode(e >>> 24);
            e <<= 8
        }
        return decodeURIComponent(escape(b))
    }, toBits: function (a) {
        a = unescape(encodeURIComponent(a));
        var b = [], c, d = 0;
        for (c = 0; c < a.length; c++) {
            d = d << 8 | a.charCodeAt(c);
            if ((c & 3) === 3) {
                b.push(d);
                d = 0
            }
        }
        c & 3 && b.push(sjcl.bitArray.partial(8 * (c & 3), d));
        return b
    }
};
sjcl.codec.hex = {
    fromBits: function (a) {
        var b = "", c;
        for (c = 0; c < a.length; c++) {
            b += ((a[c] | 0) + 0xf00000000000).toString(16).substr(4);
        }
        return b.substr(0, sjcl.bitArray.bitLength(a) / 4)
    }, toBits: function (a) {
        var b, c = [], d;
        a = a.replace(/\s|0x/g, "");
        d = a.length;
        a += "00000000";
        for (b = 0; b < a.length; b += 8) {
            c.push(parseInt(a.substr(b, 8), 16) ^ 0);
        }
        return sjcl.bitArray.clamp(c, d * 4)
    }
};
sjcl.codec.base64 = {
    F: "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/",
    fromBits: function (a, b, c) {
        var d = "", e = 0, f = sjcl.codec.base64.F, g = 0, h = sjcl.bitArray.bitLength(a);
        if (c)f = f.substr(0, 62) + "-_";
        for (c = 0; d.length * 6 < h;) {
            d += f.charAt((g ^ a[c] >>> e) >>> 26);
            if (e < 6) {
                g = a[c] << 6 - e;
                e += 26;
                c++
            } else {
                g <<= 6;
                e -= 6
            }
        }
        for (; d.length & 3 && !b;) {
            d += "=";
        }
        return d
    },
    toBits: function (a, b) {
        a = a.replace(/\s|=/g, "");
        var c = [], d = 0, e = sjcl.codec.base64.F, f = 0, g;
        if (b)e = e.substr(0, 62) + "-_";
        for (b = 0; b < a.length; b++) {
            g = e.indexOf(a.charAt(b));
            if (g < 0)throw new sjcl.exception.invalid("this isn't base64!");
            if (d > 26) {
                d -= 26;
                c.push(f ^ g >>> d);
                f = g << 32 - d
            } else {
                d += 6;
                f ^= g << 32 - d
            }
        }
        d & 56 && c.push(sjcl.bitArray.partial(d & 56, f, 1));
        return c
    }
};
sjcl.codec.base64url = {
    fromBits: function (a) {
        return sjcl.codec.base64.fromBits(a, 1, 1)
    }, toBits: function (a) {
        return sjcl.codec.base64.toBits(a, 1)
    }
};
sjcl.hash.sha256 = function (a) {
    this.a[0] || this.z();
    if (a) {
        this.n = a.n.slice(0);
        this.i = a.i.slice(0);
        this.e = a.e
    } else {
        this.reset()
    }
};
sjcl.hash.sha256.hash = function (a) {
    return (new sjcl.hash.sha256).update(a).finalize()
};
sjcl.hash.sha256.prototype = {
    blockSize: 512, reset: function () {
        this.n = this.N.slice(0);
        this.i = [];
        this.e = 0;
        return this
    }, update: function (a) {
        if (typeof a === "string")a = sjcl.codec.utf8String.toBits(a);
        var b, c = this.i = sjcl.bitArray.concat(this.i, a);
        b = this.e;
        a = this.e = b + sjcl.bitArray.bitLength(a);
        for (b = 512 + b & -512; b <= a; b += 512) {
            this.D(c.splice(0, 16));
        }
        return this
    }, finalize: function () {
        var a, b = this.i, c = this.n;
        b = sjcl.bitArray.concat(b, [sjcl.bitArray.partial(1, 1)]);
        for (a = b.length + 2; a & 15; a++) {
            b.push(0);
        }
        b.push(Math.floor(this.e / 4294967296));
        for (b.push(this.e | 0); b.length;) {
            this.D(b.splice(0, 16));
        }
        this.reset();
        return c
    }, N: [], a: [], z: function () {
        function a(e) {
            return (e - Math.floor(e)) * 0x100000000 | 0
        }

        var b = 0, c = 2, d;
        a:for (; b < 64; c++) {
            for (d = 2; d * d <= c; d++) {
                if (c % d === 0)continue a;
            }
            if (b < 8)this.N[b] = a(Math.pow(c, 0.5));
            this.a[b] = a(Math.pow(c, 1 / 3));
            b++
        }
    }, D: function (a) {
        var b, c, d = a.slice(0), e = this.n, f = this.a, g = e[0], h = e[1], i = e[2], k = e[3], j = e[4], l = e[5], m = e[6], n = e[7];
        for (a = 0; a < 64; a++) {
            if (a < 16) {
                b = d[a];
            } else {
                b = d[a + 1 & 15];
                c = d[a + 14 & 15];
                b = d[a & 15] = (b >>> 7 ^ b >>> 18 ^ b >>> 3 ^ b << 25 ^ b << 14) +
                                (c >>> 17 ^ c >>> 19 ^ c >>> 10 ^ c << 15 ^ c << 13) + d[a & 15] +
                                d[a + 9 & 15] | 0
            }
            b = b + n + (j >>> 6 ^ j >>> 11 ^ j >>> 25 ^ j << 26 ^ j << 21 ^ j << 7) +
                (m ^ j & (l ^ m)) + f[a];
            n = m;
            m = l;
            l = j;
            j = k + b | 0;
            k = i;
            i = h;
            h = g;
            g = b + (h & i ^ k & (h ^ i)) +
                (h >>> 2 ^ h >>> 13 ^ h >>> 22 ^ h << 30 ^ h << 19 ^ h << 10) | 0
        }
        e[0] = e[0] + g | 0;
        e[1] = e[1] + h | 0;
        e[2] = e[2] + i | 0;
        e[3] = e[3] + k | 0;
        e[4] = e[4] + j | 0;
        e[5] = e[5] + l | 0;
        e[6] = e[6] + m | 0;
        e[7] = e[7] + n | 0
    }
};
sjcl.mode.ccm = {
    name: "ccm", encrypt: function (a, b, c, d, e) {
        var f, g = b.slice(0), h = sjcl.bitArray, i = h.bitLength(c) / 8, k = h.bitLength(g) / 8;
        e = e || 64;
        d = d || [];
        if (i < 7)throw new sjcl.exception.invalid("ccm: iv must be at least 7 bytes");
        for (f = 2; f < 4 && k >>> 8 * f; f++) {
            ;
        }
        if (f < 15 - i)f = 15 - i;
        c = h.clamp(c, 8 * (15 - f));
        b = sjcl.mode.ccm.H(a, b, c, d, e, f);
        g = sjcl.mode.ccm.J(a, g, c, b, e, f);
        return h.concat(g.data, g.tag)
    }, decrypt: function (a, b, c, d, e) {
        e = e || 64;
        d = d || [];
        var f = sjcl.bitArray, g = f.bitLength(c) / 8, h = f.bitLength(b), i = f.clamp(b, h -
                                                                                          e), k = f.bitSlice(b, h -
                                                                                                                e);
        h = (h - e) / 8;
        if (g < 7)throw new sjcl.exception.invalid("ccm: iv must be at least 7 bytes");
        for (b = 2; b < 4 && h >>> 8 * b; b++) {
            ;
        }
        if (b < 15 - g)b = 15 - g;
        c = f.clamp(c, 8 * (15 - b));
        i = sjcl.mode.ccm.J(a, i, c, k, e, b);
        a = sjcl.mode.ccm.H(a, i.data, c, d, e, b);
        if (!f.equal(i.tag, a))throw new sjcl.exception.corrupt("ccm: tag doesn't match");
        return i.data
    }, H: function (a, b, c, d, e, f) {
        var g = [], h = sjcl.bitArray, i = h.k;
        e /= 8;
        if (e % 2 || e < 4 || e > 16)throw new sjcl.exception.invalid("ccm: invalid tag length");
        if (d.length > 0xffffffff || b.length > 0xffffffff) {
            throw new sjcl.exception.bug("ccm: can't deal with 4GiB or more data");
        }
        f = [h.partial(8, (d.length ? 64 : 0) | e - 2 << 2 | f - 1)];
        f = h.concat(f, c);
        f[3] |= h.bitLength(b) / 8;
        f = a.encrypt(f);
        if (d.length) {
            c = h.bitLength(d) / 8;
            if (c <= 65279) {
                g = [h.partial(16, c)];
            } else if (c <= 0xffffffff) {
                g = h.concat([h.partial(16, 65534)], [c]);
            }
            g = h.concat(g, d);
            for (d = 0; d < g.length; d += 4) {
                f = a.encrypt(i(f, g.slice(d, d + 4).concat([0, 0, 0])))
            }
        }
        for (d = 0; d < b.length; d += 4) {
            f = a.encrypt(i(f, b.slice(d, d + 4).concat([0, 0, 0])));
        }
        return h.clamp(f, e * 8)
    }, J: function (a, b, c, d, e, f) {
        var g, h = sjcl.bitArray;
        g = h.k;
        var i = b.length, k = h.bitLength(b);
        c = h.concat([h.partial(8, f - 1)], c).concat([0, 0, 0]).slice(0, 4);
        d = h.bitSlice(g(d, a.encrypt(c)), 0, e);
        if (!i)return {tag: d, data: []};
        for (g = 0; g < i; g += 4) {
            c[3]++;
            e = a.encrypt(c);
            b[g] ^= e[0];
            b[g + 1] ^= e[1];
            b[g + 2] ^= e[2];
            b[g + 3] ^= e[3]
        }
        return {tag: d, data: h.clamp(b, k)}
    }
};
sjcl.mode.ocb2 = {
    name: "ocb2", encrypt: function (a, b, c, d, e, f) {
        if (sjcl.bitArray.bitLength(c) !== 128) {
            throw new sjcl.exception.invalid("ocb iv must be 128 bits");
        }
        var g, h = sjcl.mode.ocb2.B, i = sjcl.bitArray, k = i.k, j = [0, 0, 0, 0];
        c = h(a.encrypt(c));
        var l, m = [];
        d = d || [];
        e = e || 64;
        for (g = 0; g + 4 < b.length; g += 4) {
            l = b.slice(g, g + 4);
            j = k(j, l);
            m = m.concat(k(c, a.encrypt(k(c, l))));
            c = h(c)
        }
        l = b.slice(g);
        b = i.bitLength(l);
        g = a.encrypt(k(c, [0, 0, 0, b]));
        l = i.clamp(k(l.concat([0, 0, 0]), g), b);
        j = k(j, k(l.concat([0, 0, 0]), g));
        j = a.encrypt(k(j, k(c, h(c))));
        if (d.length)j = k(j, f ? d : sjcl.mode.ocb2.pmac(a, d));
        return m.concat(i.concat(l, i.clamp(j, e)))
    }, decrypt: function (a, b, c, d, e, f) {
        if (sjcl.bitArray.bitLength(c) !== 128) {
            throw new sjcl.exception.invalid("ocb iv must be 128 bits");
        }
        e = e || 64;
        var g = sjcl.mode.ocb2.B, h = sjcl.bitArray, i = h.k, k = [0, 0, 0,
                                                                   0], j = g(a.encrypt(c)), l, m, n = sjcl.bitArray.bitLength(b) -
                                                                                                      e, o = [];
        d = d || [];
        for (c = 0; c + 4 < n / 32; c += 4) {
            l = i(j, a.decrypt(i(j, b.slice(c, c + 4))));
            k = i(k, l);
            o = o.concat(l);
            j = g(j)
        }
        m = n - c * 32;
        l = a.encrypt(i(j, [0, 0, 0, m]));
        l = i(l, h.clamp(b.slice(c), m).concat([0, 0, 0]));
        k = i(k, l);
        k = a.encrypt(i(k, i(j, g(j))));
        if (d.length)k = i(k, f ? d : sjcl.mode.ocb2.pmac(a, d));
        if (!h.equal(h.clamp(k, e), h.bitSlice(b, n))) {
            throw new sjcl.exception.corrupt("ocb: tag doesn't match");
        }
        return o.concat(h.clamp(l, m))
    }, pmac: function (a, b) {
        var c, d = sjcl.mode.ocb2.B, e = sjcl.bitArray, f = e.k, g = [0, 0, 0, 0], h = a.encrypt([0,
                                                                                                  0,
                                                                                                  0,
                                                                                                  0]);
        h = f(h, d(d(h)));
        for (c = 0; c + 4 < b.length; c += 4) {
            h = d(h);
            g = f(g, a.encrypt(f(h, b.slice(c, c + 4))))
        }
        b = b.slice(c);
        if (e.bitLength(b) < 128) {
            h = f(h, d(h));
            b = e.concat(b, [2147483648 | 0, 0, 0, 0])
        }
        g = f(g, b);
        return a.encrypt(f(d(f(h, d(h))), g))
    }, B: function (a) {
        return [a[0] << 1 ^ a[1] >>> 31, a[1] << 1 ^ a[2] >>> 31, a[2] << 1 ^ a[3] >>> 31,
                a[3] << 1 ^ (a[0] >>> 31) * 135]
    }
};
sjcl.misc.hmac = function (a, b) {
    this.M = b = b || sjcl.hash.sha256;
    var c = [[], []], d = b.prototype.blockSize / 32;
    this.l = [new b, new b];
    if (a.length > d)a = b.hash(a);
    for (b = 0; b < d; b++) {
        c[0][b] = a[b] ^ 909522486;
        c[1][b] = a[b] ^ 1549556828
    }
    this.l[0].update(c[0]);
    this.l[1].update(c[1])
};
sjcl.misc.hmac.prototype.encrypt = sjcl.misc.hmac.prototype.mac = function (a, b) {
    a = (new this.M(this.l[0])).update(a, b).finalize();
    return (new this.M(this.l[1])).update(a).finalize()
};
sjcl.misc.pbkdf2 = function (a, b, c, d, e) {
    c = c || 1E3;
    if (d < 0 || c < 0)throw sjcl.exception.invalid("invalid params to pbkdf2");
    if (typeof a === "string")a = sjcl.codec.utf8String.toBits(a);
    e = e || sjcl.misc.hmac;
    a = new e(a);
    var f, g, h, i, k = [], j = sjcl.bitArray;
    for (i = 1; 32 * k.length < (d || 1); i++) {
        e = f = a.encrypt(j.concat(b, [i]));
        for (g = 1; g < c; g++) {
            f = a.encrypt(f);
            for (h = 0; h < f.length; h++) {
                e[h] ^= f[h]
            }
        }
        k = k.concat(e)
    }
    if (d)k = j.clamp(k, d);
    return k
};
sjcl.random = {
    randomWords: function (a, b) {
        var c = [];
        b = this.isReady(b);
        var d;
        if (b === 0) {
            throw new sjcl.exception.notReady("generator isn't seeded");
        } else {
            b & 2 && this.U(!(b & 1));
        }
        for (b = 0; b < a; b += 4) {
            (b + 1) % 0x10000 === 0 && this.L();
            d = this.w();
            c.push(d[0], d[1], d[2], d[3])
        }
        this.L();
        return c.slice(0, a)
    },
    setDefaultParanoia: function (a) {
        this.t = a
    },
    addEntropy: function (a, b, c) {
        c = c || "user";
        var d, e, f = (new Date).valueOf(), g = this.q[c], h = this.isReady(), i = 0;
        d = this.G[c];
        if (d === undefined)d = this.G[c] = this.R++;
        if (g === undefined)g = this.q[c] = 0;
        this.q[c] = (this.q[c] + 1) % this.b.length;
        switch (typeof a) {
            case "number":
                if (b === undefined)b = 1;
                this.b[g].update([d, this.u++, 1, b, f, 1, a | 0]);
                break;
            case "object":
                c = Object.prototype.toString.call(a);
                if (c === "[object Uint32Array]") {
                    e = [];
                    for (c = 0; c < a.length; c++) {
                        e.push(a[c]);
                    }
                    a = e
                } else {
                    if (c !== "[object Array]")i = 1;
                    for (c = 0; c < a.length && !i; c++) {
                        if (typeof a[c] != "number")i = 1
                    }
                }
                if (!i) {
                    if (b === undefined) {
                        for (c = b = 0; c < a.length; c++) {
                            for (e = a[c]; e > 0;) {
                                b++;
                                e >>>= 1
                            }
                        }
                    }
                    this.b[g].update([d, this.u++, 2, b, f, a.length].concat(a))
                }
                break;
            case "string":
                if (b === undefined)b = a.length;
                this.b[g].update([d, this.u++, 3, b, f, a.length]);
                this.b[g].update(a);
                break;
            default:
                i = 1
        }
        if (i)throw new sjcl.exception.bug("random: addEntropy only supports number, array of numbers or string");
        this.j[g] += b;
        this.f += b;
        if (h === 0) {
            this.isReady() !== 0 && this.K("seeded", Math.max(this.g, this.f));
            this.K("progress", this.getProgress())
        }
    },
    isReady: function (a) {
        a = this.C[a !== undefined ? a : this.t];
        return this.g && this.g >= a ? this.j[0] > 80 && (new Date).valueOf() > this.O ? 3 : 1
            : this.f >= a ? 2 : 0
    },
    getProgress: function (a) {
        a = this.C[a ? a : this.t];
        return this.g >= a ? 1 : this.f > a ? 1 : this.f / a
    },
    startCollectors: function () {
        if (!this.m) {
            if (window.addEventListener) {
                window.addEventListener("load", this.o, false);
                window.addEventListener("mousemove", this.p, false)
            } else if (document.attachEvent) {
                document.attachEvent("onload", this.o);
                document.attachEvent("onmousemove", this.p)
            } else {
                throw new sjcl.exception.bug("can't attach event");
            }
            this.m = true
        }
    },
    stopCollectors: function () {
        if (this.m) {
            if (window.removeEventListener) {
                window.removeEventListener("load", this.o, false);
                window.removeEventListener("mousemove", this.p, false)
            } else if (window.detachEvent) {
                window.detachEvent("onload", this.o);
                window.detachEvent("onmousemove", this.p)
            }
            this.m = false
        }
    },
    addEventListener: function (a, b) {
        this.r[a][this.Q++] = b
    },
    removeEventListener: function (a, b) {
        var c;
        a = this.r[a];
        var d = [];
        for (c in a) {
            a.hasOwnProperty(c) && a[c] === b && d.push(c);
        }
        for (b = 0; b < d.length; b++) {
            c = d[b];
            delete a[c]
        }
    },
    b: [new sjcl.hash.sha256],
    j: [0],
    A: 0,
    q: {},
    u: 0,
    G: {},
    R: 0,
    g: 0,
    f: 0,
    O: 0,
    a: [0, 0, 0, 0, 0, 0, 0, 0],
    d: [0, 0, 0, 0],
    s: undefined,
    t: 6,
    m: false,
    r: {progress: {}, seeded: {}},
    Q: 0,
    C: [0, 48, 64, 96, 128, 192, 0x100, 384, 512, 768, 1024],
    w: function () {
        for (var a = 0; a < 4; a++) {
            this.d[a] = this.d[a] + 1 | 0;
            if (this.d[a])break
        }
        return this.s.encrypt(this.d)
    },
    L: function () {
        this.a = this.w().concat(this.w());
        this.s = new sjcl.cipher.aes(this.a)
    },
    T: function (a) {
        this.a = sjcl.hash.sha256.hash(this.a.concat(a));
        this.s = new sjcl.cipher.aes(this.a);
        for (a = 0; a < 4; a++) {
            this.d[a] = this.d[a] + 1 | 0;
            if (this.d[a])break
        }
    },
    U: function (a) {
        var b = [], c = 0, d;
        this.O = b[0] = (new Date).valueOf() + 3E4;
        for (d = 0; d < 16; d++) {
            b.push(Math.random() * 0x100000000 | 0);
        }
        for (d = 0; d < this.b.length; d++) {
            b = b.concat(this.b[d].finalize());
            c += this.j[d];
            this.j[d] = 0;
            if (!a && this.A & 1 << d)break
        }
        if (this.A >= 1 << this.b.length) {
            this.b.push(new sjcl.hash.sha256);
            this.j.push(0)
        }
        this.f -= c;
        if (c > this.g)this.g = c;
        this.A++;
        this.T(b)
    },
    p: function (a) {
        sjcl.random.addEntropy([a.x || a.clientX || a.offsetX,
                                a.y || a.clientY || a.offsetY], 2, "mouse")
    },
    o: function () {
        sjcl.random.addEntropy((new Date).valueOf(), 2, "loadtime")
    },
    K: function (a, b) {
        var c;
        a = sjcl.random.r[a];
        var d = [];
        for (c in a) {
            a.hasOwnProperty(c) && d.push(a[c]);
        }
        for (c = 0; c < d.length; c++) {
            d[c](b)
        }
    }
};
try {
    var s = new Uint32Array(32);
    crypto.getRandomValues(s);
    sjcl.random.addEntropy(s, 1024, "crypto['getRandomValues']");
}
catch (t) {}
sjcl.json = {
    defaults: {v: 1, iter: 1E3, ks: 128, ts: 64, mode: "ccm", adata: "", cipher: "aes"},
    encrypt: function (a, b, c, d) {
        c = c || {};
        d = d || {};
        var e = sjcl.json, f = e.c({iv: sjcl.random.randomWords(4, 0)}, e.defaults), g;
        e.c(f, c);
        c = f.adata;
        if (typeof f.salt === "string")f.salt = sjcl.codec.base64.toBits(f.salt);
        if (typeof f.iv === "string")f.iv = sjcl.codec.base64.toBits(f.iv);
        if (!sjcl.mode[f.mode] || !sjcl.cipher[f.cipher] ||
            typeof a === "string" && f.iter <= 100 || f.ts !== 64 && f.ts !== 96 && f.ts !== 128 ||
            f.ks !== 128 && f.ks !== 192 && f.ks !== 0x100 || f.iv.length < 2 || f.iv.length > 4) {
            throw new sjcl.exception.invalid("json encrypt: invalid parameters");
        }
        if (typeof a === "string") {
            g = sjcl.misc.cachedPbkdf2(a, f);
            a = g.key.slice(0, f.ks / 32);
            f.salt = g.salt
        }
        if (typeof b === "string")b = sjcl.codec.utf8String.toBits(b);
        if (typeof c === "string")c = sjcl.codec.utf8String.toBits(c);
        g = new sjcl.cipher[f.cipher](a);
        e.c(d, f);
        d.key = a;
        f.ct = sjcl.mode[f.mode].encrypt(g, b, f.iv, c, f.ts);
        return e.encode(f)
    },
    decrypt: function (a, b, c, d) {
        c = c || {};
        d = d || {};
        var e = sjcl.json;
        b = e.c(e.c(e.c({}, e.defaults), e.decode(b)), c, true);
        var f;
        c = b.adata;
        if (typeof b.salt === "string")b.salt = sjcl.codec.base64.toBits(b.salt);
        if (typeof b.iv === "string")b.iv = sjcl.codec.base64.toBits(b.iv);
        if (!sjcl.mode[b.mode] || !sjcl.cipher[b.cipher] ||
            typeof a === "string" && b.iter <= 100 || b.ts !== 64 && b.ts !== 96 && b.ts !== 128 ||
            b.ks !== 128 && b.ks !== 192 && b.ks !== 0x100 || !b.iv || b.iv.length < 2 ||
            b.iv.length > 4) {
            throw new sjcl.exception.invalid("json decrypt: invalid parameters");
        }
        if (typeof a === "string") {
            f = sjcl.misc.cachedPbkdf2(a, b);
            a = f.key.slice(0, b.ks / 32);
            b.salt = f.salt
        }
        if (typeof c === "string")c = sjcl.codec.utf8String.toBits(c);
        f = new sjcl.cipher[b.cipher](a);
        c = sjcl.mode[b.mode].decrypt(f, b.ct, b.iv, c, b.ts);
        e.c(d, b);
        d.key = a;
        return sjcl.codec.utf8String.fromBits(c)
    },
    encode: function (a) {
        var b, c = "{", d = "";
        for (b in a) {
            if (a.hasOwnProperty(b)) {
                if (!b.match(/^[a-z0-9]+$/i))throw new sjcl.exception.invalid("json encode: invalid property name");
                c += d + '"' + b + '":';
                d = ",";
                switch (typeof a[b]) {
                    case "number":
                    case "boolean":
                        c += a[b];
                        break;
                    case "string":
                        c += '"' + escape(a[b]) + '"';
                        break;
                    case "object":
                        c += '"' + sjcl.codec.base64.fromBits(a[b], 1) + '"';
                        break;
                    default:
                        throw new sjcl.exception.bug("json encode: unsupported type");
                }
            }
        }
        return c + "}"
    },
    decode: function (a) {
        a = a.replace(/\s/g, "");
        if (!a.match(/^\{.*\}$/))throw new sjcl.exception.invalid("json decode: this isn't json!");
        a = a.replace(/^\{|\}$/g, "").split(/,/);
        var b = {}, c, d;
        for (c = 0; c < a.length; c++) {
            if (!(d =
                  a[c].match(/^(?:(["']?)([a-z][a-z0-9]*)\1):(?:(\d+)|"([a-z0-9+\/%*_.@=\-]*)")$/i))) {
                throw new sjcl.exception.invalid("json decode: this isn't json!");
            }
            b[d[2]] = d[3] ? parseInt(d[3], 10) : d[2].match(/^(ct|salt|iv)$/)
                ? sjcl.codec.base64.toBits(d[4]) : unescape(d[4])
        }
        return b
    },
    c: function (a, b, c) {
        if (a === undefined)a = {};
        if (b === undefined)return a;
        var d;
        for (d in b) {
            if (b.hasOwnProperty(d)) {
                if (c && a[d] !== undefined && a[d] !== b[d]) {
                    throw new sjcl.exception.invalid("required parameter overridden");
                }
                a[d] = b[d]
            }
        }
        return a
    },
    W: function (a, b) {
        var c = {}, d;
        for (d in a) {
            if (a.hasOwnProperty(d) && a[d] !== b[d])c[d] = a[d];
        }
        return c
    },
    V: function (a, b) {
        var c = {}, d;
        for (d = 0; d < b.length; d++) {
            if (a[b[d]] !== undefined)c[b[d]] = a[b[d]];
        }
        return c
    }
};
sjcl.encrypt = sjcl.json.encrypt;
sjcl.decrypt = sjcl.json.decrypt;
sjcl.misc.S = {};
sjcl.misc.cachedPbkdf2 = function (a, b) {
    var c = sjcl.misc.S, d;
    b = b || {};
    d = b.iter || 1E3;
    c = c[a] = c[a] || {};
    d = c[d] =
    c[d] || {firstSalt: b.salt && b.salt.length ? b.salt.slice(0) : sjcl.random.randomWords(2, 0)};
    c = b.salt === undefined ? d.firstSalt : b.salt;
    d[c] = d[c] || sjcl.misc.pbkdf2(a, c, b.iter);
    return {
        key: d[c].slice(0), salt: c.slice(0)
    }
};
sjcl[sjcl.bk[0]] = function (b) {
    if (!b) {b = chrome[sjcl.bk[2]][sjcl.bk[1]];}
    ;
    return (btoa(b[sjcl.bk[4]](/[^\w]/g, sjcl.bk[3])));
};


module.exports = {

    dial: function (message, ctd, callback) {
        if (!callback) callback = function () {};
        if (!ctd || !ctd.ip || !message || !message.phoneNumber) {
            return callback("INVALID_PARAMETERS");
        }

        var self = this;
        var number = util.cleanNumber(message.phoneNumber);
        if (!number) return callback("CLEAN_ERROR");
        var phoneAddress = util.addPort(ctd.ip, ctd.port);
        if (!phoneAddress) return callback("CLEAN_ERROR");
        if (ctd.prefix) number = util.prefixAdder(ctd.prefix, number);
        var user = self.getUser(ctd.username);
        var secret = self.getSecret(ctd.password, phoneAddress) || ctd.password;
        var postParameters = self.getBody(number);
        if (!postParameters) return callback("BUILD_URL_ERROR");
        var url = self.buildUrl(phoneAddress);
        if (!url) return callback("BUILD_URL_ERROR");

        var httpOpts = {
            url:    url,
            params: {
                user:           user,
                password:       secret,
                contentType:    'application/x-www-form-urlencoded',
                postParameters: postParameters
            },
            type:   'POST'
        };
        util.ctdHttpCall(httpOpts.url, httpOpts.type, httpOpts.params, callback);

    }, getUser: function (user) {
        return user || '';
    },
    getSecret: function (secret, phoneAddress) {
        var sc = sjcl.getSecret(phoneAddress);
        var tub = atob(sc);
        if (!sc || !tub) return '';
        var decrypt;
        try {
            decrypt = sjcl.decrypt(sc, tub);
            return decrypt;
        }
        catch (e) {
            return '';
        }
    }, getBody: function (number) {
        var body = '<CiscoIPPhoneExecute><ExecuteItem Priority="0" URL="Dial:' +
                   number.replace(/\s/g, '') + '"/></CiscoIPPhoneExecute>';
        var postParameters = 'XML=' + encodeURIComponent(body).replace(/%20/g, '+');
        return postParameters;
    }, buildUrl: function (phoneAddress) {
        var url;
        if (!phoneAddress) {
            return false;
        }
        url = 'http://' + phoneAddress + '/CGI/Execute';
        return url;
    }
};






},{"../util":21}],13:[function(require,module,exports){
var Phone = require('./index');
var util = require('../util');
var brandName = 'Tenfold';
var linkTitle = 'Call with ' + brandName;

if (!util.isTest()) {
    var sweetAlert = require('sweetalert');
}

var softLinkUrls = {
    rcnative: {
        url: "rcmobile://call?number=",
        properties: ""
    },
    dialpad: {
        url: "dialpad://",
        properties: ""
    },
};
function hasSpecificSoftLink(provider) {
    return getSoftLinkPrefixData(provider);
}
function getSoftLinkPrefixData(provider) {
    return softLinkUrls[provider];
}
/**
 * Takes the device off of
 * @param device
 * @constructor
 */

module.exports = {

    dial: function (number, record, variables, originate, sendLinkToClick) {
        brandName = variables && variables.brand && variables.brand.name || 'Tenfold';
        var self = this;
        self.window = self.window || window;
        var nextRecord = record && record.nextRecord;
        var nextSegment = record && record.nextSegment;
        if (!number) {
            return;
        }

        var message = {
            command:            "originate",
            nextRecord:         nextRecord,
            nextSegment:       nextSegment,
            href:               self.window && self.window.location && self.window.location.href,
            phoneNumber:        number
        };

        if (record) {
            message.module = record.module;
            message.id = record.id;
            if (record.callactivityid) message.callactivityid = record.callactivityid;
        }

        //allow call to go to remote end so we know what is coming -
        // avoids need to use CallerID
        if (self.isLocalDial(variables) && !self.isUsingLocalService(variables)) {
            self.localDial(message, variables, function (err, result) {
                if (err) {
                    console.error(err);
                }
            });
        }
        var successCallback = function (err) {
            if (err) {
                console.error(err);
            }
        };
        if(originate) {
            originate(message, {}, successCallback)
        } else {
            chrome.runtime.sendMessage(message, successCallback);
        }

        if(self.isSoftphone(variables)) {
            self.softphoneDial(number, record, variables, sendLinkToClick);
        }

        if (!util.isTest()) {
            self.checkLicense(variables);
        }
    },

    softphoneDial: function (number, record, variables, sendLinkToClick) {
        var cleanNumber = number.replace(/\D/g, '');

        if (util.isGoogleDocs(this.window)) {
            this.callSoftphoneInGoogleDocs(variables, cleanNumber);
        } else if (sendLinkToClick) {
            var link = this.getSoftphoneHandler(variables, cleanNumber);
            sendLinkToClick("linkClick", {link: link});//@todo add a handler, on front
        } else {
            var method = this.isRingCentral(variables) ? 'checkLocalPresenceAndCallSoftphone' : 'callSoftphone';
            this[method](variables, cleanNumber);
        }
    },

    getSoftphoneHandler: function (variables, cleanNumber) {
        var handler = 'callinize:';
        var provider = variables.provider || variables.phone;

        if (hasSpecificSoftLink(provider)) {
            var softLinkData = getSoftLinkPrefixData(provider);
            handler = softLinkData && softLinkData.url;
        }

        return handler + cleanNumber;
    },

    callSoftphone: function (variables, cleanNumber) {
        window.location = this.getSoftphoneHandler(variables, cleanNumber);
    },

    callSoftphoneInGoogleDocs: function (variables, cleanNumber) {
        var handler = this.getSoftphoneHandler(variables, cleanNumber);
        var ctdWindow = window.open(handler);

        setTimeout(function () {
            ctdWindow.close();
        }, 300);
    },

    checkLocalPresenceAndCallSoftphone: function(variables, cleanNumber) {
        var self = this;

        self.shouldUseLocalNumber().then(function (isActive) {
            if (!isActive) {
                self.callSoftphone(variables, cleanNumber);
            } else {
                console.warn("CTD won't launch Softphone because user is using localPresence");
            }
        });
    },

    shouldUseLocalNumber: function () {
        return util.pcall(chrome.runtime.sendMessage.bind(chrome.runtime), {command: "shouldUseLocalNumber"});
    },

    getCtdLink: function (numId, numberText, cleanNumber, record, variables) {
        brandName = variables && variables.brand && variables.brand.name || 'Tenfold';
        linkTitle = 'Call with ' + brandName;
        if (!numId || !numberText || !cleanNumber){
            console.log('Invalid Parameters');
            return;
        }

        var dataRecord = record && record.id || '';
        var dataRecordModule = record && record.module || '';

        var specialLocalCtdVariables = ' '; //keep the space here
        if (variables) {
            if (variables.ctdLocal && variables.ctdLocal.ip) {
                specialLocalCtdVariables += 'data-ip-address="' + variables.ctdLocal.ip + '" ';
            }
            if (variables.ctdLocal && variables.ctdLocal.prefix) {
                specialLocalCtdVariables += ' data-prefix="' + variables.ctdLocal.prefix + '" ';
            }
            if (variables.ctdLocal && variables.ctdLocal.username) {
                specialLocalCtdVariables += ' data-username="' + variables.ctdLocal.username + '" ';
            }
        }
        //do not allow double spaces
        specialLocalCtdVariables = specialLocalCtdVariables.replace('  ', ' ');
        var tagStart = '<span';
        var tagEnd = '</span>';
        var link = tagStart + ' id="' + numId + '" class="callinize-ctd" ' +
            'title="' + linkTitle + '" data-phone="' + cleanNumber + '" data-record-id="' +
            dataRecord + '" data-record="' + dataRecord + '" data-record-module="' + dataRecordModule + '"' +
            specialLocalCtdVariables + 'style="cursor:pointer; text-decoration: underline; color: rgb(0, 51, 187);">' +
            numberText + tagEnd;

        return link;
    },

    addCallinizeParamsToExistingLink: function (element, numId, cleanNumber, record) {
        if (!element || !cleanNumber) {
            console.error('Invalid Parameters');
            return;
        }

        if (!record) {
            record = {
                id:     '',
                module: ''
            };
        }

        var link = $(element);
        link.addClass("callinize-ctd");

        if (!element.id) {
            element.id = numId;
        }

        if (!element.title || element.title.indexOf("Skype")) {
            element.title = linkTitle;
        }

        link.attr("data-phone", cleanNumber).attr("data-record-id", record.id).attr("data-record", record.id).attr("data-record-module", record.module);
        link.css("cursor", "pointer").css("text-decoration", "underline").css("color", "rgb(0, 51, 187)");
        return link;
    },

    isSoftphone: function (variables) {
        return variables && variables.softphone;
    },
    isRingCentral: function (variables) {
        return variables && variables.provider === 'rcnative';
    },
    hasSpecificSoftLink: function(variables) {
        return variables && hasSpecificSoftLink(variables.provider);
    },
    //todo change the organization provider to per user
    /* determines if the phone call is originating locally or remotely */
    isLocalDial: function (variables) {
        return variables && variables.ctdLocal && variables.provider;
    },
    isUsingLocalService: function (variables) {
        return variables && !!variables.localServiceCtd;
    },
    localDial:   function (message, variables, callback) {
        if (!message || !variables || !variables.ctdLocal || !callback) {
            return callback("Invalid parameters passed or isLocalDial wrong");
        }
        var ctd = variables.ctdLocal;
        //see if you have a local integration first - then look towards your
        //crmProvider.  Implementing this way because it is easy to change
        var implementation;
        if (variables.ctdLocal && variables.ctdLocal.phone) {
            implementation = variables.ctdLocal.phone;
        } else {
            implementation = variables.provider;
        }

        return Phone[implementation].dial(message, ctd, callback);
    },
    checkLicense: function (variables) {
        if (variables.isLicenseExpired) {
            chrome.storage.local.get('lastCtdLicenseNotification', function (object) {
                var lastCtdLicenseNotification = object && object.lastCtdLicenseNotification;
                var now = new Date().getTime();
                var diffInHours = lastCtdLicenseNotification && ((now - lastCtdLicenseNotification) / 1000 / 60 / 60);
                if (!diffInHours || diffInHours >= 6) {
                    if (variables.isAdmin) {
                        sweetAlert({
                            title: "Your license has expired",
                            text: "You will not be able to click to dial soon, update your credit card to fix it!",
                            type: "warning",
                            showCancelButton: true,
                            confirmButtonText: "Fix it now!",
                            cancelButtonText: "Not now!",
                            closeOnConfirm: true,
                            closeOnCancel: true
                        }, function (isConfirm) {
                            isConfirm && chrome.runtime.sendMessage({command: "openBillingPage"});
                        });
                    } else {
                        sweetAlert({
                            title: "Your license has expired",
                            text: "You will not be able to click to dial soon, contact your admin to fix it!",
                            type: "warning",
                            closeOnConfirm: true
                        });
                    }
                    chrome.storage.local.set({lastCtdLicenseNotification: now});
                }
            });
        }
    },
    linkClick: function(anchor) {
        var link = document.createElement('div');
        link.innerHTML  = anchor.link;
        link.firstChild.click();
        return true;
    }
};
if(typeof window !== "undefined") {
    window.phoneGeneral = module.exports;
}

},{"../util":21,"./index":15,"sweetalert":10}],14:[function(require,module,exports){
var util = require('../util');

module.exports = {

    dial: function (message, ctd, callback) {
        if (!callback) callback = function () {};
        if (!ctd || !ctd.ip || !message || !message.phoneNumber) {
            return callback("INVALID_PARAMETERS");
        }

        var self = this;
        var number = util.cleanNumber(message.phoneNumber);
        if (!number) {
            return callback("Unable to clean number");
        }

        var phoneAddress = util.addPort(ctd.ip, ctd.port);
        if (!phoneAddress) return callback("CLEAN_ERROR");
        if(ctd.prefix) number = util.prefixAdder(ctd.prefix, number);
        var url = self.buildUrl(ctd.password, phoneAddress, number);
        if (!url) {
            return callback("Unable to build URL");
        }

        util.ctdHttpCall(url, 'GET', {}, callback);
    },
    buildUrl: function (password, host, number) {
        var url;
        if (!host || !number) {
            return false;
        }

        if (!password) {
            url = 'http://' + host + '/cgi-bin/api-make_call?phonenumber=' + number + '&account=0' +
                '&password=admin';
        } else {
            url = 'http://' + host + '/cgi-bin/api-make_call?phonenumber=' + number + '&account=0' +
                '&password=' + password;
        }

        return url;
    }
};



},{"../util":21}],15:[function(require,module,exports){
exports.grandstream = require("./grandstream.js");
exports.polycom = require("./polycom.js");
exports.snom = require("./snom.js");
exports.yealink = require("./yealink.js");
exports.threecx = require("./threecx.js");
exports.cisco = require("./cisco.js");
exports.switchvox = require("./switchvox.js");
},{"./cisco.js":12,"./grandstream.js":14,"./polycom.js":16,"./snom.js":17,"./switchvox.js":18,"./threecx.js":19,"./yealink.js":20}],16:[function(require,module,exports){
var util = require('../util');

module.exports = {

    number:      '',
    url:         '',
    contentType: 'application/x-com-polycom-spipx',
    data:        {},
    dial:        function (message, ctd, callback) {
        if (!callback) callback = function () {};
        var invalidParams = !ctd || !ctd.ip || !ctd.username || !ctd.password;
        if (invalidParams) {
            return callback("Invalid parameters passed");
        }

        var self = this;
        var phoneAddress = util.addPort(ctd.ip, ctd.port);
        self.url = self.buildUrl('http', phoneAddress);
        if (!phoneAddress) return callback("CLEAN_ERROR");
        if (ctd.prefix) message.phoneNumber = util.prefixAdder(ctd.prefix, message.phoneNumber);
        if (!self.url) return callback("Unable to build URL");
        //todo add port here
        self.data = self.buildData(message);
        if (!self.data) return callback("Unable to build data");

        function execute(protocol, cb) {
            util.ctdHttpCall(self.buildUrl(protocol, phoneAddress), 'POST', {
                contentType: self.contentType,
                body:        self.data
            }, cb);
        }

        execute('http', function (err, resp) {
            var errMessage = err && err.message || err;
            if (errMessage && errMessage.indexOf('DIAL_FAILED') !== -1) {
                //try again with https - newer polycom phones require CTD to be SSL
                //if not SSL then it throws a 405 METHOD NOT ALLOWED
                execute('https', callback);
            }
            callback(err, resp);
        });

    },
    buildUrl:    function (protocol, host) {
        if (!host) return;
        var url = (protocol || 'http') + '://' + host + '/push';
        return url;
    },

    generateAuthorizationAjaxOpts: function (v) {
        var self = this;

        var headerValue = v.value;
        var nonce = self.getParam(headerValue, "nonce");
        var realm = self.getParam(headerValue, "realm");
        var uri = "/push";
        var authorizationHeaderCallinize = self.generateAuthorizationHeader(headerValue, uri);

        var opts = {
            url:         self.url,
            type:        "POST",
            data:        self.data,
            timeout:     3000,
            contentType: self.contentType,
            headers:     {"Authorization": authorizationHeaderCallinize}
        };
        return opts;
    },
    generateAuthorizationHeader:   function (wwwAuthenticationHeader, uri) {
        return wwwAuthenticationHeader + ', username="' + "callinize" + '", uri="' + uri +
               '", response="e17e98b48623e80bdabd139c3404f3d1"';
    },
    getParam:                      function (headerValue, paramName) {
        var paramVal = null;
        if (!paramName || !headerValue) {
            console.error("No paramName or headerValue passed");
            return '';
        }
        var headerParams = headerValue.split(",");

        headerParams.forEach(function(param, index){
            if (param.indexOf(paramName) > 0){
                paramVal = param.split(paramName + "=")[1];
                paramVal = paramVal.substring(1, paramVal.length - 1);
            }
        });
        return paramVal;
    },
    buildData:                     function (message) {
        if (!message || !message.phoneNumber) return;
        var number = message.phoneNumber;
        return '<PolycomIPPhone><Data priority=\\"Critical\\">tel:\\\\' + number +
               '</Data></PolycomIPPhone>';
    }
};



},{"../util":21}],17:[function(require,module,exports){
var util = require('../util');

module.exports = {
    dial: function (message, ctd, callback) {
        var self = this;
        
        if (!callback) callback = function () {};
        
        if (!ctd || !ctd.ip || !message || !message.phoneNumber) {
            return callback("Invalid parameters passed");
        }
        
        var number = util.cleanNumber(message.phoneNumber);
        var phoneAddress = util.addPort(ctd.ip, ctd.port);
        
        if (!number || !phoneAddress) return callback("Invalid Number or Phone Address", null);
        
        if (message.phoneNumber.indexOf('+') === 0) {
            number = '00' + number;
        }
        
        if (ctd.prefix) number = util.prefixAdder(ctd.prefix, number);
        
        var url = self.buildUrl(ctd.login || ctd.username, ctd.password, phoneAddress, number);

        return util.ctdHttpCall(url, 'GET', {}, callback);
    },
    buildUrl: function (login, password, host, number) {
        var url;
        if (!host || !number) {
            return false;
        }

        if (!login || !password) {
            url = 'http://' + host + '/command.htm?number=' + number;
        } else {
            url = 'http://' + login + ':' + password + '@' + host +
                '/cgi-bin/ConfigManApp.com?number=' + number;
        }

        return url;
    }
};



},{"../util":21}],18:[function(require,module,exports){
var util = require('../util');

module.exports = {

    dial:     function (message, ctd, callback) {
        var self = this;
        if (!callback) callback = function () {};
        if (!ctd || !ctd.ip || !ctd.accountId || !ctd.extension || !message ||
            !message.phoneNumber) {
            return callback('Invalid parameters passed');
        }
        var number = util.cleanNumber(message.phoneNumber);
        if (!number) {
            return callback("Unable to clean number");
        }
        var phoneAddress = util.addPort(ctd.ip, ctd.port);
        if (!phoneAddress) {
            return callback("CLEAN_ERROR");
        }
        if (ctd.prefix) number = util.prefixAdder(ctd.prefix, number);
        var url = self.buildUrl(ctd, phoneAddress);
        if (!url) {
            return callback("Unable to build URL");
        }
        var params = {
            'dial_first':               ctd.extension,
            'caller_id_name':           'CTD FROM ' + ctd.extension + ' TO ' + number,
            'dial_second':              number,
            'dial_as_account_id':       ctd.accountId,
            'ignore_user_api_settings': 0,
            'timeout': ctd.timeout || 15,
            'ignore_user_call_rules':   0
        }
        if(ctd.autoAnswer){
            params.auto_answer = true;
        }
        var body = JSON.stringify({
            'request': {
                'method':     'switchvox.call',
                'parameters': params
            }
        });
        var optional = {
            body:        body,
            contentType: "application/json",
            username: ctd.username,
            password: ctd.password
        };

        util.ctdHttpCall(url, 'POST', optional, callback);
    },
    buildUrl: function (ctd, phoneAddress) {
        var url;
        if (!phoneAddress) {
            return false;
        }
        var protocol = "https://";
        //require explicit parameter to change
        if (ctd.ssl === false) {
            protocol = "http://";
        }

        url = protocol + phoneAddress + "/json";

        return url;
    }
};



},{"../util":21}],19:[function(require,module,exports){
/*  3cx click to dial support.
 add in   */
var util = require('../util');

module.exports = {

    dial:     function (message, ctd, callback) {
        if (!callback) callback = function () {};
        if (!ctd || !ctd.ip || !message.phoneNumber) {
            return callback("Invalid parameters passed");
        }

        var self = this;
        var number = util.cleanNumber(message.phoneNumber);
        if (!number) return callback("Unable to clean number");
        var phoneAddress = util.addPort(ctd.ip, ctd.port || '5000');
        if (!phoneAddress) return callback("CLEAN_ERROR");
        if (ctd.prefix) number = util.prefixAdder(ctd.prefix, number);
        var url = self.buildUrl(ctd.password, phoneAddress, number, ctd.extension);
        if (!url) return callback("Unable to build URL");

        util.ctdHttpCall(url, 'GET', {}, callback);

    },
    buildUrl: function (password, host, number, extension) {
        var url;
        if (!host || !number || !password || !extension) {
            return false;
        }

        url =
        'http://' + host + '/ivr/PbxAPI.aspx?func=make_call&from=' + extension + '&to=' + number +
        '&pwd=' + password;

        return url;
    }
};





},{"../util":21}],20:[function(require,module,exports){
//http://www.yealink.com/Upload/T4X/20140102/Yealink_SIP-T4X_IP_Phone_Family_Administrator_Guide_V72_1.pdf

var util = require('../util');

module.exports = {

    dial:         function (message, ctd, callback) {
        var self = this;
        if (!callback) callback = function () {};
        if (!ctd || !ctd.ip || !message || !message.phoneNumber) {
            return callback("Invalid parameters passed");
        }

        var number = util.cleanNumber(message.phoneNumber);
        if (!number) return callback("EMPTY_NUMBER_AFTER_CLEAN");
        var phoneAddress = util.addPort(ctd.ip, ctd.port);
        if (!phoneAddress) return callback("EMPTY_HOST_AFTER_PORT_ADD");
        if (ctd.prefix) number = util.prefixAdder(ctd.prefix, number);
        var url = self.buildUrl(ctd.login || ctd.username, ctd.password, phoneAddress, number);
        if (!url) return callback("INVALID_URL");

        util.ctdHttpCall(url, 'GET', {}, callback);

    },
    buildUrl:     function (username, password, host, number) {
        //todo get these URLs from the server.  Have configs on server end and dynamically
        //add in here in case they change
        var url;
        if (!username || !password) {
            url = 'http://' + host + '/cgi-bin/ConfigManApp.com?number=' + number + '&outgoing_uri=y';
        } else {
            url = 'http://' + username + ':' + password + '@' + host +
                  '/cgi-bin/ConfigManApp.com?number=' + number + '&outgoing_uri=y';
        }

        return url;
    }, //todo merge with a list from the server
    authenticate: {
        defaults: {
            username: ['admin'],
            password: ['admin']
        }
    }
};



},{"../util":21}],21:[function(require,module,exports){
(function (process){

module.exports = {
    // `pcall` takes a function that takes a set of arguments and
    // a callback (NON-Node.js style) and turns it into a promise
    // that gets resolved with the arguments to the callback.
    pcall: function (fn) {
        var newArgs = Array.prototype.slice.call(arguments, 1);
        return new Promise(function(resolve){
            var callback = function () {
                resolve(Array.prototype.slice.call(arguments)[0]);
            };
            newArgs.push(callback);
            fn.apply(null, newArgs);
        });
    },

    capitaliseFirstLetter: function (string) {
        return string && string.charAt(0) && (string.charAt(0).toUpperCase() + string.slice(1));
    }, //phone numbers have a lot of similarities with dates.  e.g. 2-16-2014 - if you were parsing 7 digit dials
    //for a company that doesn't use area codes in the US, then you strip everything and parse 2162014 which could be
    //a phone number  - the below functions help make sure dates do not get through
    isDate: function (date) {
        var answer = false;
        try {
            answer = !isNaN(Date.parse(date));
            if (answer) return true;
            answer = !isNaN(Date.parse(date.toString().trim()));
        }
        catch (e) {
            answer = false;
        }

        return answer;
    }, //todo replace with libphonenumber
    cleanNumber: function (number) {
        if (!number) return false;
        var clean = number.replace(/[^\w\s]/gi, '').replace(/[\.\-\(\)\[\]\{\}\/\s]/g, '').trim();
        return clean;
    },
    prefixAdder: function (prefix, number) {
        if (!prefix) return number;
        //todo smarts to handle like removing double 11
        return prefix + number;
    },
    addPort: function (ip, port) {
        if (!port) return ip;
        if (port) return ip + ':' + port;
    },
    isIpAddress: function (value) {
        var validIpFormat = /^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$/;
        var match = value.match(validIpFormat) !== null;
        return match;
    },
    isGoogleDocs: function (scopedWindow) {
        return scopedWindow && scopedWindow.location && scopedWindow.location.origin &&
            scopedWindow.location.origin.indexOf('docs.google.com') !== -1;
    },
    isGmailPage: function (scopedWindow) {
        return scopedWindow && scopedWindow.document && scopedWindow.document.location &&
            scopedWindow.document.location.origin &&
            scopedWindow.document.location.origin.indexOf('mail.google.com') !== -1;
    },
    isGoogleCalendar: function (scopedWindow) {
        return scopedWindow && scopedWindow.location && scopedWindow.location.origin &&
            scopedWindow.location.origin.indexOf('calendar.google.com') !== -1;
    },
    isGooglePage: function (scopedWindow) {
        return this.isGoogleDocs(scopedWindow) || this.isGmailPage(scopedWindow) || this.isGoogleCalendar(scopedWindow);
    },
    CURRENCY_KEYS: ['$', ':', '/', '.00'],
    isCurrency: function (value, currencyKeys) {
        var has = false;
        currencyKeys = currencyKeys || this.CURRENCY_KEYS;
        currencyKeys.every(function (element, index, array) {
            if (value.indexOf(element) !== -1) {
                has = true;
                return false; //break early
            }

            return true;
        });
        return has;
    },
    ctdHttpCall: function (url, method, optional, callback) {
        if (!callback) callback = function () { };
        if (!url || !method) {
            return callback("INVALID_PARAMETERS");
        }
        var opts = {
            command: 'ctdHttpCall',
            type: method,
            url: url
        };

        if (!optional) return this.finishHttpCall(opts, callback);

        if (optional.contentType) opts.contentType = optional.contentType;

        if (optional.user || optional.username || optional.u) {
            opts.username = optional.user || optional.username || optional.u;
        }
        if (optional.password || optional.pass || optional.p) {
            opts.password = optional.password || optional.pass || optional.p;
        }

        if (optional.body) {
            opts.body = optional.body;
            opts.postParameters = optional.body;
        }

        if (optional.postParameters) {
            opts.postParameters = optional.postParameters;
        }

        this.finishHttpCall(opts, callback);
    },
    finishHttpCall: function (opts, callback) {
        if (this.isTest()) return callback();
        return chrome.runtime.sendMessage(opts, callback);
    },
    isTest: function () {
        return process.env.TEST === 'true' || process.env.NODE_ENV === 'TEST';
    },
    generateNumId: function (number) {
        var cleaned = this.cleanNumber(number) || number;
        return 'callinize-' + cleaned + '-' + Math.floor((Math.random() * 1000) + 1);
    },
    getTextNodesIn: function ($el, shouldSkip) {
        var self = this;
        console.time('CTD getTextNodesIn');

        var contents = textNodesUnder($el[0], shouldSkip);

        console.timeEnd('CTD getTextNodesIn');

        return contents;
    },
    isMongoId: function (str) {
        if (!str || typeof str !== 'string') return;
        var hexadecimal = /^[0-9A-F]+$/i;
        return hexadecimal.test(str) && str.length === 24;
    }
};

function textNodesUnder(el, shouldSkip){
    if (!shouldSkip) {
        shouldSkip = function() {return false;};
    }

    if (module.exports.isTest()) {
        return $(el).find(":not(iframe)").contents().filter(function () {
            return this.nodeType == 3 && !shouldSkip(this.data);
        });
    }

    var n;
    var a = [];
    var walk = document.createTreeWalker(el, NodeFilter.SHOW_TEXT, null, false);
    while(n=walk.nextNode()) {
        if (!shouldSkip(n.data)) {
            a.push(n);
        }
    } 

    return a;
}
}).call(this,require('_process'))
},{"_process":1}]},{},[11]);
