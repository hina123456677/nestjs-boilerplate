# Build stage
FROM node:20-alpine AS builder
WORKDIR /app

# Install all dependencies for build
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Remove dev dependencies to keep only production ones
RUN npm prune --production

# Production stage
FROM node:20-alpine
WORKDIR /app

# Copy built code + production dependencies from builder
COPY --from=builder /app/dist ./dist
COPY --from=builder /app/node_modules ./node_modules
COPY --from=builder /app/package*.json ./
CMD ["node", "dist/main.js"]