# Read existing CSV files
product1 <- read.csv("product1.csv")
product2 <- read.csv("product2.csv")
product3 <- read.csv("product3.csv")

# Combine data frames vertically using rbind
merged_products <- rbind(product1, product2, product3)

# Save the merged data frame to a new CSV file
write.csv(merged_products, "Merged Products.csv", row.names = FALSE)



# Reorder columns with "Category" as the leftmost column
product_df <- product_df[, c("Category", names(product_df)[-which(names(product_df) == "Category")])]

# Write the updated data frame to a CSV file
write.csv(product_df, "product1_updated.csv", row.names = FALSE)


# Assuming df1, df2, and df3 are your data frames
# Convert common_column to lowercase in all data frames
product1$common_column <- tolower(product1$common_column)
product2$common_column <- tolower(product2$common_column)
product3$common_column <- tolower(product3$common_column)

# Merge using the lowercase common_column
merged_df <- merge(merge(product1, product2, by="common_column", all=TRUE), product3, by="common_column", all=TRUE)
