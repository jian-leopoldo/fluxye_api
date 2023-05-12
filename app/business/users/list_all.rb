class Users::ListAll
  include Dry::Transaction

  check :authorize
  step :list, if: ->(params) { params.present? }

  private

  def authorize(current_user:, params:)
    UserPolicy.new(current_user, User).index?
  end

  def list(current_user:,params:)
    if params.present?
      users = User.where("roles @> ?", "{#{params[:roles].join(",")}}")
    else
      users = User.all
    end
    Success(users)
  end
end
