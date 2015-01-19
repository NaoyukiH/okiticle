OmniAuth.config.logger = Rails.logger

 Rails.application.config.middleware.use OmniAuth::Builder do
 #本番環境用
  # provider :facebook, ENV["1609744735911797"], ENV["999bab7cf6b7e5f42da0d6183e174110"]
 #ローカル環境用
   provider :facebook, ENV['839547276112874'], ENV['0fe2c753a2f3d0106b164c986b9ef88d']
end