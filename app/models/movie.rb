class Movie < ApplicationRecord
    # rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_res
    CATEGORIES = ['Comedy', 'Drama', 'Animation', 'Mystery', 'Horror', 'Fantasy', 'Action', 'Documentary', 'Science Fiction']

    validates :title, presence: true
    validates :year, numericality: {
        greater_than_or_equal_to: 1888,
        less_than_or_equal_to: Date.today.year
    }
    validates :poster_url, presence: true
    validates :category, inclusion: {
        in: CATEGORIES,
        message: "must be one of: #{CATEGORIES.join(', ')}"
    }

    # def index
    #     render json: Movie.all, status: :ok
    # end

    def create
        movie = Movie.create!(movie_params)
        render json: movie, status: :created
    rescue ActiveRecord::RecordInvalid => invalid
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

    private

    def movie_params
        params.permit(:title, :year, :length, :director, :description, :poster_url, :category, :discount, :female_director)
    end

    # def render_unprocessable_entity_res(invalid)
    #     render json: {errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    # end
end
