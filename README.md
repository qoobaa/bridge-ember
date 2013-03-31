## Bridge

http://bridge.jah.pl

### Tests

To run app tests

```
foreman run rake test konacha:run
```

To run js tests only

```
foreman run rake konacha:run
```

To run server with js tests http://localhost:3500/

```
foreman run rake konacha:serve
```

http://visionmedia.github.com/mocha/

http://chaijs.com/api/assert/


### Deployment

```
cap deploy
```

### Development

Copy and customize db config

```
cp config/database.yml.example config/database.yml
```

Install PostgreSQL, Redis, node.js

```
bundle install
foreman run rake db:setup
cd socket && npm install && cd ..
foreman start
```
