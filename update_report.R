library(googledrive)
library(dplyr)

# Set up Google Drive authentication
drive_auth(use_oob = TRUE)

# Define function to update the sepsis_report.csv file
update_report <- function() {
  # Get the sepsis_report.csv file from Google Drive
  report_file <- drive_get("sepsis_report.csv")
  report_df <- read.csv(text = report_file$content, stringsAsFactors = FALSE)
  
  # Update the report with the latest patient data
  updated_df <- updatePatients(report_df)
  
  # Write the updated report back to Google Drive
  updated_csv <- as.character(write.csv(updated_df, row.names = FALSE))
  drive_put(updated_csv, "sepsis_report.csv", overwrite = TRUE)
}

# Call the update_report function
update_report()