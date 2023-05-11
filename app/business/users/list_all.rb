class Users::ListAll
  include Dry::Transaction

  step :list, if: ->(params) { params.present? }

  private

  def list(params)
    if params.present?
      users = User.where("roles @> ?", "{#{params[:roles].join(",")}}")
    else
      users = User.all
    end
    Success(users)
  end
end
