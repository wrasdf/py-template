from flask import Flask
from app.services.res_manager import ResponseManager

app = Flask("py-app")
responseManager = ResponseManager()

@app.after_request
def add_header(response):
    response.headers["Access-Control-Allow-Origin"] = "*"
    response.headers["Content-Type"] = "application/json"
    return response

@app.route("/", methods=["GET"])
def home():
    return '''<h1>PY Template App</h1><p>Practice in local.</p>'''

@app.route("/v1/healthz", methods=["GET"])
def check_healthz():
    return responseManager.success({"msg": "It works."})

@app.route("/v1/failed", methods=["GET"])
def check_failed():
    return responseManager.error({"msg": "Server Failed"})
