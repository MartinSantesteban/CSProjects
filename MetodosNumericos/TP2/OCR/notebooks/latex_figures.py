# %% import modules
from asyncore import write
import pandas as pd
import numpy as np
from lib import MNIST
from PIL import Image

# %% generate header figure
train = pd.read_csv('../data/train.csv')

zero  = train.iloc[1 , 1:].to_numpy().reshape((1, 784))
one   = train.iloc[2,  1:].to_numpy().reshape((1, 784))
two   = train.iloc[16, 1:].to_numpy().reshape((1, 784))
three = train.iloc[9,  1:].to_numpy().reshape((1, 784))
four  = train.iloc[81, 1:].to_numpy().reshape((1, 784))
five  = train.iloc[51, 1:].to_numpy().reshape((1, 784))
six   = train.iloc[252,1:].to_numpy().reshape((1, 784))
seven = train.iloc[116,1:].to_numpy().reshape((1, 784))
eight = train.iloc[10, 1:].to_numpy().reshape((1, 784))
nine  = train.iloc[53, 1:].to_numpy().reshape((1, 784))

N = np.concatenate((zero, one, two, three, four, five, six, seven, eight, nine), axis=0)
df = pd.DataFrame(data = N)
im = MNIST.render_digits(df)
im.resize((2800, 280), Image.Resampling.NEAREST)
im.save('./output/header.png')

# %% generate tikz array for vectorization figure
tikz_three = MNIST.tikz(three.reshape((28, 28)))
with open("./output/tikz_array.txt", encoding = 'utf-8', mode='w') as f:
   f.write(tikz_three)
   
# %%