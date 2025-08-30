import newrelic.agent
import os
import logging

from flask import Flask, request
import requests


app = Flask(__name__)

logger = logging.getLogger(__name__)
logger.setLevel(logging.WARNING)


@newrelic.agent.function_trace()
def foo_wiki():
    requests.get("https://www.wikipedia.org/")
    requests.get("https://en.wikipedia.org/wiki/Catan")


@newrelic.agent.function_trace()
def foo_weather():
    requests.get("https://www.weather.com/")


@app.route("/")
def hello_world():
    #logger.warning("This is a warning inside / endpoint")
    requests.get("https://www.wikipedia.org/")
    foo_wiki()
    requests.get("http://app2:5000/end?type=wiki")
    requests.get("http://app2:5000/end?type=weather")
    return "<p>Hello, World!</p>"

@app.route("/end")
def end():
    _type = request.args.get('type')
    if _type == "wiki":
        foo_wiki()
    else:
        foo_weather()
    return "<p>Hello, World!</p>"
