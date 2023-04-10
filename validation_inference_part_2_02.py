import pandas as pd
import json
import warnings

csv_input_path = "./class_counts/all_class_counts.csv"

# Read the CSV data
data = pd.read_csv(csv_input_path)

# Extract the filename from the input path
filename = data["filename"][0]

# Convert data types to numeric
data.iloc[:, 2:] = data.iloc[:, 2:].apply(pd.to_numeric, errors='coerce')

# Calculate row sums
row_sums = data.iloc[:, 2:].sum(axis=1)

# Convert counts to percentages
# with warnings.catch_warnings():
#     warnings.simplefilter(action='ignore', category=DeprecationWarning)
#     warnings.simplefilter(action='ignore', category=FutureWarning)
data.iloc[:, 2:] = data.iloc[:, 2:].div(row_sums, axis=0) * 100

# Add filename column to output
data.insert(0, "filename", data.pop("filename"))

# Save the result as a new CSV
data.to_csv(csv_input_path.replace(".csv", "_percentages.csv"), index=False)