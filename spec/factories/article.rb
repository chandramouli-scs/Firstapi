FactoryBot.define do
	factory :article do
		name {FFaker::Name.name}
		description {FFaker::Name.name}
	end
end