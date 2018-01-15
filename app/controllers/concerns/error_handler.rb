module ErrorHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :not_found
    rescue_from ActiveRecord::RecordInvalid do |error| 
      bad_request(error)
    end

    def not_found
      render json: { error: 'Not found' }, status: :not_found
    end

    def bad_request(error)
      render json: error, status: :bad_request
    end
  end
end