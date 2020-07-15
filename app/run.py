# from cryptography.fernet import Fernet
#
# message = "my deep dark secret".encode()
# key = Fernet(Fernet.generate_key())
# encrypted = key.encrypt(message)
# decrypted = key.decrypt(encrypted)
#
# print(encrypted)
# print(decrypted)

class FOOBAR:
    __testy = {}
    def __init__(self, test):
        self.__testy[test] = test
    def __str__(self):
        return f"FOOBAR({self.__testy})"

foo = FOOBAR("foo")
print(foo)

bar = FOOBAR("bar")
print(foo)
print(bar)
