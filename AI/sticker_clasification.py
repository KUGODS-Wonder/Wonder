import os
import csv
import tensorflow as tf
import os
import numpy as np
import matplotlib.pyplot as plt
import tensorflow_hub as hub
import pandas as pd

data_root = ("C:/Users/Desktop/KUGODS/wonder/dataset/train")

IMAGE_SIZE = 224
IMAGE_SHAPE = (224, 224)
data_dir = str(data_root)
labels = ['dog','dosirak','others']

generate_img_train = tf.keras.preprocessing.image.ImageDataGenerator(rescale=1./255, validation_split=.20)

train_loader = generate_img_train.flow_from_directory(
    data_dir, 
    subset="training", 
    shuffle=True,
    target_size=IMAGE_SHAPE
    )

valid_loader = generate_img_train.flow_from_directory(
    data_dir, 
    subset="validation", 
    shuffle=True,
    target_size=IMAGE_SHAPE
)



model = tf.keras.Sequential([
  hub.KerasLayer("https://tfhub.dev/google/tf2-preview/mobilenet_v2/feature_vector/4", 
                 output_shape=[1280],
                 trainable=False),
  tf.keras.layers.BatchNormalization(),
  tf.keras.layers.Dense(train_loader.num_classes, activation='softmax')
])
model.build([None, IMAGE_SIZE, IMAGE_SIZE, 3])

optimizer = tf.keras.optimizers.Adam(lr=1e-3)
loss=tf.keras.losses.CategoricalCrossentropy()
metrics=tf.keras.metrics.CategoricalAccuracy()

model.compile(
  optimizer=optimizer,
  loss=loss,
  metrics=metrics
  )

model.fit(
  train_loader, 
  epochs=50,
  verbose=1,
  steps_per_epoch=len(train_loader),
  validation_data=valid_loader,
  validation_steps=len(valid_loader)
)

model.save('sticker_model')

final_loss, final_accuracy = model.evaluate(valid_loader, steps = len(valid_loader))
print("Final loss: {:.2f}".format(final_loss))
print("Final accuracy: {:.2f}%".format(final_accuracy * 100))


# Test
test_root=("C:/Users/Desktop/KUGODS/wonder/dataset/test")

generate_img_test= tf.keras.preprocessing.image.ImageDataGenerator(rescale=1. / 255)

test_loader = generate_img_test.flow_from_directory(
  test root,
  target_size=IMAGE_SHAPE
)

test_data=iter(test_loader)
for test_img,true_label in (test_loader):
  break
true_labels = np.argmax(true_label, axis=-1)
print(true_labels)
model_predictions = model.predict(test_data)
predicted_ids = np.argmax(model_predictions, axis=-1)
predicted_labels =labels[predicted_ids]
print(predicted_labels)


# Convert model to tflite
converter = tf.lite.TFLiteConverter.from_keras_model(model)
tflite_model = converter.convert()

# Save model as tflite
with open('model.tflite', 'wb') as f:
  f.write(tflite_model)
