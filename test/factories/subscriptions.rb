FactoryBot.define do
  factory :subscription do
    profile { nil }
    feed { nil }
    notify { false }
    mute { false }
  end
end
