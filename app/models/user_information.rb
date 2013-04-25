class UserInformation
  include Tire::Model::Persistence

  validates_presence_of :user_id, :user_name, :email

  property :user_id,         :type=> 'string',      :boost => 2.0
  property :user_name,       :type=> 'string',      :analyzer => 'snowball'
  property :date_of_birth,   :type=> 'date'
  property :email,           :type=> 'string'
  def self.search(params)
    tire.search() do
      query do
        puts "**********************************in search"
        string "user_id:#{params[:user_id]}" if params[:user_id].present?
      end
    end
  end
end