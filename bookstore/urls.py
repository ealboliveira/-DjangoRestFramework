from django.urls import include, path, re_path
from django.contrib import admin
from rest_framework.authtoken.views import obtain_auth_token
from . import views

urlpatterns = [
    path("admin/", admin.site.urls),
    re_path("bookstore/order/(?P<version>(v1|v2))/", include("order.urls")),
    re_path("bookstore/product/(?P<version>(v1|v2))/", include("product.urls")),
    path("api-token-auth/", obtain_auth_token, name="api_token_auth"),
    path("update_server/", views.update, name="update"),
    path("hello/", views.hello_world, name="hello_world"),
]
