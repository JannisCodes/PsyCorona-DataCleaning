# factor numeric --------------------------------------------------------------
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}

# Panels with correlation -------------------------------------------------
pairs.panels.new = function (x, smooth = TRUE, scale = FALSE, density = TRUE, ellipses = TRUE, 
                    digits = 2, method = "pearson", pch = 20, lm = FALSE, cor = TRUE, 
                    jiggle = FALSE, factor = 2, hist.col = "grey", show.points = TRUE, 
                    rug = TRUE, breaks = "Sturges", cex.cor = 1, ...) 
{
  "panel.hist.density" <- function(x, ...) {
    usr <- par("usr")
    on.exit(par(usr))
    par(usr = c(usr[1:2], 0, 1.5))
    h <- hist(x, breaks = breaks, plot = FALSE)
    breaks <- h$breaks
    nB <- length(breaks)
    y <- h$counts
    y <- y/max(y)
    rect(breaks[-nB], 0, breaks[-1], y, col = hist.col)
    if (density) {
      tryd <- try(d <- density(x, na.rm = TRUE, bw = "nrd", 
                               adjust = 1.2), silent = TRUE)
      if (class(tryd) != "try-error") {
        d$y <- d$y/max(d$y)
        lines(d)
      }
    }
    if (rug) 
      rug(x)
  }
  "panel.cor" <- function(x, y, digits = 2, prefix = "", ...) {
    usr <- par("usr")
    on.exit(par(usr))
    par(usr = c(0, 1, 0, 1))
    r <- cor(x, y, use = "pairwise", method = method)
    txt <- format(c(round(r, digits), 0.123456789), digits = digits)[1]
    txt <- paste(prefix, txt, sep = "")
    cex <- cex.cor * 0.8/strwidth(txt)
	  test <- rcorr(x,y, type = method)
	  CI <- CIrho(test$r[2], test$n[2], level = 0.95)
    Signif <- symnum(test$P[2], corr = FALSE, na = FALSE,
                     cutpoints = c(0, 0.001, 0.01, 0.05, 0.1, 1),
                     symbols = c("***", "**", "*", ".", " "))
    if (scale) {
      cex1 <- cex * abs(r)
      if (cex1 < 0.25) 
        cex1 <- 0.25
      text(0.5, 0.5, txt, cex = 1)
    }
    else {
      text(.8, .8, Signif, cex=1.2, col=2)
      text(0.5, 0.6, bquote("r"~.(paste0(' = ',txt))), cex = 1.2)
      text(.5,.3,paste("[",round(CI[2],2),", ",round(CI[3],2),"]",sep=""), cex=1.2)
    }
  }
  "panel.smoother" <- function(x, y, pch = par("pch"), col.smooth = "red", 
                               span = 2/3, iter = 3, ...) {
    xm <- mean(x, na.rm = TRUE)
    ym <- mean(y, na.rm = TRUE)
    xs <- sd(x, na.rm = TRUE)
    ys <- sd(y, na.rm = TRUE)
    r = cor(x, y, use = "pairwise", method = method)
    if (jiggle) {
      x <- jitter(x, factor = factor)
      y <- jitter(y, factor = factor)
    }
    if (show.points) 
      points(x, y, pch = pch, ...)
    ok <- is.finite(x) & is.finite(y)
    if (any(ok)) 
      lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), 
            col = col.smooth, ...)
    panel.ellipse1(xm, ym, xs, ys, r, col.smooth = col.smooth, 
                   ...)
  }
  "panel.smoother.no.noellipse" <- function(x, y, pch = par("pch"), 
                                            col.smooth = "red", span = 2/3, iter = 3, ...) {
    xm <- mean(x, na.rm = TRUE)
    ym <- mean(y, na.rm = TRUE)
    xs <- sd(x, na.rm = TRUE)
    ys <- sd(y, na.rm = TRUE)
    r = cor(x, y, use = "pairwise", method = method)
    if (jiggle) {
      x <- jitter(x, factor = factor)
      y <- jitter(y, factor = factor)
    }
    if (show.points) 
      points(x, y, pch = pch, ...)
    ok <- is.finite(x) & is.finite(y)
    if (any(ok)) 
      lines(stats::lowess(x[ok], y[ok], f = span, iter = iter), 
            col = col.smooth, ...)
  }
  "panel.lm" <- function(x, y, pch = par("pch"), col.lm = "red", 
                         ...) {
    ymin <- min(y)
    ymax <- max(y)
    xmin <- min(x)
    xmax <- max(x)
    ylim <- c(min(ymin, xmin), max(ymax, xmax))
    xlim <- ylim
    if (jiggle) {
      x <- jitter(x, factor = factor)
      y <- jitter(y, factor = factor)
    }
    points(x, y, pch = pch, ylim = ylim, xlim = xlim, ...)
    ok <- is.finite(x) & is.finite(y)
    if (any(ok)) 
      abline(lm(y[ok] ~ x[ok]), col = col.lm, ...)
  }
  "panel.lm.ellipse" <- function(x, y, pch = par("pch"), col.lm = "red", 
                                 ...) {
    ymin <- min(y)
    ymax <- max(y)
    xmin <- min(x)
    xmax <- max(x)
    ylim <- c(min(ymin, xmin), max(ymax, xmax))
    xlim <- ylim
    if (jiggle) {
      x <- jitter(x, factor = factor)
      y <- jitter(y, factor = factor)
    }
    points(x, y, pch = pch, ylim = ylim, xlim = xlim, ...)
    ok <- is.finite(x) & is.finite(y)
    if (any(ok)) 
      abline(lm(y[ok] ~ x[ok]), col = col.lm, ...)
    xm <- mean(x, na.rm = TRUE)
    ym <- mean(y, na.rm = TRUE)
    xs <- sd(x, na.rm = TRUE)
    ys <- sd(y, na.rm = TRUE)
    r = cor(x, y, use = "pairwise", method = method)
    panel.ellipse1(xm, ym, xs, ys, r, col.smooth = col.lm, 
                   ...)
  }
  "panel.ellipse1" <- function(x = 0, y = 0, xs = 1, ys = 1, 
                               r = 0, col.smooth, add = TRUE, segments = 51, ...) {
    angles <- (0:segments) * 2 * pi/segments
    unit.circle <- cbind(cos(angles), sin(angles))
    if (!is.na(r)) {
      if (abs(r) > 0) 
        theta <- sign(r)/sqrt(2)
      else theta = 1/sqrt(2)
      shape <- diag(c(sqrt(1 + r), sqrt(1 - r))) %*% matrix(c(theta, 
                                                              theta, -theta, theta), ncol = 2, byrow = TRUE)
      ellipse <- unit.circle %*% shape
      ellipse[, 1] <- ellipse[, 1] * xs + x
      ellipse[, 2] <- ellipse[, 2] * ys + y
      points(x, y, pch = 19, col = col.smooth, cex = 1.5)
      lines(ellipse, ...)
    }
  }
  "panel.ellipse" <- function(x, y, pch = par("pch"), col.smooth = "red", 
                              ...) {
    segments = 51
    xm <- mean(x, na.rm = TRUE)
    ym <- mean(y, na.rm = TRUE)
    xs <- sd(x, na.rm = TRUE)
    ys <- sd(y, na.rm = TRUE)
    r = cor(x, y, use = "pairwise", method = method)
    if (jiggle) {
      x <- jitter(x, factor = factor)
      y <- jitter(y, factor = factor)
    }
    if (show.points) 
      points(x, y, pch = pch, ...)
    angles <- (0:segments) * 2 * pi/segments
    unit.circle <- cbind(cos(angles), sin(angles))
    if (!is.na(r)) {
      if (abs(r) > 0) 
        theta <- sign(r)/sqrt(2)
      else theta = 1/sqrt(2)
      shape <- diag(c(sqrt(1 + r), sqrt(1 - r))) %*% matrix(c(theta, 
                                                              theta, -theta, theta), ncol = 2, byrow = TRUE)
      ellipse <- unit.circle %*% shape
      ellipse[, 1] <- ellipse[, 1] * xs + xm
      ellipse[, 2] <- ellipse[, 2] * ys + ym
      points(xm, ym, pch = 19, col = col.smooth, cex = 1.5)
      if (ellipses) 
        lines(ellipse, ...)
    }
  }
  old.par <- par(no.readonly = TRUE)
  on.exit(par(old.par))
  if (missing(cex.cor)) 
    cex.cor <- 1
  for (i in 1:ncol(x)) {
    if (is.character(x[[i]])) {
      x[[i]] <- as.numeric(as.factor(x[[i]]))
      colnames(x)[i] <- paste(colnames(x)[i], "*", sep = "")
    }
  }
  if (!lm) {
    if (smooth) {
      if (ellipses) {
        pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, 
              lower.panel = panel.smoother, pch = pch, ...)
      }
      else {
        pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, 
              lower.panel = panel.smoother.no.noellipse, 
              pch = pch, ...)
      }
    }
    else {
      pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, 
            lower.panel = panel.ellipse, pch = pch, ...)
    }
  }
  else {
    if (!cor) {
      if (ellipses) {
        pairs(x, diag.panel = panel.hist.density, upper.panel = panel.lm.ellipse, 
              lower.panel = panel.lm.ellipse, pch = pch, 
              ...)
      }
      else {
        pairs(x, diag.panel = panel.hist.density, upper.panel = panel.lm, 
              lower.panel = panel.lm, pch = pch, ...)
      }
    }
    else {
      if (ellipses) {
        pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, 
              lower.panel = panel.lm.ellipse, pch = pch, 
              ...)
      }
      else {
        pairs(x, diag.panel = panel.hist.density, upper.panel = panel.cor, 
              lower.panel = panel.lm, pch = pch, ...)
      }
    }
  }
}


