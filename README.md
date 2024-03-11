# docker-vue-sample

> Example of Dockerizing Vue Application

## Project Structure

```txt
.
├── ...
├── src
│   ├── ...
│   ├── App.vue
│   └── main.ts
├── .dockerignore
├── ...
├── compose.development.yaml
├── compose.production.yaml
├── ...
├── Dockerfile
├── ...
├── Makefile
├── nginx.conf
└── ...
```

## App Development

### Start the Development Container

```sh
make dev-start
```

### Stop the Development Container

```sh
make dev-stop
```

### Start the Production Container

```sh
make prod-start
```

### Stop the Production Container

```sh
make prod-stop
```

## Project Setup

```sh
npm install
```

### Compile and Hot-Reload for Development

```sh
npm run dev
```

### Type-Check, Compile and Minify for Production

```sh
npm run build
```

### Run Unit Tests with [Vitest](https://vitest.dev/)

```sh
npm run test:unit
```

### Run End-to-End Tests with [Cypress](https://www.cypress.io/)

```sh
npm run test:e2e:dev
```

Or test the production build with `test:e2e` before deploying (e.g. in CI environments):

```sh
npm run build
npm run test:e2e
```

### Lint with [ESLint](https://eslint.org/)

```sh
npm run lint
```

## Customize configuration

See [Vite Configuration Reference](https://vitejs.dev/config/).