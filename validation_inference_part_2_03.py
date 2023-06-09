import pandas as pd
import json
import warnings


import pandas as pd
import json

# Assuming your CSV file is named 'data.csv'
df = pd.read_csv('./class_counts/all_class_counts_percentages.csv')

# Initialize an empty dictionary for storing the results
result = {}

# Iterate through the DataFrame
for index, row in df.iterrows():
    filename = row['filename']
    class_1_value = row['class_1']
    class_3_value = row['class_3']
    class_7_value = row['class_7']
    
    # Check the conditions and store the result in the dictionary
    if class_1_value > 3.5 and class_3_value > 0.85 and class_7_value > 0.07:
        result[filename] = 1.0
    else:
        result[filename] = 0.0

# Save the dictionary as a JSON file
with open('/predict/classification.json', 'w') as outfile:
    json.dump(result, outfile, indent=4)