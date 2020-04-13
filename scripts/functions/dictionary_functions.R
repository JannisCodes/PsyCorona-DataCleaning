count_fun <- function(x) rowSums(x)>0

cat_words <- function(words, dict){
  rexes <- unlist(dict)
  dict_matches <- sapply(rexes, function(this_reg){
    grepl(this_reg, words, perl = TRUE)})
  matches <- matrix(FALSE, nrow = length(words), ncol = length(dict))
  reps <- c(0, sapply(dict, length))
  for(this_word in 1:length(dict)){
    sum_cols <- (sum(reps[1:this_word])+1):sum(reps[1:(this_word+1)])
    matches[, this_word] <- apply(dict_matches[, sum_cols, drop = FALSE], 1, any)
  }
  num_matches <- rowSums(matches)
  has_matches <- !num_matches == 0
  which_matches <- which(has_matches)
  outwords <- words
  outwords[has_matches] <- names(dict)[apply(matches[which_matches, ], 1, function(lv){min(which(lv))})]
  out <- list(
    words = outwords
  )
  multimatch <- num_matches > 1
  if(any(multimatch)){
    warning("Duplicate matches found; see the '$dup' element of the output.", call. = FALSE)
    dups <- unique(words[multimatch])
    out_dups <- lapply(dups, function(x){
      tmp <- which(words == x & multimatch)[1]
      unname(rexes[dict_matches[tmp, ]])
    })
    names(out_dups) <- dups
    out$dup <- out_dups
  }
  if(any(!has_matches)){
    warning("Unmatched words found; see the '$unmatched' element of the output.", call. = FALSE)
    nomatch <- which(!has_matches)
    tab <- table(words[nomatch])
    out$unmatched <- sort(tab, decreasing = TRUE)
  }
  class(out) <- c("word_matches", class(out))
  out
}
