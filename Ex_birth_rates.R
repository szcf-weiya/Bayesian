## prior parameters
a = 2; b = 1
## data in group 1
n1 = 111; sy1 = 217
## data in group 2
n2 = 44; sy2 = 66

## posterior mean
(a+sy1)/(b+n1)

## posterior mode
(a+sy1-1)/(b+n1)

## posterior 95% CI
qgamma(c(.025, .975), a+sy1, b+n1)

## the same for group 2


## prediction
y = 0:10
dnbinom(y, size=(a+sy1), mu = (a+sy1)/(b+n1))
dnbinom(y, size=(a+sy2), mu = (a+sy2)/(b+n2))

