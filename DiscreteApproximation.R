mu0 = 1.9; t20 = 0.95^2; s20 = 0.01; nu0 = 1
y = c(1.64, 1.70, 1.72, 1.74, 1.82, 1.82, 1.82, 1.90, 2.08)
G = 100; H = 100
mean.grid = seq(1.505, 2.00, length = G)
prec.grid = seq(1.75,175, length = H)
post.grid = matrix(nrow = G, ncol = H)

for (g in 1:G){
    for (h in 1:H){
        post.grid[g, h] =
            dnorm(mean.grid[g], mu0, sqrt(t20)) *
            dgamma(prec.grid[h], nu0/2, s20*nu0/2) *
            prod(dnorm(y, mean.grid[g], 1/sqrt(prec.grid[h])))
    }    
}

post.grid = post.grid/sum(post.grid)
post.grid
