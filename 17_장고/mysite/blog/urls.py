from django.urls import path
from . import views

urlpatterns = [
    path('', views.list),   # 웹브라우저에서 http://localhost:8000/blog/ 요청할 때
    path('<int:id>/', views.detail), 
    path('test1/', views.test1),
    path('test2/<int:no>/', views.test2),
]
