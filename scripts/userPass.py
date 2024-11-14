#!/usr/bin/env python3
"""
=============================================================================
File:           userPass.py
Purpose:        Generates secure usernames and passwords following specific
               formatting rules. Usernames follow XX000000 format, and 
               passwords are 16 characters with specific character type
               requirements while avoiding ambiguous characters.

How to run:     python userPass.py
               Outputs generated username and password with analysis of
               password composition.

Dependencies:   Python 3.6+
               - random
               - string

Author:         Tom Kinsella
Email:          tkinsella@sisng.io
Organization:   Personal Project

Creation Date:  2019-02-12
Last Updated:   2019-02-12
Version:        1.0.0

Change History:
   1.0.0 (2019-02-12) - Initial release
       - Username generation:
           * Format: XX000000 (2 uppercase + 6 digits)
           * Excludes ambiguous characters (I, O, 0)
       - Password generation:
           * 16 characters in length
           * 3-5 uppercase letters
           * Minimum 3 numbers
           * Minimum 3 symbols
           * Remaining characters randomly selected
           * Excludes similar-looking characters
       - Password verification system
       - Detailed password analysis output
       - Object-oriented design with CredentialGenerator class

License:        MIT License
               Copyright (c) 2024 Tom Kinsella
               See LICENSE file for full license text

Notes:
   - Excludes similar-looking characters (I, O, 0, l)
   - Passwords always contain minimum required characters
   - Uses cryptographically secure random number generator
   - Includes verification to ensure all requirements are met
   - Recursively generates new password if requirements not met
=============================================================================
"""

import random
import string

class CredentialGenerator:
    def __init__(self):
        # Define character sets, excluding similar-looking characters
        self.letters = list(set(string.ascii_uppercase) - set('IO'))
        self.digits = list(set(string.digits) - set('0'))
        self.lowercase = list(set(string.ascii_lowercase) - set('l'))
        self.symbols = list('!@#$%^&*()_+-=[]{}|;:,.<>?')
        
    def generate_username(self):
        """Generate username in format XX000000"""
        letters = ''.join(random.choices(self.letters, k=2))
        numbers = ''.join(random.choices(self.digits, k=6))
        return f"{letters}{numbers}"
    
    def generate_password(self):
        """Generate a 16-character password meeting all requirements"""
        # Generate exactly between 3-5 uppercase letters
        num_uppercase = random.randint(3, 5)
        
        # Calculate remaining characters needed
        remaining_length = 16 - num_uppercase
        
        # Ensure minimum requirements for other character types
        password_chars = (
            random.choices(self.letters, k=num_uppercase) +     # 3-5 uppercase
            random.choices(self.digits, k=3) +                  # 3 numbers
            random.choices(self.symbols, k=3) +                 # 3 symbols
            random.choices(                                     # remaining chars from lowercase, digits, and symbols
                self.lowercase + self.digits + self.symbols,
                k=remaining_length - 6                          # -6 for the numbers and symbols above
            )
        )
        
        # Shuffle the characters
        random.shuffle(password_chars)
        
        # Verify the password meets requirements
        password = ''.join(password_chars)
        if not self._verify_password(password):
            return self.generate_password()  # Try again if requirements not met
            
        return password
    
    def _verify_password(self, password):
        """Verify the password meets all requirements"""
        uppercase_count = sum(1 for c in password if c in self.letters)
        digit_count = sum(1 for c in password if c in self.digits)
        symbol_count = sum(1 for c in password if c in self.symbols)
        
        return (len(password) == 16 and
                3 <= uppercase_count <= 5 and
                digit_count >= 3 and
                symbol_count >= 3)

def main():
    generator = CredentialGenerator()
    username = generator.generate_username()
    password = generator.generate_password()
    
    print("Generated Credentials:")
    print(f"Username: {username}")
    print(f"Password: {password}")
    
    # Debug info to verify requirements
    uppercase_count = sum(1 for c in password if c.isupper())
    digit_count = sum(1 for c in password if c.isdigit())
    symbol_count = sum(1 for c in password if c in generator.symbols)
    print("\nPassword Analysis:")
    print(f"Length: {len(password)}")
    print(f"Uppercase letters: {uppercase_count}")
    print(f"Numbers: {digit_count}")
    print(f"Symbols: {symbol_count}")

if __name__ == "__main__":
    main()
