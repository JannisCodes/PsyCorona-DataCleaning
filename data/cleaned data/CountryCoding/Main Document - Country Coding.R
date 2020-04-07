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
  country_matches01 <- cat_words(tolower(country_entry), country_dict)
  # includes machted (country_matches01$words), unmatched (country_matches01$unmatched) and duplicates (country_matches01$dup)

# Approach 2:
  country_matches02 <- case_when(grepl('^usa$', country_entry, ignore.case = T) | grepl('unites state', country_entry, ignore.case = T) | 
                                  grepl('united state', country_entry, ignore.case = T) | grepl('^america$', country_entry, ignore.case = T) |
                                  grepl('U\\.S\\.', country_entry, ignore.case = T) | grepl('Estados Unidos', country_entry, ignore.case = T) |
                                  grepl('colorado', country_entry, ignore.case = T) | grepl('^us$', country_entry, ignore.case = T) |
                                  grepl('xas', country_entry, ignore.case = T) | grepl('sates', country_entry, ignore.case = T) |
                                  grepl('Amerika Serikat', country_entry, ignore.case = T) | grepl('california', country_entry, ignore.case = T) |
                                  grepl('corlifornia', country_entry, ignore.case = T) | grepl('états-unis', country_entry, ignore.case = T) |
                                  grepl('york', country_entry, ignore.case = T) | grepl('yark', country_entry, ignore.case = T) |
                                  grepl('puerto rico', country_entry, ignore.case = T) | grepl('^tx$', country_entry, ignore.case = T) |
                                  grepl('^tn$', country_entry, ignore.case = T) | grepl('U S', country_entry, ignore.case = T) ~ 'United States of America',
                                grepl('canad', country_entry, ignore.case = T) | grepl('vancouver', country_entry, ignore.case = T) ~ 'Canada',
                                grepl('mexico', country_entry, ignore.case = T) | grepl('México', country_entry, ignore.case = T) ~ 'Mexico',
                                grepl('spain', country_entry, ignore.case = T) | grepl('esp', country_entry, ignore.case = T) |
                                  grepl('Spagna', country_entry, ignore.case = T) | grepl('Spanien', country_entry, ignore.case = T) |
                                  grepl('Catal', country_entry, ignore.case = T) | grepl('Euskal Herria', country_entry, ignore.case = T) |
                                  grepl('basque', country_entry, ignore.case = T) | grepl('Eapaña', country_entry, ignore.case = T) |
                                  grepl('Esapaña', country_entry, ignore.case = T) | grepl('madrid', country_entry, ignore.case = T) |
                                  grepl('Montalbán de Córdoba', country_entry, ignore.case = T) | grepl('Pais vasco', country_entry, ignore.case = T) |
                                  grepl('Spanje', country_entry, ignore.case = T) ~ 'Spain',
                                grepl('france', country_entry, ignore.case = T) | grepl('Francia', country_entry, ignore.case = T) |
                                  grepl('Frankrijk', country_entry, ignore.case = T) ~ 'France',
                                grepl('germany', country_entry, ignore.case = T) | grepl('deutschland', country_entry, ignore.case = T) | 
                                  grepl('Alemania', country_entry, ignore.case = T) | grepl('germania', country_entry, ignore.case = T) |
                                  grepl('^Almanya$', country_entry, ignore.case = T) | grepl('berlin', country_entry, ignore.case = T) |
                                  grepl('Duitsland', country_entry, ignore.case = T) ~ 'Germany',
                                grepl('portugal', country_entry, ignore.case = T) ~ 'Portugal',
                                grepl('weden', country_entry, ignore.case = T) ~ 'Sweden',
                                grepl('netherland', country_entry, ignore.case = T) | grepl('nederland', country_entry, ignore.case = T) | 
                                  grepl('Niederlande', country_entry, ignore.case = T) | grepl('Belanda', country_entry, ignore.case = T) |
                                  grepl('^NL$', country_entry, ignore.case = T) | grepl('Olanda', country_entry, ignore.case = T) |
                                  grepl('Paesi Bassi', country_entry, ignore.case = T) | grepl('bajos', country_entry, ignore.case = T) |
                                  grepl('Gelderland', country_entry, ignore.case = T) | grepl('Hollanda', country_entry, ignore.case = T) ~ 'Netherlands',
                                grepl('^indonesia$', country_entry, ignore.case = T) | grepl('indonesian', country_entry, ignore.case = T) | 
                                  grepl('kota Tarakan', country_entry, ignore.case = T) | grepl('Imdonesia', country_entry, ignore.case = T) |
                                  grepl('Indònesia', country_entry, ignore.case = T) | grepl('jakarta', country_entry, ignore.case = T) ~ 'Indonesia',
                                grepl('ital', country_entry, ignore.case = T) | grepl('Sardegna', country_entry, ignore.case = T) | 
                                  grepl('Bisceglie', country_entry, ignore.case = T) | grepl('Ladispoli', country_entry, ignore.case = T) |
                                  grepl('Castelforte', country_entry, ignore.case = T) | grepl('milano', country_entry, ignore.case = T) |
                                  (grepl('roma', country_entry, ignore.case = T) & !grepl('romania', country_entry, ignore.case = T)) |
                                  grepl('Dorgali', country_entry, ignore.case = T) | grepl('bari', country_entry, ignore.case = T) |
                                  grepl('bologna', country_entry, ignore.case = T) | grepl('Brescia', country_entry, ignore.case = T) |
                                  grepl('Cala gonone', country_entry, ignore.case = T) | grepl('Chieti', country_entry, ignore.case = T) |
                                  grepl('Ferentino', country_entry, ignore.case = T) | grepl('Frosinone', country_entry, ignore.case = T) |
                                  grepl('Gragnano lucca	', country_entry, ignore.case = T) | grepl('Guidonia', country_entry, ignore.case = T) |
                                  grepl('Itaia', country_entry, ignore.case = T) | grepl('İtalya', country_entry, ignore.case = T) |
                                  grepl('Mareno di Piave', country_entry, ignore.case = T) | grepl('modena', country_entry, ignore.case = T) |
                                  grepl('Pellizzano', country_entry, ignore.case = T) | grepl('Predazzo', country_entry, ignore.case = T) |
                                  grepl('Refrontolo', country_entry, ignore.case = T) | grepl('Cosma e Damiano', country_entry, ignore.case = T) |
                                  grepl('Scalea', country_entry, ignore.case = T) | grepl('Scauri', country_entry, ignore.case = T) |
                                  grepl('Segni', country_entry, ignore.case = T) | grepl('SETTIMO VITTONE', country_entry, ignore.case = T) |
                                  grepl('Susegana', country_entry, ignore.case = T) | grepl('Terralba', country_entry, ignore.case = T) |
                                  grepl('trento', country_entry, ignore.case = T) | grepl('treviso', country_entry, ignore.case = T) |
                                  grepl('Tezze di Piave', country_entry, ignore.case = T) | grepl('Valmontone', country_entry, ignore.case = T) |
                                  grepl('Vergato', country_entry, ignore.case = T) | grepl('veneto', country_entry, ignore.case = T) |
                                  grepl('Gragnano lucca', country_entry, ignore.case = T) ~ 'Italy',
                                grepl('hong kong', country_entry, ignore.case = T) ~ 'Hong Kong S.A.R.',
                                grepl('phil', country_entry, ignore.case = T) | grepl('Filipinas', country_entry, ignore.case = T) ~ 'Philippines',
                                grepl('argentina', country_entry, ignore.case = T) | grepl('arge', country_entry, ignore.case = T) ~ 'Argentina',
                                grepl('pakistan', country_entry, ignore.case = T) | grepl('Abbottabad', country_entry, ignore.case = T) |
                                  grepl('Peshawar', country_entry, ignore.case = T) ~ 'Pakistan',
                                grepl('united kingdo', country_entry, ignore.case = T) | grepl('^uk$', country_entry, ignore.case = T) |
                                  grepl('Reino Unido', country_entry, ignore.case = T) | grepl('britain', country_entry, ignore.case = T) |
                                  grepl('Regno Unito', country_entry, ignore.case = T) | grepl('u\\.k\\.', country_entry, ignore.case = T) |
                                  grepl('بريطانيا', country_entry, ignore.case = T) | grepl('the uk', country_entry, ignore.case = T) |
                                  grepl('U K', country_entry, ignore.case = T) | grepl('Verenigd Koninkrijk', country_entry, ignore.case = T) |
                                  grepl('Windsor', country_entry, ignore.case = T) | grepl('scotland', country_entry, ignore.case = T) |
                                  grepl('england', country_entry, ignore.case = T) | grepl('wales', country_entry, ignore.case = T) |
                                  grepl('İngiltere', country_entry, ignore.case = T) | grepl('Northern Ireland', country_entry, ignore.case = T) |
                                  grepl('Egland', country_entry, ignore.case = T) | grepl('^gb$', country_entry, ignore.case = T) |
                                  grepl('N Ireland', country_entry, ignore.case = T) | grepl('Schotland', country_entry, ignore.case = T) |
                                  grepl('Scozia', country_entry, ignore.case = T) ~ 'United Kingdom',
                                grepl('africa', country_entry, ignore.case = T) | grepl('^SA$', country_entry, ignore.case = T) |
                                  grepl('Sudáfrica', country_entry, ignore.case = T) | grepl('western cape', country_entry, ignore.case = T) ~ 'South Africa',
                                grepl('^chile$', country_entry, ignore.case = T) ~ 'Chile',
                                grepl('australia', country_entry, ignore.case = T) | grepl('Austrija', country_entry, ignore.case = T) ~ 'Australia',
                                grepl('colombia', country_entry, ignore.case = T) ~ 'Colombia',
                                grepl('turkey', country_entry, ignore.case = T) | grepl('tür', country_entry, ignore.case = T) ~ 'Turkey',
                                grepl('taiwan', country_entry, ignore.case = T) ~ 'Taiwan',
                                grepl('^Venezuela$', country_entry, ignore.case = T) ~ 'Venezuela',
                                grepl('israel', country_entry, ignore.case = T) | grepl('اللد', country_entry, ignore.case = T) |
                                  grepl('اسرائيل', country_entry, ignore.case = T) | grepl('كفر قاسم', country_entry, ignore.case = T) |
                                  grepl('Isreal', country_entry, ignore.case = T) | grepl('רמלה', country_entry, ignore.case = T) ~ 'Israel',
                                grepl('greece', country_entry, ignore.case = T) | grepl('Grecia', country_entry, ignore.case = T) ~ 'Greece',
                                grepl('austria', country_entry, ignore.case = T) | grepl('sterreich', country_entry, ignore.case = T) ~ 'Austria',
                                grepl('new zealand', country_entry, ignore.case = T) | grepl('Neuseeland', country_entry, ignore.case = T) ~ 'New Zealand',
                                grepl('Tuni', country_entry, ignore.case = T) | grepl('تونس', country_entry, ignore.case = T) ~ 'Tunisia',
                                grepl('Belg', country_entry, ignore.case = T) | grepl('Bélgica', country_entry, ignore.case = T) ~ 'Belgium',
                                grepl('China', country_entry, ignore.case = T) ~ 'China',
                                grepl('cyp', country_entry, ignore.case = T) ~ 'Cyprus',
                                grepl('Schweiz', country_entry, ignore.case = T) | grepl('Suiza', country_entry, ignore.case = T) |
                                  grepl('Svizzera', country_entry, ignore.case = T) | grepl('Zwitserland', country_entry, ignore.case = T) |
                                  grepl('switzerland', country_entry, ignore.case = T) ~ 'Switzerland',
                                grepl('United Arab Emirates', country_entry, ignore.case = T) | grepl('uae', country_entry, ignore.case = T) ~ 'United Arab Emirates',
                                grepl('Croa', country_entry, ignore.case = T) ~ 'Croatia',
                                grepl('india', country_entry, ignore.case = T) ~ 'India',
                                grepl('algeri', country_entry, ignore.case = T) | grepl('الجزائر', country_entry, ignore.case = T) |
                                  grepl('Algérie', country_entry, ignore.case = T) ~ 'Algeria',
                                grepl('bulgaria', country_entry, ignore.case = T) ~ 'Bulgaria',
                                grepl('Poland', country_entry, ignore.case = T) | grepl('POLONIA', country_entry, ignore.case = T) ~ 'Poland',
                                grepl('romania', country_entry, ignore.case = T) ~ 'Romania',
                                grepl('singapore', country_entry, ignore.case = T) ~ 'Singapore',
                                grepl('Srbija', country_entry, ignore.case = T) | grepl('serbia', country_entry, ignore.case = T) |
                                  grepl('Србија', country_entry, ignore.case = T) ~ 'Republic of Serbia',
                                grepl('czech', country_entry, ignore.case = T) | grepl('checa', country_entry, ignore.case = T) ~ 'Czech Republic',
                                grepl('lux', country_entry, ignore.case = T) ~ 'Luxembourg',
                                grepl('slova', country_entry, ignore.case = T) ~ 'Slovakia',
                                grepl('brazil', country_entry, ignore.case = T) | grepl('brasil', country_entry, ignore.case = T)~ 'Brazil',
                                grepl('^ireland$', country_entry, ignore.case = T) | grepl('Irlanda', country_entry, ignore.case = T) ~ 'Ireland',
                                grepl('japan', country_entry, ignore.case = T) | grepl('Giappone', country_entry, ignore.case = T) |
                                  grepl('Japonya', country_entry, ignore.case = T) ~ 'Japan',
                                grepl('Malay', country_entry, ignore.case = T) ~ 'Malaysia',
                                grepl('nigeria', country_entry, ignore.case = T) ~ 'Nigeria',
                                grepl('Riyad', country_entry, ignore.case = T) | grepl('^Saudi arabia$', country_entry, ignore.case = T) |
                                  grepl('Arabia Saudita', country_entry, ignore.case = T) | grepl('^saudi$', country_entry, ignore.case = T) |
                                  grepl('Kingdom of Saudia arabia', country_entry, ignore.case = T) | grepl('KSA', country_entry, ignore.case = T) |
                                  grepl('k\\.s\\.a', country_entry, ignore.case = T) | grepl('Arabie saoudite', country_entry, ignore.case = T) | 
                                  grepl('الرياض', country_entry, ignore.case = T) | grepl('السعودية', country_entry, ignore.case = T) |
                                  grepl('السعوديه', country_entry, ignore.case = T) ~ 'Saudi Arabia',
                                grepl('^thailand$', country_entry, ignore.case = T) ~ 'Thailand',
                                grepl('urug', country_entry, ignore.case = T) ~ 'Uruguay',
                                grepl('costa', country_entry, ignore.case = T) ~ 'Costa Rica', 
                                grepl('ecuador', country_entry, ignore.case = T) ~ 'Ecuador',
                                grepl('finland', country_entry, ignore.case = T) ~ 'Finland', 
                                grepl('guat', country_entry, ignore.case = T) ~ 'Guatemala',
                                grepl('iceland', country_entry, ignore.case = T) ~ 'Iceland',
                                grepl('iraq', country_entry, ignore.case = T) | grepl('العراق', country_entry, ignore.case = T) ~ 'Iraq',
                                grepl('iran', country_entry, ignore.case = T) ~ 'Iran',
                                grepl('lebanon', country_entry, ignore.case = T) | grepl('liban', country_entry, ignore.case = T) ~ 'Lebanon',
                                grepl('norway', country_entry, ignore.case = T) ~ 'Norway',
                                grepl('palestine', country_entry, ignore.case = T) | grepl('فلسطين	', country_entry, ignore.case = T) |
                                  grepl('^فلسطين$', country_entry, ignore.case = T) | grepl('الرملة', country_entry, ignore.case = T) ~ 'Palestine',
                                grepl('peru', country_entry, ignore.case = T) ~ 'Peru',
                                grepl('domin', country_entry, ignore.case = T) ~ 'Dominican Republic',
                                grepl('albania', country_entry, ignore.case = T) ~ 'Albania',
                                grepl('andorra', country_entry, ignore.case = T) ~ 'Andorra',
                                grepl('bahrain', country_entry, ignore.case = T) ~ 'Bahrain',
                                grepl('bangladesh', country_entry, ignore.case = T) ~ 'Bangladesh',
                                grepl('botswana', country_entry, ignore.case = T) ~ 'Botswana',
                                grepl('camer', country_entry, ignore.case = T) ~ 'Cameroon',
                                grepl('المغرب', country_entry, ignore.case = T) | grepl('Maroc', country_entry, ignore.case = T) ~ 'Morocco',
                                grepl('jordan', country_entry, ignore.case = T) ~ 'Jordan',
                                grepl('ليبيا', country_entry, ignore.case = T) ~ 'Libya',
                                grepl('مصر', country_entry, ignore.case = T) ~ 'Egypt',
                                grepl('mark', country_entry, ignore.case = T) ~ 'Denmark',
                                grepl('salvador', country_entry, ignore.case = T) ~ 'El Salvador',
                                grepl('estonia', country_entry, ignore.case = T) ~ 'Estonia',
                                grepl('korea', country_entry, ignore.case = T) | grepl('Güney Kore', country_entry, ignore.case = T) ~ 'South Korea',
                                grepl('hungary', country_entry, ignore.case = T) ~ 'Hungary',
                                grepl('maurice', country_entry, ignore.case = T) ~ 'Mauritius',
                                grepl('jamaica', country_entry, ignore.case = T) ~ 'Jamaica',
                                grepl('kenia', country_entry, ignore.case = T) ~ 'Kenya',
                                grepl('laos', country_entry, ignore.case = T) ~ 'Laos',
                                grepl('latvia', country_entry, ignore.case = T) ~ 'Latvia',
                                grepl('malta', country_entry, ignore.case = T) ~ 'Malta',
                                grepl('myanmar', country_entry, ignore.case = T) ~ 'Myanmar',
                                grepl('nepal', country_entry, ignore.case = T) ~ 'Nepal',
                                grepl('^oman$', country_entry, ignore.case = T) ~ 'Oman',
                                grepl('qatar', country_entry, ignore.case = T) ~ 'Qatar',
                                grepl('panam', country_entry, ignore.case = T) ~ 'Panama',
                                grepl('tanzania', country_entry, ignore.case = T) ~ 'United Republic of Tanzania',
                                grepl('vietnam', country_entry, ignore.case = T) ~ 'Vietnam')
  # for this approach to check unmatched entries:
  country_matches02_unmatched <- sort(table(country_entry[is.na(country_matches02)]), decreasing=T)
  View(country_matches02_unmatched)
