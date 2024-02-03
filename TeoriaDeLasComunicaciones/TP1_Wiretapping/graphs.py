
import os
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns

protocol_map = {
        2048: 'IP',
        2054: 'ARP',
        34525: 'IPv6',
        34958: "PNAC",  #802.1X protocol—An IEEE standard for port-based network access control (PNAC) on wired and wireless access points. 
}

type_map = {
    "UNICAST": "U",
    "BROADCAST": "B",
}

def graphs_for_protocols(filepath, output_dir):
    df = pd.read_csv(filepath, header=None, names=['Index', 'Tipo_Destino', 'Protocolo', 'Cantidad', 'Probabilidad', 'Informacion'], skiprows=1)

    df['Protocolo'] = df['Protocolo'].replace(protocol_map)
    N = df["Cantidad"].sum()
    df_protocolos = df.drop(['Index', 'Tipo_Destino', 'Informacion'], axis = 1)
    df_protocolos = df_protocolos.groupby(["Protocolo"], as_index = False).sum()

    df_protocolos.plot(x='Protocolo', y='Cantidad', kind='bar', legend=False)
    plt.ylabel('Cantidad')
    plt.title('Cantidad por Protocolo')
    plt.grid(axis='y')
    plt.tight_layout()
    plt.savefig(os.path.join(output_dir, 'Protocols-Porcentage.pdf'))
    plt.close()

    df_protocolos.plot(y='Probabilidad', labels=df_protocolos['Protocolo'], kind='pie', autopct='%1.1f%%', legend=False) ## y es Probabilidad, pero como IP con broadcast e IP con unicast tienen probabilidad distinta, los separa
    plt.ylabel('')
    plt.title('Proporción por Protocolo')
    plt.savefig(os.path.join(output_dir, 'pie_chart.pdf'))
    plt.close()

    df.plot(x='Probabilidad', y='Informacion', kind='scatter', legend=False)
    plt.xlabel('Probabilidad')
    plt.ylabel('Información')
    plt.title('Relación entre Probabilidad e Información')
    plt.grid(True)
    
    plt.savefig(os.path.join(output_dir, 'scatter_plot.pdf'))
    plt.close()

def graphs_for_information(filepath, output_dir):
    df = pd.read_csv(filepath)

    df['protocolo'] = df['protocolo'].replace(protocol_map)
    df['tipo_destino'] = df['tipo_destino'].replace(type_map)

    entropy =(df["probabilidad"] * df["informacion"]).sum()
    df["simbolo"] = list(zip(df["tipo_destino"], df["protocolo"]))
    fig = df.plot(x='simbolo', y='informacion' , kind='bar', legend=False)
    plt.axhline(y=entropy, color='r', linestyle='--', label='Entropía')
    plt.ylabel('información')
    plt.title('Información por Símbolo')
    plt.grid(axis='y')
    plt.legend()
    plt.tight_layout()
    plt.savefig(os.path.join(output_dir, 'information_bar_chart.pdf'))
    plt.close()


def graphs_for_destination(filepath, output_dir):
    df = pd.read_csv(filepath, header=None, names=['Index', 'Tipo_Destino', 'Protocolo', 'Cantidad', 'Probabilidad', 'Informacion'], skiprows=1)

    total_paquetes = df['Cantidad'].sum()

    porcentaje_unicast = df[df['Tipo_Destino'] == 'UNICAST']['Cantidad'].sum() / total_paquetes * 100
    porcentaje_broadcast = df[df['Tipo_Destino'] == 'BROADCAST']['Cantidad'].sum() / total_paquetes * 100

    data = {'Tipo_Destino': ['UNICAST', 'BROADCAST'], 'Porcentaje': [porcentaje_unicast, porcentaje_broadcast]}
    df_porcentajes = pd.DataFrame(data)

    fig = df_porcentajes.plot(x='Tipo_Destino', y='Porcentaje', kind='bar', legend=False)
    fig.bar_label(fig.containers[0], label_type='edge')
    plt.ylabel('Porcentaje')
    plt.title('Porcentaje de paquetes Unicast y Broadcast')
    plt.grid(axis='y')
    plt.tight_layout()

    plt.savefig(os.path.join(output_dir, 'uni-brod-percentage.pdf'))
    plt.close()


def graphs_for_uni_broad_protocole(filepath, output_dir):
    df = pd.read_csv(filepath)
    df['protocolo'] = df['protocolo'].replace(protocol_map)
    fig = sns.barplot(data = df, x = "protocolo", y = "cantidad", hue = "tipo_destino")
    plt.grid(axis="y")
    f = fig.get_figure()
    f.savefig(os.path.join(output_dir, 'uni-brod-protocole.pdf'))
    plt.close()

def graficar_opcional(filepath, output_dir):
    df = pd.read_csv(filepath)
    df.plot(y='cantidad', labels=df['IP'], kind='pie', autopct='%1.1f%%', legend=False)
    if '2' in filepath:
        modo = 'destinantion'
        plt.title('Cantidad de paquetes de salida por dirección IP')
    else:
        modo = 'source'
        plt.title('Cantidad de paquetes de entrada por dirección IP')
    plt.tight_layout()
    plt.savefig(os.path.join(output_dir, 'pieplot_' + modo + '.pdf'))
    plt.close()

subdirs = [os.path.join('sources', d) for d in os.listdir('sources') if os.path.isdir(os.path.join('sources', d))]
for subdir in subdirs:
    csv_files = [f for f in os.listdir(subdir) if f.endswith('.csv')]
    for csv_file in csv_files:
        filepath = os.path.join(subdir, csv_file)
        output_dir = subdir
        print(filepath)
        if 'all_data' in csv_file:
            if subdir == "sources/arp" :
                graficar_opcional(filepath, output_dir)
            else:
                graphs_for_protocols(filepath, output_dir)
                graphs_for_destination(filepath, output_dir)
                graphs_for_uni_broad_protocole(filepath, output_dir)
                graphs_for_information(filepath, output_dir)
            
        
