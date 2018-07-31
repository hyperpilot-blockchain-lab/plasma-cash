from flask import Blueprint, jsonify, request

from dependency_config import container

bp = Blueprint('api', __name__)