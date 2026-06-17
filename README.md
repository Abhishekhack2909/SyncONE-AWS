# SyncONE-AWS

A real-time collaborative application featuring a **Vite Frontend** and a **Node.js/Express Backend** powered by `y-socket.io` for collaborative editing. The project is fully containerized using a multi-stage Docker setup optimized for AWS deployment.

---

## 🚀 Quick Start with Docker

The application is configured with a multi-stage Dockerfile that builds the frontend assets, embeds them into the backend service, and exposes the application on port `3000`.

### 1. Build the Docker Image
```bash
docker build -t sync-one .
```

### 2. Run the Container
```bash
docker run -p 3000:3000 sync-one
```
Access the application at `http://localhost:3000`.

---

## ☁️ AWS Deployment Guide

This containerized application can be deployed to AWS using several services:

### Option A: AWS App Runner (Recommended for Simplicity)
1. Push your Docker image to **Amazon ECR (Elastic Container Registry)**.
2. Create an **App Runner Service** pointing to your ECR repository.
3. Configure the service port to `3000`.
4. App Runner will handle automatic scaling, TLS/SSL termination, and load balancing.

### Option B: Amazon ECS (Elastic Container Service) on AWS Fargate
1. Push the Docker image to **Amazon ECR**.
2. Create an **ECS Task Definition** specifying port `3000`.
3. Launch the service using **Fargate** (serverless container hosting).
4. Configure an **Application Load Balancer (ALB)** to route public traffic (HTTP/HTTPS) to the target group on port `3000`. Keep in mind that WebSockets require stickiness/long-lived connections.

---

## 🛠️ Project Structure

```
.
├── Backend/                 # Express Server & Socket.io logic
│   ├── server.js            # Main server entrypoint (Port 3000)
│   └── package.json
├── Frontend/                # React/Vite web application
│   ├── vite-project/        # Source code for the frontend
│   └── package.json
├── Dockerfile               # Multi-stage build for Prod
└── README.md                # documentation
```

---

## 🔌 API & Endpoints

- **`/`**: Serves the built Frontend single-page app (SPA).
- **`/health`**: Returns `{ "message": "Server is healthy", "success": true }` (ideal for AWS target group health checks).
- **WebSockets**: Handled at the root level via `y-socket.io` for real-time collaboration.
