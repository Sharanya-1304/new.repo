const express = require('express');
const app = express();
const PORT = process.env.PORT || 3000;

// Middleware
app.use(express.json());
app.use(express.urlencoded({ extended: true }));

// Routes
app.get('/', (req, res) => {
  res.send(`
    <!DOCTYPE html>
    <html>
    <head>
      <title>My App Deployed with Chef & Jenkins</title>
      <style>
        body {
          font-family: Arial, sans-serif;
          max-width: 800px;
          margin: 50px auto;
          padding: 20px;
          background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
          color: white;
        }
        .container {
          background: rgba(255, 255, 255, 0.1);
          padding: 40px;
          border-radius: 10px;
          backdrop-filter: blur(10px);
        }
        h1 {
          text-align: center;
          margin-bottom: 30px;
        }
        .info {
          background: rgba(255, 255, 255, 0.2);
          padding: 20px;
          border-radius: 5px;
          margin-top: 20px;
        }
      </style>
    </head>
    <body>
      <div class="container">
        <h1>🚀 Application Successfully Deployed!</h1>
        <div class="info">
          <h2>Deployment Details:</h2>
          <ul>
            <li><strong>Deployed with:</strong> Chef & Jenkins CI/CD Pipeline</li>
            <li><strong>Server:</strong> Node.js + Express</li>
            <li><strong>Port:</strong> ${PORT}</li>
            <li><strong>Status:</strong> Running ✅</li>
          </ul>
        </div>
      </div>
    </body>
    </html>
  `);
});

app.get('/api/health', (req, res) => {
  res.json({
    status: 'healthy',
    timestamp: new Date().toISOString(),
    uptime: process.uptime()
  });
});

app.get('/api/info', (req, res) => {
  res.json({
    app: 'My Sample App',
    version: '1.0.0',
    deployment: 'Chef + Jenkins',
    nodeVersion: process.version
  });
});

// Start server
app.listen(PORT, () => {
  console.log(`Server is running on http://localhost:${PORT}`);
  console.log(`Health check: http://localhost:${PORT}/api/health`);
  console.log(`App info: http://localhost:${PORT}/api/info`);
});
