require 'cappie'

driver = :selenium

if ENV["MECHANIZE"] == "true"
  require 'capybara/mechanize'
  driver = :mechanize
  Capybara.app = true
end

Cappie.start(
  command: './node_modules/.bin/pogo server.pogo',
  await: /listening at 4647/,
  host: 'http://localhost:4647',
  driver: driver,
  environment: { PORT: '4647' }
)