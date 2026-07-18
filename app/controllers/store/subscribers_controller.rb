class Store::SubscribersController < Store::BaseController
  before_action :set_subscriber, except: [ :index ]
  def index
    @subscribers = Subscriber.filter_by(params)
  end

  def show
  end

  def destroy
    @subscriber.destroy
    redirect_to [ :store, :subscribers ], status: :see_other,
      notice: "Subscriber has been removed."
  end

  private

  def set_subscriber
    @subscriber = Subscriber.find_by(id: params[:id])
  end
end
