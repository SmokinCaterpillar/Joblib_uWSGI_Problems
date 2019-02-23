"""Minimal flask application."""
from math import sqrt

from flask import Flask, jsonify
import joblib

app = Flask(__name__)


def compute():
    joblib.Parallel(n_jobs=4)(joblib.delayed(sqrt)(i ** 2) for i in range(10))


@app.route('/')
def hello_joblib():
    compute()
    return jsonify({"Hello joblib": joblib.__version__})
