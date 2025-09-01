module Joinable
    extend ActiveSupport::Concern
  
    class_methods do
      # Example: joinable_with :users
      def joinable_with(assoc_name)
        define_method(:member?) do |record|
          public_send(assoc_name).exists?(record.id)
        end
  
        define_method(:join!) do |record|
          assoc = public_send(assoc_name)
          assoc << record unless assoc.exists?(record.id)
          self
        end
  
        define_method(:leave!) do |record|
          public_send(assoc_name).delete(record)
          self
        end
  
        define_method(:toggle_membership!) do |record|
          if public_send(:member?, record)
            public_send(:leave!, record)
          else
            public_send(:join!, record)
          end
        end
      end
    end
  end
  