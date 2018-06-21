RSpec::Matchers.define :have_attached_file do |name|
  match do |record|
    file = record.send(name)
    file.respond_to?(:attach)
  end
end
