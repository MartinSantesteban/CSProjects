import os
from   PIL    import Image
import numpy  as     np
from   pandas import DataFrame, Series

def vectorize(image):
    image = image.resize((28, 28), Image.Resampling.LANCZOS)
    V = np.asarray(image).flatten().reshape(1, 784)
    return V

def render_28x28(v):
        if type(v) is Series:
            v = v.to_numpy()
        image = Image.fromarray(v.reshape(28, 28).astype('uint8'))
        return image

def render_row(row, row_length):
        image = Image.new('RGB', (28 * row.shape[0], 28))
        for i, pixels in row.iterrows():
            digit = render_28x28(pixels)
            image.paste(digit, (28*(i%row_length), 0))
        return image

def render_digits(digits, row_length = 10):
    df_rows = digits.shape[0]
    digits.reset_index()
    image_rows = df_rows//row_length + (1 if df_rows % row_length > 0 else 0)
    image = Image.new('RGB', (28 * min(df_rows, row_length), 28 * image_rows))
    for i in range(image_rows):
        row = render_row(digits.iloc[i*row_length:(i+1)*row_length,:], row_length)
        image.paste(row, (0, 28*i))
    return image

def tikz(v):
    array = ''
    array += '\\def\\A{\n'
    for i in range(len(v)):
        array += '    {'
        for j in range(len(v[i])): 
            array += str(v[i,j])
            array += ', ' if j < len(v[i]) - 1 else ''
        array += '},\n' if i < len(v) - 1 else '}%\n'
    array += '}'
    return array