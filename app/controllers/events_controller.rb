class EventsController < ApplicationController
  before_action :authenticate_user!, except: %i[show index]

  before_action :set_event, only: %i[show edit update destroy]

  before_action :save_pincode_in_cookies, only: [:show]

  after_action :verify_authorized, except: :index

  def index
    @events = Event.all
  end

  def show
    pincode = params[:pincode].present? ? params[:pincode] : cookies.permanent["events_#{@event.id}_pincode"]

    event_context = EventContext.new(event: @event, pincode:)

    begin
      authorize event_context, policy_class: EventPolicy
    rescue Pundit::NotAuthorizedError
      render_pincode_form unless @event.pincode_valid?(pincode)
    end

    @new_comment = @event.comments.build(params[:comment])
    @new_subscription = @event.subscriptions.build(params[:subscription])
    @new_photo = @event.photos.build(params[:photo])
  end

  def new
    @event = current_user.events.build

    authorize @event
  end

  def edit
    authorize @event
  end

  def create
    @event = current_user.events.build(event_params)

    authorize @event

    if @event.save
      redirect_to @event, notice: I18n.t('controllers.events.created')
    else
      render :new
    end
  end

  def update
    authorize @event

    if @event.update(event_params)
      redirect_to @event, notice: I18n.t('controllers.events.updated')
    else
      render :edit
    end
  end

  def destroy
    authorize @event

    @event.destroy

    redirect_to events_url, notice: I18n.t('controllers.events.destroyed')
  end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :address, :datetime, :description, :pincode)
  end

  def save_pincode_in_cookies
    # Если нам передали код и он верный, сохраняем его в куки этого юзера
    # Так юзеру не нужно будет вводить пин-код каждый раз
    if params[:pincode].present? && @event.pincode_valid?(params[:pincode])
      cookies.permanent["events_#{@event.id}_pincode"] = params[:pincode]
    end
  end

  def render_pincode_form
    flash.now[:alert] = I18n.t('controllers.events.wrong_pincode') if params[:pincode].present?
    render 'password_form'
  end
end
