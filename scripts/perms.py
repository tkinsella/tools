def numeric_to_symbolic(numeric_perm):
    numeric_perm = int(numeric_perm, 8)
    symbolic_perm = ''
    for i in range(9):
        if numeric_perm & (1 << (8 - i)):
            symbolic_perm += 'rwx'[i % 3]
        else:
            symbolic_perm += '-'
    return symbolic_perm

def symbolic_to_numeric(symbolic_perm):
    numeric_perm = 0
    for i, char in enumerate(symbolic_perm):
        if char in 'rwx':
            numeric_perm |= (1 << (8 - i))
    return oct(numeric_perm)[2:]

def main():
    import sys

    if len(sys.argv) > 1:
        input_perm = sys.argv[1]
    else:
        input_perm = input("Enter a Linux permission in numeric (e.g., 755) or symbolic (e.g., rwxr-xr-x) format: ")

    if input_perm.isdigit() and len(input_perm) == 3:
        symbolic_result = numeric_to_symbolic(input_perm)
        user_perms = symbolic_result[:3]
        group_perms = symbolic_result[3:6]
        others_perms = symbolic_result[6:]
        print(f"User provided Number Notation: {input_perm}")
        print(f"The Symbolic Notation is: {symbolic_result}")
        print(f"Breakdown:")
        print(f"User(U): {user_perms}")
        print(f"Group(G): {group_perms}")
        print(f"Others(O): {others_perms}")
    elif len(input_perm) == 9 and all(char in '-rwx' for char in input_perm):
        numeric_result = symbolic_to_numeric(input_perm)
        print(f"User provided Symbolic Notation: {input_perm}")
        print(f"The Number Notation is: {numeric_result}")
    else:
        print("Invalid input format. Please enter a valid 3-digit numeric or 9-character symbolic permission.")

if __name__ == "__main__":
    main()

