import numpy as np
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import os
import requests
import geopandas as gpd
import warnings
warnings.simplefilter(action='ignore', category=FutureWarning)

def graficar_RTT(filename):
    # grafico de RTT
    sns.barplot(data = df, x = "TTL", y = "Average RTT")
    plt.grid(axis='y')
    plt.title('RTT promedio por TTL')
    plt.tight_layout()
    plt.savefig(f'graphs/{filename}/{filename}_RTT.pdf')
    plt.close()

def graficar_diff_RTT(filename):
    # grafico de diferencia entre saltos RTT
    sns.barplot(data = df, x = "TTL", y = "RTT Difference")
    plt.grid(axis='y')
    plt.title('Diferencia en el RTT entre saltos')
    plt.tight_layout()
    plt.savefig(f'graphs/{filename}/{filename}_diff_RTT.pdf')
    plt.close()

def graficar_unanswered_pckgs(filename):
    # grafico de proporcion de paquetes no respondidos por ttl
    sns.barplot(data = df, x = 'TTL', y = 'Unanswered packages')
    plt.grid(axis='y')
    plt.title('Cantidad de paquetes no respondidos por ttl')
    plt.tight_layout()
    plt.savefig(f'graphs/{filename}/{filename}_unanswered_pckgs.pdf')
    plt.close()

# Setup para graficar_geoplot
world = gpd.read_file(gpd.datasets.get_path('naturalearth_lowres'))
os.system('clear')

def graficar_geoplot(filename):
    # mapa del traceroute
    if os.path.exists(f'graphs/{filename}/{filename}_cities.csv'):
        cities = pd.read_csv(f'graphs/{filename}/{filename}_cities.csv')
    else:
        cities = pd.DataFrame(columns = ['City', 'Country','Continent', 'Longitude', 'Latitude'])
        paquetes_no_geolocalizables = 0
        for ip in df["IP"]: 
            response = (requests.get(f"https://ipapi.co/{ip}/json/")).json()
            if "error" not in response:
                response_df = pd.DataFrame({'City' : [response['city']],
                                            'Country': [response['country']],
                                            'Continent' : [response['continent_code']],
                                            'Longitude' : [response['longitude']],
                                            'Latitude': [response['latitude']]})
                cities = pd.concat([cities,response_df], ignore_index = True) 
            else:
                paquetes_no_geolocalizables = paquetes_no_geolocalizables + 1

        print(f'{filename} >> Proporcion de la ruta geolocalizada: {(len(df.index) - paquetes_no_geolocalizables)/len(df.index)}')    
        
        cities = (cities.groupby(cities.columns.tolist())).apply(lambda x: tuple(x.index)).reset_index(name = 'idx')
        cities.to_csv(f'graphs/{filename}/{filename}_cities.csv')       

    gdf = gpd.GeoDataFrame(cities, geometry = gpd.points_from_xy(cities['Longitude'], cities['Latitude']), crs = 'EPSG:4326')

    if gdf.empty:
            print('gdf is empty! Maybe you have been rate limited by ipapi or saved an empty cities DataFrame :(')
            return -1

    ax = world.plot(color = 'lightblue', edgecolor = 'white')

    for x, y, label in zip(gdf.geometry.x, gdf.geometry.y, gdf.idx):
        ax.annotate(label[1:-1], xy=(x, y), xycoords = 'data',xytext=(x, y), fontsize = 5)
    
    gdf.plot(ax = ax, color = 'red')
    plt.title(f'Localizaciones de la ruta con destino {filename}')
    plt.savefig(f'graphs/{filename}/{filename}_geoplot.pdf')
    plt.close()




if not os.path.exists("graphs"):
    os.mkdir("graphs")

for csv_filename in os.listdir('traceroute_output/'):
    df = pd.read_csv(f'traceroute_output/{csv_filename}')
    df = df.loc[df["RTT Difference"].notnull()]
    filename = csv_filename[:-4]
    if not os.path.exists(f'graphs/{filename}'):
        os.mkdir(f'graphs/{filename}')
    graficar_RTT(filename)
    graficar_diff_RTT(filename)
    graficar_geoplot(filename)
    graficar_unanswered_pckgs(filename)
    print(f'{filename} data done plotting.')