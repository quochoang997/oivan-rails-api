module Api
  module V1
    class AssessmentsController < ApplicationController
      before_action :authenticate_request
      before_action :set_assessment, only: :show

      def index
        page = params[:page].presence || 1
        per = params[:per].presence || Kaminari.config.default_per_page
        pagination_param = {
          category_page: page,
          category_per: per,
          post_page: params[:post_page].presence || 0,
          post_per: params[:post_per].presence || 1
        }
        @assessments = Assessment.where(user_id: @current_user.id).page(page).per(per)
        render json: @assessments, meta: pagination_param
      end

      def create
        @assessment = Assessment.new(assessment_params)
        totalScore = 0
        @assessment.assessment_responses.enum_for(:each_with_index).collect do |response, index|
          response.display_order = index
          if response.response.eql? Question.find(response.question_id).correct_answer
            response.is_correct = true
            totalScore += 1
          else
            response.is_correct = false
          end
        end
        @assessment.total_question = @assessment.assessment_responses.length
        @assessment.score = totalScore
        @assessment.save!
        json_response(@assessment, :created)
      end

      def show
        json_response(@assessment)
      end

      private

      def assessment_params
        params.require(:assessment).permit(:test_id, assessment_responses_attributes: [:response, :question_id]).merge(user_id: @current_user.id)
      end

      def set_assessment
        @assessment = Assessment.find(params[:id])
      end

    end
  end
end
