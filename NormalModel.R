## ################################
## midge data
##
## ################################

## prior
mu0 = 1.9; k0 = 1
s20 = 0.010; nu0 = 1

## data
y = c(1.64, 1.70, 1.72, 1.74, 1.82, 1.82, 1.82, 1.90, 2.08)
n = length(y)
ybar = mean(y)
s2 = var(y)

## posterior inference
kn = k0+n; nun = nu0+n
mun = (k0*mu0 + n*ybar)/kn
s2n = (nu0*s20 + (n-1)*s2 + k0*n*(ybar-mu0)^2/kn)/nun

## ################################
## MC
##
## ################################

s2.postsample = 1/rgamma(10000, nun/2, s2n*nun/2)
theta.postsample = rnorm(10000, mun, sqrt(s2.postsample/kn))

