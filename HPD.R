a = 1; b = 1
n = 10; y = 2
alpha = 0.05
HPD <- function(a, b, n, y, alpha)
{
  eps = alpha*0.0001
  alpha = 1-alpha
  x = seq(0, 1, length.out = 10000)
  p = dbeta(x, a+y, b+n-y)
  p.max = max(p)
  rate = 0.5
  p.max.half = rate*p.max
  q.hpd.last = 0
  step = 0
  while(TRUE)
  {
    step = step + 1
    x.hpd = x[which(p>p.max.half)]
    len = length(x.hpd)
    if (len == 0)
    {
      break
    }
    cat(paste0("Try [", x.hpd[1], ", ", x.hpd[len], "]\n"))
    q.left = pbeta(x.hpd[1], a+y, b+n-y)
    q.right = pbeta(x.hpd[len], a+y, b+n-y)
    q.hpd = q.right - q.left
    cat(paste0("q.hpd = ", q.hpd, "\n"))
    if (abs(q.hpd - alpha) < eps || abs(q.hpd - q.hpd.last) < eps)
    {
      cat(paste0("After ", step, " steps, finish!!\n"))
      break
    }
    else
    {
      if (q.hpd > alpha)
      {
        p.max.half = p.max.half*exp(q.hpd-alpha)
        q.hpd.last = q.hpd
      }
      else
        p.max.half = rate*p.max.half
    }
  }
  res = c(x.hpd[1], x.hpd[len])
  return(res)
}
HPD(a, b, n, y, alpha)
