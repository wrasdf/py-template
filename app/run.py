from cryptography.fernet import Fernet

message = "my deep dark secret".encode()
key = Fernet(Fernet.generate_key())
encrypted = key.encrypt(message)
decrypted = key.decrypt(encrypted)

print(encrypted)
print(decrypted)
