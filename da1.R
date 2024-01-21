# Install and load required packages
if (!require("dplyr")) install.packages("dplyr")
if (!require("ggplot2")) install.packages("ggplot2")
if (!require("tidyr")) install.packages("tidyr")

library(dplyr)
library(ggplot2)
library(tidyr)

# Set seed for reproducibility
set.seed(123)

# Generate synthetic data
data_a <- rnorm(100, mean = 30, sd = 10)
data_b <- rnorm(100, mean = 35, sd = 12)

# Create a data frame
df <- data.frame(Group_A = data_a, Group_B = data_b)

# Display the first few rows of the data frame
cat("Data Frame Head:\n")
print(head(df))

# Descriptive statistics
cat("\nDescriptive Statistics:\n")
print(summary(df))

# Data wrangling using dplyr and tidyr
df_long <- df %>%
  pivot_longer(cols = everything(), names_to = "Group", values_to = "Values")

# Data Visualization using ggplot2
distribution_plot <- ggplot(df_long, aes(x = Values, fill = Group)) +
  geom_histogram(bins = 20, position = "identity", alpha = 0.7) +
  labs(title = "Distribution of Data for Group A and Group B",
       x = "Values",
       y = "Frequency") +
  theme_minimal()

# Save the distribution plot as an image
ggsave("distribution_plot.png", distribution_plot, width = 10, height = 6)

# Boxplot to compare the two groups
boxplot_comparison <- ggplot(df_long, aes(x = Group, y = Values, fill = Group)) +
  geom_boxplot() +
  labs(title = "Boxplot Comparison of Group A and Group B",
       x = "Groups",
       y = "Values") +
  theme_minimal()

# Save the boxplot as an image
ggsave("boxplot_comparison.png", boxplot_comparison, width = 8, height = 5)

# Save the data frame to a CSV file
write.csv(df, "data_analysis_results.csv", row.names = FALSE)

# Print a message indicating successful completion
cat("\nData analysis and visualization completed. Output files saved.\n")
