class Api::V1::ResourcesController < Api::V1::ApiBaseController
  respond_to :api_v1

  before_filter :identify_api_user
  before_filter :find_resource_maker
  before_filter :find_resource, :only => [:show, :update, :destroy]

  def index
    @resources = @resource_maker.resources.includes(:resource_detail => [:venue_address])

    @resources = @resources.where('begin_at >= ?', params[:resource_begin_at_after]) if params[:resource_begin_at_after]
    @resources = @resources.where('begin_at <= ?', params[:resource_begin_at_before]) if params[:resource_begin_at_before]

    if params[:per_page].present? || params[:page].present?
      @resources = paginated_collection(@resources, params)
    end
    respond_with(@resources)
  end

  def create
    @resource = Resource::ForUpdateAndCreate.build_empty
    @resource_decorator = API_V1::ResourceDecorator.new(@resource)

    if @resource_decorator.create(params[:resource], @resource_maker)
      handle_resource_state(params)
      @resource.resource_maker = @resource_maker
      @resource.save!

      respond_with(
        Resource.find(@resource.id),
        :status => :created,
        :location => api_v1_resource_makers_resource_url(
          :resource_maker_id => @resource_maker.seccode,
          :resource_id => @resource.seccode
        )
      )
    else
      create_update_validation_failed(@resource)
    end
  end

  def show
    respond_with(@resource)
  end

  def update
    @resource_decorator = API_V1::ResourceDecorator.new(Resource::ForUpdateAndCreate.find(@resource.id))

    if @resource_decorator.update(params[:resource], @resource_maker)
      handle_resource_state(params)
      respond_with(@resource)
    else
      create_update_validation_failed(@resource)
    end
  end

  def destroy
    price_details = @resource.prices.map{|price| price.price_detail}
    resource_detail = @resource.resource_detail
    if @resource.destroy
      resource_detail.destroy unless resource_detail.is_recurring

      price_details.each do |price_detail|
        price_detail.reload
        price_detail.destroy if price_detail.prices.empty?
      end
      head :no_content
    else
      head :forbidden
    end
  end
end
