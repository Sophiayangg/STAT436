library(ggplot2)
library(reshape2)
library(dplyr)
library(RColorBrewer)

# Load dataset
high_popularity_data <- read.csv("https://raw.githubusercontent.com/shraddhabyndoor/project2_stat436/refs/heads/main/high_popularity_spotify_data.csv")

# Select only numerical features
num_features <- high_popularity_data %>% 
  select(energy, tempo, danceability, loudness, liveness, 
         valence, speechiness, acousticness, instrumentalness, track_popularity)

# Compute correlation matrix
corr_matrix <- cor(num_features, use = "complete.obs")

# Set the diagonal to NA
diag(corr_matrix) <- NA

# Melt the correlation matrix for visualization
corr_melted <- melt(corr_matrix)

# Create heatmap
ggplot(corr_melted, aes(x = Var1, y = Var2, fill = value)) +
  geom_tile() +
  scale_fill_gradient2(
    low = "blue", mid = "white", high = "red", 
    midpoint = 0, limit = c(-1, 1), space = "Lab", name = "Correlation"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1)) +
  labs(
    title = "Heatmap of Feature Correlations",
    x = "Feature",
    y = "Feature"
  )
