def avg_risk(r_i, R_e, radios):
    cercaniaTotal = 0
    for r in radios:
        cercaniaTotal += r
    res = cercaniaTotal/len(radios)
    res -= r_i
    res /= (R_e - r_i)
    return res

def max_risk(r_i, R_e, radios):
    min = radios[0]
    for t in radios:
        if(R_e - t <  min):
            min = R_e - t
    min = max(radios)
    res = (min-r_i) / (R_e - r_i)
    return res

def run_risks(instance, subinstance):
    (r_i, R_e, m, n, iso, ninst) = [line.strip() for line in open(f"../../input/{instance}/{subinstance}.in","r")][0].split(' ')
    (r_i, R_e, m, n, iso, ninst) = (float(r_i), float(R_e), int(m), int(n), float(iso), int(ninst))
    f = open(f"../../output/{instance}/{subinstance}.iso","r")
    radii = f.read().split()
    radii = [float(i) for i in list(radii)]
    isotherms = [radii[i:i+n] for i in range(0, len(radii), n)]
    output = open(f'../../output/{instance}/{subinstance}.risk', 'w')
    output.write('valor\n')
    for I in isotherms:
        output.write(str(avg_risk(r_i, R_e, I))+'\n')
        output.write(str(max_risk(r_i, R_e, I))+'\n')
    output.close()
    return
