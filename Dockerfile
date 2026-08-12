# syntax=docker/dockerfile:1

# ==============================
# Stage 1: Build
# ==============================
FROM node:22-alpine AS builder

WORKDIR /app

# Copy dependency files first
COPY package*.json ./

# Cache npm packages between Docker builds
RUN --mount=type=cache,target=/root/.npm \
    npm ci

# Copy application source
COPY . .

# Build application
RUN npm run build


# ==============================
# Stage 2: Runtime
# ==============================
FROM node:22-alpine AS runtime

WORKDIR /app

ENV NODE_ENV=production

# Copy dependency files
COPY package*.json ./

# Install production dependencies only
RUN --mount=type=cache,target=/root/.npm \
    npm ci --omit=dev

# Copy build output
COPY --from=builder /app/dist ./dist

EXPOSE 3000

CMD ["node", "dist/index.js"]
