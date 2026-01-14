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
