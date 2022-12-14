class ApplicationController < ActionController::API
    before_action :authenticate_request
    attr_reader :current_user

    def validate_transaction_params
        activity = Validate::Transaction.new(params)
        if !activity.valid?
            render json: { error: activity.errors }
        end
    end

    private

    def authenticate_request
        @current_user = AuthorizeApiRequest.call(request.headers).result
        render json: { error: 'Not Authorized' }, status: 401 unless @current_user
    end
end
