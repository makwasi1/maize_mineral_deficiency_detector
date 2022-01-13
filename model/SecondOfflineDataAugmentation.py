import tensorflow as tf
from tensorflow import keras
from tensorflow.keras.preprocessing.image import ImageDataGenerator
from skimage import io
import numpy as np
import os
from PIL import Image

datagen = ImageDataGenerator(
    zoom_range=0.6,
    horizontal_flip=True,
    vertical_flip=True,
    fill_mode='constant'
)

dataset = []

image_directory = '../../../../Schoolwork/MakerereUniversity/Year4/FinalYearProject/Datasets/New/NitrogenDeficient/Inter/'
SIZE = 1000
dataset = []

my_images = os.listdir(image_directory)
for i, image_name in enumerate(my_images):
    if(image_name.split('.')[1] == 'jpg'):
        image = io.imread(image_directory + image_name)
        image = Image.fromarray(image, 'RGB')
        image = image.resize((SIZE,SIZE))
        dataset.append(np.array(image))

x = np.array(dataset)

i=0
for batch in datagen.flow(x, batch_size = 16,
                            save_to_dir='../../../../Schoolwork/MakerereUniversity/Year4/FinalYearProject/Datasets/New/Augmentation/Augmentation2/NitrogenDeficient/1',
                            save_prefix='aug',
                            save_format='jpg'):
    i += 1
    if i>20:
        break