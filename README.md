[![CI](https://github.com/EnzoMarion/WorkflowGit/actions/workflows/ci.yml/badge.svg)](https://github.com/EnzoMarion/WorkflowGit/actions/workflows/ci.yml)
[![Quality gate](https://sonarcloud.io/api/project_badges/quality_gate?project=EnzoMarion_WorkflowGit)](https://sonarcloud.io/summary/new_code?id=EnzoMarion_WorkflowGit)
[![Docker pulls backend](https://img.shields.io/badge/GHCR-backend%20image-blue?logo=docker)](https://github.com/EnzoMarion/WorkflowGit/pkgs/container/cloudnative-backend)
[![Docker pulls frontend](https://img.shields.io/badge/GHCR-frontend%20image-blue?logo=docker)](https://github.com/EnzoMarion/WorkflowGit/pkgs/container/cloudnative-frontend)

# Gym Management System

A complete fullstack gym management application built with modern web technologies.

## Features

### User Features
- **User Dashboard**: View stats, billing, and recent bookings
- **Class Booking**: Book and cancel fitness classes
- **Subscription Management**: View subscription details and billing
- **Profile Management**: Update personal information

### Admin Features
- **Admin Dashboard**: Overview of gym statistics and revenue
- **User Management**: CRUD operations for users
- **Class Management**: Create, update, and delete fitness classes
- **Booking Management**: View and manage all bookings
- **Subscription Management**: Manage user subscriptions

### Business Logic
- **Capacity Management**: Classes have maximum capacity limits
- **Time Conflict Prevention**: Users cannot book overlapping classes
- **Cancellation Policy**: 2-hour cancellation policy (late cancellations become no-shows)
- **Billing System**: Dynamic pricing with no-show penalties
- **Subscription Types**: Standard (€30), Premium (€50), Student (€20)

## Tech Stack

### Backend
- **Node.js** with Express.js
- **Prisma** ORM with PostgreSQL
- **RESTful API** with proper error handling
- **MVC Architecture** with repositories pattern

### Frontend
- **Vue.js 3** with Composition API
- **Pinia** for state management
- **Vue Router** with navigation guards
- **Responsive CSS** styling

### DevOps
- **Docker** containerization
- **Docker Compose** for orchestration
- **PostgreSQL** database
- **Nginx** for frontend serving

## Quick Start

### Prerequisites
- Docker and Docker Compose
- Git

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd gym-management-system
   ```

2. **Set up environment variables**
   ```bash
   cp .env.example .env
   ```
   
   Edit `.env` file if needed (default values should work for development).

3. **Start the application**
   ```bash
   docker-compose up --build
   ```

4. **Access the application**
   - Frontend: http://localhost:8080
   - Backend API: http://localhost:3000
   - Database: localhost:5432

### Default Login Credentials

The application comes with seeded test data:

**Admin User:**
- Email: admin@gym.com
- Password: admin123
- Role: ADMIN

**Regular Users:**
- Email: john.doe@email.com
- Email: jane.smith@email.com  
- Email: mike.wilson@email.com
- Password: password123 (for all users)

## Project Structure

```
gym-management-system/
├── backend/
│   ├── src/
│   │   ├── controllers/     # Request handlers
│   │   ├── services/        # Business logic
│   │   ├── repositories/    # Data access layer
│   │   ├── routes/          # API routes
│   │   └── prisma/          # Database schema and client
│   ├── seed/                # Database seeding
│   └── Dockerfile
├── frontend/
│   ├── src/
│   │   ├── views/           # Vue components/pages
│   │   ├── services/        # API communication
│   │   ├── store/           # Pinia stores
│   │   └── router/          # Vue router
│   ├── Dockerfile
│   └── nginx.conf
└── docker-compose.yml
```

## API Endpoints

### Authentication
- `POST /api/auth/login` - User login

### Users
- `GET /api/users` - Get all users
- `GET /api/users/:id` - Get user by ID
- `POST /api/users` - Create user
- `PUT /api/users/:id` - Update user
- `DELETE /api/users/:id` - Delete user

### Classes
- `GET /api/classes` - Get all classes
- `GET /api/classes/:id` - Get class by ID
- `POST /api/classes` - Create class
- `PUT /api/classes/:id` - Update class
- `DELETE /api/classes/:id` - Delete class

### Bookings
- `GET /api/bookings` - Get all bookings
- `GET /api/bookings/user/:userId` - Get user bookings
- `POST /api/bookings` - Create booking
- `PUT /api/bookings/:id/cancel` - Cancel booking
- `DELETE /api/bookings/:id` - Delete booking

### Subscriptions
- `GET /api/subscriptions` - Get all subscriptions
- `GET /api/subscriptions/user/:userId` - Get user subscription
- `POST /api/subscriptions` - Create subscription
- `PUT /api/subscriptions/:id` - Update subscription

### Dashboard
- `GET /api/dashboard/user/:userId` - Get user dashboard
- `GET /api/dashboard/admin` - Get admin dashboard

## Development

### Local Development Setup

1. **Backend Development**
   ```bash
   cd backend
   npm install
   npm run dev
   ```

2. **Frontend Development**
   ```bash
   cd frontend
   npm install
   npm run dev
   ```

3. **Database Setup**
   ```bash
   cd backend
   npx prisma migrate dev
   npm run seed
   ```

### Database Management

- **View Database**: `npx prisma studio`
- **Reset Database**: `npx prisma db reset`
- **Generate Client**: `npx prisma generate`
- **Run Migrations**: `npx prisma migrate deploy`

### Useful Commands

```bash
# Stop all containers
docker-compose down

# View logs
docker-compose logs -f [service-name]

# Rebuild specific service
docker-compose up --build [service-name]

# Access database
docker exec -it gym_db psql -U postgres -d gym_management
```

## Features in Detail

### Subscription System
- **STANDARD**: €30/month, €5 per no-show
- **PREMIUM**: €50/month, €3 per no-show  
- **ETUDIANT**: €20/month, €7 per no-show

### Booking Rules
- Users can only book future classes
- Maximum capacity per class is enforced
- No double-booking at the same time slot
- 2-hour cancellation policy

### Admin Dashboard
- Total users and active subscriptions
- Booking statistics (confirmed, no-show, cancelled)
- Monthly revenue calculations
- User management tools

### User Dashboard
- Personal statistics and activity
- Current subscription details
- Monthly billing with no-show penalties
- Recent booking history

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests if applicable
5. Submit a pull request

## License

This project is licensed under the MIT License.

## Support

For support or questions, please open an issue in the repository.

## 🔧 Git Workflow & DevOps (TP1)

### Git rules

- Main branches: `main` (production) and `develop` (integration).
- Feature branches: `feature/<name>` (e.g. `feature/init-husky`).
- No direct commits on `main` or `develop`.
- All changes go through a Pull Request from a `feature/*` branch into `develop`.

### Commit convention

This project follows the **Conventional Commits** specification for all commit messages.  
Examples of valid messages:

- `feat: add authentication`
- `fix: fix postgres connection`
- `chore: update nestjs dependencies`

The allowed types include: `build`, `chore`, `ci`, `docs`, `feat`, `fix`, `perf`, `refactor`, `revert`, `style`, `test`.

### Git hooks (Husky)

The following Husky hooks are configured at the repository level:

- `pre-commit`
   - Runs a secrets scan (`npm run secrets:check` using gitleaks) to prevent leaking keys or tokens.
   - Runs the global lint (`npm run lint:all`), which calls the `lint` scripts in the frontend and backend.

- `commit-msg`
   - Validates the commit message format with Commitlint.
   - Rejects commits that do not follow the Conventional Commits convention.

- `pre-push`
   - Runs the frontend build (`npm run build:front`) and a minimal backend build check (`npm run build:back`).
   - Blocks the push if the project is unstable (failing build), to avoid pushing broken code to the remote repository.


## 🚀 Continuous Integration (CI)

This project uses continuous integration to validate every change on feature branches and pull requests targeting `develop`.

### CI pipeline

The `CI` workflow is composed of four jobs:

- **Job 1 – Lint (frontend & backend)**
    - `frontend`: `npm run lint`
    - `backend`: `npm run lint`

- **Job 2 – Build (frontend & backend)**
    - `frontend`: `npm run build`
    - `backend`: `npm run build`

- **Job 3 – Tests (backend)**
    - `backend`: `npm test`

- **Job 4 – SonarCloud (backend)**
    - Static code analysis of the backend sources
    - Uses the `SONAR_TOKEN` repository secret to authenticate against SonarCloud
    - SonarCloud **Quality Gate** is required to pass before merging into `develop`

All lint, build and test jobs run on the self-hosted Windows runner, while the SonarCloud analysis job runs on a GitHub-hosted Ubuntu runner (required for the container-based scanner).

# 📁 Part 4 – Docker & CI Usage

## 🚀 Running the application with Docker Compose

```bash
docker compose up --build
```

## 🌍 Accessible URLs

- Frontend: http://localhost:8080/login
- Backend API: http://localhost:3000/health
- PostgreSQL: Available locally inside Docker

## 🐳 Docker Images

- Backend: `ghcr.io/EnzoMarion/cloudnative-backend:latest`

- Frontend: `ghcr.io/EnzoMarion/cloudnative-frontend:latest`

## ⚙️ CI Pipeline Execution Conditions

- Requires a self-hosted runner
- Requires the following secrets:
    - CR_PAT (GitHub Container Registry access token)
    - SONAR_TOKEN (SonarCloud)

## 🔄 Déploiement local automatisé

Le projet dispose d’un déploiement **automatisé en local** piloté par GitHub Actions et un runner self‑hosted Windows.

### Fonctionnement du stage de déploiement

- Le pipeline CI suit la chaîne suivante :  
  `lint → build → test → Sonar → build images → push registry → deploy`.
- Quand les images Docker backend et frontend sont construites et poussées avec succès vers GitHub Container Registry (`ghcr.io`), un **stage de déploiement** est déclenché.
- Ce stage n’exécute pas directement les commandes Docker dans le workflow : toute la logique de déploiement est centralisée dans le script `scripts/deploy.ps1`.
- Le script :
    - arrête la stack Docker Compose courante (`docker compose down`) sans supprimer les volumes ;
    - supprime les anciens conteneurs `postgres`, `backend`, `frontend` s’ils existent encore ;
    - libère le port 3000 si un autre conteneur l’utilise ;
    - tire les images `cloudnative-backend` et `cloudnative-frontend` taggées avec le `GITHUB_SHA` du commit ;
    - redémarre toute la stack via `docker compose up -d`.

Le déploiement est **idempotent** : il peut être relancé autant de fois que nécessaire, la stack est mise à jour et les données Postgres sont conservées.

### Conditions nécessaires

Pour que le déploiement automatique fonctionne, il faut :

- **Un runner local actif**  
  Un runner GitHub Actions self‑hosted (Windows) configuré sur la machine qui héberge Docker.

- **Des secrets Docker configurés**  
  Le secret `CR_PAT` doit contenir un Personal Access Token GitHub avec les droits nécessaires pour pousser et tirer des images sur GitHub Container Registry.

- **Un accès au registre distant**  
  Le runner doit pouvoir se connecter à `ghcr.io` pour tirer les images backend et frontend taggées avec le SHA du commit.

### Branches avec déploiement actif

Dans le cadre de ce TP, le déploiement automatique est actif **uniquement sur la branche** :

- `feature/cd-deployment`

Les autres branches déclenchent la CI (lint / build / tests / Sonar), mais **ne lancent pas** le stage de déploiement Docker Compose.

## 🔵🟢 Blue/Green Deployment (TP5)

This project implements a **Blue/Green deployment strategy** using Docker, Docker Compose and an **Nginx reverse proxy** to allow zero-downtime deployments and instant rollback.

---

## 📌 Principle

Blue/Green deployment means running **two identical production environments** side by side:

- **Blue** → current live version (serving users)
- **Green** → new candidate version (being deployed and tested)

At any time, only **one color is exposed to users**, but both stacks can exist at the same time.

This allows:
- Deploying a new version **without stopping the current one**
- Switching traffic instantly
- Rolling back in seconds if something goes wrong

---

## 🌐 Role of the Reverse Proxy

The **Nginx reverse proxy** is the single entry point for users.

It:
- Listens on `http://localhost`
- Routes:
    - `/` → active frontend (blue or green)
    - `/api/*` → active backend (blue or green)

The client never knows if it is talking to blue or green.  
Only the proxy decides which color is active.

[Client] --> [Reverse Proxy] --> [Frontend Blue] (active)
-> [Frontend Green] (candidate)

[Client] --> [Reverse Proxy] --> [Backend Blue] (active)
-> [Backend Green] (candidate)

Switching versions is done by **changing the proxy configuration**, not by stopping containers.

---

## 🧱 Architecture

The system runs:

- One shared **PostgreSQL**
- One **reverse proxy**
- Two versions of the app:
    - `frontend-blue` + `backend-blue`
    - `frontend-green` + `backend-green`

Both blue and green connect to the same database.

---

## 🔄 Deployment Workflow

A typical Blue/Green deployment works like this:

### 1️⃣ Build & push images
The CI pipeline:
- Builds the frontend and backend Docker images
- Tags them with the commit SHA
- Pushes them to GitHub Container Registry (`ghcr.io`)

---

### 2️⃣ Deploy on the inactive color

If **blue is currently live**, the pipeline deploys the new images on **green**:

- `backend-green`
- `frontend-green`

The green stack is started **without stopping blue**.

At this point:
- Blue = production
- Green = new version to validate

Health checks and manual tests can be done on green.

---

### 3️⃣ Switch the reverse proxy

Once green is validated, the pipeline updates the reverse proxy so that:

- `/` → `frontend-green`
- `/api/*` → `backend-green`

From the user’s point of view, the switch is **instantaneous**.

Only the reverse proxy configuration is changed; the blue and green containers stay running, only the proxy is reloaded.

---

### 4️⃣ Rollback capability

If a problem is detected:

The proxy is switched back to **blue**.

Because blue is still running:
- No rebuild
- No redeploy
- No downtime

Rollback takes only a few seconds.

---

## ⚙️ Automation in CI

The Blue/Green logic is fully automated by the **local GitHub Actions runner**.

- A dedicated **blue-green-deploy stage** runs only on the deployment branch  
  (for example: `main` or `feature/cd-deployment`)
- Feature branches run CI but **cannot switch production**

The deployment script:
1. Detects the **currently active color**
2. Deploys the new images on the **other color**
3. Updates the reverse proxy configuration
4. Reloads Nginx
5. Keeps the previous color available for rollback

The active color is stored in a shared configuration file used by the proxy and the deployment script.

---

## 🧪 Why this is safe

This strategy guarantees that:

- A new version is never exposed to users before being deployed
- The old version is always available
- Switching and rollback are fast and reliable
- The database is preserved

This makes the deployment:
- **Idempotent**
- **Zero-downtime**
- **Production-grade**

---

## 📝 Example summary

> The `blue-green-deploy` job runs only on the deployment branch.  
> It deploys the new images on the inactive color, then updates the reverse proxy to route all traffic to this color.  
> If something goes wrong, the job can be re-run with the previous color to perform an immediate rollback.