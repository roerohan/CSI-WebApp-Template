from django.urls import path
from django.conf.urls import url
from . import views
from django.contrib.auth.views import LoginView


urlpatterns = [

    path('', views.home),
    path('login/', LoginView.as_view(template_name='account/login.html')),
]
