#
# Calculate the fibonacci numbers
#
# Warning: This script can go really slow if you try to calculate the number with n > 20
#
Math.fib = (n) ->
    s = 0
    return s if n == 0
    if n == 1
      s += 1
    else
      Math.fib(n - 1) + Math.fib(n - 2)


#
# Generate a RFC 4122 GUID
#
# See section 4.4 (Algorithms for Creating a UUID from Truly Random or
# Pseudo-Random Numbers) for generating a GUID, since we don't have
# hardware access within JavaScript.
#
# More info:
#
#   - http://www.rfc-archive.org/getrfc.php?rfc=4122
#   - http://www.broofa.com/2008/09/javascript-uuid-function/
#   - http://stackoverflow.com/questions/105034/how-to-create-a-guid-uuid-in-javascript
#
Math.uuid = ->

    chars = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz'.split('')
    uuid = new Array(36)
    random = 0

    for digit in [0..36]
      switch digit
        when 8, 13, 18, 23
          uuid[digit] = '-'
        when 14
          uuid[digit] = '4'
        else
          random = 0x2000000 + (Math.random() * 0x1000000) | 0 if (random <= 0x02)
          r = random & 0xf
          random = random >> 4
          uuid[digit] = chars[if digit == 19 then (r & 0x3) | 0x8 else r]

    uuid.join('')