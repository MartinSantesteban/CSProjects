import matplotlib.pyplot as plt

def getRTTList(file):
    rttList = []
    for line in file:
        if line[0] != "I":
            line = line.split()
            rttList.append(float(line[1]))
    return rttList

def get_rtt_and_values(filePath):
    rtts = getRTTList(open(filePath,"r"))

    #delete the negative values
    rtts = [x for x in rtts if x > 0]

    rtts.sort()

    sample_mean = sum(rtts)/len(rtts) #sample mean
    sample_std = (sum([(x-sample_mean)**2 for x in rtts])/(len(rtts)-1))**0.5 #sample standard deviation

    return rtts, [(x-sample_mean)/sample_std for x in rtts]


con_rtts, con_values = get_rtt_and_values("ResultadosTTLConcordia.txt")
tum_rtts, tum_values = get_rtt_and_values("ResultadosTTLTum.txt")
tok_rtts, tok_values = get_rtt_and_values("ResultadosTTLTokyo.txt")
uio_rtts, uio_values = get_rtt_and_values("ResultadosTTLUio.txt")
oli_rtts, oli_values = get_rtt_and_values("ResultadosTTLToliara.txt")


plt.rcParams['axes.grid'] = True

fig, ((ax1, ax2, ax3), (ax4, ax5, _)) = plt.subplots(2, 3)
fig.suptitle('Graficos de RTT por (RTT-Media) / Desvio Estandar')

ax1.plot(con_rtts, con_values, 'ro')
ax1.set_title('Canada')

ax2.plot(tum_rtts, tum_values, 'yo')
ax2.set_title('Alemania')

ax3.plot(tok_rtts, tok_values, 'bo')
ax3.set_title('Noruega')

ax4.plot(uio_rtts, uio_values, 'go')
ax4.set_title('Madagascar')

ax5.plot(oli_rtts, oli_values, 'co')
ax5.set_title('Japon')

for ax in fig.get_axes():
    ax.label_outer()

/////////////////////

con_rtts, con_values = get_rtt_and_values("ResultadosTTLConcordia.txt")
tum_rtts, tum_values = get_rtt_and_values("ResultadosTTLTum.txt")
tok_rtts, tok_values = get_rtt_and_values("ResultadosTTLTokyo.txt")
uio_rtts, uio_values = get_rtt_and_values("ResultadosTTLUio.txt")
oli_rtts, oli_values = get_rtt_and_values("ResultadosTTLToliara.txt")



plt.rcParams['axes.grid'] = True

plt.plot(con_rtts, con_values, 'ro--', tum_rtts, tum_values, 'yo--', tok_rtts, tok_values, 'bo--', uio_rtts, uio_values, 'go--', oli_rtts, oli_values, 'co--', [], [], 'ko')
plt.legend(['Canada', 'Alemania', 'Noruega', 'Madagascar', 'Japon', 'Saltos intercontinentales'])

plt.ylabel('(RTT-Media) / Desvio Estandar')
plt.xlabel('RTT')

plt.show()
