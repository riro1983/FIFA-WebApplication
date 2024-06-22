import pandas as pd

# Load the CSV data
df = pd.read_csv('players_performance23_info.csv')

# Assuming your CSV headers are consistent with the pattern 'Metric / AnotherMetric'
# We will create a new DataFrame to store the reshaped data
reshaped_data = []

# Iterate over the original DataFrame
for index, row in df.iterrows():
    # Extract pm_id and p_id
    pm_id = row['pm_id']
    p_id = row['p_id']
    
    # Iterate over each metric column
    for metric in df.columns[:-2]:  # Exclude the last two columns which are pm_id and p_id
        metric_name = metric
        metric_value = row[metric]
        reshaped_data.append([pm_id, p_id, metric_name, metric_value])

# Convert the reshaped data into a DataFrame
reshaped_df = pd.DataFrame(reshaped_data, columns=['pm_id', 'p_id', 'metric_name', 'metric_value'])

# Save the reshaped DataFrame to a new CSV file
reshaped_df.to_csv('reshaped_performance.csv', index=False)
