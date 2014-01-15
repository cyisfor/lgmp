require('./gmp')

print('lshift=',gmp.z(0x10):lshift(2):rshift(1))

print('---')

print((gmp.z(10)^1000-1)/2)
print('---')
