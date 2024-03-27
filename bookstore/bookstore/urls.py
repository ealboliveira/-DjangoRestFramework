from django.contrib import admin
from django.urls import path
from .views import update_server_view  # Importe a função de visualização necessária

urlpatterns = [
    path('admin/', admin.site.urls),
    path('update_server/', update_server_view, name='update_server'),  # Nova rota
]
