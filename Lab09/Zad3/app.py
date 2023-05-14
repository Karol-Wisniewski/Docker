import platform

system = platform.system()

if system == "Linux":
    print("Welcome to Linux!")
elif system == "Windows":
    print("Welcome to Windows!")
else:
    print("Unknown system!")