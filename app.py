from flask import Flask

app = Flask(__name__)

@app.route("/")
def home():
    return """
    <h1>Welcome to My AWS Docker Web Application!<h1>
    <p>Successfully running a Python application.</p>
    <p>Deplyoed using Docker on AWS EC2.</p>
    """

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)