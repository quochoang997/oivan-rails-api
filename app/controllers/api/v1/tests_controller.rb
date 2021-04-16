module Api
  module V1
    class TestsController < ApplicationController
      before_action :authenticate_request
      before_action :set_test, only: [:show, :update, :destroy]

      def index
        page = params[:page].presence || 1
        per = params[:per].presence || Kaminari.config.default_per_page
        pagination_param = {
          category_page: page,
          category_per: per,
          post_page: params[:post_page].presence || 0,
          post_per: params[:post_per].presence || 1
        }
        @tests = Test.not_delete.by_name.page(page).per(per)
        render json: @tests, meta: pagination_param
      end

      def show
        render json: @test
      end

      def create
        authorize
        @test = Test.new(test_params)
        @test.save!
        json_response(@test, :created)
      end

      def update
        authorize
        @test.update!(test_params)
        json_response(@test, :created)
        # head :no_content
      end

      def destroy
        authorize
        @test.update_attribute(:mark_for_delete, true)
        head :no_content
      end

      private

      def test_params
        result_params = params.require(:test).permit(:name, :description,
                                     questions_attributes: [:id, :name, :description, :_destroy,
                                                           question_answers_attributes: [:id, :index, :content, :_destroy, :is_correct]])
        result_params[:questions_attributes].each do |question|
          correct_answer = ''
          question[:question_answers_attributes].enum_for(:each_with_index).each do |answer, index|
            correct_answer += (index.to_s + ';') if answer[:is_correct] == true
            answer.merge!(index: index)
          end
          raise ActiveRecord::RecordInvalid.new if correct_answer == ''
          question.merge!(correct_answer: correct_answer)
        end
        result_params
      end

      def set_test
        @test = Test.not_delete.find(params[:id])
      end
    end
  end
end

