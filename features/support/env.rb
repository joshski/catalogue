require 'cappie'

Cappie.start(
  command: './node_modules/.bin/pogo server.pogo',
  await: /listening at 4647/,
  host: 'http://localhost:4647',
  driver: :selenium,
  environment: { PORT: '4647' }
)