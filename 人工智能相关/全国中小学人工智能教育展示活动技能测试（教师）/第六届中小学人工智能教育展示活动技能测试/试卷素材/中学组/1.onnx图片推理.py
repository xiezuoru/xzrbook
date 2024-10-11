import cv2
import BaseDeploy as bd
model_path = 'det.onnx'
img = 'cat_dog1.jpg'
model = bd(model_path)
result = model.inference(img)
print(result)       