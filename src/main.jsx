// src/main.jsx
import React from 'react'
import ReactDOM from 'react-dom/client'
import AppRouter from './AppRouter'
import ErrorBoundary from './components/ErrorBoundary'
import './App.css'

ReactDOM.createRoot(document.getElementById('root')).render(
  <React.StrictMode>
    <ErrorBoundary>
      <AppRouter />
    </ErrorBoundary>
  </React.StrictMode>,
)