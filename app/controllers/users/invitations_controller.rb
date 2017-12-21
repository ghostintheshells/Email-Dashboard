class Users::InvitationsController < Devise::InvitationsController
    layout false
    def create
      require 'securerandom'

      @user = User.find_by(email: params[:invitation][:email])
      account = Account.find(params[:invitation][:account])

      unless @user.present?
        passwd = SecureRandom.hex(8)

        @user = User.create(email: params[:invitation][:email],
                            password: passwd,
                            password_confirmation: passwd)
      end

      @account_user = AccountUser.create!(user_id: @user.id, account_id: account.id)
      @account_user.invite

      redirect_to edit_account_path(account), notice: 'Invitation successfully sent!'
    end

    def edit
      super
    end

    def update
      super
    end
end
