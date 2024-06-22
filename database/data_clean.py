import pandas as pd

# Load the CSV data into a DataFrame
df = pd.read_csv('fifa23_players_2023-10-06.csv')

# List the columns you want to delete
columns_to_delete = ['Price', 'Price_Variation', "Popularity", "Base_Stats", "Ingame_Stats"]  # Removing columns not needed

# Delete the unwanted columns
df.drop(columns_to_delete, axis=1, inplace=True)

# Save the DataFrame back to CSV
df.to_csv('fifa23_players_modified.csv', index=False)
