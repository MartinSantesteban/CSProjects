import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

sns.set_theme(style="darkgrid")
output_path = "./python/output/"

def load(filename):
    f = open(output_path + filename, 'r')
    data = pd.read_csv(f)
    f.close()
    return data

def plot(filename):
    df = load(filename)
    df["time"] = (df["time"] * 1000).astype(int)
    sns.lineplot(data=df, x="threads", y="time")
    #plt.yticks(range(5, 30, 5))
    #plt.ylim(5, 27)
    plt.xlabel("Cantidad de threads")
    plt.ylabel("Tiempo de ejecución (ms)")
    plt.savefig(output_path + filename[:-5] + ".pdf", bbox_inches='tight')
    plt.close()

def plot_many(filenames, labels=None, output_filename="TEST"):
    i = 0
    for filename in filenames:
        df = load(filename)
        df["time"] = (df["time"] * 1000).astype(int)
        sns.lineplot(data=df, x="threads", y="time", 
            label = labels[i] if labels is not None else filename[:-5])
        i += 1
    plt.xlabel("Cantidad de threads")
    plt.ylabel("Tiempo de ejecución (ms)")
    plt.savefig(output_path + "many_plots_" + output_filename + ".pdf", bbox_inches='tight')
    plt.close()

# Test cuadrados
filenames_cuadrados = ["tiempo_time_big.time","tiempo_time_giant.time"]
labels_cuadrados = [r"1000 × 1000", r"10000 × 10000"]
output_filename_cuadrados = "cuadrados"

for f in filenames_cuadrados:
    plot(f)

plot_many(filenames=filenames_cuadrados, labels=labels_cuadrados, output_filename=output_filename_cuadrados)

# Test rectangulares
filenames_rectangulares = ["tiempo_ancho.time", "tiempo_alto.time"]
labels_rectangulares = [r"10000 × 1000", r"1000 × 10000"]
output_filename_rectangulares = "rectangulares"

for f in filenames_rectangulares:
    plot(f)

plot_many(filenames=filenames_rectangulares, labels=labels_rectangulares, output_filename=output_filename_rectangulares)


# Para ajustar los ejes - Descomentar las lineas yticks(),ylim() de plot()
#plot(filenames_cuadrados[0]) 