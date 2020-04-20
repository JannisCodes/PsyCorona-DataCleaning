list_data <- function(metadata_location){
  f <- list.files(file.path(metadata_location, "data"), ".csv", recursive = TRUE, full.names = TRUE)
  f[!grepl("dictionary", f)]
}

which_files <- function(metadata_location){
  gsub("^.+\\/(.+)\\.csv$", "\\1", list_data(metadata_location))
}

this_file <- function(which_file, metadata_location){
  f <- list_data(metadata_location)
  grep(paste0("\\b", tolower(which_file), ".csv"), tolower(f), value = TRUE)
}


merge_files <- function(df, which_file, metadata_location){
  if(is.null(df[["countryiso3"]])){
    df$countryiso3 <- countrycode::countrycode(df$coded_country, origin = "country.name", destination = "iso3c")
  }
  f <- list_data(metadata_location)
  f <- grep(paste0("\\b", tolower(which_file), ".csv"), tolower(f), value = TRUE)
  if(length(f) > 1) stop("No unique match with filenames.")
  df_dat <- read.csv(f, stringsAsFactors = FALSE)
  df_dat <- df_dat[!is.na(df_dat$countryiso3), ]
  if(!all(df$countryiso3 %in% df_dat$countryiso3)){
    message("Not all countries in df are available in ", which_file, ".")
  }
  if(any(duplicated(df_dat$countryiso3))){
    message("There are some duplicated country names in ", which_file, ".")
    if(!is.null(df_dat[["region"]])){
      message("Dropping region to see if this solves the problem.")
      df_dat <- df_dat[is.na(df_dat$region), ]
      if(any(duplicated(df_dat$countryiso3))){
        message("There are still duplicated country names in ", which_file, ". Using the row with most available data. Manual merging might be required. The duplicates are:\n  ", paste0(df_dat$countryiso3[which(duplicated(df_dat$countryiso3))], collapse = "\n  "))
        the_dups <- which(duplicated(df_dat$countryiso3) | duplicated(df_dat$countryiso3, fromLast = TRUE))
        df_dups <- df_dat[the_dups, ]
        df_dat <- df_dat[-the_dups, ]
        df_dups$miss <- rowSums(is.na(df_dups))
        for(countr in unique(df_dups$countryiso3)){
          df_dups <- df_dups[-which(df_dups$countryiso3 == countr)[-which.min(df_dups$miss[df_dups$countryiso3 == countr])], ]
        }
        df_dat <- rbind(df_dat, df_dups[, -ncol(df_dups)])
        message("For duplicates, used row with most complete information.")
        #df_dat <- df_dat[!duplicated(df_dat$countryiso3), ]
      }
    }
  }  
  merge(df, df_dat, all.x = TRUE, by = "countryiso3")
}

get_metadata <- function(metadata_location, overwrite){
  if(!overwrite & dir.exists(metadata_location)) return()
  if(dir.exists(metadata_location)){
    unlink(metadata_location, recursive = TRUE)
  } 
  olddir <- getwd()
  git_dir <- metadata_location
  gert::git_clone("https://github.com/cjvanlissa/covid19_metadata.git", git_dir)
}

