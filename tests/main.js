/* Zepto v1.1.6 - zepto event ajax form ie - zeptojs.com/license */
var Zepto=function(){function L(t){return null==t?String(t):j[S.call(t)]||"object"}function Z(t){return"function"==L(t)}function _(t){return null!=t&&t==t.window}function $(t){return null!=t&&t.nodeType==t.DOCUMENT_NODE}function D(t){return"object"==L(t)}function M(t){return D(t)&&!_(t)&&Object.getPrototypeOf(t)==Object.prototype}function R(t){return"number"==typeof t.length}function k(t){return s.call(t,function(t){return null!=t})}function z(t){return t.length>0?n.fn.concat.apply([],t):t}function F(t){return t.replace(/::/g,"/").replace(/([A-Z]+)([A-Z][a-z])/g,"$1_$2").replace(/([a-z\d])([A-Z])/g,"$1_$2").replace(/_/g,"-").toLowerCase()}function q(t){return t in f?f[t]:f[t]=new RegExp("(^|\\s)"+t+"(\\s|$)")}function H(t,e){return"number"!=typeof e||c[F(t)]?e:e+"px"}function I(t){var e,n;return u[t]||(e=a.createElement(t),a.body.appendChild(e),n=getComputedStyle(e,"").getPropertyValue("display"),e.parentNode.removeChild(e),"none"==n&&(n="block"),u[t]=n),u[t]}function V(t){return"children"in t?o.call(t.children):n.map(t.childNodes,function(t){return 1==t.nodeType?t:void 0})}function B(n,i,r){for(e in i)r&&(M(i[e])||A(i[e]))?(M(i[e])&&!M(n[e])&&(n[e]={}),A(i[e])&&!A(n[e])&&(n[e]=[]),B(n[e],i[e],r)):i[e]!==t&&(n[e]=i[e])}function U(t,e){return null==e?n(t):n(t).filter(e)}function J(t,e,n,i){return Z(e)?e.call(t,n,i):e}function X(t,e,n){null==n?t.removeAttribute(e):t.setAttribute(e,n)}function W(e,n){var i=e.className||"",r=i&&i.baseVal!==t;return n===t?r?i.baseVal:i:void(r?i.baseVal=n:e.className=n)}function Y(t){try{return t?"true"==t||("false"==t?!1:"null"==t?null:+t+""==t?+t:/^[\[\{]/.test(t)?n.parseJSON(t):t):t}catch(e){return t}}function G(t,e){e(t);for(var n=0,i=t.childNodes.length;i>n;n++)G(t.childNodes[n],e)}var t,e,n,i,C,N,r=[],o=r.slice,s=r.filter,a=window.document,u={},f={},c={"column-count":1,columns:1,"font-weight":1,"line-height":1,opacity:1,"z-index":1,zoom:1},l=/^\s*<(\w+|!)[^>]*>/,h=/^<(\w+)\s*\/?>(?:<\/\1>|)$/,p=/<(?!area|br|col|embed|hr|img|input|link|meta|param)(([\w:]+)[^>]*)\/>/gi,d=/^(?:body|html)$/i,m=/([A-Z])/g,g=["val","css","html","text","data","width","height","offset"],v=["after","prepend","before","append"],y=a.createElement("table"),x=a.createElement("tr"),b={tr:a.createElement("tbody"),tbody:y,thead:y,tfoot:y,td:x,th:x,"*":a.createElement("div")},w=/complete|loaded|interactive/,E=/^[\w-]*$/,j={},S=j.toString,T={},O=a.createElement("div"),P={tabindex:"tabIndex",readonly:"readOnly","for":"htmlFor","class":"className",maxlength:"maxLength",cellspacing:"cellSpacing",cellpadding:"cellPadding",rowspan:"rowSpan",colspan:"colSpan",usemap:"useMap",frameborder:"frameBorder",contenteditable:"contentEditable"},A=Array.isArray||function(t){return t instanceof Array};return T.matches=function(t,e){if(!e||!t||1!==t.nodeType)return!1;var n=t.webkitMatchesSelector||t.mozMatchesSelector||t.oMatchesSelector||t.matchesSelector;if(n)return n.call(t,e);var i,r=t.parentNode,o=!r;return o&&(r=O).appendChild(t),i=~T.qsa(r,e).indexOf(t),o&&O.removeChild(t),i},C=function(t){return t.replace(/-+(.)?/g,function(t,e){return e?e.toUpperCase():""})},N=function(t){return s.call(t,function(e,n){return t.indexOf(e)==n})},T.fragment=function(e,i,r){var s,u,f;return h.test(e)&&(s=n(a.createElement(RegExp.$1))),s||(e.replace&&(e=e.replace(p,"<$1></$2>")),i===t&&(i=l.test(e)&&RegExp.$1),i in b||(i="*"),f=b[i],f.innerHTML=""+e,s=n.each(o.call(f.childNodes),function(){f.removeChild(this)})),M(r)&&(u=n(s),n.each(r,function(t,e){g.indexOf(t)>-1?u[t](e):u.attr(t,e)})),s},T.Z=function(t,e){return t=t||[],t.__proto__=n.fn,t.selector=e||"",t},T.isZ=function(t){return t instanceof T.Z},T.init=function(e,i){var r;if(!e)return T.Z();if("string"==typeof e)if(e=e.trim(),"<"==e[0]&&l.test(e))r=T.fragment(e,RegExp.$1,i),e=null;else{if(i!==t)return n(i).find(e);r=T.qsa(a,e)}else{if(Z(e))return n(a).ready(e);if(T.isZ(e))return e;if(A(e))r=k(e);else if(D(e))r=[e],e=null;else if(l.test(e))r=T.fragment(e.trim(),RegExp.$1,i),e=null;else{if(i!==t)return n(i).find(e);r=T.qsa(a,e)}}return T.Z(r,e)},n=function(t,e){return T.init(t,e)},n.extend=function(t){var e,n=o.call(arguments,1);return"boolean"==typeof t&&(e=t,t=n.shift()),n.forEach(function(n){B(t,n,e)}),t},T.qsa=function(t,e){var n,i="#"==e[0],r=!i&&"."==e[0],s=i||r?e.slice(1):e,a=E.test(s);return $(t)&&a&&i?(n=t.getElementById(s))?[n]:[]:1!==t.nodeType&&9!==t.nodeType?[]:o.call(a&&!i?r?t.getElementsByClassName(s):t.getElementsByTagName(e):t.querySelectorAll(e))},n.contains=a.documentElement.contains?function(t,e){return t!==e&&t.contains(e)}:function(t,e){for(;e&&(e=e.parentNode);)if(e===t)return!0;return!1},n.type=L,n.isFunction=Z,n.isWindow=_,n.isArray=A,n.isPlainObject=M,n.isEmptyObject=function(t){var e;for(e in t)return!1;return!0},n.inArray=function(t,e,n){return r.indexOf.call(e,t,n)},n.camelCase=C,n.trim=function(t){return null==t?"":String.prototype.trim.call(t)},n.uuid=0,n.support={},n.expr={},n.map=function(t,e){var n,r,o,i=[];if(R(t))for(r=0;r<t.length;r++)n=e(t[r],r),null!=n&&i.push(n);else for(o in t)n=e(t[o],o),null!=n&&i.push(n);return z(i)},n.each=function(t,e){var n,i;if(R(t)){for(n=0;n<t.length;n++)if(e.call(t[n],n,t[n])===!1)return t}else for(i in t)if(e.call(t[i],i,t[i])===!1)return t;return t},n.grep=function(t,e){return s.call(t,e)},window.JSON&&(n.parseJSON=JSON.parse),n.each("Boolean Number String Function Array Date RegExp Object Error".split(" "),function(t,e){j["[object "+e+"]"]=e.toLowerCase()}),n.fn={forEach:r.forEach,reduce:r.reduce,push:r.push,sort:r.sort,indexOf:r.indexOf,concat:r.concat,map:function(t){return n(n.map(this,function(e,n){return t.call(e,n,e)}))},slice:function(){return n(o.apply(this,arguments))},ready:function(t){return w.test(a.readyState)&&a.body?t(n):a.addEventListener("DOMContentLoaded",function(){t(n)},!1),this},get:function(e){return e===t?o.call(this):this[e>=0?e:e+this.length]},toArray:function(){return this.get()},size:function(){return this.length},remove:function(){return this.each(function(){null!=this.parentNode&&this.parentNode.removeChild(this)})},each:function(t){return r.every.call(this,function(e,n){return t.call(e,n,e)!==!1}),this},filter:function(t){return Z(t)?this.not(this.not(t)):n(s.call(this,function(e){return T.matches(e,t)}))},add:function(t,e){return n(N(this.concat(n(t,e))))},is:function(t){return this.length>0&&T.matches(this[0],t)},not:function(e){var i=[];if(Z(e)&&e.call!==t)this.each(function(t){e.call(this,t)||i.push(this)});else{var r="string"==typeof e?this.filter(e):R(e)&&Z(e.item)?o.call(e):n(e);this.forEach(function(t){r.indexOf(t)<0&&i.push(t)})}return n(i)},has:function(t){return this.filter(function(){return D(t)?n.contains(this,t):n(this).find(t).size()})},eq:function(t){return-1===t?this.slice(t):this.slice(t,+t+1)},first:function(){var t=this[0];return t&&!D(t)?t:n(t)},last:function(){var t=this[this.length-1];return t&&!D(t)?t:n(t)},find:function(t){var e,i=this;return e=t?"object"==typeof t?n(t).filter(function(){var t=this;return r.some.call(i,function(e){return n.contains(e,t)})}):1==this.length?n(T.qsa(this[0],t)):this.map(function(){return T.qsa(this,t)}):n()},closest:function(t,e){var i=this[0],r=!1;for("object"==typeof t&&(r=n(t));i&&!(r?r.indexOf(i)>=0:T.matches(i,t));)i=i!==e&&!$(i)&&i.parentNode;return n(i)},parents:function(t){for(var e=[],i=this;i.length>0;)i=n.map(i,function(t){return(t=t.parentNode)&&!$(t)&&e.indexOf(t)<0?(e.push(t),t):void 0});return U(e,t)},parent:function(t){return U(N(this.pluck("parentNode")),t)},children:function(t){return U(this.map(function(){return V(this)}),t)},contents:function(){return this.map(function(){return o.call(this.childNodes)})},siblings:function(t){return U(this.map(function(t,e){return s.call(V(e.parentNode),function(t){return t!==e})}),t)},empty:function(){return this.each(function(){this.innerHTML=""})},pluck:function(t){return n.map(this,function(e){return e[t]})},show:function(){return this.each(function(){"none"==this.style.display&&(this.style.display=""),"none"==getComputedStyle(this,"").getPropertyValue("display")&&(this.style.display=I(this.nodeName))})},replaceWith:function(t){return this.before(t).remove()},wrap:function(t){var e=Z(t);if(this[0]&&!e)var i=n(t).get(0),r=i.parentNode||this.length>1;return this.each(function(o){n(this).wrapAll(e?t.call(this,o):r?i.cloneNode(!0):i)})},wrapAll:function(t){if(this[0]){n(this[0]).before(t=n(t));for(var e;(e=t.children()).length;)t=e.first();n(t).append(this)}return this},wrapInner:function(t){var e=Z(t);return this.each(function(i){var r=n(this),o=r.contents(),s=e?t.call(this,i):t;o.length?o.wrapAll(s):r.append(s)})},unwrap:function(){return this.parent().each(function(){n(this).replaceWith(n(this).children())}),this},clone:function(){return this.map(function(){return this.cloneNode(!0)})},hide:function(){return this.css("display","none")},toggle:function(e){return this.each(function(){var i=n(this);(e===t?"none"==i.css("display"):e)?i.show():i.hide()})},prev:function(t){return n(this.pluck("previousElementSibling")).filter(t||"*")},next:function(t){return n(this.pluck("nextElementSibling")).filter(t||"*")},html:function(t){return 0 in arguments?this.each(function(e){var i=this.innerHTML;n(this).empty().append(J(this,t,e,i))}):0 in this?this[0].innerHTML:null},text:function(t){return 0 in arguments?this.each(function(e){var n=J(this,t,e,this.textContent);this.textContent=null==n?"":""+n}):0 in this?this[0].textContent:null},attr:function(n,i){var r;return"string"!=typeof n||1 in arguments?this.each(function(t){if(1===this.nodeType)if(D(n))for(e in n)X(this,e,n[e]);else X(this,n,J(this,i,t,this.getAttribute(n)))}):this.length&&1===this[0].nodeType?!(r=this[0].getAttribute(n))&&n in this[0]?this[0][n]:r:t},removeAttr:function(t){return this.each(function(){1===this.nodeType&&t.split(" ").forEach(function(t){X(this,t)},this)})},prop:function(t,e){return t=P[t]||t,1 in arguments?this.each(function(n){this[t]=J(this,e,n,this[t])}):this[0]&&this[0][t]},data:function(e,n){var i="data-"+e.replace(m,"-$1").toLowerCase(),r=1 in arguments?this.attr(i,n):this.attr(i);return null!==r?Y(r):t},val:function(t){return 0 in arguments?this.each(function(e){this.value=J(this,t,e,this.value)}):this[0]&&(this[0].multiple?n(this[0]).find("option").filter(function(){return this.selected}).pluck("value"):this[0].value)},offset:function(t){if(t)return this.each(function(e){var i=n(this),r=J(this,t,e,i.offset()),o=i.offsetParent().offset(),s={top:r.top-o.top,left:r.left-o.left};"static"==i.css("position")&&(s.position="relative"),i.css(s)});if(!this.length)return null;var e=this[0].getBoundingClientRect();return{left:e.left+window.pageXOffset,top:e.top+window.pageYOffset,width:Math.round(e.width),height:Math.round(e.height)}},css:function(t,i){if(arguments.length<2){var r,o=this[0];if(!o)return;if(r=getComputedStyle(o,""),"string"==typeof t)return o.style[C(t)]||r.getPropertyValue(t);if(A(t)){var s={};return n.each(t,function(t,e){s[e]=o.style[C(e)]||r.getPropertyValue(e)}),s}}var a="";if("string"==L(t))i||0===i?a=F(t)+":"+H(t,i):this.each(function(){this.style.removeProperty(F(t))});else for(e in t)t[e]||0===t[e]?a+=F(e)+":"+H(e,t[e])+";":this.each(function(){this.style.removeProperty(F(e))});return this.each(function(){this.style.cssText+=";"+a})},index:function(t){return t?this.indexOf(n(t)[0]):this.parent().children().indexOf(this[0])},hasClass:function(t){return t?r.some.call(this,function(t){return this.test(W(t))},q(t)):!1},addClass:function(t){return t?this.each(function(e){if("className"in this){i=[];var r=W(this),o=J(this,t,e,r);o.split(/\s+/g).forEach(function(t){n(this).hasClass(t)||i.push(t)},this),i.length&&W(this,r+(r?" ":"")+i.join(" "))}}):this},removeClass:function(e){return this.each(function(n){if("className"in this){if(e===t)return W(this,"");i=W(this),J(this,e,n,i).split(/\s+/g).forEach(function(t){i=i.replace(q(t)," ")}),W(this,i.trim())}})},toggleClass:function(e,i){return e?this.each(function(r){var o=n(this),s=J(this,e,r,W(this));s.split(/\s+/g).forEach(function(e){(i===t?!o.hasClass(e):i)?o.addClass(e):o.removeClass(e)})}):this},scrollTop:function(e){if(this.length){var n="scrollTop"in this[0];return e===t?n?this[0].scrollTop:this[0].pageYOffset:this.each(n?function(){this.scrollTop=e}:function(){this.scrollTo(this.scrollX,e)})}},scrollLeft:function(e){if(this.length){var n="scrollLeft"in this[0];return e===t?n?this[0].scrollLeft:this[0].pageXOffset:this.each(n?function(){this.scrollLeft=e}:function(){this.scrollTo(e,this.scrollY)})}},position:function(){if(this.length){var t=this[0],e=this.offsetParent(),i=this.offset(),r=d.test(e[0].nodeName)?{top:0,left:0}:e.offset();return i.top-=parseFloat(n(t).css("margin-top"))||0,i.left-=parseFloat(n(t).css("margin-left"))||0,r.top+=parseFloat(n(e[0]).css("border-top-width"))||0,r.left+=parseFloat(n(e[0]).css("border-left-width"))||0,{top:i.top-r.top,left:i.left-r.left}}},offsetParent:function(){return this.map(function(){for(var t=this.offsetParent||a.body;t&&!d.test(t.nodeName)&&"static"==n(t).css("position");)t=t.offsetParent;return t})}},n.fn.detach=n.fn.remove,["width","height"].forEach(function(e){var i=e.replace(/./,function(t){return t[0].toUpperCase()});n.fn[e]=function(r){var o,s=this[0];return r===t?_(s)?s["inner"+i]:$(s)?s.documentElement["scroll"+i]:(o=this.offset())&&o[e]:this.each(function(t){s=n(this),s.css(e,J(this,r,t,s[e]()))})}}),v.forEach(function(t,e){var i=e%2;n.fn[t]=function(){var t,o,r=n.map(arguments,function(e){return t=L(e),"object"==t||"array"==t||null==e?e:T.fragment(e)}),s=this.length>1;return r.length<1?this:this.each(function(t,u){o=i?u:u.parentNode,u=0==e?u.nextSibling:1==e?u.firstChild:2==e?u:null;var f=n.contains(a.documentElement,o);r.forEach(function(t){if(s)t=t.cloneNode(!0);else if(!o)return n(t).remove();o.insertBefore(t,u),f&&G(t,function(t){null==t.nodeName||"SCRIPT"!==t.nodeName.toUpperCase()||t.type&&"text/javascript"!==t.type||t.src||window.eval.call(window,t.innerHTML)})})})},n.fn[i?t+"To":"insert"+(e?"Before":"After")]=function(e){return n(e)[t](this),this}}),T.Z.prototype=n.fn,T.uniq=N,T.deserializeValue=Y,n.zepto=T,n}();window.Zepto=Zepto,void 0===window.$&&(window.$=Zepto),function(t){function l(t){return t._zid||(t._zid=e++)}function h(t,e,n,i){if(e=p(e),e.ns)var r=d(e.ns);return(s[l(t)]||[]).filter(function(t){return!(!t||e.e&&t.e!=e.e||e.ns&&!r.test(t.ns)||n&&l(t.fn)!==l(n)||i&&t.sel!=i)})}function p(t){var e=(""+t).split(".");return{e:e[0],ns:e.slice(1).sort().join(" ")}}function d(t){return new RegExp("(?:^| )"+t.replace(" "," .* ?")+"(?: |$)")}function m(t,e){return t.del&&!u&&t.e in f||!!e}function g(t){return c[t]||u&&f[t]||t}function v(e,i,r,o,a,u,f){var h=l(e),d=s[h]||(s[h]=[]);i.split(/\s/).forEach(function(i){if("ready"==i)return t(document).ready(r);var s=p(i);s.fn=r,s.sel=a,s.e in c&&(r=function(e){var n=e.relatedTarget;return!n||n!==this&&!t.contains(this,n)?s.fn.apply(this,arguments):void 0}),s.del=u;var l=u||r;s.proxy=function(t){if(t=j(t),!t.isImmediatePropagationStopped()){t.data=o;var i=l.apply(e,t._args==n?[t]:[t].concat(t._args));return i===!1&&(t.preventDefault(),t.stopPropagation()),i}},s.i=d.length,d.push(s),"addEventListener"in e&&e.addEventListener(g(s.e),s.proxy,m(s,f))})}function y(t,e,n,i,r){var o=l(t);(e||"").split(/\s/).forEach(function(e){h(t,e,n,i).forEach(function(e){delete s[o][e.i],"removeEventListener"in t&&t.removeEventListener(g(e.e),e.proxy,m(e,r))})})}function j(e,i){return(i||!e.isDefaultPrevented)&&(i||(i=e),t.each(E,function(t,n){var r=i[t];e[t]=function(){return this[n]=x,r&&r.apply(i,arguments)},e[n]=b}),(i.defaultPrevented!==n?i.defaultPrevented:"returnValue"in i?i.returnValue===!1:i.getPreventDefault&&i.getPreventDefault())&&(e.isDefaultPrevented=x)),e}function S(t){var e,i={originalEvent:t};for(e in t)w.test(e)||t[e]===n||(i[e]=t[e]);return j(i,t)}var n,e=1,i=Array.prototype.slice,r=t.isFunction,o=function(t){return"string"==typeof t},s={},a={},u="onfocusin"in window,f={focus:"focusin",blur:"focusout"},c={mouseenter:"mouseover",mouseleave:"mouseout"};a.click=a.mousedown=a.mouseup=a.mousemove="MouseEvents",t.event={add:v,remove:y},t.proxy=function(e,n){var s=2 in arguments&&i.call(arguments,2);if(r(e)){var a=function(){return e.apply(n,s?s.concat(i.call(arguments)):arguments)};return a._zid=l(e),a}if(o(n))return s?(s.unshift(e[n],e),t.proxy.apply(null,s)):t.proxy(e[n],e);throw new TypeError("expected function")},t.fn.bind=function(t,e,n){return this.on(t,e,n)},t.fn.unbind=function(t,e){return this.off(t,e)},t.fn.one=function(t,e,n,i){return this.on(t,e,n,i,1)};var x=function(){return!0},b=function(){return!1},w=/^([A-Z]|returnValue$|layer[XY]$)/,E={preventDefault:"isDefaultPrevented",stopImmediatePropagation:"isImmediatePropagationStopped",stopPropagation:"isPropagationStopped"};t.fn.delegate=function(t,e,n){return this.on(e,t,n)},t.fn.undelegate=function(t,e,n){return this.off(e,t,n)},t.fn.live=function(e,n){return t(document.body).delegate(this.selector,e,n),this},t.fn.die=function(e,n){return t(document.body).undelegate(this.selector,e,n),this},t.fn.on=function(e,s,a,u,f){var c,l,h=this;return e&&!o(e)?(t.each(e,function(t,e){h.on(t,s,a,e,f)}),h):(o(s)||r(u)||u===!1||(u=a,a=s,s=n),(r(a)||a===!1)&&(u=a,a=n),u===!1&&(u=b),h.each(function(n,r){f&&(c=function(t){return y(r,t.type,u),u.apply(this,arguments)}),s&&(l=function(e){var n,o=t(e.target).closest(s,r).get(0);return o&&o!==r?(n=t.extend(S(e),{currentTarget:o,liveFired:r}),(c||u).apply(o,[n].concat(i.call(arguments,1)))):void 0}),v(r,e,u,a,s,l||c)}))},t.fn.off=function(e,i,s){var a=this;return e&&!o(e)?(t.each(e,function(t,e){a.off(t,i,e)}),a):(o(i)||r(s)||s===!1||(s=i,i=n),s===!1&&(s=b),a.each(function(){y(this,e,s,i)}))},t.fn.trigger=function(e,n){return e=o(e)||t.isPlainObject(e)?t.Event(e):j(e),e._args=n,this.each(function(){e.type in f&&"function"==typeof this[e.type]?this[e.type]():"dispatchEvent"in this?this.dispatchEvent(e):t(this).triggerHandler(e,n)})},t.fn.triggerHandler=function(e,n){var i,r;return this.each(function(s,a){i=S(o(e)?t.Event(e):e),i._args=n,i.target=a,t.each(h(a,e.type||e),function(t,e){return r=e.proxy(i),i.isImmediatePropagationStopped()?!1:void 0})}),r},"focusin focusout focus blur load resize scroll unload click dblclick mousedown mouseup mousemove mouseover mouseout mouseenter mouseleave change select keydown keypress keyup error".split(" ").forEach(function(e){t.fn[e]=function(t){return 0 in arguments?this.bind(e,t):this.trigger(e)}}),t.Event=function(t,e){o(t)||(e=t,t=e.type);var n=document.createEvent(a[t]||"Events"),i=!0;if(e)for(var r in e)"bubbles"==r?i=!!e[r]:n[r]=e[r];return n.initEvent(t,i,!0),j(n)}}(Zepto),function(t){function h(e,n,i){var r=t.Event(n);return t(e).trigger(r,i),!r.isDefaultPrevented()}function p(t,e,i,r){return t.global?h(e||n,i,r):void 0}function d(e){e.global&&0===t.active++&&p(e,null,"ajaxStart")}function m(e){e.global&&!--t.active&&p(e,null,"ajaxStop")}function g(t,e){var n=e.context;return e.beforeSend.call(n,t,e)===!1||p(e,n,"ajaxBeforeSend",[t,e])===!1?!1:void p(e,n,"ajaxSend",[t,e])}function v(t,e,n,i){var r=n.context,o="success";n.success.call(r,t,o,e),i&&i.resolveWith(r,[t,o,e]),p(n,r,"ajaxSuccess",[e,n,t]),x(o,e,n)}function y(t,e,n,i,r){var o=i.context;i.error.call(o,n,e,t),r&&r.rejectWith(o,[n,e,t]),p(i,o,"ajaxError",[n,i,t||e]),x(e,n,i)}function x(t,e,n){var i=n.context;n.complete.call(i,e,t),p(n,i,"ajaxComplete",[e,n]),m(n)}function b(){}function w(t){return t&&(t=t.split(";",2)[0]),t&&(t==f?"html":t==u?"json":s.test(t)?"script":a.test(t)&&"xml")||"text"}function E(t,e){return""==e?t:(t+"&"+e).replace(/[&?]{1,2}/,"?")}function j(e){e.processData&&e.data&&"string"!=t.type(e.data)&&(e.data=t.param(e.data,e.traditional)),!e.data||e.type&&"GET"!=e.type.toUpperCase()||(e.url=E(e.url,e.data),e.data=void 0)}function S(e,n,i,r){return t.isFunction(n)&&(r=i,i=n,n=void 0),t.isFunction(i)||(r=i,i=void 0),{url:e,data:n,success:i,dataType:r}}function C(e,n,i,r){var o,s=t.isArray(n),a=t.isPlainObject(n);t.each(n,function(n,u){o=t.type(u),r&&(n=i?r:r+"["+(a||"object"==o||"array"==o?n:"")+"]"),!r&&s?e.add(u.name,u.value):"array"==o||!i&&"object"==o?C(e,u,i,n):e.add(n,u)})}var i,r,e=0,n=window.document,o=/<script\b[^<]*(?:(?!<\/script>)<[^<]*)*<\/script>/gi,s=/^(?:text|application)\/javascript/i,a=/^(?:text|application)\/xml/i,u="application/json",f="text/html",c=/^\s*$/,l=n.createElement("a");l.href=window.location.href,t.active=0,t.ajaxJSONP=function(i,r){if(!("type"in i))return t.ajax(i);var f,h,o=i.jsonpCallback,s=(t.isFunction(o)?o():o)||"jsonp"+ ++e,a=n.createElement("script"),u=window[s],c=function(e){t(a).triggerHandler("error",e||"abort")},l={abort:c};return r&&r.promise(l),t(a).on("load error",function(e,n){clearTimeout(h),t(a).off().remove(),"error"!=e.type&&f?v(f[0],l,i,r):y(null,n||"error",l,i,r),window[s]=u,f&&t.isFunction(u)&&u(f[0]),u=f=void 0}),g(l,i)===!1?(c("abort"),l):(window[s]=function(){f=arguments},a.src=i.url.replace(/\?(.+)=\?/,"?$1="+s),n.head.appendChild(a),i.timeout>0&&(h=setTimeout(function(){c("timeout")},i.timeout)),l)},t.ajaxSettings={type:"GET",beforeSend:b,success:b,error:b,complete:b,context:null,global:!0,xhr:function(){return new window.XMLHttpRequest},accepts:{script:"text/javascript, application/javascript, application/x-javascript",json:u,xml:"application/xml, text/xml",html:f,text:"text/plain"},crossDomain:!1,timeout:0,processData:!0,cache:!0},t.ajax=function(e){var a,o=t.extend({},e||{}),s=t.Deferred&&t.Deferred();for(i in t.ajaxSettings)void 0===o[i]&&(o[i]=t.ajaxSettings[i]);d(o),o.crossDomain||(a=n.createElement("a"),a.href=o.url,a.href=a.href,o.crossDomain=l.protocol+"//"+l.host!=a.protocol+"//"+a.host),o.url||(o.url=window.location.toString()),j(o);var u=o.dataType,f=/\?.+=\?/.test(o.url);if(f&&(u="jsonp"),o.cache!==!1&&(e&&e.cache===!0||"script"!=u&&"jsonp"!=u)||(o.url=E(o.url,"_="+Date.now())),"jsonp"==u)return f||(o.url=E(o.url,o.jsonp?o.jsonp+"=?":o.jsonp===!1?"":"callback=?")),t.ajaxJSONP(o,s);var C,h=o.accepts[u],p={},m=function(t,e){p[t.toLowerCase()]=[t,e]},x=/^([\w-]+:)\/\//.test(o.url)?RegExp.$1:window.location.protocol,S=o.xhr(),T=S.setRequestHeader;if(s&&s.promise(S),o.crossDomain||m("X-Requested-With","XMLHttpRequest"),m("Accept",h||"*/*"),(h=o.mimeType||h)&&(h.indexOf(",")>-1&&(h=h.split(",",2)[0]),S.overrideMimeType&&S.overrideMimeType(h)),(o.contentType||o.contentType!==!1&&o.data&&"GET"!=o.type.toUpperCase())&&m("Content-Type",o.contentType||"application/x-www-form-urlencoded"),o.headers)for(r in o.headers)m(r,o.headers[r]);if(S.setRequestHeader=m,S.onreadystatechange=function(){if(4==S.readyState){S.onreadystatechange=b,clearTimeout(C);var e,n=!1;if(S.status>=200&&S.status<300||304==S.status||0==S.status&&"file:"==x){u=u||w(o.mimeType||S.getResponseHeader("content-type")),e=S.responseText;try{"script"==u?(1,eval)(e):"xml"==u?e=S.responseXML:"json"==u&&(e=c.test(e)?null:t.parseJSON(e))}catch(i){n=i}n?y(n,"parsererror",S,o,s):v(e,S,o,s)}else y(S.statusText||null,S.status?"error":"abort",S,o,s)}},g(S,o)===!1)return S.abort(),y(null,"abort",S,o,s),S;if(o.xhrFields)for(r in o.xhrFields)S[r]=o.xhrFields[r];var N="async"in o?o.async:!0;S.open(o.type,o.url,N,o.username,o.password);for(r in p)T.apply(S,p[r]);return o.timeout>0&&(C=setTimeout(function(){S.onreadystatechange=b,S.abort(),y(null,"timeout",S,o,s)},o.timeout)),S.send(o.data?o.data:null),S},t.get=function(){return t.ajax(S.apply(null,arguments))},t.post=function(){var e=S.apply(null,arguments);return e.type="POST",t.ajax(e)},t.getJSON=function(){var e=S.apply(null,arguments);return e.dataType="json",t.ajax(e)},t.fn.load=function(e,n,i){if(!this.length)return this;var a,r=this,s=e.split(/\s/),u=S(e,n,i),f=u.success;return s.length>1&&(u.url=s[0],a=s[1]),u.success=function(e){r.html(a?t("<div>").html(e.replace(o,"")).find(a):e),f&&f.apply(r,arguments)},t.ajax(u),this};var T=encodeURIComponent;t.param=function(e,n){var i=[];return i.add=function(e,n){t.isFunction(n)&&(n=n()),null==n&&(n=""),this.push(T(e)+"="+T(n))},C(i,e,n),i.join("&").replace(/%20/g,"+")}}(Zepto),function(t){t.fn.serializeArray=function(){var e,n,i=[],r=function(t){return t.forEach?t.forEach(r):void i.push({name:e,value:t})};return this[0]&&t.each(this[0].elements,function(i,o){n=o.type,e=o.name,e&&"fieldset"!=o.nodeName.toLowerCase()&&!o.disabled&&"submit"!=n&&"reset"!=n&&"button"!=n&&"file"!=n&&("radio"!=n&&"checkbox"!=n||o.checked)&&r(t(o).val())}),i},t.fn.serialize=function(){var t=[];return this.serializeArray().forEach(function(e){t.push(encodeURIComponent(e.name)+"="+encodeURIComponent(e.value))}),t.join("&")},t.fn.submit=function(e){if(0 in arguments)this.bind("submit",e);else if(this.length){var n=t.Event("submit");this.eq(0).trigger(n),n.isDefaultPrevented()||this.get(0).submit()}return this}}(Zepto),function(t){"__proto__"in{}||t.extend(t.zepto,{Z:function(e,n){return e=e||[],t.extend(e,t.fn),e.selector=n||"",e.__Z=!0,e},isZ:function(e){return"array"===t.type(e)&&"__Z"in e}});try{getComputedStyle(void 0)}catch(e){var n=getComputedStyle;window.getComputedStyle=function(t){try{return n(t)}catch(e){return null}}}}(Zepto);/**
 * marked - a markdown parser
 * Copyright (c) 2011-2014, Christopher Jeffrey. (MIT Licensed)
 * https://github.com/chjj/marked
 */
(function(){var block={newline:/^\n+/,code:/^( {4}[^\n]+\n*)+/,fences:noop,hr:/^( *[-*_]){3,} *(?:\n+|$)/,heading:/^ *(#{1,6}) *([^\n]+?) *#* *(?:\n+|$)/,nptable:noop,lheading:/^([^\n]+)\n *(=|-){2,} *(?:\n+|$)/,blockquote:/^( *>[^\n]+(\n(?!def)[^\n]+)*\n*)+/,list:/^( *)(bull) [\s\S]+?(?:hr|def|\n{2,}(?! )(?!\1bull )\n*|\s*$)/,html:/^ *(?:comment|closed|closing) *(?:\n{2,}|\s*$)/,def:/^ *\[([^\]]+)\]: *<?([^\s>]+)>?(?: +["(]([^\n]+)[")])? *(?:\n+|$)/,table:noop,paragraph:/^((?:[^\n]+\n?(?!hr|heading|lheading|blockquote|tag|def))+)\n*/,text:/^[^\n]+/};block.bullet=/(?:[*+-]|\d+\.)/;block.item=/^( *)(bull) [^\n]*(?:\n(?!\1bull )[^\n]*)*/;block.item=replace(block.item,"gm")(/bull/g,block.bullet)();block.list=replace(block.list)(/bull/g,block.bullet)("hr","\\n+(?=\\1?(?:[-*_] *){3,}(?:\\n+|$))")("def","\\n+(?="+block.def.source+")")();block.blockquote=replace(block.blockquote)("def",block.def)();block._tag="(?!(?:"+"a|em|strong|small|s|cite|q|dfn|abbr|data|time|code"+"|var|samp|kbd|sub|sup|i|b|u|mark|ruby|rt|rp|bdi|bdo"+"|span|br|wbr|ins|del|img)\\b)\\w+(?!:/|[^\\w\\s@]*@)\\b";block.html=replace(block.html)("comment",/<!--[\s\S]*?-->/)("closed",/<(tag)[\s\S]+?<\/\1>/)("closing",/<tag(?:"[^"]*"|'[^']*'|[^'">])*?>/)(/tag/g,block._tag)();block.paragraph=replace(block.paragraph)("hr",block.hr)("heading",block.heading)("lheading",block.lheading)("blockquote",block.blockquote)("tag","<"+block._tag)("def",block.def)();block.normal=merge({},block);block.gfm=merge({},block.normal,{fences:/^ *(`{3,}|~{3,}) *(\S+)? *\n([\s\S]+?)\s*\1 *(?:\n+|$)/,paragraph:/^/});block.gfm.paragraph=replace(block.paragraph)("(?!","(?!"+block.gfm.fences.source.replace("\\1","\\2")+"|"+block.list.source.replace("\\1","\\3")+"|")();block.tables=merge({},block.gfm,{nptable:/^ *(\S.*\|.*)\n *([-:]+ *\|[-| :]*)\n((?:.*\|.*(?:\n|$))*)\n*/,table:/^ *\|(.+)\n *\|( *[-:]+[-| :]*)\n((?: *\|.*(?:\n|$))*)\n*/});function Lexer(options){this.tokens=[];this.tokens.links={};this.options=options||marked.defaults;this.rules=block.normal;if(this.options.gfm){if(this.options.tables){this.rules=block.tables}else{this.rules=block.gfm}}}Lexer.rules=block;Lexer.lex=function(src,options){var lexer=new Lexer(options);return lexer.lex(src)};Lexer.prototype.lex=function(src){src=src.replace(/\r\n|\r/g,"\n").replace(/\t/g,"    ").replace(/\u00a0/g," ").replace(/\u2424/g,"\n");return this.token(src,true)};Lexer.prototype.token=function(src,top,bq){var src=src.replace(/^ +$/gm,""),next,loose,cap,bull,b,item,space,i,l;while(src){if(cap=this.rules.newline.exec(src)){src=src.substring(cap[0].length);if(cap[0].length>1){this.tokens.push({type:"space"})}}if(cap=this.rules.code.exec(src)){src=src.substring(cap[0].length);cap=cap[0].replace(/^ {4}/gm,"");this.tokens.push({type:"code",text:!this.options.pedantic?cap.replace(/\n+$/,""):cap});continue}if(cap=this.rules.fences.exec(src)){src=src.substring(cap[0].length);this.tokens.push({type:"code",lang:cap[2],text:cap[3]});continue}if(cap=this.rules.heading.exec(src)){src=src.substring(cap[0].length);this.tokens.push({type:"heading",depth:cap[1].length,text:cap[2]});continue}if(top&&(cap=this.rules.nptable.exec(src))){src=src.substring(cap[0].length);item={type:"table",header:cap[1].replace(/^ *| *\| *$/g,"").split(/ *\| */),align:cap[2].replace(/^ *|\| *$/g,"").split(/ *\| */),cells:cap[3].replace(/\n$/,"").split("\n")};for(i=0;i<item.align.length;i++){if(/^ *-+: *$/.test(item.align[i])){item.align[i]="right"}else if(/^ *:-+: *$/.test(item.align[i])){item.align[i]="center"}else if(/^ *:-+ *$/.test(item.align[i])){item.align[i]="left"}else{item.align[i]=null}}for(i=0;i<item.cells.length;i++){item.cells[i]=item.cells[i].split(/ *\| */)}this.tokens.push(item);continue}if(cap=this.rules.lheading.exec(src)){src=src.substring(cap[0].length);this.tokens.push({type:"heading",depth:cap[2]==="="?1:2,text:cap[1]});continue}if(cap=this.rules.hr.exec(src)){src=src.substring(cap[0].length);this.tokens.push({type:"hr"});continue}if(cap=this.rules.blockquote.exec(src)){src=src.substring(cap[0].length);this.tokens.push({type:"blockquote_start"});cap=cap[0].replace(/^ *> ?/gm,"");this.token(cap,top,true);this.tokens.push({type:"blockquote_end"});continue}if(cap=this.rules.list.exec(src)){src=src.substring(cap[0].length);bull=cap[2];this.tokens.push({type:"list_start",ordered:bull.length>1});cap=cap[0].match(this.rules.item);next=false;l=cap.length;i=0;for(;i<l;i++){item=cap[i];space=item.length;item=item.replace(/^ *([*+-]|\d+\.) +/,"");if(~item.indexOf("\n ")){space-=item.length;item=!this.options.pedantic?item.replace(new RegExp("^ {1,"+space+"}","gm"),""):item.replace(/^ {1,4}/gm,"")}if(this.options.smartLists&&i!==l-1){b=block.bullet.exec(cap[i+1])[0];if(bull!==b&&!(bull.length>1&&b.length>1)){src=cap.slice(i+1).join("\n")+src;i=l-1}}loose=next||/\n\n(?!\s*$)/.test(item);if(i!==l-1){next=item.charAt(item.length-1)==="\n";if(!loose)loose=next}this.tokens.push({type:loose?"loose_item_start":"list_item_start"});this.token(item,false,bq);this.tokens.push({type:"list_item_end"})}this.tokens.push({type:"list_end"});continue}if(cap=this.rules.html.exec(src)){src=src.substring(cap[0].length);this.tokens.push({type:this.options.sanitize?"paragraph":"html",pre:cap[1]==="pre"||cap[1]==="script"||cap[1]==="style",text:cap[0]});continue}if(!bq&&top&&(cap=this.rules.def.exec(src))){src=src.substring(cap[0].length);this.tokens.links[cap[1].toLowerCase()]={href:cap[2],title:cap[3]};continue}if(top&&(cap=this.rules.table.exec(src))){src=src.substring(cap[0].length);item={type:"table",header:cap[1].replace(/^ *| *\| *$/g,"").split(/ *\| */),align:cap[2].replace(/^ *|\| *$/g,"").split(/ *\| */),cells:cap[3].replace(/(?: *\| *)?\n$/,"").split("\n")};for(i=0;i<item.align.length;i++){if(/^ *-+: *$/.test(item.align[i])){item.align[i]="right"}else if(/^ *:-+: *$/.test(item.align[i])){item.align[i]="center"}else if(/^ *:-+ *$/.test(item.align[i])){item.align[i]="left"}else{item.align[i]=null}}for(i=0;i<item.cells.length;i++){item.cells[i]=item.cells[i].replace(/^ *\| *| *\| *$/g,"").split(/ *\| */)}this.tokens.push(item);continue}if(top&&(cap=this.rules.paragraph.exec(src))){src=src.substring(cap[0].length);this.tokens.push({type:"paragraph",text:cap[1].charAt(cap[1].length-1)==="\n"?cap[1].slice(0,-1):cap[1]});continue}if(cap=this.rules.text.exec(src)){src=src.substring(cap[0].length);this.tokens.push({type:"text",text:cap[0]});continue}if(src){throw new Error("Infinite loop on byte: "+src.charCodeAt(0))}}return this.tokens};var inline={escape:/^\\([\\`*{}\[\]()#+\-.!_>])/,autolink:/^<([^ >]+(@|:\/)[^ >]+)>/,url:noop,tag:/^<!--[\s\S]*?-->|^<\/?\w+(?:"[^"]*"|'[^']*'|[^'">])*?>/,link:/^!?\[(inside)\]\(href\)/,reflink:/^!?\[(inside)\]\s*\[([^\]]*)\]/,nolink:/^!?\[((?:\[[^\]]*\]|[^\[\]])*)\]/,strong:/^__([\s\S]+?)__(?!_)|^\*\*([\s\S]+?)\*\*(?!\*)/,em:/^\b_((?:__|[\s\S])+?)_\b|^\*((?:\*\*|[\s\S])+?)\*(?!\*)/,code:/^(`+)\s*([\s\S]*?[^`])\s*\1(?!`)/,br:/^ {2,}\n(?!\s*$)/,del:noop,text:/^[\s\S]+?(?=[\\<!\[_*`]| {2,}\n|$)/};inline._inside=/(?:\[[^\]]*\]|[^\[\]]|\](?=[^\[]*\]))*/;inline._href=/\s*<?([\s\S]*?)>?(?:\s+['"]([\s\S]*?)['"])?\s*/;inline.link=replace(inline.link)("inside",inline._inside)("href",inline._href)();inline.reflink=replace(inline.reflink)("inside",inline._inside)();inline.normal=merge({},inline);inline.pedantic=merge({},inline.normal,{strong:/^__(?=\S)([\s\S]*?\S)__(?!_)|^\*\*(?=\S)([\s\S]*?\S)\*\*(?!\*)/,em:/^_(?=\S)([\s\S]*?\S)_(?!_)|^\*(?=\S)([\s\S]*?\S)\*(?!\*)/});inline.gfm=merge({},inline.normal,{escape:replace(inline.escape)("])","~|])")(),url:/^(https?:\/\/[^\s<]+[^<.,:;"')\]\s])/,del:/^~~(?=\S)([\s\S]*?\S)~~/,text:replace(inline.text)("]|","~]|")("|","|https?://|")()});inline.breaks=merge({},inline.gfm,{br:replace(inline.br)("{2,}","*")(),text:replace(inline.gfm.text)("{2,}","*")()});function InlineLexer(links,options){this.options=options||marked.defaults;this.links=links;this.rules=inline.normal;this.renderer=this.options.renderer||new Renderer;this.renderer.options=this.options;if(!this.links){throw new Error("Tokens array requires a `links` property.")}if(this.options.gfm){if(this.options.breaks){this.rules=inline.breaks}else{this.rules=inline.gfm}}else if(this.options.pedantic){this.rules=inline.pedantic}}InlineLexer.rules=inline;InlineLexer.output=function(src,links,options){var inline=new InlineLexer(links,options);return inline.output(src)};InlineLexer.prototype.output=function(src){var out="",link,text,href,cap;while(src){if(cap=this.rules.escape.exec(src)){src=src.substring(cap[0].length);out+=cap[1];continue}if(cap=this.rules.autolink.exec(src)){src=src.substring(cap[0].length);if(cap[2]==="@"){text=cap[1].charAt(6)===":"?this.mangle(cap[1].substring(7)):this.mangle(cap[1]);href=this.mangle("mailto:")+text}else{text=escape(cap[1]);href=text}out+=this.renderer.link(href,null,text);continue}if(!this.inLink&&(cap=this.rules.url.exec(src))){src=src.substring(cap[0].length);text=escape(cap[1]);href=text;out+=this.renderer.link(href,null,text);continue}if(cap=this.rules.tag.exec(src)){if(!this.inLink&&/^<a /i.test(cap[0])){this.inLink=true}else if(this.inLink&&/^<\/a>/i.test(cap[0])){this.inLink=false}src=src.substring(cap[0].length);out+=this.options.sanitize?escape(cap[0]):cap[0];continue}if(cap=this.rules.link.exec(src)){src=src.substring(cap[0].length);this.inLink=true;out+=this.outputLink(cap,{href:cap[2],title:cap[3]});this.inLink=false;continue}if((cap=this.rules.reflink.exec(src))||(cap=this.rules.nolink.exec(src))){src=src.substring(cap[0].length);link=(cap[2]||cap[1]).replace(/\s+/g," ");link=this.links[link.toLowerCase()];if(!link||!link.href){out+=cap[0].charAt(0);src=cap[0].substring(1)+src;continue}this.inLink=true;out+=this.outputLink(cap,link);this.inLink=false;continue}if(cap=this.rules.strong.exec(src)){src=src.substring(cap[0].length);out+=this.renderer.strong(this.output(cap[2]||cap[1]));continue}if(cap=this.rules.em.exec(src)){src=src.substring(cap[0].length);out+=this.renderer.em(this.output(cap[2]||cap[1]));continue}if(cap=this.rules.code.exec(src)){src=src.substring(cap[0].length);out+=this.renderer.codespan(escape(cap[2],true));continue}if(cap=this.rules.br.exec(src)){src=src.substring(cap[0].length);out+=this.renderer.br();continue}if(cap=this.rules.del.exec(src)){src=src.substring(cap[0].length);out+=this.renderer.del(this.output(cap[1]));continue}if(cap=this.rules.text.exec(src)){src=src.substring(cap[0].length);out+=escape(this.smartypants(cap[0]));continue}if(src){throw new Error("Infinite loop on byte: "+src.charCodeAt(0))}}return out};InlineLexer.prototype.outputLink=function(cap,link){var href=escape(link.href),title=link.title?escape(link.title):null;return cap[0].charAt(0)!=="!"?this.renderer.link(href,title,this.output(cap[1])):this.renderer.image(href,title,escape(cap[1]))};InlineLexer.prototype.smartypants=function(text){if(!this.options.smartypants)return text;return text.replace(/--/g,"—").replace(/(^|[-\u2014/(\[{"\s])'/g,"$1‘").replace(/'/g,"’").replace(/(^|[-\u2014/(\[{\u2018\s])"/g,"$1“").replace(/"/g,"”").replace(/\.{3}/g,"…")};InlineLexer.prototype.mangle=function(text){var out="",l=text.length,i=0,ch;for(;i<l;i++){ch=text.charCodeAt(i);if(Math.random()>.5){ch="x"+ch.toString(16)}out+="&#"+ch+";"}return out};function Renderer(options){this.options=options||{}}Renderer.prototype.code=function(code,lang,escaped){if(this.options.highlight){var out=this.options.highlight(code,lang);if(out!=null&&out!==code){escaped=true;code=out}}if(!lang){return"<pre><code>"+(escaped?code:escape(code,true))+"\n</code></pre>"}return'<pre><code class="'+this.options.langPrefix+escape(lang,true)+'">'+(escaped?code:escape(code,true))+"\n</code></pre>\n"};Renderer.prototype.blockquote=function(quote){return"<blockquote>\n"+quote+"</blockquote>\n"};Renderer.prototype.html=function(html){return html};Renderer.prototype.heading=function(text,level,raw){return"<h"+level+' id="'+this.options.headerPrefix+raw.toLowerCase().replace(/[^\w]+/g,"-")+'">'+text+"</h"+level+">\n"};Renderer.prototype.hr=function(){return this.options.xhtml?"<hr/>\n":"<hr>\n"};Renderer.prototype.list=function(body,ordered){var type=ordered?"ol":"ul";return"<"+type+">\n"+body+"</"+type+">\n"};Renderer.prototype.listitem=function(text){return"<li>"+text+"</li>\n"};Renderer.prototype.paragraph=function(text){return"<p>"+text+"</p>\n"};Renderer.prototype.table=function(header,body){return"<table>\n"+"<thead>\n"+header+"</thead>\n"+"<tbody>\n"+body+"</tbody>\n"+"</table>\n"};Renderer.prototype.tablerow=function(content){return"<tr>\n"+content+"</tr>\n"};Renderer.prototype.tablecell=function(content,flags){var type=flags.header?"th":"td";var tag=flags.align?"<"+type+' style="text-align:'+flags.align+'">':"<"+type+">";return tag+content+"</"+type+">\n"};Renderer.prototype.strong=function(text){return"<strong>"+text+"</strong>"};Renderer.prototype.em=function(text){return"<em>"+text+"</em>"};Renderer.prototype.codespan=function(text){return"<code>"+text+"</code>"};Renderer.prototype.br=function(){return this.options.xhtml?"<br/>":"<br>"};Renderer.prototype.del=function(text){return"<del>"+text+"</del>"};Renderer.prototype.link=function(href,title,text){if(this.options.sanitize){try{var prot=decodeURIComponent(unescape(href)).replace(/[^\w:]/g,"").toLowerCase()}catch(e){return""}if(prot.indexOf("javascript:")===0){return""}}var out='<a href="'+href+'"';if(title){out+=' title="'+title+'"'}out+=">"+text+"</a>";return out};Renderer.prototype.image=function(href,title,text){var out='<img src="'+href+'" alt="'+text+'"';if(title){out+=' title="'+title+'"'}out+=this.options.xhtml?"/>":">";return out};function Parser(options){this.tokens=[];this.token=null;this.options=options||marked.defaults;this.options.renderer=this.options.renderer||new Renderer;this.renderer=this.options.renderer;this.renderer.options=this.options}Parser.parse=function(src,options,renderer){var parser=new Parser(options,renderer);return parser.parse(src)};Parser.prototype.parse=function(src){this.inline=new InlineLexer(src.links,this.options,this.renderer);this.tokens=src.reverse();var out="";while(this.next()){out+=this.tok()}return out};Parser.prototype.next=function(){return this.token=this.tokens.pop()};Parser.prototype.peek=function(){return this.tokens[this.tokens.length-1]||0};Parser.prototype.parseText=function(){var body=this.token.text;while(this.peek().type==="text"){body+="\n"+this.next().text}return this.inline.output(body)};Parser.prototype.tok=function(){switch(this.token.type){case"space":{return""}case"hr":{return this.renderer.hr()}case"heading":{return this.renderer.heading(this.inline.output(this.token.text),this.token.depth,this.token.text)}case"code":{return this.renderer.code(this.token.text,this.token.lang,this.token.escaped)}case"table":{var header="",body="",i,row,cell,flags,j;cell="";for(i=0;i<this.token.header.length;i++){flags={header:true,align:this.token.align[i]};cell+=this.renderer.tablecell(this.inline.output(this.token.header[i]),{header:true,align:this.token.align[i]})}header+=this.renderer.tablerow(cell);for(i=0;i<this.token.cells.length;i++){row=this.token.cells[i];cell="";for(j=0;j<row.length;j++){cell+=this.renderer.tablecell(this.inline.output(row[j]),{header:false,align:this.token.align[j]})}body+=this.renderer.tablerow(cell)}return this.renderer.table(header,body)}case"blockquote_start":{var body="";while(this.next().type!=="blockquote_end"){body+=this.tok()}return this.renderer.blockquote(body)}case"list_start":{var body="",ordered=this.token.ordered;while(this.next().type!=="list_end"){body+=this.tok()}return this.renderer.list(body,ordered)}case"list_item_start":{var body="";while(this.next().type!=="list_item_end"){body+=this.token.type==="text"?this.parseText():this.tok()}return this.renderer.listitem(body)}case"loose_item_start":{var body="";while(this.next().type!=="list_item_end"){body+=this.tok()}return this.renderer.listitem(body)}case"html":{var html=!this.token.pre&&!this.options.pedantic?this.inline.output(this.token.text):this.token.text;return this.renderer.html(html)}case"paragraph":{return this.renderer.paragraph(this.inline.output(this.token.text))}case"text":{return this.renderer.paragraph(this.parseText())}}};function escape(html,encode){return html.replace(!encode?/&(?!#?\w+;)/g:/&/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/"/g,"&quot;").replace(/'/g,"&#39;")}function unescape(html){return html.replace(/&([#\w]+);/g,function(_,n){n=n.toLowerCase();if(n==="colon")return":";if(n.charAt(0)==="#"){return n.charAt(1)==="x"?String.fromCharCode(parseInt(n.substring(2),16)):String.fromCharCode(+n.substring(1))}return""})}function replace(regex,opt){regex=regex.source;opt=opt||"";return function self(name,val){if(!name)return new RegExp(regex,opt);val=val.source||val;val=val.replace(/(^|[^\[])\^/g,"$1");regex=regex.replace(name,val);return self}}function noop(){}noop.exec=noop;function merge(obj){var i=1,target,key;for(;i<arguments.length;i++){target=arguments[i];for(key in target){if(Object.prototype.hasOwnProperty.call(target,key)){obj[key]=target[key]}}}return obj}function marked(src,opt,callback){if(callback||typeof opt==="function"){if(!callback){callback=opt;opt=null}opt=merge({},marked.defaults,opt||{});var highlight=opt.highlight,tokens,pending,i=0;try{tokens=Lexer.lex(src,opt)}catch(e){return callback(e)}pending=tokens.length;var done=function(err){if(err){opt.highlight=highlight;return callback(err)}var out;try{out=Parser.parse(tokens,opt)}catch(e){err=e}opt.highlight=highlight;return err?callback(err):callback(null,out)};if(!highlight||highlight.length<3){return done()}delete opt.highlight;if(!pending)return done();for(;i<tokens.length;i++){(function(token){if(token.type!=="code"){return--pending||done()}return highlight(token.text,token.lang,function(err,code){if(err)return done(err);if(code==null||code===token.text){return--pending||done()}token.text=code;token.escaped=true;--pending||done()})})(tokens[i])}return}try{if(opt)opt=merge({},marked.defaults,opt);return Parser.parse(Lexer.lex(src,opt),opt)}catch(e){e.message+="\nPlease report this to https://github.com/chjj/marked.";if((opt||marked.defaults).silent){return"<p>An error occured:</p><pre>"+escape(e.message+"",true)+"</pre>"}throw e}}marked.options=marked.setOptions=function(opt){merge(marked.defaults,opt);return marked};marked.defaults={gfm:true,tables:true,breaks:false,pedantic:false,sanitize:false,smartLists:false,silent:false,highlight:null,langPrefix:"lang-",smartypants:false,headerPrefix:"",renderer:new Renderer,xhtml:false};marked.Parser=Parser;marked.parser=Parser.parse;marked.Renderer=Renderer;marked.Lexer=Lexer;marked.lexer=Lexer.lex;marked.InlineLexer=InlineLexer;marked.inlineLexer=InlineLexer.output;marked.parse=marked;if(typeof module!=="undefined"&&typeof exports==="object"){module.exports=marked}else if(typeof define==="function"&&define.amd){define(function(){return marked})}else{this.marked=marked}}).call(function(){return this||(typeof window!=="undefined"?window:global)}());PEG = {}

PEG.mainParser = (function() {
  /*
   * Generated by PEG.js 0.8.0.
   *
   * http://pegjs.majda.cz/
   */

  function peg$subclass(child, parent) {
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
  }

  function SyntaxError(message, expected, found, offset, line, column) {
    this.message  = message;
    this.expected = expected;
    this.found    = found;
    this.offset   = offset;
    this.line     = line;
    this.column   = column;

    this.name     = "SyntaxError";
  }

  peg$subclass(SyntaxError, Error);

  function parse(input) {
    var options = arguments.length > 1 ? arguments[1] : {},

        peg$FAILED = {},

        peg$startRuleFunctions = { start: peg$parsestart },
        peg$startRuleFunction  = peg$parsestart,

        peg$c0 = peg$FAILED,
        peg$c1 = [],
        peg$c2 = null,
        peg$c3 = ";",
        peg$c4 = { type: "literal", value: ";", description: "\";\"" },
        peg$c5 = ":",
        peg$c6 = { type: "literal", value: ":", description: "\":\"" },
        peg$c7 = function(l, r) { MetaParser._processMain(l,r) },
        peg$c8 = " ",
        peg$c9 = { type: "literal", value: " ", description: "\" \"" },
        peg$c10 = function(s) { MetaParser._indent = s.length },
        peg$c11 = void 0,
        peg$c12 = "//",
        peg$c13 = { type: "literal", value: "//", description: "\"//\"" },
        peg$c14 = "/*",
        peg$c15 = { type: "literal", value: "/*", description: "\"/*\"" },
        peg$c16 = /^[^\n]/,
        peg$c17 = { type: "class", value: "[^\\n]", description: "[^\\n]" },
        peg$c18 = function(c) { return c },
        peg$c19 = /^[^:\n]/,
        peg$c20 = { type: "class", value: "[^:\\n]", description: "[^:\\n]" },
        peg$c21 = /^[^;\n]/,
        peg$c22 = { type: "class", value: "[^;\\n]", description: "[^;\\n]" },
        peg$c23 = function(c) { return c.join("") },
        peg$c24 = "\"",
        peg$c25 = { type: "literal", value: "\"", description: "\"\\\"\"" },
        peg$c26 = "\n",
        peg$c27 = { type: "literal", value: "\n", description: "\"\\n\"" },
        peg$c28 = "*/",
        peg$c29 = { type: "literal", value: "*/", description: "\"*/\"" },
        peg$c30 = { type: "any", description: "any character" },

        peg$currPos          = 0,
        peg$reportedPos      = 0,
        peg$cachedPos        = 0,
        peg$cachedPosDetails = { line: 1, column: 1, seenCR: false },
        peg$maxFailPos       = 0,
        peg$maxFailExpected  = [],
        peg$silentFails      = 0,

        peg$result;

    if ("startRule" in options) {
      if (!(options.startRule in peg$startRuleFunctions)) {
        throw new Error("Can't start parsing from rule \"" + options.startRule + "\".");
      }

      peg$startRuleFunction = peg$startRuleFunctions[options.startRule];
    }

    function text() {
      return input.substring(peg$reportedPos, peg$currPos);
    }

    function offset() {
      return peg$reportedPos;
    }

    function line() {
      return peg$computePosDetails(peg$reportedPos).line;
    }

    function column() {
      return peg$computePosDetails(peg$reportedPos).column;
    }

    function expected(description) {
      throw peg$buildException(
        null,
        [{ type: "other", description: description }],
        peg$reportedPos
      );
    }

    function error(message) {
      throw peg$buildException(message, null, peg$reportedPos);
    }

    function peg$computePosDetails(pos) {
      function advance(details, startPos, endPos) {
        var p, ch;

        for (p = startPos; p < endPos; p++) {
          ch = input.charAt(p);
          if (ch === "\n") {
            if (!details.seenCR) { details.line++; }
            details.column = 1;
            details.seenCR = false;
          } else if (ch === "\r" || ch === "\u2028" || ch === "\u2029") {
            details.line++;
            details.column = 1;
            details.seenCR = true;
          } else {
            details.column++;
            details.seenCR = false;
          }
        }
      }

      if (peg$cachedPos !== pos) {
        if (peg$cachedPos > pos) {
          peg$cachedPos = 0;
          peg$cachedPosDetails = { line: 1, column: 1, seenCR: false };
        }
        advance(peg$cachedPosDetails, peg$cachedPos, pos);
        peg$cachedPos = pos;
      }

      return peg$cachedPosDetails;
    }

    function peg$fail(expected) {
      if (peg$currPos < peg$maxFailPos) { return; }

      if (peg$currPos > peg$maxFailPos) {
        peg$maxFailPos = peg$currPos;
        peg$maxFailExpected = [];
      }

      peg$maxFailExpected.push(expected);
    }

    function peg$buildException(message, expected, pos) {
      function cleanupExpected(expected) {
        var i = 1;

        expected.sort(function(a, b) {
          if (a.description < b.description) {
            return -1;
          } else if (a.description > b.description) {
            return 1;
          } else {
            return 0;
          }
        });

        while (i < expected.length) {
          if (expected[i - 1] === expected[i]) {
            expected.splice(i, 1);
          } else {
            i++;
          }
        }
      }

      function buildMessage(expected, found) {
        function stringEscape(s) {
          function hex(ch) { return ch.charCodeAt(0).toString(16).toUpperCase(); }

          return s
            .replace(/\\/g,   '\\\\')
            .replace(/"/g,    '\\"')
            .replace(/\x08/g, '\\b')
            .replace(/\t/g,   '\\t')
            .replace(/\n/g,   '\\n')
            .replace(/\f/g,   '\\f')
            .replace(/\r/g,   '\\r')
            .replace(/[\x00-\x07\x0B\x0E\x0F]/g, function(ch) { return '\\x0' + hex(ch); })
            .replace(/[\x10-\x1F\x80-\xFF]/g,    function(ch) { return '\\x'  + hex(ch); })
            .replace(/[\u0180-\u0FFF]/g,         function(ch) { return '\\u0' + hex(ch); })
            .replace(/[\u1080-\uFFFF]/g,         function(ch) { return '\\u'  + hex(ch); });
        }

        var expectedDescs = new Array(expected.length),
            expectedDesc, foundDesc, i;

        for (i = 0; i < expected.length; i++) {
          expectedDescs[i] = expected[i].description;
        }

        expectedDesc = expected.length > 1
          ? expectedDescs.slice(0, -1).join(", ")
              + " or "
              + expectedDescs[expected.length - 1]
          : expectedDescs[0];

        foundDesc = found ? "\"" + stringEscape(found) + "\"" : "end of input";

        return "Expected " + expectedDesc + " but " + foundDesc + " found.";
      }

      var posDetails = peg$computePosDetails(pos),
          found      = pos < input.length ? input.charAt(pos) : null;

      if (expected !== null) {
        cleanupExpected(expected);
      }

      return new SyntaxError(
        message !== null ? message : buildMessage(expected, found),
        expected,
        found,
        pos,
        posDetails.line,
        posDetails.column
      );
    }

    function peg$parsestart() {
      var s0, s1, s2, s3, s4, s5;

      s0 = peg$currPos;
      s1 = peg$parseline();
      if (s1 !== peg$FAILED) {
        s2 = [];
        s3 = peg$currPos;
        s4 = peg$parsenl();
        if (s4 !== peg$FAILED) {
          s5 = peg$parseline();
          if (s5 !== peg$FAILED) {
            s4 = [s4, s5];
            s3 = s4;
          } else {
            peg$currPos = s3;
            s3 = peg$c0;
          }
        } else {
          peg$currPos = s3;
          s3 = peg$c0;
        }
        while (s3 !== peg$FAILED) {
          s2.push(s3);
          s3 = peg$currPos;
          s4 = peg$parsenl();
          if (s4 !== peg$FAILED) {
            s5 = peg$parseline();
            if (s5 !== peg$FAILED) {
              s4 = [s4, s5];
              s3 = s4;
            } else {
              peg$currPos = s3;
              s3 = peg$c0;
            }
          } else {
            peg$currPos = s3;
            s3 = peg$c0;
          }
        }
        if (s2 !== peg$FAILED) {
          s3 = peg$parsenl();
          if (s3 === peg$FAILED) {
            s3 = peg$c2;
          }
          if (s3 !== peg$FAILED) {
            s1 = [s1, s2, s3];
            s0 = s1;
          } else {
            peg$currPos = s0;
            s0 = peg$c0;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$c0;
      }

      return s0;
    }

    function peg$parseline() {
      var s0, s1, s2, s3, s4, s5, s6;

      s0 = peg$currPos;
      s1 = peg$parseindent();
      if (s1 !== peg$FAILED) {
        s2 = peg$parsepair();
        if (s2 !== peg$FAILED) {
          s3 = [];
          s4 = peg$currPos;
          if (input.charCodeAt(peg$currPos) === 59) {
            s5 = peg$c3;
            peg$currPos++;
          } else {
            s5 = peg$FAILED;
            if (peg$silentFails === 0) { peg$fail(peg$c4); }
          }
          if (s5 !== peg$FAILED) {
            s6 = peg$parsepair();
            if (s6 !== peg$FAILED) {
              s5 = [s5, s6];
              s4 = s5;
            } else {
              peg$currPos = s4;
              s4 = peg$c0;
            }
          } else {
            peg$currPos = s4;
            s4 = peg$c0;
          }
          while (s4 !== peg$FAILED) {
            s3.push(s4);
            s4 = peg$currPos;
            if (input.charCodeAt(peg$currPos) === 59) {
              s5 = peg$c3;
              peg$currPos++;
            } else {
              s5 = peg$FAILED;
              if (peg$silentFails === 0) { peg$fail(peg$c4); }
            }
            if (s5 !== peg$FAILED) {
              s6 = peg$parsepair();
              if (s6 !== peg$FAILED) {
                s5 = [s5, s6];
                s4 = s5;
              } else {
                peg$currPos = s4;
                s4 = peg$c0;
              }
            } else {
              peg$currPos = s4;
              s4 = peg$c0;
            }
          }
          if (s3 !== peg$FAILED) {
            if (input.charCodeAt(peg$currPos) === 59) {
              s4 = peg$c3;
              peg$currPos++;
            } else {
              s4 = peg$FAILED;
              if (peg$silentFails === 0) { peg$fail(peg$c4); }
            }
            if (s4 === peg$FAILED) {
              s4 = peg$c2;
            }
            if (s4 !== peg$FAILED) {
              s5 = peg$parsecomment();
              if (s5 === peg$FAILED) {
                s5 = peg$c2;
              }
              if (s5 !== peg$FAILED) {
                s1 = [s1, s2, s3, s4, s5];
                s0 = s1;
              } else {
                peg$currPos = s0;
                s0 = peg$c0;
              }
            } else {
              peg$currPos = s0;
              s0 = peg$c0;
            }
          } else {
            peg$currPos = s0;
            s0 = peg$c0;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$c0;
      }
      if (s0 === peg$FAILED) {
        s0 = peg$currPos;
        s1 = peg$parsews();
        if (s1 !== peg$FAILED) {
          s2 = peg$parsecomment();
          if (s2 === peg$FAILED) {
            s2 = peg$c2;
          }
          if (s2 !== peg$FAILED) {
            s1 = [s1, s2];
            s0 = s1;
          } else {
            peg$currPos = s0;
            s0 = peg$c0;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      }

      return s0;
    }

    function peg$parsepair() {
      var s0, s1, s2, s3;

      s0 = peg$currPos;
      s1 = peg$parseleft();
      if (s1 !== peg$FAILED) {
        if (input.charCodeAt(peg$currPos) === 58) {
          s2 = peg$c5;
          peg$currPos++;
        } else {
          s2 = peg$FAILED;
          if (peg$silentFails === 0) { peg$fail(peg$c6); }
        }
        if (s2 !== peg$FAILED) {
          s3 = peg$parseright();
          if (s3 !== peg$FAILED) {
            peg$reportedPos = s0;
            s1 = peg$c7(s1, s3);
            s0 = s1;
          } else {
            peg$currPos = s0;
            s0 = peg$c0;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$c0;
      }

      return s0;
    }

    function peg$parseindent() {
      var s0, s1, s2;

      s0 = peg$currPos;
      s1 = [];
      if (input.charCodeAt(peg$currPos) === 32) {
        s2 = peg$c8;
        peg$currPos++;
      } else {
        s2 = peg$FAILED;
        if (peg$silentFails === 0) { peg$fail(peg$c9); }
      }
      while (s2 !== peg$FAILED) {
        s1.push(s2);
        if (input.charCodeAt(peg$currPos) === 32) {
          s2 = peg$c8;
          peg$currPos++;
        } else {
          s2 = peg$FAILED;
          if (peg$silentFails === 0) { peg$fail(peg$c9); }
        }
      }
      if (s1 !== peg$FAILED) {
        peg$reportedPos = s0;
        s1 = peg$c10(s1);
      }
      s0 = s1;

      return s0;
    }

    function peg$parsenotCommentChar() {
      var s0, s1, s2;

      s0 = peg$currPos;
      s1 = peg$currPos;
      peg$silentFails++;
      if (input.substr(peg$currPos, 2) === peg$c12) {
        s2 = peg$c12;
        peg$currPos += 2;
      } else {
        s2 = peg$FAILED;
        if (peg$silentFails === 0) { peg$fail(peg$c13); }
      }
      if (s2 === peg$FAILED) {
        if (input.substr(peg$currPos, 2) === peg$c14) {
          s2 = peg$c14;
          peg$currPos += 2;
        } else {
          s2 = peg$FAILED;
          if (peg$silentFails === 0) { peg$fail(peg$c15); }
        }
      }
      peg$silentFails--;
      if (s2 === peg$FAILED) {
        s1 = peg$c11;
      } else {
        peg$currPos = s1;
        s1 = peg$c0;
      }
      if (s1 !== peg$FAILED) {
        if (peg$c16.test(input.charAt(peg$currPos))) {
          s2 = input.charAt(peg$currPos);
          peg$currPos++;
        } else {
          s2 = peg$FAILED;
          if (peg$silentFails === 0) { peg$fail(peg$c17); }
        }
        if (s2 !== peg$FAILED) {
          peg$reportedPos = s0;
          s1 = peg$c18(s2);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$c0;
      }

      return s0;
    }

    function peg$parsenotCommentOrColonChar() {
      var s0, s1, s2;

      s0 = peg$currPos;
      s1 = peg$currPos;
      peg$silentFails++;
      if (input.substr(peg$currPos, 2) === peg$c12) {
        s2 = peg$c12;
        peg$currPos += 2;
      } else {
        s2 = peg$FAILED;
        if (peg$silentFails === 0) { peg$fail(peg$c13); }
      }
      if (s2 === peg$FAILED) {
        if (input.substr(peg$currPos, 2) === peg$c14) {
          s2 = peg$c14;
          peg$currPos += 2;
        } else {
          s2 = peg$FAILED;
          if (peg$silentFails === 0) { peg$fail(peg$c15); }
        }
      }
      peg$silentFails--;
      if (s2 === peg$FAILED) {
        s1 = peg$c11;
      } else {
        peg$currPos = s1;
        s1 = peg$c0;
      }
      if (s1 !== peg$FAILED) {
        if (peg$c19.test(input.charAt(peg$currPos))) {
          s2 = input.charAt(peg$currPos);
          peg$currPos++;
        } else {
          s2 = peg$FAILED;
          if (peg$silentFails === 0) { peg$fail(peg$c20); }
        }
        if (s2 !== peg$FAILED) {
          peg$reportedPos = s0;
          s1 = peg$c18(s2);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$c0;
      }

      return s0;
    }

    function peg$parsenotCommentOrSemicolonChar() {
      var s0, s1, s2;

      s0 = peg$currPos;
      s1 = peg$currPos;
      peg$silentFails++;
      if (input.substr(peg$currPos, 2) === peg$c12) {
        s2 = peg$c12;
        peg$currPos += 2;
      } else {
        s2 = peg$FAILED;
        if (peg$silentFails === 0) { peg$fail(peg$c13); }
      }
      if (s2 === peg$FAILED) {
        if (input.substr(peg$currPos, 2) === peg$c14) {
          s2 = peg$c14;
          peg$currPos += 2;
        } else {
          s2 = peg$FAILED;
          if (peg$silentFails === 0) { peg$fail(peg$c15); }
        }
      }
      peg$silentFails--;
      if (s2 === peg$FAILED) {
        s1 = peg$c11;
      } else {
        peg$currPos = s1;
        s1 = peg$c0;
      }
      if (s1 !== peg$FAILED) {
        if (peg$c21.test(input.charAt(peg$currPos))) {
          s2 = input.charAt(peg$currPos);
          peg$currPos++;
        } else {
          s2 = peg$FAILED;
          if (peg$silentFails === 0) { peg$fail(peg$c22); }
        }
        if (s2 !== peg$FAILED) {
          peg$reportedPos = s0;
          s1 = peg$c18(s2);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$c0;
      }

      return s0;
    }

    function peg$parseleft() {
      var s0, s1, s2;

      s0 = peg$currPos;
      s1 = [];
      s2 = peg$parsenotCommentOrColonChar();
      if (s2 !== peg$FAILED) {
        while (s2 !== peg$FAILED) {
          s1.push(s2);
          s2 = peg$parsenotCommentOrColonChar();
        }
      } else {
        s1 = peg$c0;
      }
      if (s1 !== peg$FAILED) {
        peg$reportedPos = s0;
        s1 = peg$c23(s1);
      }
      s0 = s1;

      return s0;
    }

    function peg$parseright() {
      var s0, s1, s2, s3;

      s0 = peg$currPos;
      s1 = [];
      s2 = peg$parsenotCommentOrSemicolonChar();
      while (s2 !== peg$FAILED) {
        s1.push(s2);
        s2 = peg$parsenotCommentOrSemicolonChar();
      }
      if (s1 !== peg$FAILED) {
        peg$reportedPos = s0;
        s1 = peg$c23(s1);
      }
      s0 = s1;
      if (s0 === peg$FAILED) {
        s0 = peg$currPos;
        if (input.charCodeAt(peg$currPos) === 34) {
          s1 = peg$c24;
          peg$currPos++;
        } else {
          s1 = peg$FAILED;
          if (peg$silentFails === 0) { peg$fail(peg$c25); }
        }
        if (s1 !== peg$FAILED) {
          s2 = [];
          s3 = peg$parsenotCommentChar();
          while (s3 !== peg$FAILED) {
            s2.push(s3);
            s3 = peg$parsenotCommentChar();
          }
          if (s2 !== peg$FAILED) {
            if (input.charCodeAt(peg$currPos) === 34) {
              s3 = peg$c24;
              peg$currPos++;
            } else {
              s3 = peg$FAILED;
              if (peg$silentFails === 0) { peg$fail(peg$c25); }
            }
            if (s3 !== peg$FAILED) {
              peg$reportedPos = s0;
              s1 = peg$c23(s2);
              s0 = s1;
            } else {
              peg$currPos = s0;
              s0 = peg$c0;
            }
          } else {
            peg$currPos = s0;
            s0 = peg$c0;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      }

      return s0;
    }

    function peg$parsews() {
      var s0, s1;

      s0 = [];
      if (input.charCodeAt(peg$currPos) === 32) {
        s1 = peg$c8;
        peg$currPos++;
      } else {
        s1 = peg$FAILED;
        if (peg$silentFails === 0) { peg$fail(peg$c9); }
      }
      while (s1 !== peg$FAILED) {
        s0.push(s1);
        if (input.charCodeAt(peg$currPos) === 32) {
          s1 = peg$c8;
          peg$currPos++;
        } else {
          s1 = peg$FAILED;
          if (peg$silentFails === 0) { peg$fail(peg$c9); }
        }
      }

      return s0;
    }

    function peg$parsenl() {
      var s0;

      if (input.charCodeAt(peg$currPos) === 10) {
        s0 = peg$c26;
        peg$currPos++;
      } else {
        s0 = peg$FAILED;
        if (peg$silentFails === 0) { peg$fail(peg$c27); }
      }

      return s0;
    }

    function peg$parsecomment() {
      var s0, s1, s2, s3, s4, s5;

      s0 = peg$currPos;
      if (input.substr(peg$currPos, 2) === peg$c12) {
        s1 = peg$c12;
        peg$currPos += 2;
      } else {
        s1 = peg$FAILED;
        if (peg$silentFails === 0) { peg$fail(peg$c13); }
      }
      if (s1 !== peg$FAILED) {
        s2 = [];
        if (peg$c16.test(input.charAt(peg$currPos))) {
          s3 = input.charAt(peg$currPos);
          peg$currPos++;
        } else {
          s3 = peg$FAILED;
          if (peg$silentFails === 0) { peg$fail(peg$c17); }
        }
        while (s3 !== peg$FAILED) {
          s2.push(s3);
          if (peg$c16.test(input.charAt(peg$currPos))) {
            s3 = input.charAt(peg$currPos);
            peg$currPos++;
          } else {
            s3 = peg$FAILED;
            if (peg$silentFails === 0) { peg$fail(peg$c17); }
          }
        }
        if (s2 !== peg$FAILED) {
          s1 = [s1, s2];
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$c0;
      }
      if (s0 === peg$FAILED) {
        s0 = peg$currPos;
        if (input.substr(peg$currPos, 2) === peg$c14) {
          s1 = peg$c14;
          peg$currPos += 2;
        } else {
          s1 = peg$FAILED;
          if (peg$silentFails === 0) { peg$fail(peg$c15); }
        }
        if (s1 !== peg$FAILED) {
          s2 = [];
          s3 = peg$currPos;
          s4 = peg$currPos;
          peg$silentFails++;
          if (input.substr(peg$currPos, 2) === peg$c28) {
            s5 = peg$c28;
            peg$currPos += 2;
          } else {
            s5 = peg$FAILED;
            if (peg$silentFails === 0) { peg$fail(peg$c29); }
          }
          peg$silentFails--;
          if (s5 === peg$FAILED) {
            s4 = peg$c11;
          } else {
            peg$currPos = s4;
            s4 = peg$c0;
          }
          if (s4 !== peg$FAILED) {
            if (input.length > peg$currPos) {
              s5 = input.charAt(peg$currPos);
              peg$currPos++;
            } else {
              s5 = peg$FAILED;
              if (peg$silentFails === 0) { peg$fail(peg$c30); }
            }
            if (s5 !== peg$FAILED) {
              s4 = [s4, s5];
              s3 = s4;
            } else {
              peg$currPos = s3;
              s3 = peg$c0;
            }
          } else {
            peg$currPos = s3;
            s3 = peg$c0;
          }
          while (s3 !== peg$FAILED) {
            s2.push(s3);
            s3 = peg$currPos;
            s4 = peg$currPos;
            peg$silentFails++;
            if (input.substr(peg$currPos, 2) === peg$c28) {
              s5 = peg$c28;
              peg$currPos += 2;
            } else {
              s5 = peg$FAILED;
              if (peg$silentFails === 0) { peg$fail(peg$c29); }
            }
            peg$silentFails--;
            if (s5 === peg$FAILED) {
              s4 = peg$c11;
            } else {
              peg$currPos = s4;
              s4 = peg$c0;
            }
            if (s4 !== peg$FAILED) {
              if (input.length > peg$currPos) {
                s5 = input.charAt(peg$currPos);
                peg$currPos++;
              } else {
                s5 = peg$FAILED;
                if (peg$silentFails === 0) { peg$fail(peg$c30); }
              }
              if (s5 !== peg$FAILED) {
                s4 = [s4, s5];
                s3 = s4;
              } else {
                peg$currPos = s3;
                s3 = peg$c0;
              }
            } else {
              peg$currPos = s3;
              s3 = peg$c0;
            }
          }
          if (s2 !== peg$FAILED) {
            if (input.substr(peg$currPos, 2) === peg$c28) {
              s3 = peg$c28;
              peg$currPos += 2;
            } else {
              s3 = peg$FAILED;
              if (peg$silentFails === 0) { peg$fail(peg$c29); }
            }
            if (s3 !== peg$FAILED) {
              s1 = [s1, s2, s3];
              s0 = s1;
            } else {
              peg$currPos = s0;
              s0 = peg$c0;
            }
          } else {
            peg$currPos = s0;
            s0 = peg$c0;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      }

      return s0;
    }

    peg$result = peg$startRuleFunction();

    if (peg$result !== peg$FAILED && peg$currPos === input.length) {
      return peg$result;
    } else {
      if (peg$result !== peg$FAILED && peg$currPos < input.length) {
        peg$fail({ type: "end", description: "end of input" });
      }

      throw peg$buildException(null, peg$maxFailExpected, peg$maxFailPos);
    }
  }

  return {
    SyntaxError: SyntaxError,
    parse:       parse
  };
})();


PEG.sideParser = (function() {
  /*
   * Generated by PEG.js 0.8.0.
   *
   * http://pegjs.majda.cz/
   */

  function peg$subclass(child, parent) {
    function ctor() { this.constructor = child; }
    ctor.prototype = parent.prototype;
    child.prototype = new ctor();
  }

  function SyntaxError(message, expected, found, offset, line, column) {
    this.message  = message;
    this.expected = expected;
    this.found    = found;
    this.offset   = offset;
    this.line     = line;
    this.column   = column;

    this.name     = "SyntaxError";
  }

  peg$subclass(SyntaxError, Error);

  function parse(input) {
    var options = arguments.length > 1 ? arguments[1] : {},

        peg$FAILED = {},

        peg$startRuleFunctions = { start: peg$parsestart },
        peg$startRuleFunction  = peg$parsestart,

        peg$c0 = peg$FAILED,
        peg$c1 = null,
        peg$c2 = [],
        peg$c3 = function() { return __res },
        peg$c4 = void 0,
        peg$c5 = "=",
        peg$c6 = { type: "literal", value: "=", description: "\"=\"" },
        peg$c7 = function(value) { __res["__positionals"].push(MetaParser._toValue(value)) },
        peg$c8 = function(id, value) { __res[id]=MetaParser._toValue(value) },
        peg$c9 = /^[a-zA-Z0-9_]/,
        peg$c10 = { type: "class", value: "[a-zA-Z0-9_]", description: "[a-zA-Z0-9_]" },
        peg$c11 = function(c) { return c.join("") },
        peg$c12 = /^[^ ="']/,
        peg$c13 = { type: "class", value: "[^ =\"']", description: "[^ =\"']" },
        peg$c14 = "\"",
        peg$c15 = { type: "literal", value: "\"", description: "\"\\\"\"" },
        peg$c16 = function(c) { return c },
        peg$c17 = /^[^"']/,
        peg$c18 = { type: "class", value: "[^\"']", description: "[^\"']" },
        peg$c19 = " ",
        peg$c20 = { type: "literal", value: " ", description: "\" \"" },

        peg$currPos          = 0,
        peg$reportedPos      = 0,
        peg$cachedPos        = 0,
        peg$cachedPosDetails = { line: 1, column: 1, seenCR: false },
        peg$maxFailPos       = 0,
        peg$maxFailExpected  = [],
        peg$silentFails      = 0,

        peg$result;

    if ("startRule" in options) {
      if (!(options.startRule in peg$startRuleFunctions)) {
        throw new Error("Can't start parsing from rule \"" + options.startRule + "\".");
      }

      peg$startRuleFunction = peg$startRuleFunctions[options.startRule];
    }

    function text() {
      return input.substring(peg$reportedPos, peg$currPos);
    }

    function offset() {
      return peg$reportedPos;
    }

    function line() {
      return peg$computePosDetails(peg$reportedPos).line;
    }

    function column() {
      return peg$computePosDetails(peg$reportedPos).column;
    }

    function expected(description) {
      throw peg$buildException(
        null,
        [{ type: "other", description: description }],
        peg$reportedPos
      );
    }

    function error(message) {
      throw peg$buildException(message, null, peg$reportedPos);
    }

    function peg$computePosDetails(pos) {
      function advance(details, startPos, endPos) {
        var p, ch;

        for (p = startPos; p < endPos; p++) {
          ch = input.charAt(p);
          if (ch === "\n") {
            if (!details.seenCR) { details.line++; }
            details.column = 1;
            details.seenCR = false;
          } else if (ch === "\r" || ch === "\u2028" || ch === "\u2029") {
            details.line++;
            details.column = 1;
            details.seenCR = true;
          } else {
            details.column++;
            details.seenCR = false;
          }
        }
      }

      if (peg$cachedPos !== pos) {
        if (peg$cachedPos > pos) {
          peg$cachedPos = 0;
          peg$cachedPosDetails = { line: 1, column: 1, seenCR: false };
        }
        advance(peg$cachedPosDetails, peg$cachedPos, pos);
        peg$cachedPos = pos;
      }

      return peg$cachedPosDetails;
    }

    function peg$fail(expected) {
      if (peg$currPos < peg$maxFailPos) { return; }

      if (peg$currPos > peg$maxFailPos) {
        peg$maxFailPos = peg$currPos;
        peg$maxFailExpected = [];
      }

      peg$maxFailExpected.push(expected);
    }

    function peg$buildException(message, expected, pos) {
      function cleanupExpected(expected) {
        var i = 1;

        expected.sort(function(a, b) {
          if (a.description < b.description) {
            return -1;
          } else if (a.description > b.description) {
            return 1;
          } else {
            return 0;
          }
        });

        while (i < expected.length) {
          if (expected[i - 1] === expected[i]) {
            expected.splice(i, 1);
          } else {
            i++;
          }
        }
      }

      function buildMessage(expected, found) {
        function stringEscape(s) {
          function hex(ch) { return ch.charCodeAt(0).toString(16).toUpperCase(); }

          return s
            .replace(/\\/g,   '\\\\')
            .replace(/"/g,    '\\"')
            .replace(/\x08/g, '\\b')
            .replace(/\t/g,   '\\t')
            .replace(/\n/g,   '\\n')
            .replace(/\f/g,   '\\f')
            .replace(/\r/g,   '\\r')
            .replace(/[\x00-\x07\x0B\x0E\x0F]/g, function(ch) { return '\\x0' + hex(ch); })
            .replace(/[\x10-\x1F\x80-\xFF]/g,    function(ch) { return '\\x'  + hex(ch); })
            .replace(/[\u0180-\u0FFF]/g,         function(ch) { return '\\u0' + hex(ch); })
            .replace(/[\u1080-\uFFFF]/g,         function(ch) { return '\\u'  + hex(ch); });
        }

        var expectedDescs = new Array(expected.length),
            expectedDesc, foundDesc, i;

        for (i = 0; i < expected.length; i++) {
          expectedDescs[i] = expected[i].description;
        }

        expectedDesc = expected.length > 1
          ? expectedDescs.slice(0, -1).join(", ")
              + " or "
              + expectedDescs[expected.length - 1]
          : expectedDescs[0];

        foundDesc = found ? "\"" + stringEscape(found) + "\"" : "end of input";

        return "Expected " + expectedDesc + " but " + foundDesc + " found.";
      }

      var posDetails = peg$computePosDetails(pos),
          found      = pos < input.length ? input.charAt(pos) : null;

      if (expected !== null) {
        cleanupExpected(expected);
      }

      return new SyntaxError(
        message !== null ? message : buildMessage(expected, found),
        expected,
        found,
        pos,
        posDetails.line,
        posDetails.column
      );
    }

    function peg$parsestart() {
      var s0, s1, s2, s3, s4, s5, s6, s7;

      s0 = peg$currPos;
      s1 = peg$parsepositional();
      if (s1 === peg$FAILED) {
        s1 = peg$c1;
      }
      if (s1 !== peg$FAILED) {
        s2 = [];
        s3 = peg$currPos;
        s4 = peg$parsews();
        if (s4 !== peg$FAILED) {
          s5 = peg$parsepositional();
          if (s5 !== peg$FAILED) {
            s4 = [s4, s5];
            s3 = s4;
          } else {
            peg$currPos = s3;
            s3 = peg$c0;
          }
        } else {
          peg$currPos = s3;
          s3 = peg$c0;
        }
        while (s3 !== peg$FAILED) {
          s2.push(s3);
          s3 = peg$currPos;
          s4 = peg$parsews();
          if (s4 !== peg$FAILED) {
            s5 = peg$parsepositional();
            if (s5 !== peg$FAILED) {
              s4 = [s4, s5];
              s3 = s4;
            } else {
              peg$currPos = s3;
              s3 = peg$c0;
            }
          } else {
            peg$currPos = s3;
            s3 = peg$c0;
          }
        }
        if (s2 !== peg$FAILED) {
          s3 = peg$parsenamed();
          if (s3 === peg$FAILED) {
            s3 = peg$c1;
          }
          if (s3 !== peg$FAILED) {
            s4 = [];
            s5 = peg$currPos;
            s6 = peg$parsews();
            if (s6 !== peg$FAILED) {
              s7 = peg$parsenamed();
              if (s7 !== peg$FAILED) {
                s6 = [s6, s7];
                s5 = s6;
              } else {
                peg$currPos = s5;
                s5 = peg$c0;
              }
            } else {
              peg$currPos = s5;
              s5 = peg$c0;
            }
            while (s5 !== peg$FAILED) {
              s4.push(s5);
              s5 = peg$currPos;
              s6 = peg$parsews();
              if (s6 !== peg$FAILED) {
                s7 = peg$parsenamed();
                if (s7 !== peg$FAILED) {
                  s6 = [s6, s7];
                  s5 = s6;
                } else {
                  peg$currPos = s5;
                  s5 = peg$c0;
                }
              } else {
                peg$currPos = s5;
                s5 = peg$c0;
              }
            }
            if (s4 !== peg$FAILED) {
              peg$reportedPos = s0;
              s1 = peg$c3();
              s0 = s1;
            } else {
              peg$currPos = s0;
              s0 = peg$c0;
            }
          } else {
            peg$currPos = s0;
            s0 = peg$c0;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$c0;
      }

      return s0;
    }

    function peg$parsepositional() {
      var s0, s1, s2, s3, s4, s5;

      s0 = peg$currPos;
      s1 = peg$currPos;
      peg$silentFails++;
      s2 = peg$currPos;
      s3 = peg$parseid();
      if (s3 !== peg$FAILED) {
        s4 = peg$parsews();
        if (s4 === peg$FAILED) {
          s4 = peg$c1;
        }
        if (s4 !== peg$FAILED) {
          if (input.charCodeAt(peg$currPos) === 61) {
            s5 = peg$c5;
            peg$currPos++;
          } else {
            s5 = peg$FAILED;
            if (peg$silentFails === 0) { peg$fail(peg$c6); }
          }
          if (s5 !== peg$FAILED) {
            s3 = [s3, s4, s5];
            s2 = s3;
          } else {
            peg$currPos = s2;
            s2 = peg$c0;
          }
        } else {
          peg$currPos = s2;
          s2 = peg$c0;
        }
      } else {
        peg$currPos = s2;
        s2 = peg$c0;
      }
      peg$silentFails--;
      if (s2 === peg$FAILED) {
        s1 = peg$c4;
      } else {
        peg$currPos = s1;
        s1 = peg$c0;
      }
      if (s1 !== peg$FAILED) {
        s2 = peg$parsevalue();
        if (s2 !== peg$FAILED) {
          peg$reportedPos = s0;
          s1 = peg$c7(s2);
          s0 = s1;
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$c0;
      }

      return s0;
    }

    function peg$parsenamed() {
      var s0, s1, s2, s3, s4, s5;

      s0 = peg$currPos;
      s1 = peg$parseid();
      if (s1 !== peg$FAILED) {
        s2 = peg$parsews();
        if (s2 === peg$FAILED) {
          s2 = peg$c1;
        }
        if (s2 !== peg$FAILED) {
          if (input.charCodeAt(peg$currPos) === 61) {
            s3 = peg$c5;
            peg$currPos++;
          } else {
            s3 = peg$FAILED;
            if (peg$silentFails === 0) { peg$fail(peg$c6); }
          }
          if (s3 !== peg$FAILED) {
            s4 = peg$parsews();
            if (s4 === peg$FAILED) {
              s4 = peg$c1;
            }
            if (s4 !== peg$FAILED) {
              s5 = peg$parsevalue();
              if (s5 !== peg$FAILED) {
                peg$reportedPos = s0;
                s1 = peg$c8(s1, s5);
                s0 = s1;
              } else {
                peg$currPos = s0;
                s0 = peg$c0;
              }
            } else {
              peg$currPos = s0;
              s0 = peg$c0;
            }
          } else {
            peg$currPos = s0;
            s0 = peg$c0;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      } else {
        peg$currPos = s0;
        s0 = peg$c0;
      }

      return s0;
    }

    function peg$parseid() {
      var s0, s1, s2;

      s0 = peg$currPos;
      s1 = [];
      if (peg$c9.test(input.charAt(peg$currPos))) {
        s2 = input.charAt(peg$currPos);
        peg$currPos++;
      } else {
        s2 = peg$FAILED;
        if (peg$silentFails === 0) { peg$fail(peg$c10); }
      }
      if (s2 !== peg$FAILED) {
        while (s2 !== peg$FAILED) {
          s1.push(s2);
          if (peg$c9.test(input.charAt(peg$currPos))) {
            s2 = input.charAt(peg$currPos);
            peg$currPos++;
          } else {
            s2 = peg$FAILED;
            if (peg$silentFails === 0) { peg$fail(peg$c10); }
          }
        }
      } else {
        s1 = peg$c0;
      }
      if (s1 !== peg$FAILED) {
        peg$reportedPos = s0;
        s1 = peg$c11(s1);
      }
      s0 = s1;

      return s0;
    }

    function peg$parsevalue() {
      var s0, s1, s2, s3;

      s0 = peg$currPos;
      s1 = [];
      if (peg$c12.test(input.charAt(peg$currPos))) {
        s2 = input.charAt(peg$currPos);
        peg$currPos++;
      } else {
        s2 = peg$FAILED;
        if (peg$silentFails === 0) { peg$fail(peg$c13); }
      }
      if (s2 !== peg$FAILED) {
        while (s2 !== peg$FAILED) {
          s1.push(s2);
          if (peg$c12.test(input.charAt(peg$currPos))) {
            s2 = input.charAt(peg$currPos);
            peg$currPos++;
          } else {
            s2 = peg$FAILED;
            if (peg$silentFails === 0) { peg$fail(peg$c13); }
          }
        }
      } else {
        s1 = peg$c0;
      }
      if (s1 !== peg$FAILED) {
        peg$reportedPos = s0;
        s1 = peg$c11(s1);
      }
      s0 = s1;
      if (s0 === peg$FAILED) {
        s0 = peg$currPos;
        if (input.charCodeAt(peg$currPos) === 34) {
          s1 = peg$c14;
          peg$currPos++;
        } else {
          s1 = peg$FAILED;
          if (peg$silentFails === 0) { peg$fail(peg$c15); }
        }
        if (s1 !== peg$FAILED) {
          s2 = peg$parsecontents();
          if (s2 !== peg$FAILED) {
            if (input.charCodeAt(peg$currPos) === 34) {
              s3 = peg$c14;
              peg$currPos++;
            } else {
              s3 = peg$FAILED;
              if (peg$silentFails === 0) { peg$fail(peg$c15); }
            }
            if (s3 !== peg$FAILED) {
              peg$reportedPos = s0;
              s1 = peg$c16(s2);
              s0 = s1;
            } else {
              peg$currPos = s0;
              s0 = peg$c0;
            }
          } else {
            peg$currPos = s0;
            s0 = peg$c0;
          }
        } else {
          peg$currPos = s0;
          s0 = peg$c0;
        }
      }

      return s0;
    }

    function peg$parsecontents() {
      var s0, s1, s2;

      s0 = peg$currPos;
      s1 = [];
      if (peg$c17.test(input.charAt(peg$currPos))) {
        s2 = input.charAt(peg$currPos);
        peg$currPos++;
      } else {
        s2 = peg$FAILED;
        if (peg$silentFails === 0) { peg$fail(peg$c18); }
      }
      if (s2 !== peg$FAILED) {
        while (s2 !== peg$FAILED) {
          s1.push(s2);
          if (peg$c17.test(input.charAt(peg$currPos))) {
            s2 = input.charAt(peg$currPos);
            peg$currPos++;
          } else {
            s2 = peg$FAILED;
            if (peg$silentFails === 0) { peg$fail(peg$c18); }
          }
        }
      } else {
        s1 = peg$c0;
      }
      if (s1 !== peg$FAILED) {
        peg$reportedPos = s0;
        s1 = peg$c11(s1);
      }
      s0 = s1;

      return s0;
    }

    function peg$parsews() {
      var s0, s1;

      s0 = [];
      if (input.charCodeAt(peg$currPos) === 32) {
        s1 = peg$c19;
        peg$currPos++;
      } else {
        s1 = peg$FAILED;
        if (peg$silentFails === 0) { peg$fail(peg$c20); }
      }
      if (s1 !== peg$FAILED) {
        while (s1 !== peg$FAILED) {
          s0.push(s1);
          if (input.charCodeAt(peg$currPos) === 32) {
            s1 = peg$c19;
            peg$currPos++;
          } else {
            s1 = peg$FAILED;
            if (peg$silentFails === 0) { peg$fail(peg$c20); }
          }
        }
      } else {
        s0 = peg$c0;
      }

      return s0;
    }

     var __res = {}; __res["__positionals"] = [];

    peg$result = peg$startRuleFunction();

    if (peg$result !== peg$FAILED && peg$currPos === input.length) {
      return peg$result;
    } else {
      if (peg$result !== peg$FAILED && peg$currPos < input.length) {
        peg$fail({ type: "end", description: "end of input" });
      }

      throw peg$buildException(null, peg$maxFailExpected, peg$maxFailPos);
    }
  }

  return {
    SyntaxError: SyntaxError,
    parse:       parse
  };
})();
// Generated by CoffeeScript 1.9.0
var Action, ActionDesc,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

ActionDesc = (function() {
  function ActionDesc() {}

  ActionDesc.register = function(a) {
    var desc, name, _i, _len, _ref, _results;
    desc = {
      init: a.init,
      processPositionals: function(side, vars) {
        var arg, value, _i, _len, _ref, _ref1, _results;
        _ref = a["arguments"];
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          arg = _ref[_i];
          value = (_ref1 = side.__positionals) != null ? _ref1.shift() : void 0;
          if (value != null) {
            _results.push(vars[arg[0]] = value);
          } else {
            break;
          }
        }
        return _results;
      },
      toLongNames: function(vars) {
        var arg, short, _i, _len, _ref, _results;
        _ref = a["arguments"];
        _results = [];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          arg = _ref[_i];
          short = arg[1];
          if (vars[short] != null) {
            vars[arg[0]] = vars[short];
            _results.push(delete vars[short]);
          } else {
            _results.push(void 0);
          }
        }
        return _results;
      },
      setDefaults: function(vars) {
        var arg, k, v, _i, _len, _name, _ref, _ref1, _results;
        _ref = a["arguments"];
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          arg = _ref[_i];
          if (vars[_name = arg[0]] == null) {
            vars[_name] = arg[2];
          }
        }
        _ref1 = a.defaultContext;
        _results = [];
        for (k in _ref1) {
          v = _ref1[k];
          _results.push(vars[k] != null ? vars[k] : vars[k] = v);
        }
        return _results;
      },
      singleStart: a.singleStart,
      singleEnd: a.singleEnd,
      exec: a.exec
    };
    if (a.name instanceof Array) {
      _ref = a.name;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        name = _ref[_i];
        Action.descs[name] = desc;
        _results.push(Action.actionNames.add(name));
      }
      return _results;
    } else {
      Action.descs[a.name] = desc;
      return Action.actionNames.add(a.name);
    }
  };

  ActionDesc.applyOnStateHelper = function(target, last, f) {
    f(target.getProvisional());
    if (last) {
      f(target.currentState);
    }
    return target;
  };

  return ActionDesc;

})();

Action = (function() {
  Action.actionNames = new Set();

  Action.descs = {};

  function Action(_at_name, _at_vars) {
    var _base;
    this.name = _at_name;
    this.vars = _at_vars;
    this.getAnim = __bind(this.getAnim, this);
    this.exec = __bind(this.exec, this);
    this.singleEnd = __bind(this.singleEnd, this);
    this.singleStart = __bind(this.singleStart, this);
    this.desc = Action.descs[this.name];
    if (typeof (_base = this.desc).init === "function") {
      _base.init(this.vars);
    }
    this.time = this.vars.time;
    this.duration = this.vars.duration;
    this.easing = Ease[this.vars.easing];
  }

  Action.prototype.singleStart = function() {
    var _base;
    return typeof (_base = this.desc).singleStart === "function" ? _base.singleStart(this.vars) : void 0;
  };

  Action.prototype.singleEnd = function() {
    var _base;
    return typeof (_base = this.desc).singleEnd === "function" ? _base.singleEnd(this.vars) : void 0;
  };

  Action.prototype.exec = function(time) {
    var delta, last, offset, rawDelta;
    offset = time - this.time;
    rawDelta = Math.min(Math.max(offset / this.duration, 0), 1);
    if ((0 < rawDelta && rawDelta < 1)) {
      delta = this.easing(rawDelta);
    } else {
      delta = rawDelta;
    }
    last = time >= (this.time + this.duration);
    return this.desc.exec(this.vars, delta, rawDelta, last);
  };

  Action.prototype.getAnim = function(onEnd) {
    var advanceTime, time;
    time = 0;
    if (this.time == null) {
      this.time = 0;
    }
    advanceTime = (function(_this) {
      return function(delta) {
        var ao;
        time += delta;
        ao = _this.exec(time);
        return ao.applyProvisional();
      };
    })(this);
    return new BaseAnimation(this.vars.duration, advanceTime, onEnd);
  };

  return Action;

})();
// Generated by CoffeeScript 1.9.0
var Animation,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

Animation = (function() {
  Animation.byFullName = {};

  function Animation(_at_animDesc, _at_namespace, _at_name) {
    this.animDesc = _at_animDesc;
    this.namespace = _at_namespace;
    this.name = _at_name;
    this.advanceTime = __bind(this.advanceTime, this);
    this.prevLabel = __bind(this.prevLabel, this);
    this.nextLabel = __bind(this.nextLabel, this);
    this.goEnd = __bind(this.goEnd, this);
    this.goStart = __bind(this.goStart, this);
    this.pause = __bind(this.pause, this);
    this.playLabel = __bind(this.playLabel, this);
    this.play = __bind(this.play, this);
    this._changeCurrentLabel = __bind(this._changeCurrentLabel, this);
    this._play = __bind(this._play, this);
    this.init = __bind(this.init, this);
    this.fullName = this.namespace !== "" ? this.namespace + "." + this.name : this.name;
    if (this.name != null) {
      Animation.byFullName[this.fullName] = this;
    }
  }

  Animation.prototype.init = function() {
    var getReferences, parallel, peekNextPositional, process, processContextPositionals, setContextDefaults, shiftNextPositional, toLongContextNames, _ref;
    if (this.actions == null) {
      this.actions = [];
      this.targets = new Set();
      this.labels = [];
      this.labelByName = {};
      this.duration = 0;
      this.currentTime = 0;
      this.currentActions = [];
      this.nextAction = 0;
      peekNextPositional = (function(_this) {
        return function(o) {
          var _ref;
          return (_ref = o.__positionals) != null ? _ref[0] : void 0;
        };
      })(this);
      shiftNextPositional = (function(_this) {
        return function(o) {
          var _ref;
          return (_ref = o.__positionals) != null ? _ref.shift() : void 0;
        };
      })(this);
      processContextPositionals = (function(_this) {
        return function(o, vars) {
          var action, c, _i, _len, _ref, _results;
          c = shiftNextPositional(o);
          _ref = ["target", "duration", "easing", "offset", "center", "namespace", "label"];
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            action = _ref[_i];
            if (c != null) {
              vars[action] = c;
              _results.push(c = shiftNextPositional(o));
            } else {
              break;
            }
          }
          return _results;
        };
      })(this);
      toLongContextNames = (function(_this) {
        return function(vars) {
          if (vars.d) {
            vars.duration = vars.d;
            delete vars.d;
          }
          if (vars.e) {
            vars.easing = vars.e;
            delete vars.e;
          }
          if (vars.o) {
            vars.offset = vars.o;
            delete vars.o;
          }
          if (vars.c) {
            vars.center = vars.c;
            delete vars.c;
          }
          if (vars.n) {
            vars.namespace = vars.n;
            delete vars.n;
          }
          if (vars.l) {
            vars.label = vars.l;
            return delete vars.l;
          }
        };
      })(this);
      setContextDefaults = (function(_this) {
        return function(vars) {
          if (vars.duration == null) {
            vars.duration = 1;
          }
          if (vars.easing == null) {
            vars.easing = "linear";
          }
          if (vars.center == null) {
            vars.center = [0.5, 0.5];
          }
          return vars.namespace != null ? vars.namespace : vars.namespace = "";
        };
      })(this);
      getReferences = (function(_this) {
        return function(vars) {
          var dref, name, namespace, value, _results;
          namespace = vars.namespace;
          _results = [];
          for (name in vars) {
            value = vars[name];
            if (typeof value === "string" && value.charAt(0) === "$" && (vars[value.slice(1)] != null)) {
              value = vars[value.slice(1)];
            }
            while (true) {
              dref = getObjectFromReference(namespace, value);
              if (dref == null) {
                break;
              }
              value = dref;
            }
            if (value != null) {
              vars[name] = value;
              if (name === "target") {
                _results.push(_this.targets.add(value));
              } else {
                _results.push(void 0);
              }
            } else {
              _results.push(void 0);
            }
          }
          return _results;
        };
      })(this);
      process = (function(_this) {
        return function(l, r, vars) {
          var a, action, actionDesc, anim, c, childrenEnd, currentEnd, end, newVars, originalTime, para, parallel, _i, _j, _len, _len1, _ref, _ref1, _ref2;
          parallel = true;
          c = peekNextPositional(l);
          if (c === "-") {
            parallel = false;
            shiftNextPositional(l);
          } else if (c === "/" || c.charAt(0) === "@") {
            shiftNextPositional(l);
          }
          c = peekNextPositional(l);
          if (c === "includeRawAnim") {
            anim = getObjectFromReference(vars.namespace, r.__positionals[0]);
            _ref = anim.animDesc, l = _ref[0], r = _ref[1];
            shiftNextPositional(l);
          } else if (c === "includeAnim") {
            anim = getObjectFromReference(vars.namespace, r.__positionals[0]);
            anim.init();
            currentEnd = vars.time;
            _ref1 = anim.actions;
            for (_i = 0, _len = _ref1.length; _i < _len; _i++) {
              a = _ref1[_i];
              newVars = $.extend({}, a.vars);
              newVars.time += vars.time;
              _this.actions.push(new Action(a.name, newVars));
              currentEnd = Math.max(currentEnd, newVars.time + newVars.duration);
            }
            return [currentEnd, parallel];
          }
          c = peekNextPositional(l);
          if (Action.actionNames.has(c)) {
            action = c;
            shiftNextPositional(l);
          }
          processContextPositionals(l, vars);
          delete l.__positionals;
          $.extend(vars, l);
          originalTime = vars.time;
          currentEnd = vars.time;
          if (action != null) {
            actionDesc = Action.descs[action];
            actionDesc.processPositionals(r, vars);
            processContextPositionals(r, vars);
            delete r.__positionals;
            $.extend(vars, r);
            actionDesc.toLongNames(vars);
            toLongContextNames(vars);
            actionDesc.setDefaults(vars);
            setContextDefaults(vars);
            vars.time += vars.offset || 0;
            getReferences(vars);
            _this.actions.push(new Action(action, vars));
            currentEnd = vars.time + vars.duration;
          } else {
            currentEnd += vars.offset || vars.o || 0;
            delete vars.offset;
            delete vars.o;
            getReferences(vars);
            if (r instanceof Array) {
              childrenEnd = currentEnd;
              for (_j = 0, _len1 = r.length; _j < _len1; _j++) {
                c = r[_j];
                newVars = $.extend({}, vars);
                newVars.time = currentEnd;
                _ref2 = process(c[0], c[1], newVars), end = _ref2[0], para = _ref2[1];
                if (para) {
                  childrenEnd = Math.max(childrenEnd, end);
                } else {
                  currentEnd = end;
                  childrenEnd = end;
                }
              }
              currentEnd = childrenEnd;
            }
          }
          if (vars.label != null) {
            l = {
              name: vars.label,
              time: vars.time
            };
            _this.labels.push(l);
            _this.labelByName[vars.label] = l;
          }
          return [currentEnd, parallel];
        };
      })(this);
      _ref = process(this.animDesc[0], this.animDesc[1], {
        time: 0,
        namespace: this.namespace
      }, null), this.duration = _ref[0], parallel = _ref[1];
      this.actions.sort((function(_this) {
        return function(a, b) {
          return a.time - b.time;
        };
      })(this));
      this.labels.sort((function(_this) {
        return function(a, b) {
          return a.time - b.time;
        };
      })(this));
      this.labels.unshift({
        name: "start",
        time: 0
      });
      this.labels.push({
        name: "end",
        time: this.duration
      });
      return this.goStart();
    }
  };

  Animation.prototype._play = function(length, onEnd) {
    var aT;
    aT = (function(_this) {
      return function(delta) {
        return _this.advanceTime(delta, true);
      };
    })(this);
    this.currentBaseAnimation = new BaseAnimation(length, aT, (function(_this) {
      return function() {
        _this.currentBaseAnimation = null;
        return typeof onEnd === "function" ? onEnd() : void 0;
      };
    })(this));
    return this.currentBaseAnimation.play();
  };

  Animation.prototype._changeCurrentLabel = function(newLabel) {
    this.currentLabel = newLabel;
    if (this.labelChangedCallback != null) {
      return this.labelChangedCallback(this.currentLabel);
    }
  };

  Animation.prototype.play = function(onEnd) {
    if (this.currentTime >= this.duration) {
      this.goStart();
    }
    return this._play(this.duration - this.currentTime, onEnd);
  };

  Animation.prototype.playLabel = function() {
    var cLabel, end, _ref;
    end = (_ref = this.labels[this.currentLabel + 1]) != null ? _ref.time : void 0;
    if (end == null) {
      end = this.duration;
    }
    cLabel = this.currentLabel;
    this.goStart();
    this.advanceTime(this.labels[cLabel].time);
    return this._play(end - this.currentTime);
  };

  Animation.prototype.pause = function() {
    var _ref;
    return (_ref = this.currentBaseAnimation) != null ? _ref.pause() : void 0;
  };

  Animation.prototype.goStart = function() {
    this.targets.forEach(function(ao) {
      return ao.resetState();
    });
    this.currentTime = 0;
    this.currentActions = [];
    this.nextAction = 0;
    this._changeCurrentLabel(0);
    this.currentBaseAnimation = null;
    return this.advanceTime(0);
  };

  Animation.prototype.goEnd = function() {
    this.goStart();
    return this.advanceTime(this.duration);
  };

  Animation.prototype.nextLabel = function() {
    if (this.currentLabel < this.labels.length - 1) {
      return this.advanceTime(this.labels[this.currentLabel + 1].time - this.currentTime);
    }
  };

  Animation.prototype.prevLabel = function() {
    var prevLabel;
    if (this.currentLabel > 0) {
      prevLabel = this.currentLabel - 1;
      this.goStart();
      return this.advanceTime(this.labels[prevLabel].time);
    }
  };

  Animation.prototype.advanceTime = function(delta, execSingle) {
    var a, changed;
    if (execSingle == null) {
      execSingle = false;
    }
    this.currentTime += delta;
    while (this.currentLabel < this.labels.length - 1 && this.labels[this.currentLabel + 1].time <= this.currentTime) {
      this._changeCurrentLabel(this.currentLabel + 1);
    }
    while (this.nextAction < this.actions.length && this.actions[this.nextAction].time <= this.currentTime) {
      a = this.actions[this.nextAction];
      if (execSingle) {
        a.singleStart();
      }
      this.currentActions.push(a);
      this.nextAction += 1;
    }
    changed = new Set();
    this.currentActions = this.currentActions.filter((function(_this) {
      return function(a) {
        var ao;
        ao = a.exec(_this.currentTime);
        if (ao != null) {
          changed.add(ao);
        }
        if (_this.currentTime >= (a.time + a.duration)) {
          if (execSingle) {
            a.singleEnd();
          }
          return false;
        } else {
          return true;
        }
      };
    })(this));
    return changed.forEach(function(ao) {
      return ao.applyProvisional();
    });
  };

  return Animation;

})();
// Generated by CoffeeScript 1.9.0
var AnimationObject,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

AnimationObject = (function() {
  AnimationObject.byFullName = {};

  AnimationObject.variablesByFullName = {};

  AnimationObject.objects = [];

  AnimationObject.createFullName = function(namespace, name) {
    if ((namespace != null) && namespace !== "") {
      return namespace + "." + name;
    } else {
      return name;
    }
  };

  function AnimationObject(_at_element, _at_meta, _at_width, _at_height, raw) {
    var animDesc, box, group, name, s, value, varFullName, varName, _ref, _ref1;
    this.element = _at_element;
    this.meta = _at_meta;
    this.width = _at_width;
    this.height = _at_height;
    if (raw == null) {
      raw = false;
    }
    this.currentDimensions = __bind(this.currentDimensions, this);
    this.applyProvisional = __bind(this.applyProvisional, this);
    this.getProvisional = __bind(this.getProvisional, this);
    this.applyCurrent = __bind(this.applyCurrent, this);
    this.resetState = __bind(this.resetState, this);
    this.setBase = __bind(this.setBase, this);
    this.init = __bind(this.init, this);
    this.namespace = this.meta.namespace;
    if (typeof this.namespace !== "string") {
      this.namespace = "";
    }
    this.name = this.meta.name;
    this.fullName = AnimationObject.createFullName(this.namespace, this.name);
    if (this.meta.type != null) {
      this.element.setAttribute("class", this.meta.type + " " + (this.element.getAttribute("class")));
    }
    $(this.element).data("fullName", this.fullName);
    this.reference = "#" + this.fullName;
    if (this.name != null) {
      AnimationObject.byFullName[this.fullName] = this;
    }
    if (this.meta.raw != null) {
      raw = this.meta.raw;
    }
    this.index = this.meta.index;
    this.origOffset = {
      x: getFloatAttr(this.element, "x", getFloatAttr(this.element, "cx", 0)),
      y: getFloatAttr(this.element, "y", getFloatAttr(this.element, "cy", 0))
    };
    this.globalOrigMatrix = globalMatrix(this.element);
    this.localOrigMatrix = localMatrix(this.element);
    this.actualOrigMatrix = actualMatrix(this.element);
    this.externalOrigMatrix = globalMatrix(svgNode).inverse().multiply(this.globalOrigMatrix).multiply(this.localOrigMatrix.inverse());
    if (this.meta.variables != null) {
      _ref = this.meta.variables;
      for (varName in _ref) {
        value = _ref[varName];
        varFullName = AnimationObject.createFullName(this.fullName, varName);
        AnimationObject.variablesByFullName[varFullName] = value;
      }
    }
    if (this.meta.animations != null) {
      this.animations = (function() {
        var _ref1, _results;
        _ref1 = this.meta.animations;
        _results = [];
        for (name in _ref1) {
          animDesc = _ref1[name];
          name = animDesc[0].__positionals[0].slice(1);
          _results.push(new Animation(animDesc, this.fullName, name));
        }
        return _results;
      }).call(this);
    }
    if (this.meta.rawAnimations != null) {
      _ref1 = this.meta.rawAnimations;
      for (name in _ref1) {
        animDesc = _ref1[name];
        name = animDesc[0].__positionals[0].slice(1);
        new Animation(animDesc, this.fullName, name);
      }
    }
    if (!raw) {
      s = State.fromMatrix(this.localOrigMatrix);
      s.opacity = $(this.element).css("opacity");
      s.animationObject = this;

      /*
       FIXME getBBox() of transformed groups in Chrome doesn't always work as expected.
      
       It's calculated (it seems at least) as the bounding box of the untransformed group.
       Then, this box is transformed, and a new box (bound the transformed one) is created.
      
       https://code.google.com/p/chromium/issues/detail?id=377665
      
       Any ideas for a workaround? See raphael or Snap.svg?
      
       This only affects to nested groups inside the animation object, therefore, it's really
       simple to fix it. Just ungroup and regroup, to have the group transformation applied directly
       to it's elements.
      
       The same for the other getBBox() below.
       */
      box = this.element.getBBox();
      if (!((this.width != null) && (this.height != null))) {
        this.width = box.width;
        this.height = box.height;
      }
      this.origElement = this.element;
      group = svgElement("g");
      $(this.element).replaceWith(group);
      group.appendChild(this.element);
      setTransform(this.element, "");
      this.element = group;
      this.setBase(s);
      box = this.element.getBBox();
      this.compensateDelta = {
        x: box.x,
        y: box.y
      };
    }
  }

  AnimationObject.prototype.init = function() {
    var anim, _i, _len, _ref;
    if (this.index != null) {
      this.navigation = AnimationObject.byFullName[this.namespace];
      this.navigation.viewList[this.index] = this;
      $(this.element).click((function(_this) {
        return function() {
          _this.navigation.goTo(_this.index);
          return _this.navigation._setShowSlides(false);
        };
      })(this));
      this.element.setAttribute("cursor", "pointer");
    }
    if (this.animations != null) {
      _ref = this.animations;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        anim = _ref[_i];
        anim.init();
      }
    }
    return this.mainAnimation = Animation.byFullName[this.fullName + ".main"];
  };

  AnimationObject.prototype.setBase = function(state) {
    state.animationObject = this;
    this.baseState = state;
    return this.resetState();
  };

  AnimationObject.prototype.resetState = function() {
    this.baseState.apply();
    return this.currentState = this.baseState.clone();
  };

  AnimationObject.prototype.applyCurrent = function() {
    return this.currentState.apply();
  };

  AnimationObject.prototype.getProvisional = function() {
    if (this.provisionalState == null) {
      this.provisionalState = this.currentState.clone();
    }
    return this.provisionalState;
  };

  AnimationObject.prototype.applyProvisional = function() {
    this.provisionalState.apply();
    return this.provisionalState = null;
  };

  AnimationObject.prototype.currentDimensions = function() {
    var p;
    if (this.currentState != null) {
      p = this.currentState.scalePoint({
        x: this.width,
        y: this.height
      });
      return {
        width: p.x,
        height: p.y
      };
    } else {
      return {
        width: this.width,
        height: this.height
      };
    }
  };

  return AnimationObject;

})();
// Generated by CoffeeScript 1.9.0

/*
ActionDesc.register
  name: "foo"
  init: (vars) ->
    vars.duration = 0 # Here we can force duration for external actions
  arguments: [
    ["translateX", "tx"]  # Name, short and optionally default
    ["scale", null, 3]    # If short is missing, but want default
    "rotate"              # Only long name without default
  ]
  defaultContext:
    duration: 1.5
  exec: (vars, delta, rawDelta, last) ->
 */
ActionDesc.register({
  name: ["transform", "trf", "alter"],
  "arguments": [["translateX", "tx"], ["translateY", "ty"], ["scale", "s"], ["rotate", "r"], ["scaleX", "sx"], ["scaleY", "sy"], ["path"], ["range"]],
  init: function(vars) {
    var range;
    if (vars.path != null) {
      if (vars.range != null) {
        range = vars.range.split(",");
        return vars.pathRangeInfo = vars.path.getRangeInfo([parseInt(range[0]), parseInt(range[1])]);
      } else {
        return vars.pathRangeInfo = vars.path.wholeRangeInfo();
      }
    }
  },
  exec: function(vars, delta, rawDelta, last) {
    if (vars.scaleX == null) {
      vars.scaleX = vars.scale;
    }
    if (vars.scaleY == null) {
      vars.scaleY = vars.scale;
    }
    return ActionDesc.applyOnStateHelper(vars.target, last, function(state) {
      var diffScaleX, diffScaleY, t;
      state.changeCenter(vars.center);
      if (vars.translateX != null) {
        state.translateX += vars.translateX * delta;
      }
      if (vars.translateY != null) {
        state.translateY += vars.translateY * delta;
      }
      if (vars.scaleX != null) {
        diffScaleX = (state.scaleX * vars.scaleX) - state.scaleX;
        state.scaleX += diffScaleX * delta;
      }
      if (vars.scaleY != null) {
        diffScaleY = (state.scaleY * vars.scaleY) - state.scaleY;
        state.scaleY += diffScaleY * delta;
      }
      if (vars.rotate != null) {
        state.rotation += vars.rotate * delta;
      }
      if (vars.path != null) {
        t = vars.path.getTransform(delta, vars.pathRangeInfo);
        state.translateX += t.x;
        return state.translateY += t.y;
      }
    });
  }
});

ActionDesc.register({
  name: "hide",
  "arguments": [["effect", null, "fade"]],
  defaultContext: {
    duration: 0.5,
    easing: "in"
  },
  exec: function(vars, delta, rawDelta, last) {
    return ActionDesc.applyOnStateHelper(vars.target, last, function(state) {
      switch (vars.effect) {
        case "fade":
          return state.opacity = 1 - delta;
        case "slide":
          if ((0 < delta && delta < 1)) {
            state.translateX += state.width() * delta;
          }
          return state.opacity = 1 - delta;
        case "scale":
          if ((0 < delta && delta < 1)) {
            state.scaleX *= 1 + delta;
            state.scaleY *= 1 + delta;
          }
          return state.opacity = 1 - delta;
      }
    });
  }
});

ActionDesc.register({
  name: "attention",
  "arguments": [["effect", null, "shake"], ["amplitude", null, 0.05]],
  defaultContext: {
    duration: 0.5,
    easing: "inout"
  },
  exec: function(vars, delta, rawDelta, last) {
    return ActionDesc.applyOnStateHelper(vars.target, last, function(state) {
      var displacement, iterDelta, step, times, v;
      switch (vars.effect) {
        case "shake":
          if ((0 < delta && delta < 1)) {
            times = 4 * 4;
            displacement = state.width() * vars.amplitude;
            iterDelta = (delta % (1 / times)) * times;
            step = ((delta / (1 / times)) | 0) % 4;
            v = 0;
            switch (step) {
              case 0:
                v = -iterDelta * displacement;
                break;
              case 1:
                v = -(1 - iterDelta) * displacement;
                break;
              case 2:
                v = iterDelta * displacement;
                break;
              case 3:
                v = (1 - iterDelta) * displacement;
            }
            return state.translateX += v;
          }
      }
    });
  }
});
// Generated by CoffeeScript 1.9.0
var BaseAnimation,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

BaseAnimation = (function() {
  function BaseAnimation(_at_length, _at__advanceTime, _at__onEnd) {
    this.length = _at_length;
    this._advanceTime = _at__advanceTime;
    this._onEnd = _at__onEnd;
    this.pause = __bind(this.pause, this);
    this.play = __bind(this.play, this);
    this.step = __bind(this.step, this);
    this._last = null;
    this.progress = 0;
    this.paused = true;
  }

  BaseAnimation.prototype.step = function(timestamp) {
    var delta;
    if (!this.paused) {
      if (!this._last) {
        this._last = timestamp;
      }
      delta = (timestamp - this._last) / 1000;
      this.progress += delta;
      this._last = timestamp;
      this._advanceTime(delta);
      if (this.progress < this.length) {
        return window.requestAnimationFrame(this.step);
      } else if (this._onEnd != null) {
        return this._onEnd();
      }
    }
  };

  BaseAnimation.prototype.play = function() {
    if (this.pause) {
      this._last = null;
    }
    this.paused = false;
    return window.requestAnimationFrame(this.step);
  };

  BaseAnimation.prototype.pause = function() {
    return this.paused = true;
  };

  return BaseAnimation;

})();
// Generated by CoffeeScript 1.9.0
var applyCurrentReferenceState, applyDocumentState, clearDocumentState, documentState, ensureDocumentState, getCurrentReferenceState, loadDocumentState, newReferenceState, redoReferenceState, saveDocumentState, saveEmptyDocumentState, undoReferenceState, updateReferenceState, _ensureAndGetReferenceState;

documentState = null;

ensureDocumentState = function() {
  if (documentState == null) {
    documentState = {};
    return window.history.pushState("", document.title, window.location.pathname + "#restore");
  }
};

clearDocumentState = function() {
  return documentState = null;
};

_ensureAndGetReferenceState = function(reference) {
  var refStates;
  ensureDocumentState();
  refStates = documentState[reference];
  if (refStates == null) {
    refStates = {
      idx: 0,
      states: [{}]
    };
    documentState[reference] = refStates;
  }
  return refStates;
};

newReferenceState = function(reference, state) {
  var refStates;
  if (state == null) {
    state = {};
  }
  refStates = _ensureAndGetReferenceState(reference);
  refStates.states = refStates.states.slice(0, +refStates.idx + 1 || 9e9);
  refStates.states.push(state);
  return refStates.idx += 1;
};

undoReferenceState = function(reference) {
  var refStates;
  refStates = documentState != null ? documentState[reference] : void 0;
  if ((refStates != null) && refStates.idx > 0) {
    refStates.idx -= 1;
    return applyCurrentState([reference]);
  }
};

redoReferenceState = function(reference) {
  var refStates;
  refStates = documentState != null ? documentState[reference] : void 0;
  if ((refStates != null) && refStates.idx < (refStates.states.length - 1)) {
    refStates.idx += 1;
    return applyCurrentState([reference]);
  }
};

updateReferenceState = function(reference, updateFunction) {
  var current, refStates;
  refStates = _ensureAndGetReferenceState(reference);
  current = refStates.states[refStates.idx];
  return updateFunction(current);
};

getCurrentReferenceState = function(reference) {
  var refStates, s, state, _i, _len, _ref;
  refStates = documentState != null ? documentState[reference] : void 0;
  if (refStates != null) {
    state = {};
    _ref = refStates.states.slice(0, +refStates.idx + 1 || 9e9);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      s = _ref[_i];
      $.extend(true, state, s);
    }
    return state;
  }
};

applyCurrentReferenceState = function(reference, skipAnimation) {
  var o, s;
  if (skipAnimation == null) {
    skipAnimation = false;
  }
  s = getCurrentReferenceState(reference);
  if (s != null) {
    o = getObjectFromReference("", reference);
    return o != null ? o.applyReferenceState(s, skipAnimation) : void 0;
  }
};

applyDocumentState = function(skipAnimation) {
  var k, v, _results;
  if (skipAnimation == null) {
    skipAnimation = false;
  }
  if (documentState != null) {
    _results = [];
    for (k in documentState) {
      v = documentState[k];
      _results.push(applyCurrentReferenceState(k, skipAnimation));
    }
    return _results;
  }
};

saveDocumentState = function() {
  var stateString;
  if (documentState != null) {
    stateString = JSON.stringify(documentState);
    return localStorage.setItem("documentState", stateString);
  }
};

loadDocumentState = function() {
  var stateString;
  stateString = localStorage.getItem("documentState");
  if (stateString != null) {
    try {
      documentState = JSON.parse(stateString);
    } catch (_error) {

    }
  }
  if (documentState != null) {
    return applyDocumentState(true);
  }
};

saveEmptyDocumentState = function() {
  return localStorage.setItem("documentState", "{}");
};
// Generated by CoffeeScript 1.9.0

/*

* Forked from https://github.com/CreateJS/TweenJS/blob/master/src/tweenjs/Ease.js
*
* Ease
* Visit http://createjs.com/ for documentation, updates and examples.
*
* Copyright (c) 2010 gskinner.com, inc.
*
* Permission is hereby granted, free of charge, to any person
* obtaining a copy of this software and associated documentation
* files (the "Software"), to deal in the Software without
* restriction, including without limitation the rights to use,
* copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the
* Software is furnished to do so, subject to the following
* conditions:
*
* The above copyright notice and this permission notice shall be
* included in all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
* EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
* OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
* NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
* HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
* FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
* OTHER DEALINGS IN THE SOFTWARE.
 */
var Ease;

Ease = {};

Ease.linear = function(t) {
  return t;
};


/**
 * Mimics the simple -100 to 100 easing in Flash Pro.
 * @method get
 * @param {Number} amount A value from -1 (ease in) to 1 (ease out) indicating the strength and direction of the ease.
 * @static
 * @return {Function}
#
 */

Ease.get = function(amount) {
  if (amount < -1) {
    amount = -1;
  }
  if (amount > 1) {
    amount = 1;
  }
  return function(t) {
    if (amount === 0) {
      return t;
    }
    if (amount < 0) {
      return t * (t * -amount + 1 + amount);
    }
    return t * ((2 - t) * amount + 1 - amount);
  };
};


/**
 * Configurable exponential ease.
 * @method getPowIn
 * @param {Number} pow The exponent to use (ex. 3 would return a cubic ease).
 * @static
 * @return {Function}
#
 */

Ease.getPowIn = function(pow) {
  return function(t) {
    return Math.pow(t, pow);
  };
};


/**
 * Configurable exponential ease.
 * @method getPowOut
 * @param {Number} pow The exponent to use (ex. 3 would return a cubic ease).
 * @static
 * @return {Function}
#
 */

Ease.getPowOut = function(pow) {
  return function(t) {
    return 1 - Math.pow(1 - t, pow);
  };
};


/**
 * Configurable exponential ease.
 * @method getPowInOut
 * @param {Number} pow The exponent to use (ex. 3 would return a cubic ease).
 * @static
 * @return {Function}
#
 */

Ease.getPowInOut = function(pow) {
  return function(t) {
    if ((t *= 2) < 1) {
      return 0.5 * Math.pow(t, pow);
    }
    return 1 - 0.5 * Math.abs(Math.pow(2 - t, pow));
  };
};

Ease.quadIn = Ease.getPowIn(2);

Ease.quadOut = Ease.getPowOut(2);

Ease.quadInOut = Ease.getPowInOut(2);

Ease.cubicIn = Ease.getPowIn(3);

Ease.cubicOut = Ease.getPowOut(3);

Ease.cubicInOut = Ease.getPowInOut(3);

Ease["in"] = Ease.cubicIn;

Ease.out = Ease.cubicOut;

Ease.inout = Ease.cubicInOut;

Ease.quartIn = Ease.getPowIn(4);

Ease.quartOut = Ease.getPowOut(4);

Ease.quartInOut = Ease.getPowInOut(4);

Ease.quintIn = Ease.getPowIn(5);

Ease.quintOut = Ease.getPowOut(5);

Ease.quintInOut = Ease.getPowInOut(5);

Ease.sineIn = function(t) {
  return 1 - Math.cos(t * Math.PI / 2);
};

Ease.sineOut = function(t) {
  return Math.sin(t * Math.PI / 2);
};

Ease.sineInOut = function(t) {
  return -0.5 * (Math.cos(Math.PI * t) - 1);
};


/**
 * Configurable "back in" ease.
 * @method getBackIn
 * @param {Number} amount The strength of the ease.
 * @static
 * @return {Function}
#
 */

Ease.getBackIn = function(amount) {
  return function(t) {
    return t * t * ((amount + 1) * t - amount);
  };
};

Ease.backIn = Ease.getBackIn(1.7);


/**
 * Configurable "back out" ease.
 * @method getBackOut
 * @param {Number} amount The strength of the ease.
 * @static
 * @return {Function}
#
 */

Ease.getBackOut = function(amount) {
  return function(t) {
    return --t * t * ((amount + 1) * t + amount) + 1;
  };
};

Ease.backOut = Ease.getBackOut(1.7);


/**
 * Configurable "back in out" ease.
 * @method getBackInOut
 * @param {Number} amount The strength of the ease.
 * @static
 * @return {Function}
#
 */

Ease.getBackInOut = function(amount) {
  amount *= 1.525;
  return function(t) {
    if ((t *= 2) < 1) {
      return 0.5 * t * t * ((amount + 1) * t - amount);
    }
    return 0.5 * ((t -= 2) * t * ((amount + 1) * t + amount) + 2);
  };
};

Ease.backInOut = Ease.getBackInOut(1.7);

Ease.circIn = function(t) {
  return -(Math.sqrt(1 - t * t) - 1);
};

Ease.circOut = function(t) {
  return Math.sqrt(1 - --t * t);
};

Ease.circInOut = function(t) {
  if ((t *= 2) < 1) {
    return -0.5 * (Math.sqrt(1 - t * t) - 1);
  }
  return 0.5 * (Math.sqrt(1 - (t -= 2) * t) + 1);
};

Ease.bounceIn = function(t) {
  return 1 - Ease.bounceOut(1 - t);
};

Ease.bounceOut = function(t) {
  if (t < 1 / 2.75) {
    return 7.5625 * t * t;
  } else if (t < 2 / 2.75) {
    return 7.5625 * (t -= 1.5 / 2.75) * t + 0.75;
  } else if (t < 2.5 / 2.75) {
    return 7.5625 * (t -= 2.25 / 2.75) * t + 0.9375;
  } else {
    return 7.5625 * (t -= 2.625 / 2.75) * t + 0.984375;
  }
};

Ease.bounceInOut = function(t) {
  if (t < 0.5) {
    return Ease.bounceIn(t * 2) * .5;
  }
  return Ease.bounceOut(t * 2 - 1) * 0.5 + 0.5;
};


/**
 * Configurable elastic ease.
 * @method getElasticIn
 * @param {Number} amplitude
 * @param {Number} period
 * @static
 * @return {Function}
#
 */

Ease.getElasticIn = function(amplitude, period) {
  var pi2;
  pi2 = Math.PI * 2;
  return function(t) {
    var s;
    if (t === 0 || t === 1) {
      return t;
    }
    s = period / pi2 * Math.asin(1 / amplitude);
    return -(amplitude * Math.pow(2, 10 * (t -= 1)) * Math.sin((t - s) * pi2 / period));
  };
};

Ease.elasticIn = Ease.getElasticIn(1, 0.3);


/**
 * Configurable elastic ease.
 * @method getElasticOut
 * @param {Number} amplitude
 * @param {Number} period
 * @static
 * @return {Function}
#
 */

Ease.getElasticOut = function(amplitude, period) {
  var pi2;
  pi2 = Math.PI * 2;
  return function(t) {
    var s;
    if (t === 0 || t === 1) {
      return t;
    }
    s = period / pi2 * Math.asin(1 / amplitude);
    return amplitude * Math.pow(2, -10 * t) * Math.sin((t - s) * pi2 / period) + 1;
  };
};

Ease.elasticOut = Ease.getElasticOut(1, 0.3);


/**
 * Configurable elastic ease.
 * @method getElasticInOut
 * @param {Number} amplitude
 * @param {Number} period
 * @static
 * @return {Function}
#
 */

Ease.getElasticInOut = function(amplitude, period) {
  var pi2;
  pi2 = Math.PI * 2;
  return function(t) {
    var s;
    s = period / pi2 * Math.asin(1 / amplitude);
    if ((t *= 2) < 1) {
      return -0.5 * amplitude * Math.pow(2, 10 * (t -= 1)) * Math.sin((t - s) * pi2 / period);
    }
    return amplitude * Math.pow(2, -10 * (t -= 1)) * Math.sin((t - s) * pi2 / period) * 0.5 + 1;
  };
};

Ease.elasticInOut = Ease.getElasticInOut(1, 0.3 * 1.5);
// Generated by CoffeeScript 1.9.0
var createMainNavigation, initInkscape, initInkscapeLayers, processDefaultInkscapeMetaDescs, processInkscapeMetaDescs, reviveClones;

initInkscape = function() {
  reviveClones();
  initInkscapeLayers();
  createMainNavigation();
  return processDefaultInkscapeMetaDescs();
};

reviveClones = function() {
  $(".package").appendTo(svgNode).hide();
  return $(".reviveUse").each(function() {
    var clone, mClone, mUse, original, use, useDesc;
    use = this;
    original = document.getElementById(use.getAttribute("xlink:href").substr(1));
    clone = original.cloneNode(true);
    mUse = localMatrix(use);
    mClone = localMatrix(clone);
    setTransform(clone, mUse.multiply(mClone));
    setAttrs(clone, {
      id: use.getAttribute("id"),
      x: getFloatAttr(use, "x", 0),
      y: getFloatAttr(use, "y", 0)
    });
    useDesc = $(use).children("desc").appendTo(clone);
    $(clone).find("*").removeAttr("id");
    return $(use).replaceWith(clone);
  });
};

createMainNavigation = function() {
  var control, desc, m, mainNavigation, viewport, viewportDesc;
  mainNavigation = svgElement("g");
  viewport = svgElement("rect");
  setAttrs(viewport, {
    x: -50000,
    y: -50000,
    width: 100000 + svgPageWidth,
    height: 100000 + svgPageHeight,
    fill: document.querySelector("svg namedview").getAttribute("pagecolor"),
    "class": "viewport"
  });
  viewportDesc = svgElement("desc");
  viewportDesc.innerHTML = "# Meta\nnamespace: __auto__\nname: viewport\nraw: true";
  viewport.appendChild(viewportDesc);
  mainNavigation.appendChild(viewport);
  control = $("#mainNavigation")[0];
  desc = $(control).find("desc")[0];
  mainNavigation.appendChild(desc);
  control.setAttribute("class", "navigationControl");
  m = actualMatrix(control);
  setTransform(control, m);
  mainNavigation.appendChild(control);
  return svgNode.appendChild(mainNavigation);
};

initInkscapeLayers = function() {
  var baseLayers, inkscapeLayersRecursive, l, mainLayerEl, _i, _len;
  inkscapeLayersRecursive = function(root, namespace) {
    var children, layers;
    children = root.children("g");
    layers = children.filter(function(idx) {
      return children[idx].getAttribute("inkscape:groupmode") === "layer";
    }).map(function(idx, l) {
      var name;
      name = l.getAttribute("inkscape:label");
      children = inkscapeLayersRecursive($(l), namespace + "." + name);
      return new Layer(l, namespace, name, children);
    });
    return [].slice.call(layers);
  };
  baseLayers = inkscapeLayersRecursive($("svg").first(), "layers");
  mainLayerEl = svgElement("g");
  svgNode.appendChild(mainLayerEl);
  for (_i = 0, _len = baseLayers.length; _i < _len; _i++) {
    l = baseLayers[_i];
    mainLayerEl.appendChild(l.element);
  }
  return Layer.main = new Layer(mainLayerEl, "layers", "__main__", baseLayers);
};

processInkscapeMetaDescs = function(base, callback) {
  return $(base).find("desc").each(function(idx, d) {
    var doc, e, m, meta, parent, text;
    text = $(d).text();
    m = text.match(/[\s\S]*#\s*meta\s*\n([\s\S]*)/i);
    if (m != null) {
      meta = m[1];
      try {
        doc = MetaParser.parse(meta);
      } catch (_error) {
        e = _error;
        console.log("Error parsing meta: " + meta);
        throw e;
      }
      parent = d.parentNode;
      return callback(parent, doc);
    }
  });
};

processDefaultInkscapeMetaDescs = function() {
  var ao, e, getNamespaceRecursive, meta, metas, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _results;
  metas = [];
  processInkscapeMetaDescs(document, function(e, meta) {
    var aoIdx, classes;
    if (meta["class"] != null) {
      classes = "AnimationObject " + meta["class"];
    } else {
      classes = "AnimationObject";
    }
    e.setAttribute("class", classes);
    metas.push([e, meta]);
    aoIdx = metas.length - 1;
    return $(e).data("aoIdx", aoIdx);
  });
  for (_i = 0, _len = metas.length; _i < _len; _i++) {
    _ref = metas[_i], e = _ref[0], meta = _ref[1];
    if (meta.namespace === "__auto__") {
      getNamespaceRecursive = function(currEl) {
        var parent, parentIdx, parentMeta, _ref1;
        parent = $(currEl).parent().closest(".AnimationObject");
        parentIdx = parent.data("aoIdx");
        parentMeta = (_ref1 = metas[parentIdx]) != null ? _ref1[1] : void 0;
        if (parentMeta != null) {
          if (parentMeta.namespace === "__auto__") {
            parentMeta.namespace = getNamespaceRecursive(parent[0]);
          }
          return AnimationObject.createFullName(parentMeta.namespace, parentMeta.name);
        } else {
          return "packageTemplate";
        }
      };
      meta.namespace = getNamespaceRecursive(e);
    }
  }
  for (_j = 0, _len1 = metas.length; _j < _len1; _j++) {
    _ref1 = metas[_j], e = _ref1[0], meta = _ref1[1];
    ao = (function() {
      switch (meta.type) {
        case "Navigation":
          return new Navigation(e, meta);
        case "Slide":
          return new Slide(e, meta);
        case "TextScroll":
          return new TextScroll(e, meta);
        case "Path":
          return new Path(e, meta);
        default:
          return new AnimationObject(e, meta);
      }
    })();
    AnimationObject.objects.push(ao);
  }
  _ref2 = AnimationObject.objects;
  _results = [];
  for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
    ao = _ref2[_k];
    _results.push(ao.init());
  }
  return _results;
};
// Generated by CoffeeScript 1.9.0
var Layer,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

Layer = (function(_super) {
  __extends(Layer, _super);

  Layer.main = null;

  function Layer(element, namespace, name, _at_children) {
    var c, _i, _len, _ref, _ref1;
    this.children = _at_children;
    this.hide = __bind(this.hide, this);
    this.show = __bind(this.show, this);
    this.isMain = __bind(this.isMain, this);
    Layer.__super__.constructor.call(this, element, {
      namespace: namespace,
      name: name
    }, svgPageWidth, svgPageHeight, true);
    this.parent = null;
    this.slidesLayer = null;
    this.animationLayer = null;
    this.isSlides = false;
    if (name.match(/^Slides.*/i)) {
      this.isSlides = true;
    }
    this.isAnimation = false;
    if (name.match(/^Animation.*/i)) {
      this.isAnimation = true;
    }
    _ref = this.children;
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      c = _ref[_i];
      c.parent = this;
      if (c.isSlides) {
        this.slidesLayer = c;
      }
      if (c.isAnimation) {
        this.animationLayer = c;
      }
    }
    if ((_ref1 = this.animationLayer) != null) {
      _ref1.hide();
    }
    this.init();
  }

  Layer.prototype.isMain = function() {
    return this.fullName === "layers.__main__";
  };

  Layer.prototype.show = function() {
    return $(this.element).show();
  };

  Layer.prototype.hide = function() {
    return $(this.element).hide();
  };

  return Layer;

})(AnimationObject);
// Generated by CoffeeScript 1.9.0
var init;

init = function() {
  setAttrs(svgNode, {
    width: "100%",
    height: "100%"
  });
  updateWindowDimensions();
  initInkscape();
  switch (window.location.hash) {
    case "#restore":
      loadDocumentState();
      break;
    case "#reset":
      saveEmptyDocumentState();
      window.history.pushState("", document.title, window.location.pathname);
      window.location.reload();
  }
  $(window).on('hashchange', function() {
    return window.location.reload();
  });
  $(window).unload(function() {
    return saveDocumentState();
  });
  return $(svgNode).keydown(function(e) {
    if (e.keyCode === 39) {
      Navigation.active.goNext();
    }
    if (e.keyCode === 37) {
      return Navigation.active.goPrev();
    }
  });
};

window.addEventListener("load", init);
// Generated by CoffeeScript 1.9.0
var MetaParser;

MetaParser = (function() {
  function MetaParser() {}

  MetaParser.mainParser = PEG.mainParser;

  MetaParser.sideParser = PEG.sideParser;

  MetaParser.parse = function(meta, root) {
    if (root == null) {
      root = {};
    }
    MetaParser._stack = [[-1, root]];
    MetaParser._parse(MetaParser.mainParser, meta);
    return root;
  };

  MetaParser.parseAnimation = function(meta) {
    return MetaParser.parse(meta, []);
  };

  MetaParser._parse = function(parser, string) {
    var e, i, l, _i, _len, _ref;
    try {
      return parser.parse(string);
    } catch (_error) {
      e = _error;
      console.log("Error parsing Meta:");
      _ref = string.split("\n");
      for (i = _i = 0, _len = _ref.length; _i < _len; i = ++_i) {
        l = _ref[i];
        console.log(i + ": " + l);
      }
      return console.log("At line " + e.line + " char " + e.column + ": " + e.message);
    }
  };

  MetaParser._indent = 0;

  MetaParser._toValue = function(value) {
    try {
      value = JSON.parse(value);
    } catch (_error) {

    }
    return value;
  };

  MetaParser._processMain = function(left, right) {
    var current, inAnimations, indent, key, l, oudent, outdent, parent, r, sp, value;
    indent = MetaParser._indent;
    current = MetaParser._stack[MetaParser._stack.length - 1];
    oudent = false;
    while (current[0] >= indent) {
      MetaParser._stack.pop();
      current = MetaParser._stack[MetaParser._stack.length - 1];
      outdent = true;
    }
    parent = current[1];
    inAnimations = parent instanceof Array;
    key = $.trim(left);
    value = $.trim(right);
    if (value.length === 0) {
      value = key === "animations" || key === "rawAnimations" || inAnimations ? [] : {};
      MetaParser._stack.push([indent, value]);
    } else if (!inAnimations) {
      value = MetaParser._toValue(value);
    }
    if (inAnimations) {
      sp = MetaParser.sideParser;
      l = MetaParser._parse(sp, key);
      r = typeof value === "string" ? MetaParser._parse(sp, value) : value;
      return parent.push([l, r]);
    } else {
      return parent[key] = value;
    }
  };

  return MetaParser;

})();


/*

metaOut = MetaParser.parse """
  asda:
    bar:
      xxx: 27
      zar: "35 \\n 45"

  as: dasd
  foo: true ; bar: 27.45
  animations:
    @click:
      / #objectA:
       - scale:  2  d=1.5 // A comment
       - rotate: 30 d=3 ; - translate: 10 20
      / #objectB o=300:
       - scale:  2 d=7 e=linear
       - rotate: 30 d=2.3
  """

metaOut2 = MetaParser.parse """
class: Slide
namespace: slideTest
name: s0
slide:
 index: 0
 duration: 1000
animations:
 @slide:
  - transform #cursor: path=#path$0..1 d=1.5 e=inout
  - transform #cursor: s=0.8 r=-15 d=0.1 e=out o=0.2
  - d=1.5 e=inout o=0.2:
   / transform #cursor: path=#path$1..2
   / transform #var: path=#path$1..2
  - transform #cursor: s=1.25 r=15 d=0.1 e=out o=0.2
  - transform #cursor: path=#path$2..3 e=inout o=0.2
"""

animOut = MetaParser.parseAnimation "scale #foo: 2 3; rotate #bar: 25 d=37"

console.log JSON.stringify(metaOut, null, 2)
console.log JSON.stringify(metaOut2, null, 2)
console.log JSON.stringify(animOut, null, 2)
 */
// Generated by CoffeeScript 1.9.0
var Navigation,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

Navigation = (function(_super) {
  __extends(Navigation, _super);

  Navigation.main;

  Navigation.active;

  Navigation.mainNavigationContainer = null;

  function Navigation(element, meta) {
    this.viewNextLabel = __bind(this.viewNextLabel, this);
    this.viewPrevLabel = __bind(this.viewPrevLabel, this);
    this.viewAnimEnd = __bind(this.viewAnimEnd, this);
    this.viewAnimStart = __bind(this.viewAnimStart, this);
    this.viewPlayLabel = __bind(this.viewPlayLabel, this);
    this.viewPause = __bind(this.viewPause, this);
    this.viewPlay = __bind(this.viewPlay, this);
    this.applyReferenceState = __bind(this.applyReferenceState, this);
    this.updateReferenceState = __bind(this.updateReferenceState, this);
    this.saveReferenceState = __bind(this.saveReferenceState, this);
    this.goFull = __bind(this.goFull, this);
    this.goNext = __bind(this.goNext, this);
    this.goPrev = __bind(this.goPrev, this);
    this.goTo = __bind(this.goTo, this);
    this.goToState = __bind(this.goToState, this);
    this.goToView = __bind(this.goToView, this);
    this._updateCurrentLabel = __bind(this._updateCurrentLabel, this);
    this._setCurrentView = __bind(this._setCurrentView, this);
    this._setActive = __bind(this._setActive, this);
    this._setShowSlides = __bind(this._setShowSlides, this);
    this._setLock = __bind(this._setLock, this);
    this.init = __bind(this.init, this);
    if (meta.navigation.content === Layer.main.fullName) {
      this.isMain = true;
      Navigation.main = this;
    } else {
      this.isMain = false;
    }
    Navigation.__super__.constructor.call(this, element, meta, null, null, true);
    this.setBase(State.fromMatrix(localMatrix(this.element)));
    this.viewList = [];
  }

  Navigation.prototype.init = function() {
    var content, se, viewportAO;
    Navigation.__super__.init.call(this);
    content = AnimationObject.byFullName[this.meta.navigation.content];
    viewportAO = AnimationObject.byFullName[this.fullName + ".viewport"];
    this.viewport = new NavigationViewport(content, viewportAO);
    this.viewport.changeCallback = (function(_this) {
      return function() {
        _this._setCurrentView(null);
        return _this.updateReferenceState();
      };
    })(this);
    this.slidesLayer = content.slidesLayer;
    if (this.slidesLayer != null) {
      se = this.slidesLayer.element;
      $(se).appendTo(se.parentNode);
    }
    this.control = $(this.element).children(".navigationControl")[0];
    this._initNavigationControl();
    this._setLock(this.meta.navigation.hasOwnProperty("lock") && this.meta.navigation.lock !== false);
    this._setShowSlides(this.meta.navigation.hasOwnProperty("showSlides") && this.meta.navigation.showSlides !== false);
    this._setActive(this.isMain);
    if (this.meta.navigation.start != null) {
      return this.goTo(this.meta.navigation.start, true);
    } else {
      return this._setCurrentView(null);
    }
  };

  Navigation.prototype._setLock = function(isLocked) {
    this.viewport.lock = isLocked;
    if (isLocked) {
      return $(this.lockElement).css({
        opacity: 1
      });
    } else {
      return $(this.lockElement).css({
        opacity: 0.1
      });
    }
  };

  Navigation.prototype._setShowSlides = function(areShown) {
    var _ref;
    this.showSlides = areShown;
    if (areShown && (this.slidesLayer != null)) {
      $(this.showSlidesElement).css({
        opacity: 1
      });
      return this.slidesLayer.show();
    } else {
      $(this.showSlidesElement).css({
        opacity: 0.1
      });
      return (_ref = this.slidesLayer) != null ? _ref.hide() : void 0;
    }
  };

  Navigation.prototype._setActive = function(isActive) {
    if (isActive) {
      Navigation.active = this;
      return $(this.activeCueElement).css({
        opacity: 1
      });
    } else {
      return $(this.activeCueElement).css({
        opacity: 0.1
      });
    }
  };

  Navigation.prototype._setCurrentView = function(n) {
    var s, _ref, _ref1;
    this.currentView = n;
    if ((_ref = this.currentViewElementText) != null) {
      _ref.textContent = n != null ? n : "-";
    }
    s = this.viewList[this.currentView];
    if ((s != null ? s.mainAnimation : void 0) != null) {
      $(this.animationElements).css({
        opacity: 1
      });
      s.mainAnimation.labelChangedCallback = this._updateCurrentLabel;
      s.mainAnimation.goStart();
    } else {
      $(this.animationElements).css({
        opacity: 0.1
      });
      if ((_ref1 = this.currentLabelElementText) != null) {
        _ref1.textContent = "-";
      }
    }
    if ((n == null) || n === 0) {
      $(this.prevViewElement).css({
        opacity: 0.1
      });
    } else {
      $(this.prevViewElement).css({
        opacity: 1
      });
    }
    if ((n == null) || n === this.viewList.length - 1) {
      $(this.nextViewElement).css({
        opacity: 0.1
      });
    } else {
      $(this.nextViewElement).css({
        opacity: 1
      });
    }
    if (n == null) {
      return $(this.currentViewElementText).css({
        opacity: 0.1
      });
    } else {
      return $(this.currentViewElementText).css({
        opacity: 1
      });
    }
  };

  Navigation.prototype._updateCurrentLabel = function(n) {
    var s, _ref;
    s = this.viewList[this.currentView];
    if ((s != null ? s.mainAnimation : void 0) != null) {
      if ((_ref = this.currentLabelElementText) != null) {
        _ref.textContent = n;
      }
      if (n === 0) {
        $(this.prevLabelElement).css({
          opacity: 0.1
        });
        $(this.animStartElement).css({
          opacity: 0.1
        });
      } else {
        $(this.prevLabelElement).css({
          opacity: 1
        });
        $(this.animStartElement).css({
          opacity: 1
        });
      }
      if (n === s.mainAnimation.labels.length - 1) {
        $(this.nextLabelElement).css({
          opacity: 0.1
        });
        return $(this.animEndElement).css({
          opacity: 0.1
        });
      } else {
        $(this.nextLabelElement).css({
          opacity: 1
        });
        return $(this.animEndElement).css({
          opacity: 1
        });
      }
    }
  };

  Navigation.prototype._initNavigationControl = function() {
    this.activeCueElement = $(this.control).find(".activeCue")[0];
    this.homeViewElement = $(this.control).find(".homeSlide")[0];
    this.prevViewElement = $(this.control).find(".prevSlide")[0];
    this.currentViewElement = $(this.control).find(".currentSlide")[0];
    this.currentViewElementText = $(this.currentViewElement).find("tspan")[0];
    this.nextViewElement = $(this.control).find(".nextSlide")[0];
    this.playElement = $(this.control).find(".play")[0];
    this.pauseElement = $(this.control).find(".pause").hide()[0];
    this.playLabelElement = $(this.control).find(".playLabel")[0];
    this.animStartElement = $(this.control).find(".animStart")[0];
    this.prevLabelElement = $(this.control).find(".prevLabel")[0];
    this.currentLabelElement = $(this.control).find(".currentLabel")[0];
    this.currentLabelElementText = $(this.currentLabelElement).find("tspan")[0];
    this.nextLabelElement = $(this.control).find(".nextLabel")[0];
    this.animEndElement = $(this.control).find(".animEnd")[0];
    this.lockElement = $(this.control).find(".lock")[0];
    this.showSlidesElement = $(this.control).find(".showViews")[0];
    this.fullViewElement = $(this.control).find(".fullView")[0];
    this.animationElements = [this.playElement, this.pauseElement, this.playLabelElement, this.animStartElement, this.prevLabelElement, this.currentLabelElement, this.nextLabelElement, this.animEndElement];
    $(this.control).click((function(_this) {
      return function() {
        Navigation.active._setActive(false);
        return _this._setActive(true);
      };
    })(this));
    $(this.homeViewElement).click((function(_this) {
      return function() {
        return _this.goTo(0);
      };
    })(this));
    $(this.prevViewElement).click((function(_this) {
      return function() {
        return _this.goPrev();
      };
    })(this));
    $(this.nextViewElement).click((function(_this) {
      return function() {
        return _this.goNext();
      };
    })(this));
    $(this.playElement).click((function(_this) {
      return function() {
        return _this.viewPlay();
      };
    })(this));
    $(this.pauseElement).click((function(_this) {
      return function() {
        return _this.viewPause();
      };
    })(this));
    $(this.playLabelElement).click((function(_this) {
      return function() {
        return _this.viewPlayLabel();
      };
    })(this));
    $(this.animStartElement).click((function(_this) {
      return function() {
        return _this.viewAnimStart();
      };
    })(this));
    $(this.prevLabelElement).click((function(_this) {
      return function() {
        return _this.viewPrevLabel();
      };
    })(this));
    $(this.nextLabelElement).click((function(_this) {
      return function() {
        return _this.viewNextLabel();
      };
    })(this));
    $(this.animEndElement).click((function(_this) {
      return function() {
        return _this.viewAnimEnd();
      };
    })(this));
    $(this.lockElement).click((function(_this) {
      return function() {
        return _this._setLock(!_this.viewport.lock);
      };
    })(this));
    $(this.showSlidesElement).click((function(_this) {
      return function() {
        return _this._setShowSlides(!_this.showSlides);
      };
    })(this));
    return $(this.fullViewElement).click((function(_this) {
      return function() {
        return _this.goFull();
      };
    })(this));
  };

  Navigation.prototype.goToView = function(view, skipAnimation, centerPage) {
    var dest;
    if (skipAnimation == null) {
      skipAnimation = false;
    }
    if (centerPage == null) {
      centerPage = true;
    }
    dest = this.viewport.getStateForMaximizedView(view, centerPage);
    return this.goToState(dest, skipAnimation, view.duration, view.easing);
  };

  Navigation.prototype.goToState = function(dest, skipAnimation, duration, easing) {
    var a, anim, current, diff;
    if (skipAnimation == null) {
      skipAnimation = false;
    }
    if (duration === 0 || skipAnimation) {
      this.viewport.currentState = dest;
      return this.viewport.applyCurrent();
    } else {
      current = this.viewport.currentState;
      current.changeCenter(dest.center);
      diff = current.diff(dest);
      a = new Action("transform", {
        time: 0,
        target: this.viewport,
        translateX: diff.translateX,
        translateY: diff.translateY,
        scaleX: diff.scaleX,
        scaleY: diff.scaleY,
        rotate: diff.rotation,
        center: diff.center,
        duration: duration != null ? duration : 1,
        easing: easing != null ? easing : "inout"
      });
      this.animating = true;
      anim = a.getAnim((function(_this) {
        return function() {
          _this.animating = false;
          return _this.updateReferenceState();
        };
      })(this));
      return anim.play();
    }
  };

  Navigation.prototype.goTo = function(dest, skipAnimation) {
    var s;
    if (skipAnimation == null) {
      skipAnimation = false;
    }
    if (this.viewList.length > 0 && !this.animating) {
      this._setCurrentView(dest);
      s = this.viewList[dest];
      if (s != null) {
        return this.goToView(s, skipAnimation);
      }
    }
  };

  Navigation.prototype.goPrev = function() {
    var n;
    if (this.viewList.length > 0) {
      n = this.currentView;
      if (n != null) {
        n -= 1;
        if (n < 0) {
          n = 0;
        }
        return this.goTo(n);
      }
    }
  };

  Navigation.prototype.goNext = function() {
    var n;
    if (this.viewList.length > 0) {
      n = this.currentView;
      if (n != null) {
        n += 1;
        if (n > this.viewList.length - 1) {
          n = this.viewList.length - 1;
        }
        return this.goTo(n);
      }
    }
  };

  Navigation.prototype.goFull = function() {
    if (!this.animating) {
      this._setCurrentView(null);
      return this.goToState(this.viewport.baseState, false, 1, "inout");
    }
  };

  Navigation.prototype.saveReferenceState = function() {
    return newReferenceState(this.reference);
  };

  Navigation.prototype.updateReferenceState = function() {
    return updateReferenceState(this.reference, (function(_this) {
      return function(s) {
        var viewState;
        if (_this.currentView != null) {
          return s.view = _this.currentView;
        } else {
          viewState = _this.viewport.currentState;
          return s.view = {
            translateX: viewState.translateX,
            translateY: viewState.translateY,
            scaleX: viewState.scaleX,
            scaleY: viewState.scaleY,
            rotation: viewState.rotation,
            center: viewState.center
          };
        }
      };
    })(this));
  };

  Navigation.prototype.applyReferenceState = function(s, skipAnimation) {
    var dest, v;
    if (skipAnimation == null) {
      skipAnimation = false;
    }
    v = s.view;
    if (v instanceof Object) {
      dest = new State();
      dest.translateX = v.translateX;
      dest.translateY = v.translateY;
      dest.scaleX = v.scaleX;
      dest.scaleY = v.scaleY;
      dest.rotation = v.rotation;
      dest.center = v.center;
      dest.animationObject = this.viewport.currentState.animationObject;
      this.goToState(dest, skipAnimation);
      return this._setCurrentView(null);
    } else {
      return this.goTo(v, skipAnimation);
    }
  };

  Navigation.prototype.viewPlay = function() {
    var v;
    v = this.viewList[this.currentView];
    if ((v != null ? v.mainAnimation : void 0) != null) {
      $(this.pauseElement).show();
      $(this.playElement).hide();
      return v.mainAnimation.play((function(_this) {
        return function() {
          $(_this.pauseElement).hide();
          return $(_this.playElement).show();
        };
      })(this));
    }
  };

  Navigation.prototype.viewPause = function() {
    var v;
    v = this.viewList[this.currentView];
    if ((v != null ? v.mainAnimation : void 0) != null) {
      $(this.pauseElement).hide();
      $(this.playElement).show();
      return v.mainAnimation.pause();
    }
  };

  Navigation.prototype.viewPlayLabel = function() {
    var v;
    v = this.viewList[this.currentView];
    if ((v != null ? v.mainAnimation : void 0) != null) {
      this.viewPause();
      return v.mainAnimation.playLabel();
    }
  };

  Navigation.prototype.viewAnimStart = function() {
    var v;
    v = this.viewList[this.currentView];
    if ((v != null ? v.mainAnimation : void 0) != null) {
      return v.mainAnimation.goStart();
    }
  };

  Navigation.prototype.viewAnimEnd = function() {
    var v;
    v = this.viewList[this.currentView];
    if ((v != null ? v.mainAnimation : void 0) != null) {
      return v.mainAnimation.goEnd();
    }
  };

  Navigation.prototype.viewPrevLabel = function() {
    var v;
    v = this.viewList[this.currentView];
    if ((typeof s !== "undefined" && s !== null ? s.mainAnimation : void 0) != null) {
      return v.mainAnimation.prevLabel();
    }
  };

  Navigation.prototype.viewNextLabel = function() {
    var v;
    v = this.viewList[this.currentView];
    if ((v != null ? v.mainAnimation : void 0) != null) {
      return v.mainAnimation.nextLabel();
    }
  };

  return Navigation;

})(AnimationObject);
// Generated by CoffeeScript 1.9.0
var NavigationViewport,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

NavigationViewport = (function(_super) {
  __extends(NavigationViewport, _super);

  NavigationViewport.main = null;

  function NavigationViewport(content, _at_viewportAO, _at_wheelMode, limitMode) {
    var bg, clip, clipRect, container, contentDimensions, contentExternalMatrix, correctedBaseMatrix, viewportEl, viewportExternalMatrixInv;
    this.viewportAO = _at_viewportAO;
    this.wheelMode = _at_wheelMode;
    this.transformPointToCurrent = __bind(this.transformPointToCurrent, this);
    this.parentNavigations = __bind(this.parentNavigations, this);
    this.applyViewportLimits = __bind(this.applyViewportLimits, this);
    this.viewToViewportRect = __bind(this.viewToViewportRect, this);
    this.stateToViewportRect = __bind(this.stateToViewportRect, this);
    this._ToViewportRect = __bind(this._ToViewportRect, this);
    this.getStateForMaximizedView = __bind(this.getStateForMaximizedView, this);
    this.getViewportCurrentDimensions = __bind(this.getViewportCurrentDimensions, this);
    this.rotate = __bind(this.rotate, this);
    this.scale = __bind(this.scale, this);
    this.translate = __bind(this.translate, this);
    this.transformCurrent = __bind(this.transformCurrent, this);
    this.initUserNavigation = __bind(this.initUserNavigation, this);
    viewportEl = this.viewportAO.element;
    this.viewportWidth = getFloatAttr(viewportEl, "width", 0);
    this.viewportHeight = getFloatAttr(viewportEl, "height", 0);
    this.viewportElement = svgElement("g");
    bg = svgElement("rect");
    this.viewportElement.appendChild(bg);
    setAttrs(bg, {
      x: this.viewportAO.origOffset.x,
      y: this.viewportAO.origOffset.y,
      width: this.viewportWidth,
      height: this.viewportHeight,
      fill: "rgba(0,0,0,0)"
    });
    setTransform(bg, this.viewportAO.localOrigMatrix);
    clipRect = bg.cloneNode(false);
    clip = createClip(clipRect, this.viewportElement);
    applyClip(this.viewportElement, clip);
    container = svgElement("g");
    $(container).append(content.element);
    this.viewportElement.appendChild(container);
    viewportEl.parentElement.insertBefore(this.viewportElement, viewportEl.nextSibling);
    contentDimensions = content.currentDimensions();
    NavigationViewport.__super__.constructor.call(this, container, {}, contentDimensions.width, contentDimensions.height, true);
    contentExternalMatrix = content.externalOrigMatrix;
    viewportExternalMatrixInv = this.viewportAO.externalOrigMatrix.inverse();
    correctedBaseMatrix = viewportExternalMatrixInv.multiply(contentExternalMatrix);
    this.setBase(State.fromMatrix(correctedBaseMatrix));
    this.rawBaseState = State.fromMatrix(viewportExternalMatrixInv);
    this.rawBaseState.animationObject = this;
    if (content === Layer.main) {
      this.isMain = true;
      NavigationViewport.main = this;
      this.baseViewState = new State();
    } else {
      this.isMain = false;
      this.baseViewState = State.fromMatrix(viewportExternalMatrixInv.multiply(this.viewportAO.actualOrigMatrix));
    }
    this.baseViewState.animationObject = this;
    switch (limitMode) {
      case 1:
        this.rectLimits = this.stateToViewportRect(this.baseState);
        break;
      case 2:
        if (content.currentState != null) {
          this.rectLimits = this.viewToViewportRect(content);
        } else {
          console.log("Error: " + content.fullName + " cannot be used as a limit");
        }
        break;
      case 3:
        null;
    }
    this.lock = false;
    this.initUserNavigation();
  }

  NavigationViewport.prototype.initUserNavigation = function() {
    var dragging, getTransformedCursor, panning, prev, stopMove;
    prev = null;
    dragging = false;
    panning = false;
    getTransformedCursor = (function(_this) {
      return function(e) {
        var cursor;
        cursor = {
          x: e.clientX,
          y: e.clientY
        };
        return _this.transformPointToCurrent(cursor, true);
      };
    })(this);
    stopMove = (function(_this) {
      return function() {
        dragging = false;
        return panning = false;
      };
    })(this);
    return $(this.viewportElement).mousemove((function(_this) {
      return function(e) {
        var adjustedDelta, delta, p;
        if (!_this.lock) {
          if (e.ctrlKey) {
            if (!(dragging || panning)) {
              prev = getTransformedCursor(e);
            }
            panning = true;
          } else {
            panning = false;
          }
          if (dragging || panning) {
            p = getTransformedCursor(e);
            delta = {
              x: p.x - prev.x,
              y: p.y - prev.y
            };
            adjustedDelta = _this.baseState.scaleRotatePoint(delta);
            _this.translate(adjustedDelta);
            prev = p;
            if (typeof _this.changeCallback === "function") {
              _this.changeCallback();
            }
            return false;
          }
        }
      };
    })(this)).mousedown((function(_this) {
      return function(e) {
        if (!_this.lock) {
          prev = getTransformedCursor(e);
          dragging = true;
          return false;
        }
      };
    })(this)).mouseup((function(_this) {
      return function(e) {
        if (!_this.lock) {
          stopMove();
          return false;
        }
      };
    })(this)).mouseleave((function(_this) {
      return function(e) {
        if (!_this.lock) {
          stopMove();
          return false;
        }
      };
    })(this)).on("mousewheel wheel", (function(_this) {
      return function(e) {
        var center, centerPoint, delta, propagateEvent, rotation, scale;
        if (!_this.lock) {
          stopMove();
          delta = e.wheelDelta || e.deltaY;
          delta /= 500;
          if (delta > 0.5) {
            delta = 0.5;
          }
          if (delta < -0.5) {
            delta = -0.5;
          }
          propagateEvent = false;
          switch (_this.wheelMode) {
            case null:
            case void 0:
            case 0:
              centerPoint = _this.transformPointToCurrent({
                x: e.clientX,
                y: e.clientY
              });
              center = [centerPoint.x / _this.width, centerPoint.y / _this.height];
              if (e.altKey) {
                rotation = delta * 20;
                _this.rotate(rotation, center);
              } else {
                scale = 1 + delta;
                _this.scale(scale, center);
              }
              break;
            case 1:
              if (!e.ctrlKey) {
                _this.translate({
                  x: 0,
                  y: delta * 50
                });
              } else {
                propagateEvent = true;
              }
          }
          if (typeof _this.changeCallback === "function") {
            _this.changeCallback();
          }
          return propagateEvent;
        }
      };
    })(this));
  };

  NavigationViewport.prototype.transformCurrent = function(center, f) {
    var origCenter, s;
    s = this.currentState;
    if (center != null) {
      origCenter = s.center;
      s.changeCenter(center);
    }
    f(s);
    if (center != null) {
      s.changeCenter(origCenter);
    }
    this.applyViewportLimits();
    return s.apply();
  };

  NavigationViewport.prototype.translate = function(p) {
    return this.transformCurrent(null, function(s) {
      s.translateX += p.x;
      return s.translateY += p.y;
    });
  };

  NavigationViewport.prototype.scale = function(scale, center) {
    return this.transformCurrent(center, function(s) {
      s.scaleX *= scale;
      return s.scaleY *= scale;
    });
  };

  NavigationViewport.prototype.rotate = function(rotation, center) {
    return this.transformCurrent(center, function(s) {
      return s.rotation += rotation;
    });
  };

  NavigationViewport.prototype.getViewportCurrentDimensions = function() {
    if (this.isMain) {
      return {
        width: svgPageCorrectedWidth,
        height: svgPageCorrectedHeight
      };
    } else {
      return {
        width: this.viewportWidth,
        height: this.viewportHeight
      };
    }
  };

  NavigationViewport.prototype.getStateForMaximizedView = function(view, centerPage) {
    var cx, cy, orig, s, scaleFactor, scaleHorizontal, scaleVertical, tx, ty, viewDimensions, viewportDimensions, viewportProportions;
    if (centerPage == null) {
      centerPage = true;
    }
    s = this.baseViewState.clone();
    orig = view.currentState.transformPoint(view.compensateDelta);
    viewDimensions = view.currentDimensions();
    s.translateX -= orig.x;
    s.translateY -= orig.y;
    cx = orig.x / this.width;
    cy = orig.y / this.height;
    s.center = [cx, cy];
    s.rotation -= view.currentState.rotation;
    viewportDimensions = this.getViewportCurrentDimensions();
    viewportProportions = viewportDimensions.width / viewportDimensions.height;
    scaleHorizontal = viewportDimensions.width / viewDimensions.width;
    scaleVertical = viewportDimensions.height / viewDimensions.height;
    scaleFactor = null;
    tx = 0;
    ty = 0;
    if (scaleHorizontal > scaleVertical) {
      scaleFactor = scaleVertical;
      tx = ((viewDimensions.height * viewportProportions) - viewDimensions.width) * scaleFactor * matrixScaleX(this.viewportAO.localOrigMatrix) / 2;
    } else {
      scaleFactor = scaleHorizontal;
      ty = ((viewDimensions.width / viewportProportions) - viewDimensions.height) * scaleFactor * matrixScaleY(this.viewportAO.localOrigMatrix) / 2;
    }
    if (this.isMain && centerPage) {
      if (svgProportions > viewportProportions) {
        ty -= (viewportDimensions.height - (viewportDimensions.width / svgProportions)) / 2;
      } else {
        tx -= (viewportDimensions.width - (viewportDimensions.height * svgProportions)) / 2;
      }
    }
    s.translateX += tx;
    s.translateY += ty;
    s.scaleX *= scaleFactor;
    s.scaleY *= scaleFactor;
    return s;
  };

  NavigationViewport.prototype._ToViewportRect = function(orig, w, h, rotation) {
    var cos, cosH, cosW, radRotation, sin, sinH, sinW;
    radRotation = toRadians(rotation);
    sin = Math.sin(radRotation);
    cos = Math.cos(radRotation);
    sinW = sin * w;
    cosW = cos * w;
    sinH = sin * h;
    cosH = cos * h;
    return {
      points: [
        orig, {
          x: orig.x + cosW,
          y: orig.y + sinW
        }, {
          x: orig.x + cosW - sinH,
          y: orig.y + sinW + cosH
        }, {
          x: orig.x - sinH,
          y: orig.y + cosH
        }
      ],
      width: w,
      height: h
    };
  };

  NavigationViewport.prototype.stateToViewportRect = function(s) {
    var h, orig, rel, viewportDimensions, w;
    s = s.clone();
    s.changeCenter([0, 0]);
    rel = s.diff(this.baseViewState);
    orig = rel.scaleRotatePoint({
      x: rel.translateX,
      y: rel.translateY
    });
    viewportDimensions = this.getViewportCurrentDimensions();
    w = viewportDimensions.width * rel.scaleX;
    h = viewportDimensions.height * rel.scaleY;
    return this._ToViewportRect(orig, w, h, rel.rotation);
  };

  NavigationViewport.prototype.viewToViewportRect = function(view) {
    var orig, p, s;
    s = view.currentState;
    orig = s.transformPoint(view.compensateDelta);
    p = s.scalePoint({
      x: view.width,
      y: view.height
    });
    return this._ToViewportRect(orig, p.x, p.y, s.rotation);
  };

  NavigationViewport.prototype.applyViewportLimits = function() {
    var a, allowedNegH, allowedNegV, allowedPosH, allowedPosV, b, baX, baY, c, correction, current, dh, dist, dv, dx, dy, i, limits, neededNegH, neededNegV, neededPosH, neededPosV, sideLength, unitHX, unitHY, unitVX, unitVY, z, _i, _j, _len, _ref;
    limits = this.rectLimits;
    if (limits != null) {
      neededPosH = neededNegH = neededPosV = neededNegV = 0;
      allowedPosH = allowedPosV = Number.POSITIVE_INFINITY;
      allowedNegH = allowedNegV = Number.NEGATIVE_INFINITY;
      current = this.stateToViewportRect(this.currentState);
      for (i = _i = 0; _i <= 3; i = ++_i) {
        a = limits.points[i];
        b = limits.points[(i + 1) % 4];
        sideLength = i % 2 === 0 ? limits.width : limits.height;
        baX = b.x - a.x;
        baY = b.y - a.y;
        _ref = current.points;
        for (_j = 0, _len = _ref.length; _j < _len; _j++) {
          c = _ref[_j];
          z = baX * (c.y - a.y) - baY * (c.x - a.x);
          dist = Math.abs(z / sideLength);
          if (z < 0) {
            switch (i) {
              case 0:
                if (dist > neededPosV) {
                  neededPosV = dist;
                }
                break;
              case 1:
                if (-dist < neededNegH) {
                  neededNegH = -dist;
                }
                break;
              case 2:
                if (-dist < neededNegV) {
                  neededNegV = -dist;
                }
                break;
              case 3:
                if (dist > neededPosH) {
                  neededPosH = dist;
                }
            }
          } else {
            switch (i) {
              case 0:
                if (-dist > allowedNegV) {
                  allowedNegV = -dist;
                }
                break;
              case 1:
                if (dist < allowedPosH) {
                  allowedPosH = dist;
                }
                break;
              case 2:
                if (dist < allowedPosV) {
                  allowedPosV = dist;
                }
                break;
              case 3:
                if (-dist > allowedNegH) {
                  allowedNegH = -dist;
                }
            }
          }
        }
      }
      dh = neededPosH === 0 ? neededNegH : neededNegH === 0 ? neededPosH : (neededPosH + neededNegH) / 2;
      if (dh < 0 && dh < allowedNegH) {
        dh = ((dh - allowedNegH) / 2) + allowedNegH;
      } else if (dh > 0 && dh > allowedPosH) {
        dh = ((dh - allowedPosH) / 2) + allowedPosH;
      }
      dv = neededPosV === 0 ? neededNegV : neededNegV === 0 ? neededPosV : (neededPosV + neededNegV) / 2;
      if (dv < 0 && dv < allowedNegV) {
        dv = ((dv - allowedNegV) / 2) + allowedNegV;
      } else if (dv > 0 && dv > allowedPosV) {
        dv = ((dv - allowedPosV) / 2) + allowedPosV;
      }
      unitHX = (limits.points[1].x - limits.points[0].x) / limits.width;
      unitHY = (limits.points[1].y - limits.points[0].y) / limits.width;
      unitVX = (limits.points[2].x - limits.points[1].x) / limits.height;
      unitVY = (limits.points[2].y - limits.points[1].y) / limits.height;
      dx = unitHX * dh + unitVX * dv;
      dy = unitHY * dh + unitVY * dv;
      correction = this.currentState.scaleRotatePoint({
        x: dx,
        y: dy
      });
      this.currentState.translateX -= correction.x;
      return this.currentState.translateY -= correction.y;
    }
  };

  NavigationViewport.prototype.parentNavigations = function() {
    if (this.parentNavigationsCache == null) {
      this.parentNavigationsCache = [];
      $(this.element).parent().parents(".Navigation, .TextScroll").each((function(_this) {
        return function(idx, e) {
          var n;
          n = AnimationObject.byFullName[$(e).data("fullName")];
          return _this.parentNavigationsCache.push(n);
        };
      })(this));
    }
    return this.parentNavigationsCache;
  };

  NavigationViewport.prototype.transformPointToCurrent = function(p, excludeOwn, isClient) {
    var idx, n, navDiffState, _i, _ref;
    if (excludeOwn == null) {
      excludeOwn = false;
    }
    if (isClient == null) {
      isClient = true;
    }
    if (isClient) {
      p.x = (p.x - svgPageOffsetX) / svgPageScale;
      p.y = (p.y - svgPageOffsetY) / svgPageScale;
    }
    _ref = this.parentNavigations();
    for (idx = _i = _ref.length - 1; _i >= 0; idx = _i += -1) {
      n = _ref[idx];
      navDiffState = n.currentState.diff(n.baseState);
      p = navDiffState.transformPoint(p);
      if (!excludeOwn || idx > 0) {
        p = n.viewport.rawBaseState.transformPoint(p);
        p = n.viewport.currentState.transformPointInverse(p);
      }
    }
    return p;
  };

  return NavigationViewport;

})(AnimationObject);
// Generated by CoffeeScript 1.9.0
var Path,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty,
  __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

Path = (function(_super) {
  __extends(Path, _super);

  function Path(element, meta) {
    this.getTransform = __bind(this.getTransform, this);
    this.wholeRangeInfo = __bind(this.wholeRangeInfo, this);
    this.getRangeInfo = __bind(this.getRangeInfo, this);
    var destSegments, i, info, origSegments, p, s;
    Path.__super__.constructor.call(this, element, meta, 0, 0, true);
    p = __indexOf.call(this.element.classList, "translatePath") >= 0 ? this.element : this.element.querySelector(".translatePath");
    this.path = svgElement("path");
    origSegments = (function() {
      var _i, _ref, _results;
      _results = [];
      for (i = _i = 1, _ref = p.pathSegList.length; 1 <= _ref ? _i < _ref : _i > _ref; i = 1 <= _ref ? ++_i : --_i) {
        _results.push(p.pathSegList.getItem(i));
      }
      return _results;
    })();
    destSegments = this.path.pathSegList;
    destSegments.appendItem(p.createSVGPathSegMovetoRel(0, 0));
    this.segmentsInfo = (function() {
      var _i, _len, _results;
      _results = [];
      for (_i = 0, _len = origSegments.length; _i < _len; _i++) {
        s = origSegments[_i];
        info = {};
        info.offset = this.path.getTotalLength();
        info.base = this.path.getPointAtLength(info.offset);
        destSegments.appendItem(s);
        info.length = this.path.getTotalLength() - info.offset;
        _results.push(info);
      }
      return _results;
    }).call(this);
    this.totalLength = this.path.getTotalLength();
  }

  Path.prototype.getRangeInfo = function(range) {
    var l, si, startInfo, _i, _len, _ref;
    startInfo = this.segmentsInfo[range[0]];
    l = 0;
    _ref = this.segmentsInfo.slice(range[0], range[1]);
    for (_i = 0, _len = _ref.length; _i < _len; _i++) {
      si = _ref[_i];
      l += si.length;
    }
    return {
      offset: startInfo.offset,
      length: l,
      base: startInfo.base
    };
  };

  Path.prototype.wholeRangeInfo = function() {
    return getRangeInfo([0, this.segmentsInfo.length]);
  };

  Path.prototype.getTransform = function(delta, rangeInfo) {
    var p, pos;
    pos = rangeInfo.offset + rangeInfo.length * delta;
    p = this.path.getPointAtLength(pos);
    return {
      x: p.x - rangeInfo.base.x,
      y: p.y - rangeInfo.base.y
    };
  };

  return Path;

})(AnimationObject);


/* Old Bezier class, it might be of use in the future

class Bezier

  @cubicBezierPosition: (a,b,c,d,t) ->
    t2 = t*t
    t3 = t2*t

    tm = 1-t
    tm2 = tm*tm
    tm3 = tm2*tm

     * Bezier coeficients
    bc0 = tm3
    bc1 = 3 * t * tm2
    bc2 = 3 * t2 * tm
    bc3 = t3

    bc0*a + bc1*b + bc2*c + bc3*d

  constructor: (path, @N = 16) -> # N is the number of points to take in each curve to make the animation uniform

     * TODO This has to be done in both ways to be usefull
     * For now, this cannot be used on objects inside transformed groups
     * Transforms the path using the matrix,
    #transformedPath = Snap.path.map(path, matrix).toString()

     * Transform all segments to cubic
    cubicPath = Snap.path.toCubic(path).toString()

     * Transform into relative to simplify
    pathComponents = Snap.path.toRelative(cubicPath)
    pathComponents.shift() # Remove the relative initial move

    current = (x: 0, y: 0)
    prev = (x: 0, y: 0)

    @totalLength = 0
    @lengthIndex = [] # Lengths on the whole curve
    @curveIndex = [] # Double elements of lengthIndex, corresponding bezier curve and pos

     * Preprocess all the bezier curves
    for c in pathComponents
      bzr = [
        current.x, current.y
        current.x + c[1], current.y + c[2],
        current.x + c[3], current.y + c[4],
        current.x + c[5], current.y + c[6]
      ]

       * Sample the curve on N points to calculate lengths
      for i in [0...@N]
        pos = i / (@N-1)
        x = Bezier.cubicBezierPosition(bzr[0], bzr[2], bzr[4], bzr[6], pos)
        y = Bezier.cubicBezierPosition(bzr[1], bzr[3], bzr[5], bzr[7], pos)

        dx = x - prev.x
        dy = y - prev.y

        @totalLength += Math.sqrt(dx*dx + dy*dy)

        @lengthIndex.push(@totalLength)
        @curveIndex.push(bzr)
        @curveIndex.push(pos)

        prev.x = x
        prev.y = y

      current.x = bzr[6]
      current.y = bzr[7]

  getRangeInfo: (range) =>
    start = @lengthIndex[@N * range[0]]
    end = @lengthIndex[@N * range[1]] ? @totalLength

    offset: start
    length: end - start
    base: @getPoint(start)

  getPoint: (pos) =>

     * Find entry in index
    i = 0
    lI = @lengthIndex
    i++ while lI[i] < pos

    bzr = @curveIndex[2*i]
    bzrPos = @curveIndex[2*i + 1]

     * If it's not the exact pos, interpolate
    if lI[i] > pos
      nextPos = @lengthIndex[i]
      prevPos =  @lengthIndex[i-1]
      interpolateRatio = (pos - prevPos) / (nextPos - prevPos)

      if @curveIndex[2*(i-1)] != bzr # If prev is a different curve
        prevBzrPos = 0
      else
        prevBzrPos = @curveIndex[2*(i-1) + 1]

      bzrPos = interpolateRatio * (bzrPos - prevBzrPos) + prevBzrPos

    x: Bezier.cubicBezierPosition(bzr[0], bzr[2], bzr[4], bzr[6], bzrPos)
    y: Bezier.cubicBezierPosition(bzr[1], bzr[3], bzr[5], bzr[7], bzrPos)
 */
// Generated by CoffeeScript 1.9.0
var Slide,
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

Slide = (function(_super) {
  __extends(Slide, _super);

  function Slide(element, meta) {
    var t, x, y;
    Slide.__super__.constructor.call(this, element, meta);
    setStyle(this.origElement, {
      fill: "#777",
      "fill-opacity": 0.4
    });
    x = getFloatAttr(this.origElement, "x", 0);
    y = getFloatAttr(this.origElement, "y", 0);
    t = svgElement("text");
    t.appendChild(document.createTextNode(this.index.toString()));
    this.element.appendChild(t);
    setAttrs(t, {
      x: x + this.width * 0.5,
      y: y + this.height * 0.5,
      dy: ".3em"
    });
    setStyle(t, {
      "text-anchor": "middle",
      "font-family": "Arial",
      "font-size": this.width * 0.5,
      fill: "#fff",
      "fill-opacity": 0.8
    });
  }

  return Slide;

})(AnimationObject);
// Generated by CoffeeScript 1.9.0
var State,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

State = (function() {
  function State() {
    this.diff = __bind(this.diff, this);
    this.scalePointInverse = __bind(this.scalePointInverse, this);
    this.scalePoint = __bind(this.scalePoint, this);
    this.rotatePointInverse = __bind(this.rotatePointInverse, this);
    this.rotatePoint = __bind(this.rotatePoint, this);
    this.scaleRotatePointInverse = __bind(this.scaleRotatePointInverse, this);
    this.scaleRotatePoint = __bind(this.scaleRotatePoint, this);
    this.transformPointInverse = __bind(this.transformPointInverse, this);
    this.transformPoint = __bind(this.transformPoint, this);
    this.apply = __bind(this.apply, this);
    this.getMatrix = __bind(this.getMatrix, this);
    this.getCurrentTranslate = __bind(this.getCurrentTranslate, this);
    this.getCompensationDelta = __bind(this.getCompensationDelta, this);
    this.changeCenter = __bind(this.changeCenter, this);
    this._calcCenterChange = __bind(this._calcCenterChange, this);
    this.clone = __bind(this.clone, this);
    this.height = __bind(this.height, this);
    this.width = __bind(this.width, this);
    this.translateX = 0;
    this.translateY = 0;
    this.scaleX = 1;
    this.scaleY = 1;
    this.rotation = 0;
    this.opacity = 1;
    this.center = [0.5, 0.5];
    this.animationObject = null;
  }

  State.fromMatrix = function(matrix) {
    var deltaTransformPoint, px, py, s, skewX, skewY;
    deltaTransformPoint = function(matrix, point) {
      return {
        x: point.x * matrix.a + point.y * matrix.c + 0,
        y: point.x * matrix.b + point.y * matrix.d + 0
      };
    };
    px = deltaTransformPoint(matrix, {
      x: 0,
      y: 1
    });
    py = deltaTransformPoint(matrix, {
      x: 1,
      y: 0
    });
    skewX = (180 / Math.PI) * Math.atan2(px.y, px.x) - 90;
    skewY = (180 / Math.PI) * Math.atan2(py.y, py.x);
    s = new State();
    s.translateX = matrix.e;
    s.translateY = matrix.f;
    s.scaleX = matrixScaleX(matrix);
    s.scaleY = matrixScaleY(matrix);
    s.rotation = skewX;
    s.center = [0, 0];
    return s;
  };

  State.prototype.width = function() {
    return this.animationObject.width;
  };

  State.prototype.height = function() {
    return this.animationObject.height;
  };

  State.prototype.clone = function() {
    var s;
    s = new State();
    s.translateX = this.translateX;
    s.translateY = this.translateY;
    s.scaleX = this.scaleX;
    s.scaleY = this.scaleY;
    s.rotation = this.rotation;
    s.center = this.center;
    s.animationObject = this.animationObject;
    s.opacity = this.opacity;
    return s;
  };

  State._rotatePoint = function(p, degress) {
    var cos, radians, sin;
    radians = toRadians(degress);
    sin = Math.sin(radians);
    cos = Math.cos(radians);
    return {
      x: p.x * cos - p.y * sin,
      y: p.x * sin + p.y * cos
    };
  };

  State.prototype._calcCenterChange = function(c) {
    var ao, trans, vec;
    ao = this.animationObject;
    vec = {
      x: (c[0] - this.center[0]) * ao.width,
      y: (c[1] - this.center[1]) * ao.height
    };
    trans = this.scaleRotatePoint(vec);
    return {
      x: trans.x - vec.x,
      y: trans.y - vec.y
    };
  };

  State.prototype.changeCenter = function(c) {
    var cp;
    if (this.center[0] !== c[0] || this.center[1] !== c[1]) {
      cp = this._calcCenterChange(c);
      this.translateX += cp.x;
      this.translateY += cp.y;
      return this.center = c;
    }
  };

  State.prototype.getCompensationDelta = function() {
    var ao, baseDelta, currentDelta, delta;
    ao = this.animationObject;
    if (ao.compensateDelta != null) {
      delta = ao.compensateDelta;
      baseDelta = ao.baseState.scaleRotatePoint(delta);
      currentDelta = this.scaleRotatePoint(delta);
      return {
        x: currentDelta.x - baseDelta.x,
        y: currentDelta.y - baseDelta.y
      };
    } else {
      return {
        x: 0,
        y: 0
      };
    }
  };

  State.prototype.getCurrentTranslate = function() {
    var cd, cp;
    cp = this._calcCenterChange([0, 0]);
    cd = this.getCompensationDelta();
    return {
      x: this.translateX + cp.x - cd.x,
      y: this.translateY + cp.y - cd.y
    };
  };

  State.prototype.getMatrix = function() {
    var translate;
    translate = this.getCurrentTranslate();
    return svgNode.createSVGMatrix().translate(translate.x, translate.y).scaleNonUniform(this.scaleX, this.scaleY).rotate(this.rotation);
  };

  State.prototype.apply = function() {
    var ao;
    ao = this.animationObject;
    setTransform(ao.element, this.getMatrix());
    return $(ao.origElement).css({
      opacity: this.opacity
    });
  };

  State.prototype.transformPoint = function(p) {
    var srp, translate;
    srp = this.scaleRotatePoint(p);
    translate = this.getCurrentTranslate();
    return {
      x: srp.x + translate.x,
      y: srp.y + translate.y
    };
  };

  State.prototype.transformPointInverse = function(p) {
    var px, py, translate;
    translate = this.getCurrentTranslate();
    px = p.x - translate.x;
    py = p.y - translate.y;
    return this.scaleRotatePointInverse({
      x: px,
      y: py
    });
  };

  State.prototype.scaleRotatePoint = function(p) {
    var rP;
    rP = State._rotatePoint(p, this.rotation);
    return {
      x: rP.x * this.scaleX,
      y: rP.y * this.scaleY
    };
  };

  State.prototype.scaleRotatePointInverse = function(p) {
    var sX, sY;
    sX = p.x / this.scaleX;
    sY = p.y / this.scaleY;
    return State._rotatePoint({
      x: sX,
      y: sY
    }, -this.rotation);
  };

  State.prototype.rotatePoint = function(p) {
    return State._rotatePoint(p, this.rotation);
  };

  State.prototype.rotatePointInverse = function(p) {
    return State._rotatePoint(p, -this.rotation);
  };

  State.prototype.scalePoint = function(p) {
    return {
      x: p.x * this.scaleX,
      y: p.y * this.scaleY
    };
  };

  State.prototype.scalePointInverse = function(p) {
    return {
      x: p.x / this.scaleX,
      y: p.y / this.scaleY
    };
  };

  State.prototype.diff = function(dest) {
    var s;
    if (dest.center[0] !== this.center[0] || dest.center[1] !== this.center[1]) {
      dest = dest.clone();
      dest.changeCenter(this.center);
    }
    s = new State();
    s.translateX = dest.translateX - this.translateX;
    s.translateY = dest.translateY - this.translateY;
    s.scaleX = dest.scaleX / this.scaleX;
    s.scaleY = dest.scaleY / this.scaleY;
    s.rotation = dest.rotation - this.rotation;
    s.opacity = this.opacity;
    s.center = this.center;
    s.animationObject = dest.animationObject;
    return s;
  };

  return State;

})();
// Generated by CoffeeScript 1.9.0
var TextScroll,
  __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
  __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
  __hasProp = {}.hasOwnProperty;

TextScroll = (function(_super) {
  __extends(TextScroll, _super);

  function TextScroll(element, meta) {
    this.applyReferenceState = __bind(this.applyReferenceState, this);
    this.updateReferenceState = __bind(this.updateReferenceState, this);
    this.saveReferenceState = __bind(this.saveReferenceState, this);
    this.goToAnchor = __bind(this.goToAnchor, this);
    this.setScroll = __bind(this.setScroll, this);
    this.getScroll = __bind(this.getScroll, this);
    var align, animCount, container, containerAO, containerHeight, currentTextOffset, currentTextScale, flowHeight, flowRect, flowRoot, flowWidth, padding, rawText, rederedText, renderer, t, viewportAO;
    TextScroll.__super__.constructor.call(this, element, meta, null, null, true);
    this.setBase(State.fromMatrix(localMatrix(this.element)));
    flowRoot = $(this.element).find("flowRoot")[0];
    flowRect = $(flowRoot).find("flowRegion > rect")[0];
    setTransform(flowRect, getStringAttr(flowRoot, "transform"));
    flowWidth = getFloatAttr(flowRect, "width", 0);
    flowHeight = getFloatAttr(flowRect, "height", 0);
    this.scroll = 0;
    container = svgElement("foreignObject");
    setAttrs(container, {
      width: flowWidth,
      height: flowHeight
    });
    rawText = [].slice.call($(flowRoot).find("flowPara")).map(function(p) {
      return $(p).text();
    }).join("\n");
    rederedText = meta.textScroll.process === "markdown" ? (this.animations != null ? this.animations : this.animations = [], renderer = new marked.Renderer(), animCount = 0, renderer.link = (function(_this) {
      return function(href, title, text) {
        var a, animDesc, name;
        if (title == null) {
          title = "";
        }
        if (href.charAt(0) === "@") {
          animDesc = MetaParser.parseAnimation(href)[0];
          name = animDesc[0].__positionals[0].slice(1);
          if (name === "") {
            name = "link" + animCount;
          }
          a = new Animation(animDesc, _this.fullname, name);
          _this.animations.push(a);
          animCount += 1;
          return "<span\n  style=\"font-weight: bold; cursor: pointer; text-decoration: underline\"\n  title=\"" + title + "\"\n  onclick=\"Animation.byFullName['" + a.fullName + "'].play()\"\n>" + text + "</span>";
        } else {
          return "<a href=\"" + href + "\" target=\"_blank\" title=\"" + title + "\">" + text + "</a>";
        }
      };
    })(this), marked(rawText, {
      renderer: renderer
    })) : rawText;
    this.textContent = htmlElement("div");
    align = meta.textScroll.align != null ? meta.textScroll.align : "justify";
    padding = meta.textScroll.padding != null ? meta.textScroll.padding : 20;
    setStyle(this.textContent, {
      width: flowWidth - padding * 2,
      padding: padding + "px",
      "text-align": align
    });
    this.textContent.innerHTML = rederedText;
    container.appendChild(this.textContent);
    svgNode.appendChild(container);
    containerHeight = this.textContent.clientHeight;
    container.setAttribute("height", containerHeight);
    $(flowRect).hide().appendTo(this.element);
    viewportAO = new AnimationObject(flowRect, {
      namespace: this.fullName,
      name: "viewport"
    }, flowWidth, flowHeight, true);
    setTransform(container, viewportAO.actualOrigMatrix);
    containerAO = new AnimationObject(container, {
      namespace: this.fullName,
      name: "text"
    });
    this.viewport = new NavigationViewport(containerAO, viewportAO, 1, 2);
    this.viewport.changeCallback = (function(_this) {
      return function() {
        return _this.updateReferenceState();
      };
    })(this);
    this.anchors = {};
    t = $(this.textContent);
    currentTextOffset = t.offset();
    currentTextScale = containerHeight / currentTextOffset.height;
    t.find("a[name]").each((function(_this) {
      return function(idx, anchor) {
        var anchorScroll, name;
        name = getStringAttr(anchor, "name");
        anchorScroll = ($(anchor).offset().top - currentTextOffset.top) * currentTextScale;
        return _this.anchors[name] = anchorScroll - padding;
      };
    })(this));
  }

  TextScroll.prototype.getScroll = function() {
    return this.viewport.baseState.translateY - this.viewport.currentState.translateY;
  };

  TextScroll.prototype.setScroll = function(scroll) {
    this.viewport.currentState.translateY = this.viewport.baseState.translateY - scroll;
    this.viewport.applyViewportLimits();
    return this.viewport.currentState.apply();
  };

  TextScroll.prototype.goToAnchor = function(name) {
    var anchorScroll;
    anchorScroll = this.anchors[name];
    if (anchorScroll != null) {
      return this.setScroll(anchorScroll);
    }
  };

  TextScroll.prototype.saveReferenceState = function() {
    return newReferenceState(this.reference);
  };

  TextScroll.prototype.updateReferenceState = function() {
    return updateReferenceState(this.reference, (function(_this) {
      return function(s) {
        return s.scroll = _this.getScroll();
      };
    })(this));
  };

  TextScroll.prototype.applyReferenceState = function(s, skipAnimation) {
    if (skipAnimation == null) {
      skipAnimation = false;
    }
    if (s.scroll != null) {
      return this.setScroll(s.scroll);
    }
  };

  return TextScroll;

})(AnimationObject);
// Generated by CoffeeScript 1.9.0
var actualMatrix, applyClip, createClip, getFloatAttr, getIntAttr, getObjectFromReference, getStringAttr, globalMatrix, htmlElement, localMatrix, matrixScaleX, matrixScaleY, setAttrs, setStyle, setTransform, stringCmp, svgElement, svgNode, svgPageHeight, svgPageWidth, svgProportions, svgViewBox, toRadians, updateWindowDimensions, __nextClipId;

svgNode = $("svg")[0];

svgViewBox = svgNode.getAttribute("viewBox").match(/-?[\d\.]+/g);

svgPageWidth = parseFloat(svgViewBox[2]);

svgPageHeight = parseFloat(svgViewBox[3]);

svgProportions = svgPageWidth / svgPageHeight;

updateWindowDimensions = (function(_this) {
  return function() {
    _this.windowWidth = window.innerWidth;
    _this.windowHeight = window.innerHeight;
    _this.windowProportions = _this.windowWidth / _this.windowHeight;
    _this.svgPageCorrectedWidth = svgPageWidth;
    _this.svgPageCorrectedHeight = svgPageHeight;
    if (_this.windowProportions <= svgProportions) {
      _this.svgPageScale = _this.windowWidth / _this.svgPageWidth;
      _this.svgPageCorrectedHeight = svgPageCorrectedWidth / _this.windowProportions;
    } else {
      _this.svgPageScale = _this.windowHeight / _this.svgPageHeight;
      _this.svgPageCorrectedWidth = svgPageCorrectedHeight * _this.windowProportions;
    }
    _this.svgPageOffsetX = (_this.windowWidth - (_this.svgPageWidth * _this.svgPageScale)) / 2;
    return _this.svgPageOffsetY = (_this.windowHeight - (_this.svgPageHeight * _this.svgPageScale)) / 2;
  };
})(this);

$(window).resize(updateWindowDimensions);

htmlElement = function(name) {
  return document.createElementNS("http://www.w3.org/1999/xhtml", name);
};

svgElement = function(name) {
  return document.createElementNS("http://www.w3.org/2000/svg", name);
};

__nextClipId = 0;

createClip = function(path, element) {
  var clip, id;
  clip = svgElement("clipPath");
  clip.appendChild(path);
  id = "clip" + __nextClipId;
  __nextClipId += 1;
  clip.setAttribute('id', id);
  element.appendChild(clip);
  return clip;
};

applyClip = function(element, clip) {
  return element.setAttribute("clip-path", "url(#" + ($(clip).attr('id')) + ")");
};

localMatrix = function(element) {
  var bv, m, _ref;
  m = null;
  bv = element.transform.baseVal;
  if ((bv != null) && bv.length > 0) {
    m = (_ref = bv[0]) != null ? _ref.matrix : void 0;
  }
  return m != null ? m : svgNode.createSVGMatrix();
};

globalMatrix = function(element) {
  return element.getScreenCTM();
};

actualMatrix = function(element, base) {
  var baseMatrix, elementMatrix, x, y;
  baseMatrix = base != null ? globalMatrix(base) : globalMatrix(svgNode);
  elementMatrix = globalMatrix(element);
  x = getFloatAttr(element, "x", 0);
  y = getFloatAttr(element, "y", 0);
  return baseMatrix.inverse().multiply(elementMatrix.translate(x, y));
};

matrixScaleX = function(matrix) {
  return Math.sqrt(matrix.a * matrix.a + matrix.b * matrix.b);
};

matrixScaleY = function(matrix) {
  return Math.sqrt(matrix.c * matrix.c + matrix.d * matrix.d);
};

getStringAttr = function(e, name, def) {
  var _ref;
  return (_ref = e.getAttribute(name)) != null ? _ref : def;
};

getIntAttr = function(e, name, def) {
  return parseInt(getStringAttr(e, name)) || def;
};

getFloatAttr = function(e, name, def) {
  return parseFloat(getStringAttr(e, name)) || def;
};

setAttrs = function(e, attrs) {
  var k, v, _results;
  _results = [];
  for (k in attrs) {
    v = attrs[k];
    _results.push(e.setAttribute(k, v));
  }
  return _results;
};

setStyle = function(e, attrs) {
  var k, v, _results;
  _results = [];
  for (k in attrs) {
    v = attrs[k];
    _results.push(e.style[k] = v);
  }
  return _results;
};

setTransform = function(e, t) {
  if (t instanceof SVGMatrix) {
    t = "matrix(" + t.a + "," + t.b + "," + t.c + "," + t.d + "," + t.e + "," + t.f + ")";
  }
  return e.setAttribute("transform", t);
};

getObjectFromReference = function(namespace, reference) {
  var anim, ao, c, fullName, name, parentLevels, path, v;
  if (typeof reference === "string") {
    c = reference.charAt(0);
    if (c === "#" || c === "@" || c === "$") {
      path = namespace !== "" ? namespace.split(".") : [];
      if (reference.slice(1, 3) === "*%") {
        path = [];
        parentLevels = 2;
      } else {
        parentLevels = 0;
        while (reference.charAt(parentLevels + 1) === "%") {
          path.pop();
          parentLevels += 1;
        }
      }
      name = reference.slice(parentLevels + 1);
      path.push(name);
      fullName = path.join(".");
      switch (c) {
        case "#":
          ao = AnimationObject.byFullName[fullName];
          if (ao != null) {
            return ao;
          } else {
            return AnimationObject.byFullName[name];
          }
          break;
        case "@":
          anim = Animation.byFullName[fullName];
          if (anim != null) {
            return anim;
          } else {
            return Animation.byFullName[name];
          }
          break;
        case "$":
          v = AnimationObject.variablesByFullName[fullName];
          if (v != null) {
            return v;
          } else {
            return AnimationObject.variablesByFullName[name];
          }
      }
    }
  }
};

stringCmp = function(a, b) {
  if (a < b) {
    return -1;
  } else if (a > b) {
    return 1;
  } else {
    return 0;
  }
};

toRadians = function(degress) {
  return degress * (Math.PI / 180);
};
