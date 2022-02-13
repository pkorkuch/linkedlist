# Configure RSpec so FactoryBot methods don't need to be prefixed
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
end
