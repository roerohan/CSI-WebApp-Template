from django.conf import settings
from django.contrib import messages
from django.contrib.auth import REDIRECT_FIELD_NAME, authenticate
from django.contrib.auth import login as auth_login
from django.contrib.auth import logout as auth_logout
from django.contrib.auth.decorators import login_required
from django.http import HttpResponseRedirect
from django.shortcuts import redirect, render, resolve_url
from django.urls import reverse


def login_user(request):
    auth_logout(request)
    username = password = ""
    if request.POST:
        username = request.POST["username"]
        password = request.POST["password"]
        user = authenticate(username=username, password=password)
        if user is not None:
            if user.is_active:
                auth_login(request, user)
                return HttpResponseRedirect("/")
        else:
            messages.warning(request, "Invalid Credentials!")
    return render(request, "core/login.html")


@login_required
def dashboard(request):
    return render(request, "core/in.html")


def logout(
    request,
    next_page=None,
    template_name="core/login.html",
    redirect_field_name=REDIRECT_FIELD_NAME,
    current_app=None,
    extra_context=None,
):
    auth_logout(request)
    return redirect(reverse("login"))


def logout_then_login(
    request, login_url="core/in.html", current_app=None, extra_context=None
):
    """
    Logs out the user if they are logged in. Then redirects to the log-in page.
    """
    if not login_url:
        login_url = settings.LOGIN_URL
    login_url = resolve_url("core/in.html")
    return logout(
        request, login_url, current_app=current_app, extra_context=extra_context
    )
