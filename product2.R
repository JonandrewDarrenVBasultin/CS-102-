# Install and load the rvest package
# if (!requireNamespace("rvest", quietly = TRUE)) {
#   install.packages("rvest")
# }
library(rvest)
library(polite)

# Read the HTML file
url <- "https://www.amazon.com/s?i=specialty-aps&bbn=4954955011&rh=n%3A4954955011%2Cn%3A%212617942011%2Cn%3A378733011&ref=nav_em__nav_desktop_sa_intl_crafting_0_2_8_4"

session <- bow(url, user_agent = "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/58.0.3029.110 Safari/537.3")
session_page <- scrape(session)

# Find all div elements with the specified class
div_elements <- html_elements(session_page, 'div.s-result-item')

# Create empty lists to store data
titles <- list()
prices <- list()
ratings <- list()
brand_descriptions <- list()
review_stars <- list()

for (div_element in div_elements) {
  # Find the span element with class="a-size-base-plus a-color-base a-text-normal" and get the title
  title_element <- html_node(div_element, 'span.a-size-base-plus.a-color-base.a-text-normal')
  title <- html_text(title_element)
  if (is.na(title)) title <- NA
  
  # Exclude rows with "No. 1" in the title
  if (!grepl("No\\.\\s*1", title, ignore.case = TRUE)) {
    # Find the span element with class="a-offscreen" and get the price
    price_element <- html_node(div_element, 'span.a-offscreen')
    price <- html_text(price_element)
    if (is.na(price)) price <- NA
    
    # Find the span element with class="a-icon-alt" and get the ratings
    rating_element <- html_node(div_element, 'span.a-icon-alt')
    rating <- html_text(rating_element)
    if (is.na(rating)) rating <- NA
    
    # Find the span element with class="a-text-bold" and get the brand
    brand_element <- html_node(div_element, 'span.a-text-bold')
    brand <- html_text(brand_element)
    if (is.na(brand)) brand <- NA
    
    # Find the div element with class="a-row a-size-base a-color-secondary" and get the description
    description_element <- html_node(div_element, 'div.a-row.a-size-base.a-color-secondary')
    description <- html_text(description_element)
    if (is.na(description)) description <- NA
    
    # Find the span element with class="a-icon-alt" inside the div with class="a-row a-spacing-medium" and get the review stars
    review_star_element <- html_node(div_element, 'div.a-row.a-spacing-medium span.a-icon-alt')
    review_star <- html_text(review_star_element)
    if (is.na(review_star)) review_star <- NA
    
    # Append data to lists
    titles <- c(titles, title)
    prices <- c(prices, price)
    ratings <- c(ratings, rating)
    brand_descriptions <- c(brand_descriptions, paste(brand, description, sep = " "))
    review_stars <- c(review_stars, review_star)
  }
}

# Create a data frame
product_df2 <- data.frame(
  Category = rep("Crafting Supplies", length(titles)),  # Replace with the appropriate category
  Title = unlist(titles),
  Price = unlist(prices),
  Rating = unlist(ratings),
  BrandDescription = unlist(brand_descriptions),
  ReviewStars = unlist(review_stars)
)

# Write to CSV
write.csv(product_df2, "product2.csv")
