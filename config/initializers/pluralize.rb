module ActionView
  module Helpers
    module TextHelper

      def pluralize(count, singular, plural = nil)
      "#{count || 0} " + ([0, 1, '0', '1'].include?(count) ? singular : (plural || singular.pluralize))
      end

    end
  end
end
