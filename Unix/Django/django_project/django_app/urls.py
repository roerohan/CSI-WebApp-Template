from django.contrib.auth.views import LoginView, LogoutView
from django.urls import path

from . import views

urlpatterns = [
    path('', views.dashboard, name='dashboard'),
    path('login/', views.login_user, name='login'),
    path('logout/', views.logout_then_login, name='logout'),
    path('register/', views.register, name='register'),
]
