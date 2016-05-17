class UserController < ApplicationController

	#before_action :verify_admin

	

	# GET /users
	def index
		@user = User.all
	

	end

	# GET /user/1
	# GET /user/1.json
	def show
		@user = User.find_by_id(params[:id])
		respond_to do |format|
		format.html
		#format.any {redirect_to root_path}
		end
	end
 def new
    @user = User.new
  end

    def create
    @user = User.new(user_params)

if params[:user][:password].blank?
      params[:user].delete(:password)
      params[:user].delete(:password_confirmation)
    end

    respond_to do |format|
      if @user.save
        format.html { redirect_to root_path, notice: 'Produto was successfully created.' }
        format.json { render :show, status: :created, location: @user }
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
	def inative
		@user = User.find_by_id(params[:id])
		if @user.ativo?
			@user.ativo = false
		else
			@user.ativo = true
		end
		@user.save

		respond_to do |format|
		  format.html { redirect_to users_path, notice: 'Usuário ativo/inativo com sucesso.' }
		  format.json { head :no_content }
		end
	end

	def admin
		@user = User.find_by_id(params[:id])
		if @user.admin?
			@user.admin = false
		else
			@user.admin = true
		end
		@user.save

		respond_to do |format|
			format.html { redirect_to users_path, notice: 'Usuário Admin ativo/inativo com sucesso.' }
			format.json { head :no_content }
		end
	end

	def verify_admin
		if current_user.admin? || current_user.id.to_i == 1 
  			return true
		else
			redirect_to root_path
			return false
		end
	end
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:email, :password)
    end
end
