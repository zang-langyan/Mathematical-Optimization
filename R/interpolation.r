# BSD 3-Clause License
# Copyright (c) 2022, Langyan
# All rights reserved.

divided_diff = function(func,x) {
    if (!is.function(func)) stop("`func` is not a function")

    if (length(x) == 1) {
        return(func(x[1]))
    } else {
        return( divided_diff(func,x[2:length(x)]) - divided_diff(func,x[1:length(x)-1]) ) / ( x[length(x)] - x[1] )
    }
}

powells = function(func,lam0 = 0,h = 0.01,eps=1e-4,H=2) {
    if (!is.function(func)) stop("`func` is not a function")

    lam1 = lam0 + h
    F0 = func(lam0)
    F1 = func(lam1)
    if (F0 < F1) {
        lam2 = lam0 - h
    } else {
        lam2 = lam0 + 2*h
    }

    lam <- as.matrix(c(lam0,lam1,lam2))

    i = 0

    while (TRUE) {
        i = i+1

        lam_m <- (lam[1] + lam[2]) / 2 - divided_diff(func,lam[1;2]) / (2*divided_diff(func,lam))

        if (func(lam_m) < func(lam(1))) {
            mincheck <- TRUE
        } else {
            mincheck <- FALSE
        }

        lam_n <- lam[which.min(lam - lam_m)]

        if (mincheck) {
            if (abs(lam_m - lam_n) > H) {
                lam[which.max(lam - lam_m)] <- lam[which.min(apply(lam,1,func))] + H * sign(func(lam[which.min(apply(lam,1,func))]) - func(lam[which.min(apply(lam,1,func))] + 1e-3))
            } else if (abs(lam_m - lam_n) < eps) {
                lam_star = as.matrix(c(lam_n,lam_m))

                return(list("argmin" = lam_star(which.min(apply(lam,1,func))), "min" = min(apply(lam_star,1,func)), "iter" = i))
            } else {
                lam[which.max(lam - lam_m)] <- lam_m
            }
        } else {
            lam[which.min(lam - lam_m)] <- lam[which.min(apply(lam,1,func))] + H * sign(func(lam[which.min(apply(lam,1,func))]) - func(lam[which.min(apply(lam,1,func))] + 1e-3))
        }
    }
}