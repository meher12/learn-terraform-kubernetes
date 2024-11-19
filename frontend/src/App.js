import React, { useState, useEffect } from 'react';
import axios from 'axios';
import './App.css';

function App() {
  const [message, setMessage] = useState('Loading...');
  const [error, setError] = useState('');
  const [todos, setTodos] = useState([]);
  const [newTodo, setNewTodo] = useState('');

  const API_URL = process.env.REACT_APP_API_URL || '';

  useEffect(() => {
    fetchMessage();
    fetchTodos();
  }, []);

  const fetchMessage = async () => {
    try {
      const response = await axios.get(`${API_URL}/api/hello`);
      setMessage(response.data.message);
    } catch (err) {
      setError('Failed to fetch message from backend');
      console.error('Error:', err);
    }
  };

  const fetchTodos = async () => {
    try {
      const response = await axios.get(`${API_URL}/api/todos`);
      setTodos(response.data);
    } catch (err) {
      console.error('Error fetching todos:', err);
    }
  };

  const addTodo = async (e) => {
    e.preventDefault();
    if (!newTodo.trim()) return;
    try {
      await axios.post(`${API_URL}/api/todos`, { text: newTodo });
      setNewTodo('');
      fetchTodos();
    } catch (err) {
      console.error('Error adding todo:', err);
    }
  };

  return (
    <div className="App">
      <header className="App-header">
        <h1>Frontend + Backend Demo</h1>
        <div className="message-box">
          <h2>Message from Backend:</h2>
          {error ? (
            <p className="error">{error}</p>
          ) : (
            <p className="message">{message}</p>
          )}
        </div>
        <div className="todo-section">
          <h2>Todo List</h2>
          <form onSubmit={addTodo} className="todo-form">
            <input
              type="text"
              value={newTodo}
              onChange={(e) => setNewTodo(e.target.value)}
              placeholder="Add new todo"
              className="todo-input"
            />
            <button type="submit" className="add-button">Add</button>
          </form>
          <ul className="todo-list">
            {todos.map((todo) => (
              <li key={todo.id} className="todo-item">
                {todo.text}
              </li>
            ))}
          </ul>
        </div>
      </header>
    </div>
  );
}

export default App;
