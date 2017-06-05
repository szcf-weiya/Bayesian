## data
mu0 = 1.9; t20 = 0.95^2; s20 = 0.01; nu0 = 1
y = c(1.64, 1.70, 1.72, 1.74, 1.82, 1.82, 1.82, 1.90, 2.08)

mean.y = mean(y)
var.y = var(y)
n = length(y)

## starting values
S = 1000
PHI = matrix(nrow = S, ncol=2)
PHI[1,] = phi = c(mean.y, 1/var.y)

## gibbs sampling
set.seed(1)
for (s in 2:S)
{
    ## generate a new theta value from its full conditional
    mun = (mu0/t20 + n*mean.y*phi[2])/(1/t20 + n*phi[2])
    t2n = 1/(1/t20 + n*phi[2])
    phi[1] = rnorm(1, mun, sqrt(t2n))

    ## generate a new 1/sigma^2 value from its full conditional
    nun = nu0 + n
    ## A trick
    s2n = (nu0*s20 + (n-1)*var.y + n*(mean.y-phi[1])^2)/nun
    phi[2] = rgamma(1, nun/2, nun*s2n/2)

    PHI[s, ] = phi
}

## CI for population mean
quantile(PHI[,1], c(.025, .5, .975))
## CI for population precision
quantile(PHI[,2], c(.025, .5, .975))

## CI for population standard deviation
quantile(1/sqrt(PHI[,2]), c(.025, .5, .975))



## ##################################
## The empirical distribution of these Gibbs samples very closely resembles the
## discrete approximation to their posterior distribution
##
## ##################################
