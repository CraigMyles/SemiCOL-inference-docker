import os
import json
from pathlib import Path

classification_file_path = "/predict/classification.json"
input_folder_path = "/input/02_BX/"

def create_classification_json(input_folder, output_file):
    file_list = os.listdir(input_folder)
    file_dict = {}

    for file in file_list:
        if file.endswith(".ome.tiff"):
            file_key = file.split(".")[0]
            file_dict[file_key] = 0.5

    with open(output_file, "w") as outfile:
        json.dump(file_dict, outfile, indent=4)

if not Path(classification_file_path).is_file():
    create_classification_json(input_folder_path, classification_file_path)

print("INFERENCE COMPLETED. \n\n\nThank you.")