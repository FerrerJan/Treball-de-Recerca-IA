def parse_txt_file(file_path):
    matrix = []
    
    with open(file_path, 'r') as file:
        for line in file:
            line = line.strip()
            if not line or ';' not in line:
                continue
            
            # Split the line into the main part and the result
            main_part, result = line.split(';')
            
            # Extract P, I, M
            p_part, rest = main_part.split('_', 1)
            p_value = int(p_part.split('-')[1])
            
            i_part, m_part = rest.split('_M-')
            i_values = [int(i) for i in i_part.split('-')[1].split(',')]
            m_values = [float(m) for m in m_part.split(',')]
            
            # Convert the result to a float
            r_value = float(result.replace(',', '.'))
            
            # Append the parsed values as a list to the matrix
            matrix.append([p_value, i_values, m_values, r_value])
    
    return matrix

def filter_and_calculate(matrix, p_filter, i_filter, m_filter):
    filtered_r_values = []

    for entry in matrix:
        p_value, i_values, m_values, r_value = entry

        # Check P filter
        if p_filter != '-' and p_value != int(p_filter):
            continue

        # Check I filter
        if i_filter != '-' and sorted(i_values) != sorted([int(i) for i in i_filter.split(',')]):
            continue

        # Check M filter
        if m_filter != '-' and sorted(m_values) != sorted([float(m) for m in m_filter.split(',')]):
            continue

        # If all conditions match, add the R value
        filtered_r_values.append(r_value)

    if not filtered_r_values:
        return "No matching records found."

    max_r = max(filtered_r_values)
    min_r = min(filtered_r_values)
    mean_r = sum(filtered_r_values) / len(filtered_r_values)

    return f"Max: {max_r:.3f}\nMin: {min_r:.3f}\nMean: {mean_r:.3f}"

def main():
    # Specify the file path here
    file_path = r"C:\Users\07map\Documents\GitHub\Flappy-bird_TR\TR\PYTHON\nom-r2.txt"
    
    # Parse the TXT file
    parsed_matrix = parse_txt_file(file_path)

    # Get user input for configuration
    p_filter = input("Enter P value (or '-' for any): ").strip()
    i_filter = input("Enter I values (comma-separated, or '-' for any): ").strip()
    m_filter = input("Enter M values (comma-separated, or '-' for any): ").strip()

    # Calculate and display results
    result = filter_and_calculate(parsed_matrix, p_filter, i_filter, m_filter)
    print(result)

if __name__ == "__main__":
    main()