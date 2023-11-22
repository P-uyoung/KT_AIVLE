from django.db import models

"""1:N 관계 설정 : Post 모델과 Comment 모델"""
# Create your models here.
class Post(models.Model):
    title = models.CharField(max_length=250)
    body = models.TextField()
    tag = models.ManyToManyField('Tag', null=True, blank=True)
    
    # (디폴트) 앱명_모델명 소문자
    
    def __str__(self):
        return self.title

# 모델 관계 설정
class Comment(models.Model):
    post = models.ForeignKey(Post, on_delete=models.CASCADE,  # Post 모델과 1:N 관계 설정
                                                              # (필수 옵션 설정) 연관된 데이터 삭제 시 CASCADE 옵션으로 연관된 데이터도 삭제
                             related_name='comments')  # 모델 관계설정 이름 재정의
                            # 데이터베이스 스키마에 직접적인 영향을 미치는 변경 사항은 아니므로, 
                            # 데이터베이스 마이그레이션 없이도 Django ORM 내에서 즉시 반영됨.
    author = models.CharField(max_length=20)
    message = models.TextField()
    created = models.DateField(auto_now_add=True)  # 최초 저장 시점의 시간 저장
    updated = models.DateTimeField(auto_now=True)  # 객체 저장 시점의 시간 저장
    
    
"""1:1 관계 설정 : User 모델과 Profile 모델"""
class User(models.Model):
    name = models.CharField(max_length=50)
    
    def __str__(self):
        return self.name
    
class Profle(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE)
    phone_number = models.CharField(max_length=20)
    address = models.CharField(max_length=50)


"""N:M 관계 설정 : Post 모델과 Tag 모델"""
class Tag(models.Model):
    name = models.CharField(max_length=50, unique=True)
    
    def __str__(self):
        return self.name
    