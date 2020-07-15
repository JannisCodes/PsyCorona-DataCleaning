
nameOut <- function(df){
# if there is a B (baseline) paste the variable
  if (grepl("B|Baseline|All",df[2], ignore.case = T)) {
    stringOut[1] = paste(df[1])
  } else {
    stringOut[1] = NA
  }
# if there is a W1 (baseline) paste w1 and the variable
  if (grepl("W1,|W1;|Wave1,|Wave1;|Wave 1,|Wave 1;|All",df[2], ignore.case = T)) { # needs special care as it coincides with 10
    stringOut[2] = paste("w1_", df[1], sep = "")
  } else {
    stringOut[2] = NA
  }
  if (grepl("W2|Wave2|Wave 2|All",df[2], ignore.case = T)) {
    stringOut[3] = paste("w2_", df[1], sep = "")
  } else {
    stringOut[3] = NA
  }
  if (grepl("W3|Wave3|Wave 3|All",df[2], ignore.case = T)) {
    stringOut[4] = paste("w3_", df[1], sep = "")
  } else {
    stringOut[4] = NA
  }
  if (grepl("W4|Wave4|Wave 4|All",df[2], ignore.case = T)) {
    stringOut[5] = paste("w4_", df[1], sep = "")
  } else {
    stringOut[5] = NA
  }
  if (grepl("W5|Wave5|Wave 5|All",df[2], ignore.case = T)) {
    stringOut[6] = paste("w5_", df[1], sep = "")
  } else {
    stringOut[6] = NA
  }
  if (grepl("W6|Wave6|Wave 6|All",df[2], ignore.case = T)) {
    stringOut[7] = paste("w6_", df[1], sep = "")
  } else {
    stringOut[7] = NA
  }
  if (grepl("W7|Wave7|Wave 7|All",df[2], ignore.case = T)) {
    stringOut[8] = paste("w7_", df[1], sep = "")
  } else {
    stringOut[8] = NA
  }
  if (grepl("W8|Wave8|Wave 8|All",df[2], ignore.case = T)) {
    stringOut[9] = paste("w8_", df[1], sep = "")
  } else {
    stringOut[9] = NA
  }
  if (grepl("W9|Wave9|Wave 9|All",df[2], ignore.case = T)) {
    stringOut[10] = paste("w9_", df[1], sep = "")
  } else {
    stringOut[10] = NA
  }
  if (grepl("W10|Wave10|Wave 10|All",df[2], ignore.case = T)) {
    stringOut[11] = paste("w10_", df[1], sep = "")
  } else {
    stringOut[11] = NA
  }
  if (grepl("W11|Wave11|Wave 11|All",df[2], ignore.case = T)) {
    stringOut[12] = paste("w11_", df[1], sep = "")
  } else {
    stringOut[12] = NA
  }
return(stringOut)
}
