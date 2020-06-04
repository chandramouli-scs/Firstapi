module RailsJwtAuth
  module Lockable
    BOTH_UNLOCK_STRATEGIES = %i[time email].freeze

    def self.included(base)
      base.class_eval do
        if defined?(Mongoid) && ancestors.include?(Mongoid::Document)
          field :failed_attempts,         type: Integer
          field :unlock_token,            type: String
          field :first_failed_attempt_at, type: Time
          field :locked_at,               type: Time
        end
      end
    end

    def lock_access!
      self.locked_at = Time.now.utc
      save(validate: false).tap do |result|
        send_unlock_instructions if result && unlock_strategy_enabled?(:email)
      end
    end

    def unlock_access!
      self.locked_at = nil
      self.failed_attempts = 0
      self.first_failed_attempt_at = nil
      self.unlock_token = nil
      save(validate: false)
    end

    def reset_attempts!
      self.failed_attempts = 0
      self.first_failed_attempt_at = nil
      save(validate: false)
    end

    def authentication?(pass)
      return super(pass) unless lock_strategy_enabled?(:failed_attempts)

      reset_attempts! if !access_locked? && attempts_expired?
      unlock_access! if lock_expired?

      if access_locked?
        false
      elsif super(pass)
        unlock_access!
        self
      else
        failed_attempt!
        lock_access! if attempts_exceeded?
        false
      end
    end

    def unauthenticated_error
      return super unless lock_strategy_enabled?(:failed_attempts)

      if access_locked?
        {error: :locked}
      else
        {error: :invalid_session, remaining_attempts: remaining_attempts}
      end
    end

    protected

    def send_unlock_instructions
      self.unlock_token = SecureRandom.base58(24)
      save(validate: false)

      mailer = Mailer.send_unlock_instructions(self)
      RailsJwtAuth.deliver_later ? mailer.deliver_later : mailer.deliver
    end

    def access_locked?
      locked_at && !lock_expired?
    end

    def lock_expired?
      if unlock_strategy_enabled?(:time)
        locked_at && locked_at < RailsJwtAuth.unlock_in.ago
      else
        false
      end
    end

    def failed_attempt!
      self.failed_attempts ||= 0
      self.failed_attempts += 1
      self.first_failed_attempt_at = Time.now.utc if failed_attempts == 1
      save(validate: false)
    end

    def attempts_exceeded?
      failed_attempts && failed_attempts >= RailsJwtAuth.maximum_attempts
    end

    def remaining_attempts
      RailsJwtAuth.maximum_attempts - failed_attempts.to_i
    end

    def attempts_expired?
      first_failed_attempt_at && first_failed_attempt_at < RailsJwtAuth.reset_attempts_in.ago
    end

    def lock_strategy_enabled?(strategy)
      RailsJwtAuth.lock_strategy == strategy
    end

    def unlock_strategy_enabled?(strategy)
      RailsJwtAuth.unlock_strategy == strategy ||
        (RailsJwtAuth.unlock_strategy == :both && BOTH_UNLOCK_STRATEGIES.include?(strategy))
    end
  end
end
