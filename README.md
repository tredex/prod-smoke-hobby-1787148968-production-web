# web



## Getting Started

This is a React application bootstrapped for the Stelm MVP platform.

### Development

```bash
npm install
npm start
```

The app will run on [http://localhost:3000](http://localhost:3000).

### Build

```bash
npm run build
```

Builds the app for production to the `build` folder.

### Docker

```bash
docker build -t tredex/prod-smoke-hobby-1787148968-production-web .
docker run -p 3000:3000 tredex/prod-smoke-hobby-1787148968-production-web
```

## Project Structure

```
src/
  ├── App.js          # Main application component
  ├── App.css         # Application styles
  ├── index.js        # Entry point
  └── index.css       # Global styles
public/
  └── index.html      # HTML template
```

## Database

When your webapp is connected to a Stelm **Database** component, Stelm injects `DATABASE_URL` at
runtime. Stelm creates an **empty** database — you define tables and migrations in this repo.

Example migration script (`scripts/migrate.js`) you can run locally or from a CI step **you add**:

```javascript
const { Client } = require('pg');

async function main() {
  const client = new Client({ connectionString: process.env.DATABASE_URL });
  await client.connect();
  await client.query(`
    CREATE TABLE IF NOT EXISTS items (
      id SERIAL PRIMARY KEY,
      name TEXT NOT NULL
    );
  `);
  await client.end();
}

main().catch((err) => {
  console.error(err);
  process.exit(1);
});
```

Example GitHub Actions step (add to `.github/workflows/ci.yml` yourself — Stelm does not run this):

```yaml
- name: Run migrations
  env:
    DATABASE_URL: ${{ secrets.DATABASE_URL }}
  run: node scripts/migrate.js
```

See [Stelm database migrations guide](https://app.stelm.dev/app/docs/database-migrations).

## Learn More

- [React Documentation](https://reactjs.org/)
- [Create React App Documentation](https://create-react-app.dev/)
