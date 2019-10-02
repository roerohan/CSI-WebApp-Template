from django.shortcuts import render, HttpResponse

# Create your views here.
def login(request):
    numbers=[1,2,3,4]
    name='Vaishnavi Nandakumar'
    args={'myname':name, 'numbers':numbers}
    return render(request,'account/login.html',args)

def home(request):
    return render(request,'account/home.html')

