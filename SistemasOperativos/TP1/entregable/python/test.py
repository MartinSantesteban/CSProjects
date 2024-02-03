import subprocess
import os
import shutil
from   enum               import Enum
from   lib.generate_board import generate
from   lib.render_game    import render

class Strategy(Enum):
    SEQUENTIAL = 0
    RR         = 1
    SHORTEST   = 2
    USTEDES    = 3

def execute(test_name, strategy, quantum=0):
    print("CASO TEST:", test_name)
    subprocess.call(["./build/tp_sistemas", test_name, str(strategy.value), str(quantum)])

def time(test_name, samples=1):
    print("TIEMPOS TEST:", test_name)
    subprocess.call(["./build/tiempos_sistemas", test_name, str(samples)])

shutil.rmtree("./config")
shutil.rmtree("./output")
shutil.rmtree("./python/output")
os.mkdir("./config")
os.mkdir("./output")
os.mkdir("./python/output")

test_name = "sequential_small"
generate(test_name, 10, 10, 8)
execute (test_name, Strategy.SEQUENTIAL)
render  (test_name)

# test_name = "sequential_dense"
# generate(test_name, 10, 10, 35)
# execute (test_name, Strategy.SEQUENTIAL)
# render  (test_name)

# test_name = "sequential_big"
# generate(test_name, 25, 10, 10)
# execute (test_name, Strategy.SEQUENTIAL)
# render  (test_name)

# test_name = "robin_small"
# generate(test_name, 10, 10, 4)
# execute (test_name, Strategy.RR, 5)
# render  (test_name)

# test_name = "robin_dense"
# generate(test_name, 10, 7, 17)
# execute (test_name, Strategy.RR, 48)
# render  (test_name)

# test_name = "shortest_small"
# generate(test_name, 25, 25, 23)
# execute(test_name, Strategy.SHORTEST)
# render  (test_name)

# test_name = "shortest_big"
# generate(test_name, 3, 50, 1)
# execute (test_name, Strategy.SHORTEST)
# render  (test_name)

# test_name = "shortest_deadlock"
# generate(test_name, 2, 11, 1)
# try:
#     output = subprocess.run(["./build/tp_sistemas", test_name, str(Strategy.SHORTEST.value), "0"], stderr=subprocess.STDOUT, timeout=5)
#     print("ERROR")
# except subprocess.TimeoutExpired:
#     render  (test_name, 100)

# test_name = "afinidad_small"
# generate(test_name, 10, 10, 17)
# execute (test_name, Strategy.USTEDES, 1)
# render  (test_name)

# test_name = "afinidad_big"
# generate(test_name, 25, 25, 5)
# execute (test_name, Strategy.USTEDES, 3)
# render  (test_name)

# test_name = "time_big"
# generate(test_name, 1000, 1000, 1)
# time    (test_name, 512)

# test_name = "time_giant"
# generate(test_name, 10000, 10000, 1)
# time    (test_name, 256)

test_name = "ancho"
generate(test_name, 10000, 1000, 1)
time    (test_name, 256)

test_name = "alto"
generate(test_name, 1000, 10000, 1)
time    (test_name, 256)

