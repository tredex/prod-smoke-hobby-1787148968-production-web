FROM node:18-alpine

WORKDIR /app

# Copy package files
COPY package*.json ./

# Install dependencies
RUN npm install --production

# Copy source code
COPY . .

# Build the app
RUN npm run build

# Install serve to run the production build
RUN npm install -g serve

# Port is configurable via PORT env var (default 3000).
# Shell-form CMD is required so the variable expands at runtime.
ENV PORT=3000
EXPOSE 3000

CMD serve -s build -l ${PORT}
