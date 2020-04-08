# R Studio Clean-Up
  cat("\014") # clear console
  rm(list=ls()) # clear workspace
  gc() # garbage collector

# Reset working directory to folder current file is saved in
  setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

# load data
  load('countries 2020-04-06 18-30 CEST.RData')
  # To be coded country free text entries are in the country_entry element
  # Country names that we need as output are in country_nemas element
  
# Approach 1:
  source("dictionary_functions.R")
  # sourcing seems to destroy everything
  country_dict <- list('Albania' = c('albania'),
                       'Algeria' = c('algeri','الجزائر','algérie','الجزاءر'),
                       'Andorra' = c('andorra'),
                       'Argentina' = c('argentina',  'arge'),
                       'Australia' = c('australia',  'austrija'),
                       'Austria' = c('austria',  'sterreich'),
                       'Azerbaijan' = c('azerba'),
                       'Bahrain' = c('bahrain'),
                       'Bangladesh' = c('bangladesh'),
                       'Belgium' = c('belg',  'bélgica', 'бельгия'),
                       'Bosnia and Herzegovina' = c('bosnaihercegovina'),
                       'Botswana' = c('botswana'),
                       'Brazil' = c('brazil',  'brasil'),
                       'Bulgaria' = c('bulgaria', 'българия'),
                       'Cameroon' = c('camer'),
                       'Canada' = c('canad',  'vancouver', 'канада'),
                       'Chile' = c('^chile$'),
                       'China' = c('^china', '中国', '中华人民共和国'),
                       'Colombia' = c('colombia'),
                       'Costa Rica' = c('costa'), 
                       'Croatia' = c('croa', "hrvatsk"),
                       'Cyprus' = c('cyp', '^κ...ο.', '^κ...ο'), 
                       'Czech Republic' = c('czech',  'checa'),
                       'Denmark' = c('mark'),
                       'Dominican Republic' = c('domin'),
                       'Ecuador' = c('ecuador'),
                       'Egypt' = c('مصر'),
                       'El Salvador' = c('salvador'),
                       'Estonia' = c('estonia'),
                       'Finland' = c('finland'),
                       'France' = c('france',  'francia',  'frankrijk'),
                       'Germany' = c('germany',  'deutschland',  'alemania',  'germania',  '^almanya$', 'allemagne',  'berlin',  'duitsland', 'γ.ρ.....'),
                       'Greece' = c('greece',  'grecia', 	'.λλ...', '.λλ..'),
                       'Guatemala' = c('guat'),
                       'Hong Kong S.A.R.' = c('hong.{0,}kong', '香港'),
                       'Hungary' = c('hungary', '^magyarorsz', 'magyar', 'ungarn'),
                       'Iceland' = c('iceland'),
                       'India' = c('india'),
                       'Indonesia' = c('^indonesia$',  'indonesian',  'kota, tarakan',  'imdonesia',  'indònesia',  'jakarta'),
                       'Iran' = c('iran'),
                       'Iraq' = c('iraq',  'العراق'),
                       'Ireland' = c('^ireland$',  'irlanda', 'ιρλ.....'),
                       'Israel' = c('القدس', 'israel', 'اللد',  'اسرائيل',  'كفر, قاسم',  'isreal',  'רמלה', 'الرمله'), 
                       'Italy' = c('ital',  'sardegna',  'bisceglie',  'ladispoli',  'castelforte',  'milano',  '^roma$', 'dorgali',  'bari',  'bologna',  'brescia',  'cala, gonone',  'chieti',  'ferentino',  'frosinone',  'gragnano, lucca, ',  'guidonia',  'itaia',  'italya',  'mareno, di, piave',  'modena',  'pellizzano',  'predazzo',  'refrontolo',  'cosma, e, damiano',  'scalea',  'scauri',  'segni',  'settimo, vittone',  'susegana',  'terralba',  'trento',  'treviso',  'tezze, di, piave',  'valmontone',  'vergato',  'veneto',  'gragnano, lucca'),
                       'Jamaica' = c('jamaica'),
                       'Japan' = c('japan',  'giappone',  'japonya', '日本'),
                       'Jordan' = c('jordan', 'الأردن'),
                       'Kazakhstan' = c('казахстан', 'kazakhstan'),
                       'Kenya' = c('kenia'),
                       'Laos' = c('laos'),
                       'Latvia' = c('latvia'),
                       'Lebanon' = c('lebanon',  'liban'),
                       'Libya' = c('ليبيا'),
                       'Luxembourg' = c('lux'),
                       'Malaysia' = c('malay'),
                       'Malta' = c('malta'),
                       'Mauritius' = c('maurice'),
                       'Mexico' = c('mexico',  'méxico'),
                       'Montenegro' = c('crnagora'),
                       'Morocco' = c('المغرب',  'maroc'),
                       'Myanmar' = c('myanmar'),
                       'Nepal' = c('nepal'),
                       'Netherlands' = c('netherland',  'nederland',  'niederlande',  'belanda',  '^nl$',  'olanda',  'paesi, bassi',  'paesi bassi',  'bajos',  'gelderland',  'hollanda', 'paes.+bass.'),
                       'New Zealand' = c('new.+zeal', 'newzealand',  'neuseeland'),
                       'Nigeria' = c('nigeria'),
                       'Norway' = c('norway'),
                       'Oman' = c('^oman$'),
                       'Pakistan' = c('pakistan',  'abbottabad',  'peshawar'),
                       'Palestine' = c('palestine',  'فلسطين, ',  '^فلسطين$',  'الرملة'),
                       'Panama' = c('panam'), 
                       'Peru' = c('peru', 'perú'),
                       'Philippines' = c('phil',  'filipinas'),
                       'Poland' = c('poland',  'polonia', 'польша'),
                       'Portugal' = c('portugal'), 
                       'Qatar' = c('qatar'),
                       'Republic of Serbia' = c('srbija',  'serbia',  'србија'),
                       'Romania' = c('romania', 'rom.nia'),
                       'Russia' = c('россия'),
                       'Saudi Arabia' = c('riyad',  'saud.+arab',  'arabia, saudita',  '^saudi$',  'kingdom, of, saudia, arabia',  'ksa',  'k\\.s\\.a',  'arabie, saoudite',  'الرياض',  'السعودية',  'السعوديه', 'emira+arab'),
                       'Republic of Serbia' = c('srbiji', 's.erbia'),
                       'Singapore' = c('singapore'),
                       'Slovakia' = c('slova'),
                       'South Africa' = c('africa',  '^sa$',  'sudáfrica',  'western, cape', 'southaf...'),
                       'South Korea' = c('korea',  'güney, kore'),
                       'Spain' = c('spain',  'esp',  'spagna',  'spanien',  'catal',  'euskal, herria',  'basque',  'eapaña',  'esapaña',  'madrid',  'montalbán, de, córdoba',  'pais, vasco',  'spanje'),
                       'Sweden' = c('weden'),
                       'Switzerland' = c('schweiz',  'suiza',  'svizzera',  'zwitserland',  'switzerland', 'suisse'),
                       'Taiwan' = c('taiwan', '台灣'),
                       'Thailand' = c('^thailand$'),
                       "Trinidad and Tobago" = c("trinid"),
                       'Tunisia' = c('tuni',  'تونس'),
                       'Turkey' = c('turkey',  't.rk.y.', 't.rk.{0,2}', "t[a-z]rkiye"), #"'\u00fcrkiye'"
                       'Ukraine' = c('ukraine', 'у.ра..а'),
                       'United Arab Emirates' = c('الخرج',  'united, arab, emirates', 'الامارات', '^uae$', 'arabemirates', 'لعربيةالمتحدة'),
                       'United Kingdom' = c('uni.+kin',  '^uk$',  'reino, unido',  'britain',  'regno, unito',  'u\\.k\\.',  'بريطانيا',  'the, uk',  'u, k',  'verenigd, koninkrijk',  'windsor',  'scotland',  'england',  'wales',  'ingiltere',  'northern, ireland',  'egland',  '^gb$',  'n, ireland',  'schotland',  'scozia', '英国', 'ngiltere', 'n.{4,9}ireland', 'reinounido'),
                       'United Republic of Tanzania' = c('tanzania'),
                       'United States of America' = c('america', '^usa', 'u.s.a',  'uni.+stat', 'uni.+merica',  '^america$',  '^u.{0,1}s.{0,1}$',  'esta.+unid',  'colorado',  '^us$',  'xas',  'sates',  'amerika, serikat',  'california',  'corlifornia',  'états-unis', 'puerto, rico',  '^tx$',  '^tn$',  'u, s', '美国', 'new+york', 'сша', 'un..edsta.es', 'arizona'), 
                       'Uruguay' = c('urug'),
                       'Uzbekistan' = c('u.{2,5}istan'),
                       'Venezuela' = c('^venezuela$'),
                       'Vietnam' = c('vietnam')
  )
  
  
  country_matches <- cat_words(dt5newVars$country, country_dict) 
  country_matches$words[country_matches$words %in% names(country_matches$unmatched)] <- NA
  # Check unmatched strings, fix common ones
  View(country_matches$unmatched)
  # Check duplicates, and which regular expressions triggered them
 View(country_matches$dup)
