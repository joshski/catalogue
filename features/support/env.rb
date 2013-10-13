require 'cappie'

driver = :selenium

module WaitsForClientReady
  def visit(url)
    result = super
    page.should have_css("body.client-ready")
    result
  end
end

if ENV["MECHANIZE"] == "true"
  require 'capybara/mechanize'
  driver = :mechanize
  Capybara.app = true
else
  World(WaitsForClientReady)
end

Cappie.start(
  command: './node_modules/.bin/pogo ./app/server.pogo',
  await: /listening at 4647/,
  host: 'http://localhost:4647',
  driver: driver,
  environment: { PORT: '4647' }
)