from flask import jsonify, make_response

# message = {
#     "message": "It works.",
# }


class ResponseManager:
    def __init__(self):
        self.success_status_code = 200
        self.error_status_code = 503

    def response(self, message, status_code=200):
        return make_response(jsonify(message)), status_code

    def success(self, message):
        return make_response(jsonify(message)), self.success_status_code

    def error(self, message):
        return make_response(jsonify(message)), self.error_status_code
