class GiftAssigmentsController < ApplicationController
  before_action :family, only: %i[index]

  def index
    @gift_assigments = GiftAssigment
                       .includes(:giver, :recipient)
                       .current_assigment(family)
  end

  def create
    assigner = SecretSantaAssignerService.new(family)

    if assigner.call
      redirect_to family_gift_assigments_path(family), notice: 'Gifts were successfully assigned.'
    else
      redirect_to family_url(family), alert: assigner.errors.join(' | ')
    end
  end

  private

  def family
    @family ||= Family.find(params[:family_id])
  end
end
