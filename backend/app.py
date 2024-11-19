from flask import Flask, jsonify, request
from flask_cors import CORS
import uuid

app = Flask(__name__)
CORS(app)

# In-memory storage for todos (replace with database in production)
todos = []

@app.route('/api/hello')
def hello():
    return jsonify({"message": "Hello from backend!"})

@app.route('/api/todos', methods=['GET'])
def get_todos():
    return jsonify(todos)

@app.route('/api/todos', methods=['POST'])
def add_todo():
    data = request.get_json()
    todo = {
        'id': str(uuid.uuid4()),
        'text': data.get('text'),
        'completed': False
    }
    todos.append(todo)
    return jsonify(todo), 201

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8080)
