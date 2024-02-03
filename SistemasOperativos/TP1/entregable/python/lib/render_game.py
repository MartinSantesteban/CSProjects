from   random import randint
import numpy  as     np
from   PIL    import Image
import imageio

red_flag  = Image.open("./python/lib/sprites/red_flag.png" )
blue_flag = Image.open("./python/lib/sprites/blue_flag.png")
red_mage  = Image.open("./python/lib/sprites/red_mage.png" )
blue_mage = Image.open("./python/lib/sprites/blue_mage.png")

grass     = Image.open("./python/lib/sprites/grass.png"    )
grass     = [grass.crop((x, y, x+16, y+16)) for x in [0, 16, 32] for y in [0, 16, 32]]

def parse_coords(coords):
    coords = coords.split(',')
    coords = list(map(int, coords))
    coords = list(map(lambda x: x - 1, coords))
    return tuple(coords)

def parse_move(move):
    move, color = move.split(',')[:4], move.split(',')[4]
    move = list(map(int, move))
    move = list(map(lambda x: x - 1, move))
    return tuple(move + [color])

def build(x, y, flags, red_team, blue_team):
    background = Image.new('RGB', (x*16, y*16))
    for i, j in [(i, j) for i in range(x) for j in range(y)]:
        background.paste(grass[randint(0, 8)], (i * 16, j * 16))
    image = background.copy()
    image.paste(red_flag , (flags[0][0] * 16, flags[0][1] * 16), red_flag )
    image.paste(blue_flag, (flags[1][0] * 16, flags[1][1] * 16), blue_flag)
    for (red, blue) in list(zip(red_team, blue_team)):
        image.paste(red_mage , (red[0]  * 16, red[1]  * 16) , red_mage )
        image.paste(blue_mage, (blue[0] * 16, blue[1] * 16), blue_mage)
    return background, image

def load(path, cutoff):
    I = [line.strip() for line in open(path)]

    D, n, flags, T = parse_coords(I[0]), int(I[1]), (parse_coords(I[2]), parse_coords(I[3])), I[4:]
    red_team  = [parse_coords(pair) for pair in T[:n]]
    blue_team = [parse_coords(pair) for pair in T[n:2*n]]
    moves     = [parse_move(move) for move in T[2*n:]][:cutoff if cutoff != 0 else len(T) - 2*n]
    background, image = build(D[0], D[1], flags, red_team, blue_team)
    return background, image, moves

def render(name, cutoff = 0, duration = 0.1):
    #render to video
    background, image, moves = load("./output/" + name, cutoff)
    with imageio.get_writer("./python/output/" + name + ".gif", mode="I", duration=duration) as writer:
        for w, x, y, z, color, i in [moves[i] + tuple([i+1]) for i in range(len(moves))]:
            if (w, x) == (y, z):
                continue
            writer.append_data(np.array(image))
            image.paste(background.crop((w*16, x*16, w*16+16, x*16+16)), (w*16, x*16))
            image.paste(red_mage if color == "rojo" else blue_mage, (y*16, z*16), red_mage if color == "rojo" else blue_mage)
            print(i, "/", len(moves))
        writer.append_data(np.array(image))