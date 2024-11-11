#title: " Week 9 Assignment Vignette"
#author: "Jose Fuentes"
#date: "2024-11-09"

For this assignment dataset used is a Dataset that is a collection of hotel bookings information that includes various details about each booking, such as the hotel type, booking dates, customer demographics, booking status, and more. This dataset is useful for analyzing trends in hotel bookings, cancellations, and customer behavior.

Dataset extracted from Kaggle portal: https://www.kaggle.com/datasets/jessemostipak/hotel-booking-demand
## R Markdown

{r ploading-data}
# Load necessary libraries
library(tidyverse)

# Load the dataset
hotel_data <- read_csv("https://raw.githubusercontent.com/Jomifum/Assignment9TidyVerse/main/hotel_bookings.csv")

print(head(hotel_data))


## Examples of packages and plot:

This dataset contains information on hotel bookings, including details such as hotel type, booking dates, customer demographics, and booking status. Key functions from the tidyverse package were used to manipulate and analyze this data, functions like read_csv() that loaded the data, group_by() and summarize() aggregate it, while mutate() was used to add new variables. Now arrange() sorted the data, while filter() subsetted it, and select() picked specific columns. Regarding Visualization functions like ggplot() helped to create insightful plots. Those tools streamline data analysis, enabling efficient exploration of booking trends, cancellations, and customer behaviors.

{r examples}

# Example 1: Calculate the Cancellation Rate by Country
cancellation_by_country <- hotel_data %>%
  group_by(country) %>%
  summarize(total_bookings = n(),
            cancellations = sum(is_canceled),
            cancellation_rate = (cancellations / total_bookings) * 100) %>%
  arrange(desc(cancellation_rate))

# Display the top 10 countries by cancellation rate
cancellation_by_country %>%
  slice_max(order_by = cancellation_rate, n = 10) %>%
  print()

# Example 2: Plot the average lead time by market segment
hotel_data %>%
  group_by(market_segment) %>%
  summarize(avg_lead_time = mean(lead_time, na.rm = TRUE)) %>%
  ggplot(aes(x = reorder(market_segment, avg_lead_time), y = avg_lead_time)) +
  geom_col(fill = "skyblue") +
  coord_flip() +
  labs(title = "Average Lead Time by Market Segment",
       x = "Market Segment",
       y = "Average Lead Time (days)") +
  theme_minimal()

# Example 3: Count the number of bookings by reservation status
reservation_status_count <- hotel_data %>%
  count(reservation_status) %>%
  ggplot(aes(x = reservation_status, y = n, fill = reservation_status)) +
  geom_bar(stat = "identity") +
  labs(title = "Bookings by Reservation Status",
       x = "Reservation Status",
       y = "Number of Bookings") +
  theme_minimal()
# Example 4: Using select to keep specific columns
selected_data <- hotel_data %>%
  select(hotel, country, market_segment, is_canceled)

# Display the first few rows of the selected data
print(head(selected_data))

# Example 5: Using mutate to create a new column for cancellation rate per country
hotel_data <- hotel_data %>%
  group_by(country) %>%
  mutate(total_bookings = n(),
         cancellations = sum(is_canceled),
         cancellation_rate = (cancellations / total_bookings) * 100)

# Display the first few rows of the data with the new column
print(head(hotel_data))

# Example 6: Using filter to get rows where cancellation_rate is higher than 50%
high_cancellation_rate <- hotel_data %>%
  filter(cancellation_rate > 50)

# Display the first few rows of the filtered data
print(head(high_cancellation_rate))


###Conclusion: The tidyverse library in analyzing the hotel_data dataset demostrated its powerful and cohesive set of tools designed for data manipulation and visualization. By utilizing some of their functions, it efficiently processed and explored the dataset, extracting meaningful insights into booking trends, cancellation rates, and customer behaviors. Meanwhile, ggplot2 created an informative visualization, enhancing the understanding of this data. Overall, tidyverse streamlined the data analysis workflow, making it more intuitive and effective.
