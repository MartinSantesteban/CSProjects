#!/usr/bin/env python3

from scapy.all import *
import math 
import pandas as pd

S1 = {}
S2 = {}
S3 = {}
totalPackets = 0

def mostrar_fuente(S):
    #S must be not empty
    N = sum(S.values())
    simbolos = sorted(S.items(), key=lambda x: -x[1])

    information = {}
    entropy = 0.0

    for d,k in simbolos:
        p = k/N
        information[d] = (-1) * math.log2(p)
        entropy += p * information[d]

    print("Entropy: %.5f" % entropy)
    print("Information:")
    print("\n".join([ "%s : %.5f" % (d,k/N) for d,k in simbolos ]))

    df = pd.DataFrame(columns = ["tipo_destino", "protocolo", "cantidad", "probabilidad", "informacion"])
    for (k1,k2),v in simbolos:
        d = (k1,k2)
        df1 = pd.DataFrame({"tipo_destino" : [k1], "protocolo" : [k2], "cantidad" : [v], "probabilidad" : [v/N], "informacion" : [information[d]]})
        df = pd.concat([df,df1], axis = 0, ignore_index = True)
    df.to_csv('all_data.csv')
    print(df)

    #write entropy and probabilities to file 
    with open('entropy+information.csv', 'a') as f:
        f.write("Entropy: %.5f" % entropy)
        f.write("\n")
        f.write("Information:")
        f.write("\n")
        f.write("\n".join([ "%s : %.5f" % (d,k/N) for d,k in simbolos ]))
        f.write("\n")


def mostrar_fuente2(S):
    #Recevie a dictionnary key = source IP, value = number of packets 
    N = sum(S.values())
    simbolos = sorted(S.items(), key=lambda x: -x[1])

    information = {}
    entropy = 0.0

    for d,k in simbolos:
        p = k/N
        information[d] = (-1) * math.log2(p)
        entropy += p * information[d]

    df = pd.DataFrame(columns = ["IP", "cantidad", "probabilidad", "informacion"])
    for k,v in simbolos:
        df1 = pd.DataFrame({"IP" : [k], "cantidad" : [v], "probabilidad" : [v/N], "informacion" : [information[k]]})
        df = pd.concat([df,df1], axis = 0, ignore_index = True)
    df.to_csv('all_data.csv')
    print(df)

    #write entropy and probabilities to Filter
    with open('entropy+information.csv', 'a') as f:
        f.write("Entropy: %.5f" % entropy)
        f.write("\n")
        f.write("Information:")
        f.write("\n")
        f.write("\n".join([ "%s : %.5f" % (d,k/N) for d,k in simbolos ]))
        f.write("\n")

def mostrar_fuente3(S):
    #Recevie a dictionnary key = source IP, value = number of packets 
    N = sum(S.values())
    simbolos = sorted(S.items(), key=lambda x: -x[1])

    information = {}
    entropy = 0.0

    for d,k in simbolos:
        p = k/N
        information[d] = (-1) * math.log2(p)
        entropy += p * information[d]

    df = pd.DataFrame(columns = ["IP", "cantidad", "probabilidad", "informacion"])
    for k,v in simbolos:
        df1 = pd.DataFrame({"IP" : [k], "cantidad" : [v], "probabilidad" : [v/N], "informacion" : [information[k]]})
        df = pd.concat([df,df1], axis = 0, ignore_index = True)
    df.to_csv('all_data2.csv')
    print(df)

    #write entropy and probabilities to Filter
    with open('entropy+information2.csv', 'a') as f:
        f.write("Entropy: %.5f" % entropy)
        f.write("\n")
        f.write("Information:")
        f.write("\n")
        f.write("\n".join([ "%s : %.5f" % (d,k/N) for d,k in simbolos ]))
        f.write("\n")
    

def callback(pkt):
    global totalPackets, S1, S2
    #if pkt.haslayer(Ether):
        #dire = "BROADCAST" if pkt[Ether].dst == "ff:ff:ff:ff:ff:ff" else "UNICAST"
        #proto = pkt[Ether].type  # The 'type' field of the frame contains the protocol
        #s_i = (dire, proto)  # Define the symbol for the source

        ## Update the symbol count in the dictionary for S1
        #if s_i not in S1:
        #    S1[s_i] = 0.0
        #S1[s_i] += 1.0

    # Filter by ARP and then store the source IP 
    if pkt.haslayer(ARP):
        s_i = pkt[ARP].psrc
        s_j = pkt[ARP].pdst
        if s_i not in S2:
            S2[s_i] = 0.0
        if s_j not in S3:
            S3[s_j] = 0.0
        S2[s_i] += 1.0
        S3[s_j] += 1.0
        totalPackets += 1
        print(s_i)
    
    if totalPackets >= 1000:
       # mostrar_fuente(S1, 'all_data.csv')
        mostrar_fuente2(S2)
        mostrar_fuente3(S3)
        sys.exit(0)


try:
    sniff(prn=callback)
    mostrar_fuente2(S2)
    mostrar_fuente3(S3)
except KeyboardInterrupt:
    mostrar_fuente2(S2)
    mostrar_fuente3(S3)
    sys.exit(0)
