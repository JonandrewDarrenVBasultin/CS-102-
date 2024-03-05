#Practical Exam CS102

#A

#1
numeric_or_integer <- sapply(warpbreaks, function(x) is.numeric(x) || is.integer(x))
print(numeric_or_integer)

#2
warpbreaks$breaks <- as.integer(warpbreaks$breaks)
str(warpbreaks$breaks)

#3
sum_warpbreaks <- sum(warpbreaks)
#Error in FUN(X[[i]], ...) : 
#only defined on a data frame with all numeric-alike variables

#B

#1

textfile <- readLines('exampleFile.txt')

#2 

Linesfromtxt <- c(
  "// Survey data. Created : 21 May 2013",
  "// Field 1: Gender",
  "// Field 2: Age (in years)",
  "// Field 3: Weight (in kg)",
  "M;28;81.3",
  "male;45;",
  "Female;17;57,2",
  "fem.;64;62.8"
)

identify_comments <- Linesfromtxt[grepl("^//",Linesfromtxt)]

identify_data <- Linesfromtxt[!grepl("^//",Linesfromtxt)]

print("Comments")
print(identify_comments)

#3
install.packages("lubridate")
library(lubridate)

firstline <- "// Survey data. Created : 21 May 2013"

extract_date <- dmy(gsub("// Survey data. Created : ", "", firstline))

print(extract_date)



#4

# Step a: Split the data lines by semicolon (;)
data_lines <- lines[!grepl("^//", Linesfromtxt)]  # Exclude comment lines
split_data <- strsplit(data_lines, ";")

# Step b: Find the maximum number of fields retrieved by split and append rows with NA's
max_fields <- max(sapply(split_data, length))
filled_data <- t(sapply(split_data, function(x) c(x, rep(NA, max_fields - length(x)))))

# Step c: Use unlist and matrix to transform the data to row-column format
matrix_data <- matrix(unlist(filled_data), ncol = max_fields, byrow = TRUE)

# Step d: Extract names of the fields from comment lines 2-4
field_names <- sapply(lines[2:4], function(line) gsub("^// Field [0-9]+: ", "", line))

# Set field names as colnames for the matrix
colnames(matrix_data) <- field_names

# Print the resulting matrix
print(matrix_data)
writeTocsv <- write.csv(matrix_data, file = "MatrixDataset.csv", row.names = FALSE)


