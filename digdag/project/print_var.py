# print_var.py
import digdag
import json


def hello_world(var1, var2):
    print("Hello World, {}".format(var1))
    print("Hello World, {}".format(var2))
    print(json.dumps(digdag.env.params, indent=4))
