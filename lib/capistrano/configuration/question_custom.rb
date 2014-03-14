module Capistrano
  class Configuration
    class QuestionCustom

      def initialize(env, message, key, default)
        @env, @message, @key, @default = env, message, key, default
      end

      def call
        ask_question
        save_response
      end

      private
      attr_reader :env, :key, :default

      def ask_question
        $stdout.puts question
      end

      def save_response
        env.set(key, value)
      end

      def value
        if response.empty?
          default
        else
          response
        end
      end

      def response
        @response ||= $stdin.gets.chomp
      end

      def question
        I18n.t(:question_custom, message: message, key: key, default_value: default, scope: :capistrano)
      end
    end
  end
end
