from flask import Flask, render_template, request
import subprocess
import time

app = Flask(__name__)

@app.route("/", methods=["GET", "POST"])
def index():

    if request.method == "POST":

        income = request.form["income"]
        rent = request.form["rent"]
        food = request.form["food"]
        travel = request.form["travel"]
        other = request.form["other"]

        # Run Octave script
        command = f'octave --eval "finance_project({income},{rent},{food},{travel},{other})"'
        subprocess.run(command, shell=True)

        suggestions = ""

        try:
            with open("static/suggestions.txt") as f:
                suggestions = f.read()
        except:
            suggestions = "No suggestions available."

        return render_template(
            "index.html",
            show_graphs=True,
            suggestions=suggestions,
            time=time.time()
        )

    return render_template(
        "index.html",
        show_graphs=False,
        suggestions="",
        time=time.time()
    )

if __name__ == "__main__":
    app.run(debug=True)