# allow_mass_assignment_of matcher
# Extracted from Shoulda
# Works with Mongoid

module RSpec
  module Matchers

    # Ensures that the attribute can be set on mass update.
    #
    #   it { should_not allow_mass_assignment_of(:password) }
    #   it { should allow_mass_assignment_of(:first_name) }
    #
    def allow_mass_assignment_of(value)
      AllowMassAssignmentOfMatcher.new(value)
    end

    class AllowMassAssignmentOfMatcher # :nodoc:

      def initialize(attribute)
        @attribute = attribute.to_s
      end

      def matches?(subject)
        @subject = subject
        if attr_mass_assignable?
          if whitelisting?
            @failure_message = "#{@attribute} was made accessible"
          else
            if protected_attributes.empty?
              @negative_failure_message = "no attributes were protected"
            else
              @failure_message = "#{class_name} is protecting " <<
                "#{protected_attributes.to_a.to_sentence}, " <<
                "but not #{@attribute}."
            end
          end
          true
        else
          if whitelisting?
            @negative_failure_message =
              "Expected #{@attribute} to be accessible"
          else
            @negative_failure_message =
              "Did not expect #{@attribute} to be protected"
          end
          false
        end
      end

      attr_reader :failure_message, :negative_failure_message

      def description
        "allow mass assignment of #{@attribute}"
      end

      private

      def protected_attributes
        @protected_attributes ||= (@subject.class.protected_attributes || [])
      end

      def accessible_attributes
        @accessible_attributes ||= (@subject.class.accessible_attributes || [])
      end

      def whitelisting?
        !accessible_attributes.empty?
      end

      def attr_mass_assignable?
        if whitelisting?
          accessible_attributes.include?(@attribute)
        else
          !protected_attributes.include?(@attribute)
        end
      end

      def class_name
        @subject.class.name
      end

    end

  end # module Matchers
end # module RSpec

#module RSpec
#  module Matchers
#    class AllowMassAssignmentOf # :nodoc:
#      def initialize hash = nil
#        raise if hash.nil?
#        raise unless hash.kind_of? Hash
#        raise unless hash.length > 0
#        @attributes = hash
#      end

#      def matches? model
#        old = {}
#        @attributes.each do |key, val|
#          current = model.send(key.to_s)
#          raise if val == current
#          old[key] = current
#        end
#        model.update_attributes(@attributes)
#        @attributes.keys.all? do |key|
#          model.send(key.to_s) != old[key]
#        end
#      end

#      def failure_message
#        "expected mass assignment to #{self.keys_as_string} to succeed but it did not"
#      end

#      def negative_failure_message
#        "expected mass assignment to #{self.keys_as_string} to fail but it did not"
#      end

#      def description
#        "allow mass assignment to #{self.keys_as_string}"
#      end

#      def keys_as_string
#        @attributes.keys.join(', ')
#      end
#    end # class AllowMassAssignmentFor

#    def allow_mass_assignment_of hash = nil
#      AllowMassAssignmentOf.new hash
#    end
#  end # module Matchers
#end # module RSpec

