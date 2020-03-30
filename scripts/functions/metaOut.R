metaOut <- function(processDataIn, name) {
  process <- processDataIn
  
  # extract parameter names
    var <- as.character(unique(process$Parameter))
    names <- qdap::mgsub(c("Fail", ".", "RadNat", "Prej", "Hate", "Total", "Direct"),
                         c("Disempowerment"," to ", "Radical Nationalism", "Prejudice", "Hate Crime", "Total Effect", "Direct Effect"), 
                         var)
  
  # recode Utrecht parameters that predict hate crime attributions
    process[process$Parameter %in% grep("Hate|Total|irect", var, value=T) & process$Study=="Utrecht",]$B <- 
      process[process$Parameter %in% grep("Hate|Total|irect", var, value=T) & process$Study=="Utrecht",]$B*-1
    process[process$Parameter %in% grep("Hate|Total|irect", var, value=T) & process$Study=="Utrecht",]$t <- 
      process[process$Parameter %in% grep("Hate|Total|irect", var, value=T) & process$Study=="Utrecht",]$t*-1
    
  ### Parametric Meta-Analysis
    meta.parametric <- list()
    meta.parametric.forest <- list()
    meta.bootstrapped <- list()
    meta.parametric.sum <- data.frame(effect = var, 
                                      name = names, 
                                      beta.Pittsburgh = NA, 
                                      CI.Pittsburgh = NA,
                                      beta.Christchurch = NA, 
                                      CI.Christchurch = NA,
                                      beta.Utrecht = NA,
                                      CI.Utrecht = NA, 
                                      RE.beta = NA,
                                      RE.CI = NA,
                                      RE.pval = NA,
                                      RE.star = NA)

    for(i in 1:7){
      md <- escalc(data = process[process$Parameter==var[i],],
                   measure = "SPCOR",
                   ti = t,
                   ni = N,
                   mi = m,
                   r2i = r2,
                   var.names = c(paste(var[i],".yi",sep=""),paste(var[i],".vi",sep="")))
      
      meta.parametric[[var[i]]] <- rma(yi = get(paste(var[i],".yi",sep="")),
                                       vi = get(paste(var[i],".vi",sep="")), 
                                       data = md, 
                                       method = "REML", 
                                       slab = Study)
      #metafor::forest(meta.parametric[[var[i]]],
      #                main = paste("Meta Analysis ",names[i],sep = ""))
      
      meta.parametric.sum$effect[i] <- var[i]
      meta.parametric.sum$beta.Pittsburgh[i] <- meta.parametric[[var[i]]]$yi[1]
      meta.parametric.sum$beta.Christchurch[i] <- meta.parametric[[var[i]]]$yi[2]
      meta.parametric.sum$beta.Utrecht[i] <- meta.parametric[[var[i]]]$yi[3]
      meta.parametric.sum$CI.Pittsburgh[i] <- paste("[",                                  round(meta.parametric[[var[i]]]$yi[1]-1.96*sqrt(meta.parametric$Fail.RadNat$vi[1]),2),", ",round(meta.parametric[[var[i]]]$yi[1]+1.96*sqrt(meta.parametric$Fail.RadNat$vi[1]),2),"]",sep="")
      meta.parametric.sum$CI.Christchurch[i] <- paste("[",                                  round(meta.parametric[[var[i]]]$yi[2]-1.96*sqrt(meta.parametric$Fail.RadNat$vi[2]),2),", ",round(meta.parametric[[var[i]]]$yi[2]+1.96*sqrt(meta.parametric$Fail.RadNat$vi[2]),2),"]",sep="")
      meta.parametric.sum$CI.Utrecht[i] <- paste("[",                                  round(meta.parametric[[var[i]]]$yi[3]-1.96*sqrt(meta.parametric$Fail.RadNat$vi[3]),2),", ",round(meta.parametric[[var[i]]]$yi[3]+1.96*sqrt(meta.parametric$Fail.RadNat$vi[3]),2),"]",sep="")
      meta.parametric.sum$RE.beta[i] <- meta.parametric[[var[i]]]$b
      meta.parametric.sum$RE.CI[i] <- paste("[",
                                            round(meta.parametric[[var[i]]]$ci.lb, 2),
                                            ", ", round(meta.parametric[[var[i]]]$ci.ub,2),"]", sep="")
      meta.parametric.sum$RE.pval[i] <- meta.parametric[[var[i]]]$pval
      meta.parametric.sum$RE.star[i] <- ifelse(meta.parametric.sum$RE.pval[i]<0.001,"***",ifelse(meta.parametric.sum$RE.pval[i]<0.01,"**",ifelse(meta.parametric.sum$RE.pval[i]<0.05,"*","")))
    }
    #meta.parametric
      
    eff <- escalc(data = process, slab = Parameter,
                  measure = "SPCOR",
                  ti = t,
                  ni = N,
                  mi = m,
                  r2i = r2)
    meta <- rma(yi = yi,
                vi = vi, 
                data = eff[1:21,], 
                method = "REML", 
                slab = paste(Parameter, Study, sep=" - "))
    
    k <- 7*3
    png(file = paste0("Output/figures/forest_parametric_", name, ".png"), height = 200 + 40*k^.85) 
      metafor::forest(meta, xlim=c(-1.25, 1.5), cex=0.75, ylim=c(-1, 44), rows=c(40:38,34:32,28:26,22:20,16:14,10:8,4:2), 
                      slab = rep(c("Pittsburgh","Christchurch", "Utrecht"),7),
                      mlab="", xlab = "Standardized Beta", main=paste0("Meta Analysis: Forest Plot [Parametric] \n(",name,")"))
      par(font=2)
      text(-1.28, c(41,35,29,23,17,11,5), cex=0.75, pos=4, names[1:7])
      m=1
      for(i in 7:1){
        addpoly(meta.parametric[[i]], row=m, cex=0.75, mlab=paste("►RE",names[i]),)
        m <- m+6
      }
      text(-1.28, 43, "Path by study",  cex=.8, pos=4)
      text(1.5, 43, "Standardized Betas [95% CI]", cex=.8, pos=2)
    dev.off()

  ### Bootstrapped Meta-Analysis
    var.boot <- var[!var %in% c("Total","Direct")]
    names.boot <- names[!names %in% c("Total Effect","Direct Effect")]
    meta.bootstrapped.sum <- data.frame(effect = var.boot, 
                                        name = names.boot, 
                                        beta.Pittsburgh = NA, 
                                        CI.Pittsburgh = NA,
                                        beta.Christchurch = NA, 
                                        CI.Christchurch = NA,
                                        beta.Utrecht = NA,
                                        CI.Utrecht = NA, 
                                        RE.beta = NA,
                                        RE.CI = NA,
                                        RE.pval = NA,
                                        RE.star = NA)

    for(i in 1:length(var.boot)){
      md <- escalc(data = process[process$Parameter==var.boot[i],],
                   measure = "SPCOR",
                   yi = B,
                   sei = BSE,
                   ni = N,
                   mi = m,
                   var.names = c(paste(var.boot[i],".yi",sep=""),paste(var.boot[i],".vi",sep="")))
      
      meta.bootstrapped[[var.boot[i]]] <- rma(yi = get(paste(var.boot[i],".yi",sep="")),
                                              vi = get(paste(var.boot[i],".vi",sep="")),
                                              data = md,
                                              method = "REML",
                                              slab = Study)
      #metafor::forest(meta.bootstrapped[[var.boot[i]]],
      #                main = paste("Meta Analysis ",names.boot[i],sep = ""))
      meta.bootstrapped.sum$effect[i] <- var.boot[i]
      meta.bootstrapped.sum$beta.Pittsburgh[i] <- meta.bootstrapped[[var.boot[i]]]$yi[1]
      meta.bootstrapped.sum$beta.Christchurch[i] <- meta.bootstrapped[[var.boot[i]]]$yi[2]
      meta.bootstrapped.sum$beta.Utrecht[i] <- meta.bootstrapped[[var.boot[i]]]$yi[3]
      meta.bootstrapped.sum$CI.Pittsburgh[i] <- paste("[",                                  round(meta.bootstrapped[[var.boot[i]]]$yi[1]-1.96*sqrt(meta.bootstrapped$Fail.RadNat$vi[1]),2),", ",round(meta.bootstrapped[[var.boot[i]]]$yi[1]+1.96*sqrt(meta.bootstrapped$Fail.RadNat$vi[1]),2),"]",sep="")
      meta.bootstrapped.sum$CI.Christchurch[i] <- paste("[",                                  round(meta.bootstrapped[[var.boot[i]]]$yi[2]-1.96*sqrt(meta.bootstrapped$Fail.RadNat$vi[2]),2),", ",round(meta.bootstrapped[[var.boot[i]]]$yi[2]+1.96*sqrt(meta.bootstrapped$Fail.RadNat$vi[2]),2),"]",sep="")
      meta.bootstrapped.sum$CI.Utrecht[i] <- paste("[",                                  round(meta.bootstrapped[[var.boot[i]]]$yi[3]-1.96*sqrt(meta.bootstrapped$Fail.RadNat$vi[3]),2),", ",round(meta.bootstrapped[[var.boot[i]]]$yi[3]+1.96*sqrt(meta.bootstrapped$Fail.RadNat$vi[3]),2),"]",sep="")
      meta.bootstrapped.sum$RE.beta[i] <- meta.bootstrapped[[var.boot[i]]]$b
      meta.bootstrapped.sum$RE.CI[i] <- paste("[",
                                              round(meta.bootstrapped[[var.boot[i]]]$ci.lb, 2),
                                              ", ", round(meta.bootstrapped[[var.boot[i]]]$ci.ub,2),"]", sep="")
      meta.bootstrapped.sum$RE.pval[i] <- meta.bootstrapped[[var.boot[i]]]$pval
      meta.bootstrapped.sum$RE.star[i] <- ifelse(meta.bootstrapped.sum$RE.pval[i]<0.001,"***",ifelse(meta.bootstrapped.sum$RE.pval[i]<0.01,"**",ifelse(meta.bootstrapped.sum$RE.pval[i]<0.05,"*","")))
    }
    #meta.bootstrapped
    
    eff.boot <- escalc(data = process[!process$Parameter %in% c("Total","Direct"),], 
                       slab = Parameter,
                       measure = "SPCOR",
                       yi = B,
                       sei = BSE,
                       ni = N,
                       mi = m)
    meta.boot <- rma(yi = yi,
                     vi = vi, 
                     data = eff.boot, 
                     method = "REML", 
                     slab = paste(Parameter, Study, sep=" - "))

    k <- 9*3
    png(file = paste0("Output/figures/forest_bootstrapped_all_", name, ".png"), height = 200 + 40*k^.85)
      metafor::forest(meta.boot, cex=0.75, ylim=c(-1, 56), rows=c(52:50,46:44,40:38,34:32,28:26,22:20,16:14,10:8,4:2),
                      slab = rep(c("Pittsburgh","Christchurch", "Utrecht"),9),
                      mlab="", xlab = "Standardized Beta", main=paste0("Meta Analysis: Forest Plot [Bootstrapped] \n(",name,")"))
      par(font=2)
      text(-1.45, c(53,47,41,35,29,23,17,11,5), cex=0.75, pos=4, names.boot)
      m=1
      names.boot.RE <- c(names.boot[1:6],"indirect 1","indirect 2","indirect 3")
      for(i in 9:1){
        addpoly(meta.bootstrapped[[i]], row=m, cex=0.75, mlab=paste("►RE",names.boot.RE[i]))
        m <- m+6
      }
      text(-1.45, 55, "Path by study",  cex=.8, pos=4)
      text(1.62, 55, "Standardized Betas [95% CI]", cex=.8, pos=2)
    dev.off()
    
    
    # Boot without indirect
    eff.boot.dir <- escalc(data = process[!process$Parameter %in% c("Total","Direct",
                                                                    "Fail.RadNat.Hate",
                                                                    "Fail.Prej.Hate", 
                                                                    "SecondaryIndirect"),], 
                       slab = Parameter,
                       measure = "SPCOR",
                       yi = B,
                       sei = BSE,
                       ni = N,
                       mi = m)
    meta.boot.dir <- rma(yi = yi,
                     vi = vi, 
                     data = eff.boot.dir, 
                     method = "REML", 
                     slab = paste(Parameter, Study, sep=" - "))
    
    k <- 6*3
    png(file = paste0("Output/figures/forest_bootstrapped_direct_", name, ".png"), height = 200 + 40*k^.85)
      metafor::forest(meta.boot.dir, cex=0.75, ylim=c(-1, 38), rows=c(34:32,28:26,22:20,16:14,10:8,4:2),
                      slab = rep(c("Pittsburgh","Christchurch", "Utrecht"),6),
                      mlab="", xlab = "Standardized Beta", main=paste0("Meta Analysis: Forest Plot Direct Paths [Bootstrapped] \n(",name,")"))
      par(font=2)
      text(-1.45, c(35,29,23,17,11,5), cex=0.75, pos=4, names.boot[1:6])
      m=1
      names.boot.RE <- names.boot[1:6]
      for(i in 6:1){
        addpoly(meta.bootstrapped[[i]], row=m, cex=0.75, mlab=paste("►RE",names.boot.RE[i]))
        m <- m+6
      }
      text(-1.45, 37, labels = c("Path by study"),  cex=.8, pos=4)
      text(1.6, 37, "Standardized Betas [95% CI]", cex=.8, pos=2)
    dev.off()
    
    # Indirect Paths
    eff.boot.indir <- escalc(data = process[process$Parameter %in% c("Fail.RadNat.Hate",
                                                                    "Fail.Prej.Hate", 
                                                                    "SecondaryIndirect"),], 
                           slab = Parameter,
                           measure = "SPCOR",
                           yi = B,
                           sei = BSE,
                           ni = N,
                           mi = m)
    meta.boot.indir <- rma(yi = yi,
                         vi = vi, 
                         data = eff.boot.indir, 
                         method = "REML", 
                         slab = paste(Parameter, Study, sep=" - "))

    k <- 3
    png(file = paste0("Output/figures/forest_bootstrapped_indirect_", name, ".png"), height = 200 + 40*k^.85)
      metafor::forest(meta.boot.indir, cex=0.75, ylim=c(-1, 20), rows=c(16:14,10:8,4:2),
                      slab = rep(c("Pittsburgh","Christchurch", "Utrecht"),3),
                      mlab="", xlab = "Standardized Beta", main=paste0("Meta Analysis: Forest Plot Indirect Paths [Bootstrapped] \n(",name,")"))
      par(font=2)
      text(-0.25, c(17,11,5), cex=0.75, pos=4, names.boot[7:9])
      m=1
      names.boot.RE <- c("indirect 1","indirect 2", "secondary indirect")
      for(i in 3:1){
        addpoly(meta.bootstrapped[[i+6]], row=m, cex=0.75, mlab=paste("►RE",names.boot.RE[i]))
        m <- m+6
      }
      text(-0.25, 19, labels = c("Path by study"),  cex=.8, pos=4)
      text(0.18, 19, "Standardized Betas [95% CI]", cex=.8, pos=2)
    dev.off()
    
    list(tbl.parametric = meta.parametric.sum, tbl.bootstrapped = meta.bootstrapped.sum, meta.parametric = meta.parametric, meta.boot = meta.bootstrapped)
}