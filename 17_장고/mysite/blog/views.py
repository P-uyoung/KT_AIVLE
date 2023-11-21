from django.shortcuts import render
from django.http import HttpResponse  # Response의 status code 200으로 지정

# Create your views here.
def test1(request):
    return HttpResponse("hello world")  # body에 응답정보를 직접 내용을 넣음

def test2(request, no):
    print(type(no))
    return HttpResponse(no)  # path 변수를 받아서 출력