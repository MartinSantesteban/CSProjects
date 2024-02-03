import csv
from statistics import mean, stdev
from scipy.stats import norm, t
import requests


def load_csv_data(filename):
    """Carga los datos desde un archivo CSV."""
    data = []
    with open(filename, "r") as file:
        reader = csv.DictReader(file)
        for row in reader:
            ttl = int(row["TTL"])
            ip = row["IP"]
            avg_rtt = float(row["Average RTT"])
            rtt_diff = (
                None if row["RTT Difference"] == "" else float(row["RTT Difference"])
            )
            data.append(
                {
                    "TTL": ttl,
                    "IP": ip,
                    "Average RTT": avg_rtt,
                    "RTT Difference": rtt_diff,
                }
            )
    return data


def detect_outliers(data):
    """Detecta outliers usando el método de Cimbala."""
    outliers = []
    rtt_diff_values = [
        entry["RTT Difference"] for entry in data if entry["RTT Difference"] is not None
    ]
    mean_rtt_diff = mean(rtt_diff_values)
    std_rtt_diff = stdev(rtt_diff_values)
    n = len(rtt_diff_values)
    alpha = 0.05
    t_alpha_over_2 = t.ppf(alpha / 2, n - 2)
    tau = t_alpha_over_2 * (n - 1) / (n * (n - 2 + t_alpha_over_2**2)) ** 0.5

    for entry in data:
        if entry["RTT Difference"] is not None:
            standardized_value = abs(entry["RTT Difference"] - mean_rtt_diff) 
            if standardized_value > tau * std_rtt_diff:
                outliers.append(entry)
    #print("OUTLIERS:")
    #print(outliers)

    return outliers


def geolocate_ip(ip):
    """Geolocaliza una IP y devuelve el código del continente."""
    try:
        response = requests.get(f"https://ipapi.co/{ip}/json/")
        data = response.json()
        #print(data["continent_code"])
        return data["continent_code"]
    except:
        print(f"Error al geolocalizar la IP {ip}")
        return None


def predict_intercontinental_links(outliers):
    """Predice enlaces intercontinentales basándose en outliers y geolocalización."""
    # Si dos IPs consecutivas detectadas como outliers pertenecen a diferentes continentes,
    # entonces es probable que haya un enlace intercontinental entre ellas.
    intercontinental_links = []
    previous_ip_continent = None
    for entry in outliers:
        ip = entry["IP"]
        continent = geolocate_ip(ip)
        #print(continent)
        if (previous_ip_continent is not None) and (continent is not None) and (previous_ip_continent != continent):
            intercontinental_links.append((previous_ip, ip))
        previous_ip = ip
        previous_ip_continent = continent
    return intercontinental_links


def main():
    # Cargar datos del CSV
    data = load_csv_data("www.calstate.edu.csv")

    print("Continentes por los que pasa el traceroute")
    for entry in data: 
        ip = entry["IP"]
        continent = geolocate_ip(ip)
        print(f"{entry} , {continent}")

    # Detectar outliers
    outliers = detect_outliers(data)

    # Predecir enlaces intercontinentales
    intercontinental_links = predict_intercontinental_links(outliers)

    # Imprimir enlaces intercontinentales predichos
    print("Enlaces intercontinentales predichos:")
    for link in intercontinental_links:
        print(f"{link[0]} -> {link[1]}")


if __name__ == "__main__":
    main()
