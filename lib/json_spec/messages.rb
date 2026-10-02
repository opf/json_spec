module JsonSpec
  module Messages
    def message_with_path(message)
      @path ? %(#{message} at path "#{@path}") : message
    end
  end
end
