import pandas as pd

# Load the CSV data into a DataFrame
df = pd.read_csv('fifa23_players_modified.csv')

# Add a new column named 'p_id' with sequential numbers starting from 1
df.insert(0, 'p_id', range(1, len(df) + 1))  # This will insert the 'p_id' column at the first position

# Switch the columns 'p_league' and 'p_nation'
df['p_league'], df['p_nation'] = df['p_nation'], df['p_league']

# List the columns you want to delete
columns_to_delete = ['Alternate_Positions', 'Card_Version', 'Run_Style', 'Skills_Star', 'Weak_Foot_Star', 'Attack_Workrate', 'Defense_Workrate', 'Pace / Diving', 'Shooting / Handling', 'Passing / Kicking', 'Dribbling / Reflexes', 'Defense / Speed', 'Physical / Positioning', 'Height']  # Removing columns not needed

# Delete the unwanted columns
df.drop(columns_to_delete, axis=1, inplace=True)

# Save the DataFrame back to CSV
df.to_csv('players23_info.csv', index=False)

