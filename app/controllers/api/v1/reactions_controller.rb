module Api
  module V1
    class ReactionsController < ApiController
      def index
        reactions = ReactionResource.all(params)
        respond_with(reactions)
      end

      def show
        reaction = ReactionResource.find(params)
        respond_with(reaction)
      end

      def create
        reaction = ReactionResource.build(params)

        if reaction.save
          render jsonapi: reaction, status: 201
        else
          render jsonapi_errors: reaction
        end
      end

      def update
        reaction = ReactionResource.find(params)

        if reaction.update_attributes
          render jsonapi: reaction
        else
          render jsonapi_errors: reaction
        end
      end

      def destroy
        reaction = ReactionResource.find(params)

        if reaction.destroy
          render jsonapi: { meta: {} }, status: 200
        else
          render jsonapi_errors: reaction
        end
      end
    end
  end
end
