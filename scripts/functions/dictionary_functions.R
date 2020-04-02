country_dict <- list('united, states, of, america' = c('^usa$',  'uni.+stat',  '^america$',  '^u.{0,1}s.{0,1}$',  'esta.+unid',  'colorado',  '^us$',  'xas',  'sates',  'amerika, serikat',  'california',  'corlifornia',  'états-unis',  'york',  'yark',  'puerto, rico',  '^tx$',  '^tn$',  'u, s'),
                     'canada' = c('canad',  'vancouver'),
                     'mexico' = c('mexico',  'méxico'),
                     'spain' = c('spain',  'esp',  'spagna',  'spanien',  'catal',  'euskal, herria',  'basque',  'eapaña',  'esapaña',  'madrid',  'montalbán, de, córdoba',  'pais, vasco',  'spanje'),
                     'france' = c('france',  'francia',  'frankrijk'),
                     'germany' = c('germany',  'deutschland',  'alemania',  'germania',  '^almanya$',  'berlin',  'duitsland'),
                     'portugal' = c('portugal'),
                     'sweden' = c('weden'),
                     'netherlands' = c('netherland',  'nederland',  'niederlande',  'belanda',  '^nl$',  'olanda',  'paesi, bassi',  'paesi bassi',  'bajos',  'gelderland',  'hollanda'),
                     'indonesia' = c('^indonesia$',  'indonesian',  'kota, tarakan',  'imdonesia',  'indònesia',  'jakarta'),
                     'italy' = c('ital',  'sardegna',  'bisceglie',  'ladispoli',  'castelforte',  'milano',  '^roma$', 'dorgali',  'bari',  'bologna',  'brescia',  'cala, gonone',  'chieti',  'ferentino',  'frosinone',  'gragnano, lucca, ',  'guidonia',  'itaia',  'italya',  'mareno, di, piave',  'modena',  'pellizzano',  'predazzo',  'refrontolo',  'cosma, e, damiano',  'scalea',  'scauri',  'segni',  'settimo, vittone',  'susegana',  'terralba',  'trento',  'treviso',  'tezze, di, piave',  'valmontone',  'vergato',  'veneto',  'gragnano, lucca'),
                     'hong, kong, s.a.r.' = c('hong.{0,}kong'),
                     'philippines' = c('phil',  'filipinas'),
                     'argentina' = c('argentina',  'arge'),
                     'pakistan' = c('pakistan',  'abbottabad',  'peshawar'),
                     'united, kingdom' = c('uni.+king',  '^uk$',  'reino, unido',  'britain',  'regno, unito',  'u\\.k\\.',  'بريطانيا',  'the, uk',  'u, k',  'verenigd, koninkrijk',  'windsor',  'scotland',  'england',  'wales',  'ingiltere',  'northern, ireland',  'egland',  '^gb$',  'n, ireland',  'schotland',  'scozia'),
                     'south, africa' = c('africa',  '^sa$',  'sudáfrica',  'western, cape'),
                     'chile' = c('^chile$'),
                     'australia' = c('australia',  'austrija'),
                     'colombia' = c('colombia'),
                     'turkey' = c('turkey',  't[üu]rk[ie]y'),
                     'taiwan' = c('taiwan'),
                     'venezuela' = c('^venezuela$'),
                     'israel' = c('israel',  'اللد',  'اسرائيل',  'كفر, قاسم',  'isreal',  'רמלה'),
                     'greece' = c('greece',  'grecia'),
                     'austria' = c('austria',  'sterreich'),
                     'new, zealand' = c('new.+zeal',  'neuseeland'),
                     'tunisia' = c('tuni',  'تونس'),
                     'belgium' = c('belg',  'bélgica'),
                     'china' = c('^china'),
                     'cyprus' = c('cyp'),
                     'switzerland' = c('schweiz',  'suiza',  'svizzera',  'zwitserland',  'switzerland'),
                     'united, arab, emirates' = c('united, arab, emirates',  'uae'),
                     'croatia' = c('croa', "hrvatsk"),
                     'india' = c('india'),
                     'algeria' = c('algeri',  'الجزائر',  'algérie'),
                     'bulgaria' = c('bulgaria'),
                     'poland' = c('poland',  'polonia'),
                     'romania' = c('romania'),
                     'singapore' = c('singapore'),
                     'republic, of, serbia' = c('srbija',  'serbia',  'србија'),
                     'czech, republic' = c('czech',  'checa'),
                     'luxembourg' = c('lux'),
                     'slovakia' = c('slova'),
                     'brazil' = c('brazil',  'brasil'),
                     'ireland' = c('^ireland$',  'irlanda'),
                     'japan' = c('japan',  'giappone',  'japonya'),
                     'malaysia' = c('malay'),
                     'nigeria' = c('nigeria'),
                     'saudi, arabia' = c('riyad',  'saud.+arab',  'arabia, saudita',  '^saudi$',  'kingdom, of, saudia, arabia',  'ksa',  'k\\.s\\.a',  'arabie, saoudite',  'الرياض',  'السعودية',  'السعوديه'),
                     'thailand' = c('^thailand$'),
                     'uruguay' = c('urug'),
                     'costa, rica' = c('costa'),
                     'ecuador' = c('ecuador'),
                     'finland' = c('finland'),
                     'guatemala' = c('guat'),
                     'iceland' = c('iceland'),
                     'iraq' = c('iraq',  'العراق'),
                     'iran' = c('iran'),
                     'lebanon' = c('lebanon',  'liban'),
                     'norway' = c('norway'),
                     'palestine' = c('palestine',  'فلسطين, ',  '^فلسطين$',  'الرملة'),
                     'peru' = c('peru'),
                     'dominican, republic' = c('domin'),
                     'albania' = c('albania'),
                     'andorra' = c('andorra'),
                     'bahrain' = c('bahrain'),
                     'bangladesh' = c('bangladesh'),
                     'botswana' = c('botswana'),
                     'cameroon' = c('camer'),
                     'morocco' = c('المغرب',  'maroc'),
                     'jordan' = c('jordan'),
                     'libya' = c('ليبيا'),
                     'egypt' = c('مصر'),
                     'denmark' = c('mark'),
                     'el, salvador' = c('salvador'),
                     'estonia' = c('estonia'),
                     'south, korea' = c('korea',  'güney, kore'),
                     'hungary' = c('hungary'),
                     'mauritius' = c('maurice'),
                     'jamaica' = c('jamaica'),
                     'kenya' = c('kenia'),
                     'laos' = c('laos'),
                     'latvia' = c('latvia'),
                     'malta' = c('malta'),
                     'myanmar' = c('myanmar'),
                     'nepal' = c('nepal'),
                     'oman' = c('^oman$'),
                     'qatar' = c('qatar'),
                     'panama' = c('panam'),
                     'united, republic, of, tanzania' = c('tanzania'),
                     'vietnam' = c('vietnam'),
                     "Trinidad and Tobago" = c("trinid")
)


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
