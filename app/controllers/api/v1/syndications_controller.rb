module Api
  module V1
    class SyndicationsController < ApiController
      def index
        syndications = SyndicationResource.all(params)
        respond_with(syndications)
      end

      def show
        syndication = SyndicationResource.find(params)
        respond_with(syndication)
      end

      def create
        syndication = SyndicationResource.build(params)

        if syndication.save
          render jsonapi: syndication, status: 201
        else
          render jsonapi_errors: syndication
        end
      end

      def update
        syndication = SyndicationResource.find(params)

        if syndication.update_attributes
          render jsonapi: syndication
        else
          render jsonapi_errors: syndication
        end
      end

      def destroy
        syndication = SyndicationResource.find(params)

        if syndication.destroy
          render jsonapi: { meta: {} }, status: 200
        else
          render jsonapi_errors: syndication
        end
      end
    end
  end
end
