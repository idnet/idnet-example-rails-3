# Patch for https://www.ruby-lang.org/en/news/2014/03/10/regression-of-hash-reject-in-ruby-2-1-1/
if RUBY_VERSION == '2.1.1'
  class ActiveSupport::HashWithIndifferentAccess
    def select(*args, &block)
      dup.tap { |hash| hash.select!(*args, &block) }
    end

    def reject(*args, &block)
      dup.tap { |hash| hash.reject!(*args, &block) }
    end

  end

  class ActiveSupport::OrderedHash
    def select(*args, &block)
      dup.tap { |hash| hash.select!(*args, &block) }
    end

    def reject(*args, &block)
      dup.tap { |hash| hash.reject!(*args, &block) }
    end
  end
end