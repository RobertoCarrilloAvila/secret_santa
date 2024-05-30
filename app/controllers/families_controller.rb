class FamiliesController < ApplicationController
  before_action :set_family, only: %i[ show edit update destroy ]

  def index
    @families = Family.all
  end

  def show; end

  def new
    @family = Family.new
  end

  def edit; end

  def create
    @family = Family.new(family_params)

    if @family.save
      redirect_to family_url(@family), notice: "Family was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @family.update(family_params)
      redirect_to family_url(@family), notice: "Family was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @family.destroy

    redirect_to families_url, notice: "Family was successfully destroyed."
  end

  private

  def set_family
    @family = Family.find(params[:id])
  end

  def family_params
    params.require(:family).permit(:name)
  end
end
