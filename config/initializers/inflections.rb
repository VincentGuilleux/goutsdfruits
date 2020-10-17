# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# On ne précise pas ici de paramètre de langue (:fr) car la méthode pluralize par défaut de Rails est override sur cette application par la méthode pluralize.rb qui ne prend pas en argument de locale.
ActiveSupport::Inflector.inflections do |inflect|
  inflect.plural 'bocal', 'bocaux'
end
