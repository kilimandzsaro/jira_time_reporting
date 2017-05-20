class UsersController < ApplicationController
  def edit
    @user = current_user
  end

  def update
    @user = update_person_params["user"]
    # @user[:username] = params[:user][:user][:username]
    # @user.save!
    if @user.update(@user)
      User.where(email: current_user.email).update_all(username: @user["username"])
      flash[:success] = "Profile updated"
      redirect_to edit_user_path(current_user.id)
    else
      render 'edit'
    end
  end

  private
    def update_person_params
      params.require(:user).permit(user: [:email, :username])
    end
end
