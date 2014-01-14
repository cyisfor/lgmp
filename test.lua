local gmp = require('gmp')

print((gmp.z(10)^1000-1)/2)
