from django.http import HttpResponse
from django.shortcuts import render
from django.views import View

def dummy(request):
    return HttpResponse("Hello, world. You suck.")

class homepage(View):
    context = {}
    template_name = 'base.html'

    def get(self, request):
        return render(request, self.template_name, self.context)

