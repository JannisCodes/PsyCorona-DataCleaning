country_dict <- list('United States of America' = c('^usa$',  'uni.+stat',  '^america$',  '^u.{0,1}s.{0,1}$',  'esta.+unid',  'colorado',  '^us$',  'xas',  'sates',  'amerika, serikat',  'california',  'corlifornia',  'états-unis',  'york',  'yark',  'puerto, rico',  '^tx$',  '^tn$',  'u, s'),
                     'Canada' = c('canad',  'vancouver'),
                     'Mexico' = c('mexico',  'méxico'),
                     'Spain' = c('spain',  'esp',  'spagna',  'spanien',  'catal',  'euskal, herria',  'basque',  'eapaña',  'esapaña',  'madrid',  'montalbán, de, córdoba',  'pais, vasco',  'spanje'),
                     'France' = c('france',  'francia',  'frankrijk'),
                     'Germany' = c('germany',  'deutschland',  'alemania',  'germania',  '^almanya$',  'berlin',  'duitsland'),
                     'Portugal' = c('portugal'),
                     'Sweden' = c('weden'),
                     'Netherlands' = c('netherland',  'nederland',  'niederlande',  'belanda',  '^nl$',  'olanda',  'paesi, bassi',  'paesi bassi',  'bajos',  'gelderland',  'hollanda'),
                     'Indonesia' = c('^indonesia$',  'indonesian',  'kota, tarakan',  'imdonesia',  'indònesia',  'jakarta'),
                     'Italy' = c('ital',  'sardegna',  'bisceglie',  'ladispoli',  'castelforte',  'milano',  '^roma$', 'dorgali',  'bari',  'bologna',  'brescia',  'cala, gonone',  'chieti',  'ferentino',  'frosinone',  'gragnano, lucca, ',  'guidonia',  'itaia',  'italya',  'mareno, di, piave',  'modena',  'pellizzano',  'predazzo',  'refrontolo',  'cosma, e, damiano',  'scalea',  'scauri',  'segni',  'settimo, vittone',  'susegana',  'terralba',  'trento',  'treviso',  'tezze, di, piave',  'valmontone',  'vergato',  'veneto',  'gragnano, lucca'),
                     'Hong Kong S.A.R.' = c('hong.{0,}kong'),
                     'Philippines' = c('phil',  'filipinas'),
                     'Argentina' = c('argentina',  'arge'),
                     'Pakistan' = c('pakistan',  'abbottabad',  'peshawar'),
                     'United Kingdom' = c('uni.+king',  '^uk$',  'reino, unido',  'britain',  'regno, unito',  'u\\.k\\.',  'بريطانيا',  'the, uk',  'u, k',  'verenigd, koninkrijk',  'windsor',  'scotland',  'england',  'wales',  'ingiltere',  'northern, ireland',  'egland',  '^gb$',  'n, ireland',  'schotland',  'scozia'),
                     'South Africa' = c('africa',  '^sa$',  'sudáfrica',  'western, cape'),
                     'Chile' = c('^chile$'),
                     'Australia' = c('australia',  'austrija'),
                     'Colombia' = c('colombia'),
                     'Turkey' = c('turkey',  't[üu]rk[ie]y'),
                     'Taiwan' = c('taiwan'),
                     'Venezuela' = c('^venezuela$'),
                     'Israel' = c('israel',  'اللد',  'اسرائيل',  'كفر, قاسم',  'isreal',  'רמלה'),
                     'Greece' = c('greece',  'grecia'),
                     'Austria' = c('austria',  'sterreich'),
                     'New Zealand' = c('new.+zeal',  'neuseeland'),
                     'Tunisia' = c('tuni',  'تونس'),
                     'Belgium' = c('belg',  'bélgica'),
                     'China' = c('^china'),
                     'Cyprus' = c('cyp'),
                     'Switzerland' = c('schweiz',  'suiza',  'svizzera',  'zwitserland',  'switzerland'),
                     'United Arab Emirates' = c('united, arab, emirates',  'uae'),
                     'Croatia' = c('croa', "hrvatsk"),
                     'India' = c('india'),
                     'Algeria' = c('algeri',  'الجزائر',  'algérie', 'الجزاءر'),
                     'Bulgaria' = c('bulgaria'),
                     'Poland' = c('poland',  'polonia'),
                     'Romania' = c('romania'),
                     'Singapore' = c('singapore'),
                     'Republic of Serbia' = c('srbija',  'serbia',  'србија'),
                     'Czech Republic' = c('czech',  'checa'),
                     'Luxembourg' = c('lux'),
                     'Slovakia' = c('slova'),
                     'Brazil' = c('brazil',  'brasil'),
                     'Ireland' = c('^ireland$',  'irlanda'),
                     'Japan' = c('japan',  'giappone',  'japonya'),
                     'Malaysia' = c('malay'),
                     'Nigeria' = c('nigeria'),
                     'Saudi Arabia' = c('riyad',  'saud.+arab',  'arabia, saudita',  '^saudi$',  'kingdom, of, saudia, arabia',  'ksa',  'k\\.s\\.a',  'arabie, saoudite',  'الرياض',  'السعودية',  'السعوديه'),
                     'Thailand' = c('^thailand$'),
                     'Uruguay' = c('urug'),
                     'Costa Rica' = c('costa'),
                     'Ecuador' = c('ecuador'),
                     'Finland' = c('finland'),
                     'Guatemala' = c('guat'),
                     'Iceland' = c('iceland'),
                     'Iraq' = c('iraq',  'العراق'),
                     'Iran' = c('iran'),
                     'Lebanon' = c('lebanon',  'liban'),
                     'Norway' = c('norway'),
                     'Palestine' = c('palestine',  'فلسطين, ',  '^فلسطين$',  'الرملة'),
                     'Peru' = c('peru'),
                     'Dominican Republic' = c('domin'),
                     'Albania' = c('albania'),
                     'Andorra' = c('andorra'),
                     'Bahrain' = c('bahrain'),
                     'Bangladesh' = c('bangladesh'),
                     'Botswana' = c('botswana'),
                     'Cameroon' = c('camer'),
                     'Morocco' = c('المغرب',  'maroc'),
                     'Jordan' = c('jordan'),
                     'Libya' = c('ليبيا'),
                     'Egypt' = c('مصر'),
                     'Denmark' = c('mark'),
                     'El Salvador' = c('salvador'),
                     'Estonia' = c('estonia'),
                     'South Korea' = c('korea',  'güney, kore'),
                     'Hungary' = c('hungary'),
                     'Mauritius' = c('maurice'),
                     'Jamaica' = c('jamaica'),
                     'Kenya' = c('kenia'),
                     'Laos' = c('laos'),
                     'Latvia' = c('latvia'),
                     'Malta' = c('malta'),
                     'Myanmar' = c('myanmar'),
                     'Nepal' = c('nepal'),
                     'Oman' = c('^oman$'),
                     'Qatar' = c('qatar'),
                     'Panama' = c('panam'),
                     'United Republic of Tanzania' = c('tanzania'),
                     'Vietnam' = c('vietnam'),
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
