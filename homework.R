#PSYC 259 Homework 1 - Data Import - Laura Ashlock 
#For full credit, provide answers for at least 6/8 questions

#List names of students collaborating with (no more than 2): 
#Merab Gomez 

#GENERAL INFO 
#data_A contains 12 files of data. 
#Each file (6192_3.txt) notes the participant (6192) and block number (3)
#The header contains metadata about the session
#The remaining rows contain 4 columns, one for each of 20 trials:
#trial_number, speed_actual, speed_response, correct
#Speed actual was whether the figure on the screen was actually moving faster/slower
#Speed response was what the participant report
#Correct is whether their response matched the actual speed

### QUESTION 1 ------ 

# Load the readr package

# ANSWER

library(readr)

### QUESTION 2 ----- 

# Read in the data for 6191_1.txt and store it to a variable called ds1
# Ignore the header information, and just import the 20 trials
# Be sure to look at the format of the file to determine what read_* function to use
# And what arguments might be needed

# ds1 should look like this:

# # A tibble: 20 × 4
#  trial_num    speed_actual speed_response correct
#   <dbl>       <chr>        <chr>          <lgl>  
#     1          fas          slower         FALSE  
#     2          fas          faster         TRUE   
#     3          fas          faster         TRUE   
#     4          fas          slower         FALSE  
#     5          fas          faster         TRUE   
#     6          slo          slower         TRUE
# etc..

# A list of column names are provided to use:

col_names  <-  c("trial_num","speed_actual","speed_response","correct")

# ANSWER
fname <- "data_A/6191_1.txt"
colname <- c("trial_num", "speed_actual", "speed_response", "correct")
coltypes<- "nccc"
ds1 <- read_delim(file = fname, delim = "\t", col_names = colname, col_types = coltypes, skip=7)
print(ds1)

# A tibble: 20 × 4
#trial_num speed_actual speed_response correct
#<dbl> <chr>        <chr>          <chr>  
#1         1 fas          slower         False  
#2         2 fas          faster         True   
#3         3 fas          faster         True   
#4         4 fas          slower         False  
#5         5 fas          faster         True   
#6         6 slo          slower         True   
#7         7 fas          faster         True   
#8         8 slo          slower         True   
#9         9 slo          slower         True   
#10        10 slo          faster         False  
#11        11 slo          slower         True   
#12        12 fas          faster         True   
#13        13 slo          slower         True   
#14        14 fas          faster         True   
#15        15 slo          faster         False  
#16        16 fas          faster         True   
#17        17 slo          slower         True   
#18        18 slo          slower         True   
#19        19 slo          slower         True   
#20        20 fas          faster         True 

### QUESTION 3 ----- 

# For some reason, the trial numbers for this experiment should start at 100
# Create a new column in ds1 that takes trial_num and adds 100
# Then write the new data to a CSV file in the "data_cleaned" folder

# ANSWER
ds1$trialnum_new <- ds1$trial_num+99
#used point and click to add data_cleaned folder... not sure if there is code?
write_csv(ds1, file = "data_cleaned/trials_relabeled.csv")

### QUESTION 4 ----- 

# Use list.files() to get a list of the full file names of everything in "data_A"
# Store it to a variable

# ANSWER
data_A_files<- list.files('data_A', full.names = TRUE)

# Make a variable containing the list of data files
full_file_names <- list.files('data_raw', full.names = TRUE)
# Pass the list to read_csv to read all of them into a single tibble
ds_all <- read_csv(full_file_names)
print(ds_all)

### QUESTION 5 ----- 

# Read all of the files in data_A into a single tibble called ds

# ANSWER
colname <- c("trial_num", "speed_actual", "speed_response", "correct")
coltypes<- "iccl"
ds <- read_tsv(data_A_files, col_names = colname, col_types = coltypes, skip=7)
print(ds)

### QUESTION 6 -----

# Try creating the "add 100" to the trial number variable again
# There's an error! Take a look at 6191_5.txt to see why.
# Use the col_types argument to force trial number to be an integer "i"
# You might need to check ?read_tsv to see what options to use for the columns
# trial_num should be integer, speed_actual and speed_response should be character, and correct should be logical
# After fixing it, create the column to add 100 to the trial numbers 
# (It should work now, but you'll see a warning because of the erroneous data point)

# ANSWER
coltypes<- "iccl"
col_types=coltypes
ds$trialnum_new <- ds$trial_num+99

### QUESTION 7 -----

# Now that the column type problem is fixed, take a look at ds
# We're missing some important information (which participant/block each set of trials comes from)
# Read the help file for read_tsv to use the "id" argument to capture that information in the file
# Re-import the data so that filename becomes a column

# ANSWER
# ANSWER
colname <- c("trial_num", "speed_actual", "speed_response", "correct")
coltypes<- "iccl"
ds <- read_tsv(data_A_files, col_names = colname, col_types = coltypes, skip=7, id="block_num")
print(ds)

### QUESTION 8 -----

# Your PI emailed you an Excel file with the list of participant info 
# Install the readxl package, load it, and use it to read in the .xlsx data in data_B
# There are two sheets of data -- import each one into a new tibble

# ANSWER
install.packages("readxl")
library(readxl)
read_xlsx("data_B/participant_info.xlsx")
excel_sheets("data_B/participant_info.xlsx")
ds_participants<- read_xlsx("data_B/participant_info.xlsx", sheet = "participant")
print(ds_participants)

colname <- c("participant", "test_date")
coltypes<- c("numeric", "date")
ds_testdate<- read_xlsx("data_B/participant_info.xlsx", sheet = "testdate", col_names = colname, col_types = coltypes)
print(ds_testdate)
