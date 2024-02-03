def generate(nombre, x, y, cant_jugadores):
    f = open("./config/config_" + nombre + ".csv", "w")
    f.write(  str(x) + " " +  str(y)  + " " + str(cant_jugadores) + "\n")
    f.write(  "1"    + " " +    "1"   + "\n")
    f.write(str(x-1) + " " + str(y-1) + "\n")
    for i in range(1, 1+cant_jugadores):
        f.write(str((i//(y-1)) + 1) + " " + str((i%(y-1)) + 1) + " ")
    f.write("\n")
    for i in range(1, 1+cant_jugadores):
        f.write(str((x-1)-(i//(y-1))) + " " + str(((y-1)-(i)%(y-1))) + " ")