import subprocess
from graph  import temp_graph

def correr_instancia(algorithm, instance, subinstance, method):
    ext = "temp" if algorithm == "temperatura" else "iso"
    result = subprocess.run([f'../../cpp/build/{algorithm}', f"../../input/{instance}/{subinstance}.in", f"../../output/{instance}/{subinstance}.{ext}", f"{method}"], stdout=subprocess.PIPE, encoding='ascii')
    print(f'fin {instance}, {subinstance}')
    return result.stdout.split('\n')