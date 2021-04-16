module Api
  module V1
    class UsersController < ApplicationController
      before_action :authorize
      before_action :set_user, only: [:show, :update, :destroy]

      def create
        @user = User.create!(user_params)
        if @user.save
          json_response({ message: "User created successfully" }, :created)
        else
          json_response(@user.errors, :bad_request)
        end
      end

      def index
        page = params[:page].presence || 1
        per = params[:per].presence || Kaminari.config.default_per_page
        pagination_param = {
          category_page: page,
          category_per: per,
          post_page: params[:post_page].presence || 0,
          post_per: params[:post_per].presence || 1
        }
        @users = User.by_email.page(page).per(per)
        render json: @users, meta: pagination_param
      end

      def show
        json_response(@user)
      end

      def update
        @user.update!(user_params)
        # json_response(@users, :created)
        head :no_content
      end

      def destroy
        @user.destroy
      end

      private

      def user_params
        params.permit(:email, :password, :role)
      end

      def set_user
        @user = User.find(params[:id])
      end
    end
  end
end



