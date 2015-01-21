class User < ActiveRecord::Base
	has_many :microposts, dependent: :destroy
	has_many :relationships, foreign_key: "follower_id", dependent: :destroy
	has_many :followed_users, through: :relationships, source: :followed

	has_many :reverse_relationships, foreign_key: "followed_id", 
	                                class_name: "Relationship",
	                                dependent: :destroy
	has_many :followers, through: :reverse_relationships, source: :follower



	before_save { self.email = email.downcase }
	before_create :create_remember_token

	validates :name, presence: true, length: { maximum: 50 }
	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :email, presence: true, 
	                  format: { with: VALID_EMAIL_REGEX },
	                  uniqueness: { case_sensitive: false }

	has_secure_password
	validates :password, length: { minimum: 6 }

	# devise :registerable,
         # :omniauthable, omniauth_providers: [:facebook]


	def feed
		Micropost.from_users_followed_by(self)
	end

	def following?(other_user)
		relationships.find_by(followed_id: other_user.id)
	end

	def follow!(other_user)
		relationships.create!(followed_id: other_user.id)
	end

	def unfollow!(other_user)
		relationships.find_by(followed_id: other_user.id).destroy
	end


	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end


	def self.find_or_create_by_auth(auth)
        user = User.where(["provider = ? and uid = ?", auth,provider, auth,uid])
      if user.blank?
       user = User.new
       user.provider = auth.provider
       user.uid = auth.uid
       user.token = auth.credentials.token
       user.save!
      end
      user
    end

    def self.search(search)
    	if search
    	  # User.where(['name LIKE ?', "%#{search}%"])
    	  find(:all, :conditions => ['name LIKE ?', "%#{search}%"])
    	else
    	  User.all # ここをrender 'index'に変えても入力なしの場合全user表示になってしまう。
    	  # redirect_to 'index'
    	end
    end


	private


	  def create_remember_token
	  	self.remember_token = User.encrypt(User.new_remember_token)
	  end


	
end