# x is a matrix containing the data -------------------------------------------------------------
# method : correlation method. "pearson"" or "spearman"" is supported
# removeTriangle : remove upper or lower triangle
# results :  if "html" or "latex"
  # the results will be displayed in html or latex format
corstars <-function(x, method=c("pearson", "spearman"), removeTriangle=c("upper", "lower"),
                     result=c("none", "html", "latex")){
    #Compute correlation matrix
    require(Hmisc)
    x <- as.matrix(x)
    correlation_matrix<-rcorr(x, type=method[1])
    R <- correlation_matrix$r # Matrix of correlation coeficients
    p <- correlation_matrix$P # Matrix of p-value 
    
    ## Define notions for significance levels; spacing is important.
    mystars <- ifelse(p < .0001, "****", ifelse(p < .001, "*** ", ifelse(p < .01, "**  ", ifelse(p < .05, "*   ", "    "))))
    
    ## trunctuate the correlation matrix to two decimal
    R <- format(round(cbind(rep(-1.11, ncol(x)), R), 2))[,-1]
    
    ## build a new matrix that includes the correlations with their apropriate stars
    Rnew <- matrix(paste(R, mystars, sep=""), ncol=ncol(x))
    diag(Rnew) <- paste(diag(R), " ", sep="")
    rownames(Rnew) <- colnames(x)
    colnames(Rnew) <- paste(colnames(x), "", sep="")
    
    ## remove upper triangle of correlation matrix
    if(removeTriangle[1]=="upper"){
      Rnew <- as.matrix(Rnew)
      Rnew[upper.tri(Rnew, diag = TRUE)] <- ""
      Rnew <- as.data.frame(Rnew)
    }
    
    ## remove lower triangle of correlation matrix
    else if(removeTriangle[1]=="lower"){
      Rnew <- as.matrix(Rnew)
      Rnew[lower.tri(Rnew, diag = TRUE)] <- ""
      Rnew <- as.data.frame(Rnew)
    }
    
    ## remove last column and return the correlation matrix
    Rnew <- cbind(Rnew[1:length(Rnew)-1])
    if (result[1]=="none") return(Rnew)
    else{
      if(result[1]=="html") print(xtable(Rnew), type="html")
      else print(xtable(Rnew), type="latex") 
    }
} 

