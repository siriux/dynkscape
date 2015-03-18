###

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

###

Ease = {}

Ease.linear = (t) -> t


###*
# Mimics the simple -100 to 100 easing in Flash Pro.
# @method get
# @param {Number} amount A value from -1 (ease in) to 1 (ease out) indicating the strength and direction of the ease.
# @static
# @return {Function}
#
###

Ease.get = (amount) ->
  if amount < -1
    amount = -1
  if amount > 1
    amount = 1
  (t) ->
    if amount == 0
      return t
    if amount < 0
      return t * (t * -amount + 1 + amount)
    t * ((2 - t) * amount + 1 - amount)

###*
# Configurable exponential ease.
# @method getPowIn
# @param {Number} pow The exponent to use (ex. 3 would return a cubic ease).
# @static
# @return {Function}
#
###

Ease.getPowIn = (pow) ->
  (t) ->
    t ** pow

###*
# Configurable exponential ease.
# @method getPowOut
# @param {Number} pow The exponent to use (ex. 3 would return a cubic ease).
# @static
# @return {Function}
#
###

Ease.getPowOut = (pow) ->
  (t) ->
    1 - (1 - t) ** pow

###*
# Configurable exponential ease.
# @method getPowInOut
# @param {Number} pow The exponent to use (ex. 3 would return a cubic ease).
# @static
# @return {Function}
#
###

Ease.getPowInOut = (pow) ->
  (t) ->
    if (t *= 2) < 1
      return 0.5 * t ** pow
    1 - 0.5 * Math.abs((2 - t) ** pow)


Ease.quadIn = Ease.getPowIn(2)
Ease.quadOut = Ease.getPowOut(2)
Ease.quadInOut = Ease.getPowInOut(2)


Ease.cubicIn = Ease.getPowIn(3)
Ease.cubicOut = Ease.getPowOut(3)
Ease.cubicInOut = Ease.getPowInOut(3)

Ease.in = Ease.cubicIn
Ease.out = Ease.cubicOut
Ease.inout = Ease.cubicInOut

Ease.quartIn = Ease.getPowIn(4)
Ease.quartOut = Ease.getPowOut(4)
Ease.quartInOut = Ease.getPowInOut(4)

Ease.quintIn = Ease.getPowIn(5)
Ease.quintOut = Ease.getPowOut(5)
Ease.quintInOut = Ease.getPowInOut(5)

Ease.sineIn = (t) -> 1 - Math.cos(t * Math.PI / 2)
Ease.sineOut = (t) -> Math.sin t * Math.PI / 2
Ease.sineInOut = (t) -> -0.5 * (Math.cos(Math.PI * t) - 1)

###*
# Configurable "back in" ease.
# @method getBackIn
# @param {Number} amount The strength of the ease.
# @static
# @return {Function}
#
###

Ease.getBackIn = (amount) ->
  (t) ->
    t * t * ((amount + 1) * t - amount)

Ease.backIn = Ease.getBackIn(1.7)

###*
# Configurable "back out" ease.
# @method getBackOut
# @param {Number} amount The strength of the ease.
# @static
# @return {Function}
#
###

Ease.getBackOut = (amount) ->
  (t) ->
    --t * t * ((amount + 1) * t + amount) + 1

Ease.backOut = Ease.getBackOut(1.7)

###*
# Configurable "back in out" ease.
# @method getBackInOut
# @param {Number} amount The strength of the ease.
# @static
# @return {Function}
#
###

Ease.getBackInOut = (amount) ->
  amount *= 1.525
  (t) ->
    if (t *= 2) < 1
      return 0.5 * t * t * ((amount + 1) * t - amount)
    0.5 * ((t -= 2) * t * ((amount + 1) * t + amount) + 2)

Ease.backInOut = Ease.getBackInOut(1.7)

Ease.circIn = (t) -> -(Math.sqrt(1 - t * t) - 1)
Ease.circOut = (t) -> Math.sqrt 1 - --t * t
Ease.circInOut = (t) ->
  if (t *= 2) < 1
    return -0.5 * (Math.sqrt(1 - t * t) - 1)
  0.5 * (Math.sqrt(1 - (t -= 2) * t) + 1)


Ease.bounceIn = (t) ->
  1 - Ease.bounceOut(1 - t)

Ease.bounceOut = (t) ->
  if t < 1 / 2.75
    7.5625 * t * t
  else if t < 2 / 2.75
    7.5625 * (t -= 1.5 / 2.75) * t + 0.75
  else if t < 2.5 / 2.75
    7.5625 * (t -= 2.25 / 2.75) * t + 0.9375
  else
    7.5625 * (t -= 2.625 / 2.75) * t + 0.984375

Ease.bounceInOut = (t) ->
  if t < 0.5
    return Ease.bounceIn(t * 2) * .5
  Ease.bounceOut(t * 2 - 1) * 0.5 + 0.5

###*
# Configurable elastic ease.
# @method getElasticIn
# @param {Number} amplitude
# @param {Number} period
# @static
# @return {Function}
#
###

Ease.getElasticIn = (amplitude, period) ->
  pi2 = Math.PI * 2
  (t) ->
    if t == 0 or t == 1
      return t
    s = period / pi2 * Math.asin(1 / amplitude)
    -(amplitude * 2 ** (10 * (t -= 1)) * Math.sin((t - s) * pi2 / period))

Ease.elasticIn = Ease.getElasticIn(1, 0.3)

###*
# Configurable elastic ease.
# @method getElasticOut
# @param {Number} amplitude
# @param {Number} period
# @static
# @return {Function}
#
###

Ease.getElasticOut = (amplitude, period) ->
  pi2 = Math.PI * 2
  (t) ->
    if t == 0 or t == 1
      return t
    s = period / pi2 * Math.asin(1 / amplitude)
    amplitude * 2 ** (-10 * t) * Math.sin((t - s) * pi2 / period) + 1

Ease.elasticOut = Ease.getElasticOut(1, 0.3)

###*
# Configurable elastic ease.
# @method getElasticInOut
# @param {Number} amplitude
# @param {Number} period
# @static
# @return {Function}
#
###

Ease.getElasticInOut = (amplitude, period) ->
  pi2 = Math.PI * 2
  (t) ->
    s = period / pi2 * Math.asin(1 / amplitude)
    if (t *= 2) < 1
      return -0.5 * amplitude * 2 ** (10 * (t -= 1)) * Math.sin((t - s) * pi2 / period)
    amplitude * 2 ** (-10 * (t -= 1)) * Math.sin((t - s) * pi2 / period) * 0.5 + 1

Ease.elasticInOut = Ease.getElasticInOut(1, 0.3 * 1.5)
