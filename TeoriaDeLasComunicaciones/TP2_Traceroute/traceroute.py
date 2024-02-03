import sys
from scapy.all import *
from time import time
from collections import defaultdict
from statistics import mean
import csv

responses = {}
url = sys.argv[1]
NUM_PROBES = 30

def export_to_csv(data, filename=url + ".csv"):

    if not os.path.exists("traceroute_output"):
        os.makedirs("traceroute_output")
    path = f"traceroute_output/{filename}"
    with open(path, "w", newline="") as csvfile:
        fieldnames = ["TTL","Unanswered packages", "IP", "Average RTT", "RTT Difference"]
        writer = csv.DictWriter(csvfile, fieldnames=fieldnames)
        writer.writeheader()

        previous_rtt = None
        for ttl, (ip, rtt, none) in sorted(data.items()):
            row = {"TTL": ttl,"Unanswered packages": none, "IP": ip, "Average RTT": rtt}
            if previous_rtt is not None:
                rtt_diff = rtt - previous_rtt
                if rtt_diff >= 0:
                    row["RTT Difference"] = rtt_diff
            else:
                row["RTT Difference"] = ""
            writer.writerow(row)
            previous_rtt = rtt


for ttl in range(1, 25):
    rtt_list = defaultdict(list)                         
    unanswered_packages = 0   
    for _ in range(NUM_PROBES):
        probe = IP(dst=sys.argv[1], ttl=ttl) / ICMP()
        t_i = time()
        ans = sr1(probe, verbose=False, timeout=0.8)
        t_f = time()
        rtt = (t_f - t_i) * 1000
        if ans is None: 
            unanswered_packages = unanswered_packages + 1
        if ans is not None and ans.type == 11:  # ICMP Time exceeded
            rtt_list[ans.src].append(rtt)

    # Select the IP that responded the most times
    if rtt_list:
        most_common_ip = max(rtt_list, key=lambda k: len(rtt_list[k]))
        avg_rtt = mean(rtt_list[most_common_ip])
        responses[ttl] = (most_common_ip, avg_rtt, unanswered_packages)
        print(f"TTL {ttl} - IP: {most_common_ip} - Average RTT: {avg_rtt} ms")

export_to_csv(responses)
