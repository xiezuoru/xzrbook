import cv2
 # 打开摄像头，添加“cv2.CAP_DSHOW"参数是避免部分电脑出现报错警告
cap = cv2.VideoCapture(0, cv2.CAP_DSHOW)
while True:
    # 读取每一帧画面
    ret, frame = cap.read()

    # 如果拍下，显示画面
    if ret:
        cv2.imshow("Camera", frame)

    # 如果按下 q 键，退出循环
    if cv2.waitKey(1)&0xFF == ord('q'):
        break

# 释放摄像头
cap.release()

# 关闭显示
cv2.destroyAllWindows()