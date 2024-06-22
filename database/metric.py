import pandas as pd

# Load the CSV data into a DataFrame
df = pd.read_csv('fifa23_players_modified.csv')

# Create new DataFrames for pm_id and p_id with sequential numbers starting from 1
pm_id_df = pd.DataFrame({'pm_id': range(1, len(df) + 1)})
p_id_df = pd.DataFrame({'p_id': range(1, len(df) + 1)})

# Concatenate pm_id_df and p_id_df with the original DataFrame
df = pd.concat([pm_id_df, p_id_df, df], axis=1)

# List the columns you want to delete
columns_to_delete = ['p_name', 'p_club', 'p_nation', 'p_league', 'p_rating', 'p_position', 'Alternate_Positions', 'Card_Version', 'Run_Style', 'Skills_Star', 'Weak_Foot_Star', 'Attack_Workrate', 'Defense_Workrate', 'Height']  # Removing columns not needed

# Delete the unwanted columns
df.drop(columns_to_delete, axis=1, inplace=True)

# Specify the order of columns if needed (optional)
column_order = ['pm_id', 'p_id'] + [col for col in df.columns if col not in ['pm_id', 'p_id']]

# Save the DataFrame back to CSV with the specified column order
df.to_csv('players_performance23_info.csv', columns=column_order, index=False)
