import requests

url="http://127.0.0.1:8080"
url=url+"/real_ans"
data={
    'stu':'STU001',
    'ans':'D'
    }
result=requests.get(url=url,data=data)
print(str(result.text))
