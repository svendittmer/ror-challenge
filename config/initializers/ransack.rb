Ransack.configure do |config|
  config.add_predicate 'gteq_euros',
                       arel_predicate: 'gteq',
                       formatter: proc { |v| v * 100 },
                       validator: proc { |v| v.present? },
                       type: :float

  config.add_predicate 'lteq_euros',
                       arel_predicate: 'lteq',
                       formatter: proc { |v| v * 100 },
                       validator: proc { |v| v.present? },
                       type: :float
end
