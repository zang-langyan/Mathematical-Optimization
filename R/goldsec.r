goldsec = function(optfunc, interval, eps = 1e-4) {
    if (!is.function(optfunc)) stop("`optfunc` is not a function")

    r = (sqrt(5) - 1) / 2
    # containers
    a <- interval[1]
    b <- interval[2]
    L <- b - a
    i <- 0
    lam1 <- a + r^2 * L
    lam2 <- a + r * L
    F1 <- optfunc(lam1)
    F2 <- optfunc(lam2)

    while TRUE {
        if (F1 < F2) {
            b <- lam2
            lam2 <- lam1
            F2 <- F1
            L <- r * L
            lam1 <- a + r^2 * L
            F1 <- optfunc(lam1)
        } else {
            a <- lam1
            lam1 <- lam2
            F1 <- F2
            L <- r * L
            lam2 <- a + r * L
            F2 <- optfunc(lam2)
        }

        i <- i + 1

        if (L < eps) {
            argmin = (b - a) / 2
            min = optfunc(argmin)
            iter = i
        }
    }

    return(list("argmin" = argmin, "min" = min, "iter" = iter))
}