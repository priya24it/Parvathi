import pandas as pd

def parse_combinations(file_path):
    # Read the input file
    with open(file_path, 'r') as file:
        lines = file.readlines()

    records = []  # To store each combination
    record = {}  # To store a single record
    start_processing = False  # Flag to start processing after the first `CLM`

    for line in lines:
        line = line.strip()  # Remove extra spaces or newlines

        if line.startswith("CLM"):
            # Start processing only after encountering the first CLM
            start_processing = True
            # If a new CLM is encountered, store the current record and start a new one
            if record:
                records.append(record)
                record = {}
            # Parse CLM line
            clm_parts = line.split('*')
            record.update({
                "CLM01": clm_parts[1] if len(clm_parts) > 1 else "",
                "CLM02": clm_parts[2] if len(clm_parts) > 2 else "",
                "CLM03": clm_parts[3] if len(clm_parts) > 3 else "",
            })
        elif start_processing and line.startswith("AMT"):
            # Parse AMT line
            amt_parts = line.split('*')
            record.update({
                "AMT01": amt_parts[1] if len(amt_parts) > 1 else "",
                "AMT02": amt_parts[2] if len(amt_parts) > 2 else "",
                "AMT03": amt_parts[3] if len(amt_parts) > 3 else "",
            })
        elif start_processing and line.startswith("SBR"):
            # Parse SBR line
            sbr_parts = line.split('*')
            record.update({
                "SBR01": sbr_parts[1] if len(sbr_parts) > 1 else "",
                "SBR02": sbr_parts[2] if len(sbr_parts) > 2 else "",
                "SBR03": sbr_parts[3] if len(sbr_parts) > 3 else "",
            })
        elif start_processing and line.startswith("OI"):
            # Parse OI line
            oi_parts = line.split('*')
            record.update({
                "OI01": oi_parts[1] if len(oi_parts) > 1 else "",
                "OI02": oi_parts[2] if len(oi_parts) > 2 else "",
            })

    # Add the last record if it exists
    if record:
        records.append(record)

    return records

def save_to_csv(records, output_csv):
    # Convert to pandas DataFrame
    df = pd.DataFrame(records)
    
    # Save DataFrame to a CSV file
    df.to_csv(output_csv, index=False)
    print(f"Data has been successfully written to {output_csv}")

# Input and output file paths
input_file = 'input.txt'  # Replace with the actual input file path
output_csv = 'output3.csv'  # Desired output CSV file

# Parse the input file and save to CSV
records = parse_combinations(input_file)
save_to_csv(records, output_csv)