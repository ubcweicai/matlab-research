import os

files = [f for f in os.listdir('.') if os.path.isfile(f) and f.endswith('.log')]
for f in files:
    with open(f, 'r') as file:
        with open(f+"-modify", "w") as of:
            for line in file.readlines():
                of.write(line[:-3] + "\n")
