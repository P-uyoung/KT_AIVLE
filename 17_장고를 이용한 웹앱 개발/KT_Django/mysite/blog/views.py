from django.shortcuts import render
from django.http import HttpResponse  # Response의 status code 200으로 지정
from django.shortcuts import get_object_or_404
from .models import *

# Create your views here.
def test1(request):
    # 서비스 구현
    return HttpResponse("hello world")  # body에 응답정보를 직접 내용을 넣음

def test2(request, no):
    print(type(no))
    return HttpResponse(no)  # path 변수를 받아서 출력

# 전체 목록 조회 서비스
def list(request):
    # 서비스 처리
    post_all = Post.objects.all()  # select * from post
    return HttpResponse(post_all)

# 상세 보기 (get) 
# status code 404 예외처리 (87p)
def detail(request, id):
    # post = Post.objects.get(id=id)  # 없으면 프로그램 강제 종료됨
    post = get_object_or_404(Post, id=id)  # 없으면 404 예외처리
    return HttpResponse(post.title)