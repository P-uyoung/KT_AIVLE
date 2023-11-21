from django.db import models

# Create your models here.
class Post(models.Model):
    title = models.CharField(max_length=250)
    body = models.TextField()
    
    # (디폴트) 앱명_모델명 소문자
    
    def __str__(self):
        return self.title

# 모델 관계 설정
class Comment(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE)  # Post 모델과 1:N 관계 설정
    author = models.CharField(max_length=20)
    message = models.TextField()
    created = models.DateField(auto_now_add=True)  # 최초 저장 시점의 시간 저장
    updated = models.DateTimeField(auto_now=True)  # 객체 저장 시점의 시간 저장
    