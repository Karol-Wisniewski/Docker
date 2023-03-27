import flask

app = flask.Flask(__name__)
app.config["DEBUG"] = True


@app.route('/', methods=['GET'])
def home():
    return "Hello from flask!"

if __name__ == '__main__':
    app.run(host='0.0.0.0')